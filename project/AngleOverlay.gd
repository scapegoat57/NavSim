extends Line2D

export(NodePath) var graph_path
onready var graph_node = get_node(graph_path)
export(float) var angle

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	points[0] = graph_node.graph_to_world(Vector2.ZERO)
	var far_point=Vector2(10, sin(deg2rad(angle)) * 10)
	points[1]= graph_node.graph_to_world(far_point)


