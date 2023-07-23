extends Line2D

@export var graph_path:NodePath
@onready var graph_node:Control = get_node(graph_path)
@export var label_path:NodePath
@onready var label_node:Label = get_node(label_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.points[0] = graph_node.graph_to_world(Vector2.ZERO)
	self.points[1] = get_global_mouse_position()

	var angle=rad_to_deg(-atan2(points[1].y-points[0].y, points[1].x-points[0].x))
	if angle<0: angle=360+angle
	label_node.text= "%.2f" % angle

