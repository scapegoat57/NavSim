class_name DragPoint
extends ColorRect

@export var graph:RadiationGraph
var drag_offset:Vector2=Vector2.ZERO
var graph_pos=Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position=graph.graph_to_world(graph_pos)-get_rect().size/2

func _gui_input(event):
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_LEFT:
			graph_pos=graph.world_to_graph(event.global_position-drag_offset)
			accept_event()

			
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				drag_offset = Vector2.ZERO# event.position-get_rect().size/2
