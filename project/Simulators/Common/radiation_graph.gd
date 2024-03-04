class_name RadiationGraph
extends ColorRect

@export var paused=false;
@export var zoom_level=10.0
@export var origin:Vector2=Vector2(0,0)
@export var frequency=1
@export var time_scale = 1.0
var timer=0.0;
var aspect_ratio=Vector2.ONE;
signal zoom_level_changed(new_value)
signal right_clicked(world_pos)
var antennas=[]
var shader_material
var diagram_mode
var a_space=0

func _ready():
	shader_material=%Graph.material as ShaderMaterial
	shader_material.set_shader_parameter("zoom",zoom_level)
	shader_material.set_shader_parameter("freq", frequency)
	antennas.append(AntennaModel.new());
	antennas.append(AntennaModel.new());
	antennas.append(AntennaModel.new());
	antennas.append(AntennaModel.new());
	antennas.append(AntennaModel.new());


func _process(delta):
	var aspect= self.get_rect().size.x/self.get_rect().size.y;
	if aspect < 1.0:
		aspect_ratio.x=aspect;
		aspect_ratio.y=1.0; 
	else:
		aspect_ratio.x=1.0;
		aspect_ratio.y=1/aspect;
	shader_material.set_shader_parameter("aspect_ratio", aspect_ratio);
	if (!paused):
		timer+=delta*time_scale
		shader_material.set_shader_parameter("timer",timer)


func set_paused(is_paused):
	paused=is_paused


func set_overlay(enabled):
	shader_material.set_shader_parameter("overlay",enabled)
	
	
func _on_reset_time_button_pressed():
	timer=0
	shader_material.set_shader_parameter("timer",timer)
	
	
func set_antenna_pos(antenna, pos):
	var param="ant"+str(antenna)+"_pos"
	shader_material.set_shader_parameter(param, pos)
	antennas[antenna-1].position=pos


func set_pos_with_a_spacing(a_spacing, ant_a, ant_b):
	var pos1=Vector2(0,a_spacing/360/frequency)
	var pos2=Vector2(0,-a_spacing/360/frequency)
	shader_material.set_shader_parameter("ant%d_pos" % ant_a,pos1)
	shader_material.set_shader_parameter("ant%d_pos" % ant_b,pos2)
	shader_material.set_shader_parameter("a_space",a_spacing)
	a_space=a_spacing
	antennas[ant_a-1].position=pos1
	antennas[ant_b-1].position=pos2


func set_NWSE_with_a_space(a_space):
	var pos1=Vector2(-1,1)*(a_space/360/frequency)#*sqrt(2)
	var pos2=Vector2(1,-1)*(a_space/360/frequency)#*sqrt(2)
	shader_material.set_shader_parameter("ant1_pos",pos1)
	shader_material.set_shader_parameter("ant2_pos",pos2)
	antennas[0].position=pos1
	antennas[1].position=pos2


func set_NESW_with_a_space(a_space):
	var pos1=Vector2(1,1)*(a_space/360/frequency)#*sqrt(2)
	var pos2=Vector2(-1,-1)*(a_space/360/frequency)#*sqrt(2)
	shader_material.set_shader_parameter("ant3_pos",pos1)
	shader_material.set_shader_parameter("ant4_pos",pos2)
	
	antennas[2].position=pos1
	antennas[3].position=pos2

var drag_start:Vector2=Vector2.ZERO
func _on_Graph_gui_input(event):
	if event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_RIGHT:
				emit_signal("right_clicked", world_to_graph(get_global_mouse_position()))
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_LEFT:
			var drag_end=world_to_uv(event.position)
			
			origin-=(uv_to_graph(drag_end)-uv_to_graph(drag_start))*Vector2(1,-1)
			shader_material.set_shader_parameter("origin",origin)
			drag_start=drag_end
		#if event.button_mask == MOUSE_BUTTON_RIGHT:
				#emit_signal("right_clicked", world_to_graph(get_global_mouse_position()))
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				drag_start=world_to_uv(event.position)
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom_level -= 1 if zoom_level > 1 else 0
				set_zoom_level(zoom_level)
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				set_zoom_level(zoom_level+1)
			

func phase_from_antenna(index, graph_pos):
	var a = antennas[index]
	return phase_from(a.position, graph_pos, a.phase);

func phase_from(antenna_pos, field_pos, phase_offset):
	var dist=(field_pos- antenna_pos).length()
	var phase = (frequency * dist * 2 * PI - deg_to_rad(phase_offset) - timer);
	return phase

func phasor_from(antenna_pos, field_pos, phase_offset):
	var phase=phase_from(antenna_pos, field_pos, phase_offset)
	return Vector2(cos(phase), sin(phase));

func phasor_from_antenna(index, graph_pos):
	var a=antennas[index]
	if !a.enabled: return Vector2.ZERO
	return phasor_from(a.position, graph_pos, a.phase) * a.amplitude

func phasor_from_antenna_with_phase(index, graph_pos, phase_offset):
	var a=antennas[index]
	if !a.enabled: return Vector2.ZERO
	return phasor_from(a.position, graph_pos, a.phase+phase_offset) * a.amplitude


func uv_to_graph(uv:Vector2):
	var offset=Vector2(0.5,0.5)
	return ((uv-offset)*aspect_ratio*zoom_level+origin)*Vector2(1,-1)

func graph_to_uv(graph:Vector2):
	var offset=Vector2(0.5,0.5)
	return (graph*Vector2(1,-1) - origin) / (aspect_ratio * zoom_level) + offset

func world_to_uv(world:Vector2):
	return (world - get_global_rect().position) / get_rect().size

func uv_to_world(uv:Vector2):
	return uv * get_rect().size #+ get_global_rect().position

func graph_to_world(graph):
	return uv_to_world(graph_to_uv(graph))

func world_to_graph(world_coordinates):
	var uv = world_to_uv(world_coordinates)
	return uv_to_graph(uv)
	

func toggle_antenna(enabled, index):
	var param="ant"+str(index)+"_enabled"
	shader_material.set_shader_parameter(param,1 if enabled else 0)
	antennas[index-1].enabled=enabled
	
func set_antenna_phase(phase, antenna):
	var param="ant" + str(antenna) + "_phase"
	shader_material.set_shader_parameter(param,phase)
	
	antennas[antenna-1].phase=phase


func set_antenna_amplitude(amplitude, antenna):
	var param="ant" + str(antenna) + "_amplitude"
	shader_material.set_shader_parameter(param,amplitude)
	
	antennas[antenna-1].amplitude=amplitude


func set_zoom_level(value):
	zoom_level=value
	shader_material.set_shader_parameter("zoom",value)
	emit_signal("zoom_level_changed",value)

func increment_zoom_level(delta):
	set_zoom_level(zoom_level + delta)

func hide_below_ground(value):
	shader_material.set_shader_parameter("hide_below_ground", value)
	
func set_time_scale(value):
	time_scale=value;
	
func increase_time_scale(value):
	set_time_scale(time_scale + value)
	
func set_origin(value):
	origin=value
	shader_material.set_shader_parameter("origin",value)

func set_phase_mode(value):
	shader_material.set_shader_parameter("phase_mode",value)

func set_diagram_mode(value):
	shader_material.set_shader_parameter("diagram_mode", value)
	diagram_mode=value

func set_show_vor_circle(value):
	shader_material.set_shader_parameter("show_vor_circle", value)
