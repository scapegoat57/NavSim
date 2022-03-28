class_name RadiationGraph
extends ColorRect

export var paused=false;
export var zoom_level=10.0
export var origin:Vector2=Vector2(0,0)
export var frequency=1
var timer=0.0;

func _ready():
	material.set_shader_param("zoom",zoom_level)
	material.set_shader_param("freq", frequency)


func _process(delta):
	if (!paused):
		timer+=delta
		material.set_shader_param("timer",timer)


func toggle_paused(is_paused):
	paused=is_paused


func reset_time():
	timer=0.0
	material.set_shader_param("timer",timer)


func _on_overlay_button_toggled(button_pressed):
	material.set_shader_param("overlay",button_pressed)
	
	
func _on_reset_time_button_pressed():
	timer=0
	material.set_shader_param("timer",timer)
	
	
func set_antenna_pos(antenna, position):
	var param="ant"+String(antenna)+"_pos"
	material.set_shader_param(param, position)


func set_pos_with_a_spacing(var a_spacing):
	var pos1=Vector2(0,a_spacing/360/frequency)
	var pos2=Vector2(0,-a_spacing/360/frequency)
	material.set_shader_param("ant1_pos",pos1)
	material.set_shader_param("ant2_pos",pos2)


func set_NWSE_with_a_space(var a_space):
	var pos1=Vector2(-1,1)*(a_space/360/frequency)*sqrt(2)
	var pos2=Vector2(1,-1)*(a_space/360/frequency)*sqrt(2)
	material.set_shader_param("ant1_pos",pos1)
	material.set_shader_param("ant2_pos",pos2)


func set_NESW_with_a_space(var a_space):
	var pos1=Vector2(1,1)*(a_space/360/frequency)*sqrt(2)
	var pos2=Vector2(-1,-1)*(a_space/360/frequency)*sqrt(2)
	material.set_shader_param("ant3_pos",pos1)
	material.set_shader_param("ant4_pos",pos2)
	

var drag_start:Vector2=Vector2.ZERO
func _on_Graph_gui_input(event):
	if event is InputEventMouseMotion:
		if event.button_mask == BUTTON_LEFT:
			var drag_end=event.position/rect_size
			
			origin+=(uv_to_local(drag_end)-uv_to_local(drag_start))
			material.set_shader_param("origin",origin)
			drag_start=drag_end
			
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == BUTTON_LEFT:
				drag_start=event.position/rect_size
			if event.button_index == BUTTON_WHEEL_UP:
				zoom_level -= 1 if zoom_level > 1 else 0
				material.set_shader_param("zoom",zoom_level)
			if event.button_index == BUTTON_WHEEL_DOWN:
				zoom_level+=1
				material.set_shader_param("zoom",zoom_level)
#		if !event.pressed:
#			print(event.as_text())

func uv_to_local(uv:Vector2):
	return (uv-Vector2(0.5,0.5))*-zoom_level+origin

func local_to_world(local_coordinates):
	var local_to_uv= (local_coordinates+origin)/-zoom_level+Vector2(0.5,0.5)
	return local_to_uv * self.rect_size


func toggle_antenna(enabled, index):
	var param="ant"+String(index)+"_enabled"
	material.set_shader_param(param,1 if enabled else 0)
	
	
func set_antenna_phase(phase, antenna):
	var param="ant" + String(antenna) + "_phase"
	material.set_shader_param(param,phase)


func set_antenna_amplitude(amplitude, antenna):
	var param="ant" + String(antenna) + "_amplitude"
	material.set_shader_param(param,amplitude)


func set_zoom_level(value):
	zoom_level=value
	material.set_shader_param("zoom",value)
