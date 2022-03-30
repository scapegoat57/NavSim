extends Line2D

export(NodePath) var graph_path
onready var graph_node = get_node(graph_path)
export(float) var angle

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	global_position=Vector2.ZERO
	self.points[0] = graph_node.local_to_world(Vector2.ZERO)+graph_node.rect_global_position
	var far_point=Vector2(-100000,sin(deg2rad(angle))*100000)
	points[1]=graph_node.local_to_world(far_point)


