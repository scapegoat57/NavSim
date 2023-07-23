extends Control
var scene_index=0;

var scenes=[]


func _ready():
	#get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_KEEP, Vector2(1024,600))
	for i in 5:
		var s = "res://Lighthouse/LighthouseScene%d.tscn" % i
		scenes.push_back(load(s))

	load_scene(0);


func _on_IntelSlider_value_changed(value):
	Global.set_intel_level(value);

func load_scene(index):
	if index==scenes.size():
		self.queue_free()
		get_tree().root.add_child(load("res://Antenna/antenna_player.tscn").instantiate())
	scene_index=index;
	scene_index=min(scene_index, scenes.size() - 1)
	scene_index=max(scene_index, 0)
	
	for i in $"%SceneHolder".get_children():
		i.queue_free();
	$"%SceneHolder".add_child(scenes[scene_index].instantiate());
	
	if scene_index == 2:
		$VBoxContainer/IntelSlider.value=1
	
	if scene_index == 4:
		$VBoxContainer/IntelSlider.value = 6
	
	$"%SceneLabel".text="%d/%d" %[scene_index + 1, scenes.size()]

func _on_Blink_pressed():
	Global.lighthouse.blink();


func _on_Sweep_pressed():
	Global.lighthouse.sweep();


func _on_Both_pressed():
	Global.lighthouse.sweep_and_blink();


func _on_Continous_toggled(button_pressed):
	Global.lighthouse.cycle_toggled(button_pressed);


func _on_NextButton_pressed():
	load_scene(scene_index+1)


func _on_BackButton_pressed():
	load_scene(scene_index-1)
