class_name RadiationGraph
extends ColorRect

export var Paused=false;
export var ZoomLevel=10.0
export var Origin:Vector2=Vector2(0,0)
export var a_label_path:NodePath
var timer=0.0;

func _ready():
	material.set_shader_param("zoom",ZoomLevel)

func _process(delta):
	if (!Paused):
		timer+=delta
		material.set_shader_param("timer",timer)

func toggle_paused(is_paused):
	Paused=is_paused

func reset_time():
	timer=0.0

func _on_overlay_button_toggled(button_pressed):
	material.set_shader_param("overlay",button_pressed)
	
func _on_reset_time_button_pressed():
	timer=0
	material.set_shader_param("timer",timer)

func set_pos_with_a_spacing(var a_spacing):
	var pos1=Vector2(0,a_spacing/360)
	var pos2=Vector2(0,-a_spacing/360)
	material.set_shader_param("ant1_pos",pos1)
	material.set_shader_param("ant2_pos",pos2)

var drag_start:Vector2=Vector2.ZERO
func _on_Graph_gui_input(event):
	if event is InputEventMouseMotion:
		if event.button_mask == BUTTON_LEFT:
			var drag_end=event.position/rect_size
			
			Origin+=(uv_to_world(drag_end)-uv_to_world(drag_start))
			material.set_shader_param("origin",Origin)
			drag_start=drag_end
			
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == BUTTON_LEFT:
				drag_start=event.position/rect_size
			if event.button_index == BUTTON_WHEEL_UP:
				ZoomLevel -= 1 if ZoomLevel > 1 else 0
				material.set_shader_param("zoom",ZoomLevel)
			if event.button_index == BUTTON_WHEEL_DOWN:
				ZoomLevel+=1
				material.set_shader_param("zoom",ZoomLevel)
#		if !event.pressed:
#			print(event.as_text())

func uv_to_world(uv:Vector2):
	return (uv-Vector2(0.5,0.5))*-ZoomLevel+Origin


func toggle_antenna(index, enabled):
	var param="ant"+String(index)+"_amplitude"
	material.set_shader_param(param,1 if enabled else 0)

func toggle_SIP(enabled):
	material.set_shader_param("sip", 1 if enabled else -1)
	
func set_antenna_phase(antenna, phase):
	var param="ant" + String(antenna) + "_phase"
	material.set_shader_param(param,phase)
