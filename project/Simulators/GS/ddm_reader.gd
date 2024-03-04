extends Label
@export var graph:RadiationGraph
@export var point:DragPoint

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var csb_factor=.2
	var sbo_factor=.155/143.0
	var csb=(graph.phasor_from_antenna(0,point.graph_pos)+\
			graph.phasor_from_antenna(1,point.graph_pos))/2
	var csb_power=csb.length()
	
	var sbo=(graph.phasor_from_antenna(2,point.graph_pos)+\
			graph.phasor_from_antenna(3,point.graph_pos))/2
	var sbo_power=sbo.length()/2
	
	var mod150=(csb*0.4+sbo*sbo_factor).length()/csb_power*100
	var mod90=(csb*0.4-sbo*sbo_factor).length()/csb_power*100
	

	var ddm=mod150-mod90
#	if csb_power<.1:
#		text="FLAG"
#	else:
	text="90: %.3f  150: %.3f\nDDM: %.3f" % [mod90, mod150, ddm]
