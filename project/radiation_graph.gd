class_name RadiationGraph
extends ColorRect

export var paused=false;
export var zoom_level=10.0
export var origin:Vector2=Vector2(0,0)
export var frequency=1
export var time_scale = 1.0
var timer=0.0;
var aspect_ratio=Vector2.ONE;
signal zoom_level_changed(new_value)
var antennas=[]

func _ready():
	material.set_shader_param("zoom",zoom_level)
	material.set_shader_param("freq", frequency)
	antennas.append(AntennaModel.new());
	antennas.append(AntennaModel.new());
	antennas.append(AntennaModel.new());
	antennas.append(AntennaModel.new());
	antennas.append(AntennaModel.new());


func _process(delta):
	var aspect=.get_rect().size.x/.get_rect().size.y;
	if aspect < 1.0:
		aspect_ratio.x=aspect;
		aspect_ratio.y=1.0; 
	else:
		aspect_ratio.x=1.0;
		aspect_ratio.y=1/aspect;
	material.set_shader_param("aspect_ratio", aspect_ratio);
	if (!paused):
		timer+=delta*time_scale
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
	antennas[antenna-1].position=position


func set_pos_with_a_spacing(var a_spacing, ant_a, ant_b):
	var pos1=Vector2(0,a_spacing/360/frequency)
	var pos2=Vector2(0,-a_spacing/360/frequency)
	material.set_shader_param("ant%d_pos" % ant_a,pos1)
	material.set_shader_param("ant%d_pos" % ant_b,pos2)
	antennas[ant_a-1].position=pos1
	antennas[ant_b-1].position=pos2


func set_NWSE_with_a_space(var a_space):
	var pos1=Vector2(-1,1)*(a_space/360/frequency)#*sqrt(2)
	var pos2=Vector2(1,-1)*(a_space/360/frequency)#*sqrt(2)
	material.set_shader_param("ant1_pos",pos1)
	material.set_shader_param("ant2_pos",pos2)
	antennas[0].position=pos1
	antennas[1].position=pos2


func set_NESW_with_a_space(var a_space):
	var pos1=Vector2(1,1)*(a_space/360/frequency)#*sqrt(2)
	var pos2=Vector2(-1,-1)*(a_space/360/frequency)#*sqrt(2)
	material.set_shader_param("ant3_pos",pos1)
	material.set_shader_param("ant4_pos",pos2)
	
	antennas[2].position=pos1
	antennas[3].position=pos2

var drag_start:Vector2=Vector2.ZERO
func _on_Graph_gui_input(event):
	if event is InputEventMouseMotion:
		if event.button_mask == BUTTON_LEFT:
			var drag_end=world_to_uv(event.position)
			
			origin-=(uv_to_graph(drag_end)-uv_to_graph(drag_start))*Vector2(1,-1)
			material.set_shader_param("origin",origin)
			drag_start=drag_end
			
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == BUTTON_LEFT:
				drag_start=world_to_uv(event.position)
			if event.button_index == BUTTON_WHEEL_UP:
				zoom_level -= 1 if zoom_level > 1 else 0
				set_zoom_level(zoom_level)
			if event.button_index == BUTTON_WHEEL_DOWN:
				set_zoom_level(zoom_level+1)

func phase_from_antenna(index, graph_pos):
	var a = antennas[index]
	return phase_from(a.position, graph_pos, a.phase);

func phase_from(antenna_pos, field_pos, phase_offset):
	var dist=(field_pos- antenna_pos).length()
	var phase = (frequency * dist * 2 * PI - deg2rad(phase_offset) - timer);
	return phase

func phasor_from(antenna_pos, field_pos, phase_offset):
	var phase=phase_from(antenna_pos, field_pos, phase_offset)
	return Vector2(cos(phase), sin(phase));

func phasor_from_antenna(index, graph_pos):
	var a=antennas[index]
	if !a.enabled: return Vector2.ZERO
	return phasor_from(a.position, graph_pos, a.phase) * a.amplitude


func uv_to_graph(uv:Vector2):
	var offset=Vector2(0.5,0.5)
	return ((uv-offset)*aspect_ratio*zoom_level+origin)*Vector2(1,-1)

func graph_to_uv(graph:Vector2):
	var offset=Vector2(0.5,0.5)
	return (graph*Vector2(1,-1) - origin) / (aspect_ratio * zoom_level) + offset

func world_to_uv(world:Vector2):
	return (world - get_global_rect().position) / get_rect().size

func uv_to_world(uv:Vector2):
	return uv * get_rect().size + get_global_rect().position

func graph_to_world(graph):
	return uv_to_world(graph_to_uv(graph))

func world_to_graph(world_coordinates):
	var uv = world_to_uv(world_coordinates)
	return uv_to_graph(uv)
	

func toggle_antenna(enabled, index):
	var param="ant"+String(index)+"_enabled"
	material.set_shader_param(param,1 if enabled else 0)
	antennas[index-1].enabled=enabled
	
func set_antenna_phase(phase, antenna):
	var param="ant" + String(antenna) + "_phase"
	material.set_shader_param(param,phase)
	
	antennas[antenna-1].phase=phase


func set_antenna_amplitude(amplitude, antenna):
	var param="ant" + String(antenna) + "_amplitude"
	material.set_shader_param(param,amplitude)
	
	antennas[antenna-1].amplitude=amplitude


func set_zoom_level(value):
	zoom_level=value
	material.set_shader_param("zoom",value)
	emit_signal("zoom_level_changed",value)

func increment_zoom_level(delta):
	set_zoom_level(zoom_level + delta)

func hide_below_ground(value):
	material.set_shader_param("hide_below_ground", value)
	
func set_time_scale(value):
	time_scale=value;
	
func increase_time_scale(value):
	set_time_scale(time_scale + value)
	
func set_origin(value):
	origin=value
	material.set_shader_param("origin",value)

func set_phase_mode(value):
	material.set_shader_param("phase_mode",value)
