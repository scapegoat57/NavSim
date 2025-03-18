extends Control



func _on_antennas_button_pressed():
	get_tree().change_scene_to_file("res://Simulators/Pair/pair_sim.tscn")


func _on_gs_button_pressed():
	get_tree().change_scene_to_file("res://Simulators/GS/gs_sim.tscn")


func _on_lighthouse_button_pressed():
	get_tree().change_scene_to_file("res://Lighthouse/Lighthouse_player.tscn")


func _on_vor_button_pressed():
	get_tree().change_scene_to_file("res://Simulators/VOR/vor_sim.tscn")


func _on_audio_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Audio/audio_sim.tscn")
