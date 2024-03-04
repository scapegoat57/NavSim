extends PanelContainer
@export var graph:RadiationGraph
@export var ant1: Line2D
@export var ant2: Line2D
@export var ant3: Line2D
@export var ant1_thumb: ColorRect
@export var output: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var thumb_pos = ant1_thumb.global_position + ant1_thumb.size/2;
	if graph.diagram_mode:
		var theta=atan2(graph.world_to_graph(thumb_pos).y, graph.world_to_graph(thumb_pos).x)
		theta=fmod(theta + TAU, TAU)

		var pr=deg_to_rad(graph.a_space) * sin(theta)
		
		var a1=graph.antennas[0]
		var b1=deg_to_rad(a1.phase) + pr
		var phasor=Vector2(a1.amplitude * cos(b1), -a1.amplitude * sin(b1));
		ant1.set_point_position(1,phasor*60)
		
		var a2=graph.antennas[1]
		var b2=deg_to_rad(a2.phase) - pr
		var phasor2=Vector2(a2.amplitude * cos(b2), -a2.amplitude * sin(b2));
		ant2.set_point_position(1,phasor2*60)
		
		var phasor3 = phasor+phasor2;
		ant3.set_point_position(1,phasor3*60)
		output.text="ant1 = %.1f L%05.1f\nant2 = %.1f L%05.1f\ntotal = %.1f L%05.1f" % [phasor.length(), fmod(-rad_to_deg(phasor.angle())+360, 360),phasor2.length(), fmod(-rad_to_deg(phasor2.angle())+360, 360),phasor3.length(), fmod(-rad_to_deg(phasor3.angle())+360, 360)]
	else:
		
		var phasor = graph.phasor_from_antenna(0,graph.world_to_graph(thumb_pos))
		ant1.set_point_position(1,phasor*60)
		
		var phasor2 = graph.phasor_from_antenna(1,graph.world_to_graph(thumb_pos))
		ant2.set_point_position(1,phasor2*60)
		
		var phasor3 = phasor+phasor2;
		ant3.set_point_position(1,phasor3*60)
		output.text="ant1 = %.1f L%05.1f\nant2 = %.1f L%05.1f\ntotal = %.1f L%05.1f" % [phasor.length(), fmod(-rad_to_deg(phasor.angle())+360, 360),phasor2.length(), fmod(-rad_to_deg(phasor2.angle())+360, 360),phasor3.length(), fmod(-rad_to_deg(phasor3.angle())+360, 360)]
	pass


func _on_graph_right_clicked(graph_pos):
	ant1_thumb.global_position=get_global_mouse_position() - ant1_thumb.size/2
