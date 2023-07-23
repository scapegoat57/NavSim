extends Button

@export var pause_texture: CompressedTexture2D
@export var play_texture: CompressedTexture2D
@export var graph_path: NodePath

@onready var graph_node = get_node(graph_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PausePlayButton_toggled(value):
	graph_node.toggle_paused(value)
	icon = play_texture if value else pause_texture
	
