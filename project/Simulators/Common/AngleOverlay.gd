extends Line2D


@export var angle: float


func _process(_delta):
	points[0] = %Graph.graph_to_world(Vector2.ZERO)
	var far_point=Vector2(cos(deg_to_rad(angle)), sin(deg_to_rad(angle)))*10_000
	points[1]= %Graph.graph_to_world(far_point)
