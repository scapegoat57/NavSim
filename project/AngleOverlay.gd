extends Line2D

@export var graph_path: NodePath
@onready var graph_node = get_node(graph_path)
@export var angle: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(_delta):
	points[0] = graph_node.graph_to_world(Vector2.ZERO)
	var far_point=Vector2(cos(deg_to_rad(angle)), sin(deg_to_rad(angle)))*10_000
	points[1]= graph_node.graph_to_world(far_point)


