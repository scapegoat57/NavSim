extends Control
var scene_index=0;

var scenes=[]
var cont_timer=-1;
var is_cont=false;

func _ready():
	get_tree().root.content_scale_mode=Window.CONTENT_SCALE_MODE_VIEWPORT
	#get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_KEEP, Vector2(1024,600))
#	for i in 5:
#		var s = "res://Lighthouse/LighthouseScene%d.tscn" % i
#		scenes.push_back(load(s))
#
#	load_scene(0);

func _process(delta):
	if cont_timer>0:
		cont_timer-=delta
	if is_cont and cont_timer<0:
		cont_timer=Global.sweep_time
		_on_Both_pressed()

func _on_IntelSlider_value_changed(value):
	Global.set_intel_level(value);

func load_scene(index):
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
	Global.reference_antenna.blink();


func _on_Sweep_pressed():
	Global.variable_antenna.sweep();


func _on_Both_pressed():
	Global.reference_antenna.blink();
	Global.variable_antenna.sweep();


func _on_Continous_toggled(button_pressed):
	is_cont=button_pressed


func _on_NextButton_pressed():
	load_scene(scene_index+1)


func _on_BackButton_pressed():
	load_scene(scene_index-1)
