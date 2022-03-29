extends Button

export(StreamTexture) var pause_texture
export(StreamTexture) var play_texture
export(NodePath) var graph_path

onready var graph_node = get_node(graph_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PausePlayButton_toggled(button_pressed):
	graph_node.toggle_paused(button_pressed)
	icon = play_texture if button_pressed else pause_texture
	
