extends PanelContainer
@export var graph_path:NodePath
@export var distance:float
@export var angle:float

var graph_pos:Vector2
@onready var label:=$Label
@onready var graph: RadiationGraph=get_node(graph_path)


# Called when the node enters the scene tree for the first time.
func _ready():
	label.text="test"
	graph_pos=Vector2(cos(deg_to_rad(angle)), sin(deg_to_rad(angle)))*distance


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var pos=graph.graph_to_world(graph_pos)-get_rect().size/2
	super.set_position(pos)
	var total_phasor = graph.phasor_from_antenna(0, graph_pos) +\
						graph.phasor_from_antenna(1, graph_pos) +\
						graph.phasor_from_antenna(2, graph_pos) +\
						graph.phasor_from_antenna(3, graph_pos)
						
	var total_phase=atan2(total_phasor.y, total_phasor.x) + 2*PI
	total_phase=fmod(total_phase, 2*PI)
	
	var carrier_phasor= graph.phasor_from(graph.antennas[0].position, graph_pos, 225.0) +\
						graph.phasor_from(graph.antennas[1].position, graph_pos, 225.0) +\
						graph.phasor_from(graph.antennas[2].position, graph_pos, 225.0) +\
						graph.phasor_from(graph.antennas[3].position, graph_pos, 225.0)
	
	var carrier_phase=atan2(carrier_phasor.y, carrier_phasor.x) + 2*PI
	carrier_phase=fmod(carrier_phase, 2*PI)
	
	total_phase=rad_to_deg(total_phase - carrier_phase)
	total_phase=fmod(total_phase, 360.0)
	if total_phase+0.05 >=360: total_phase=0
	if total_phase < 0: total_phase=total_phase + 360
	total_phase=total_phase-fmod(360-angle+90,360)
	if total_phase<-180: total_phase+=360
	else:if total_phase>180: total_phase-=360
	label.text="%5.2f" % total_phase
