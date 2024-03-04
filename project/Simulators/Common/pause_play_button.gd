extends Button

@export var pause_texture: CompressedTexture2D
@export var play_texture: CompressedTexture2D

func _on_PausePlayButton_toggled(value):
	%Graph.set_paused(value)
	
	icon = play_texture if value else pause_texture
	
