extends Line2D


@export var graph_node:Control 
@export var label_node:Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.points[0] = graph_node.graph_to_world(Vector2.ZERO)
	self.points[1] = get_local_mouse_position()

	var angle=rad_to_deg(-atan2(points[1].y-points[0].y, points[1].x-points[0].x))
	var dist= %Graph.world_to_graph(get_global_mouse_position()).length()
	var freq=334_700_000.0
	var c=983_571_056.0
	if angle<0: angle=360+angle
	label_node.text= "%.2f°\n%.2fλ\n%.2fft" % [angle, dist, c/freq*dist]
