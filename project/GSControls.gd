extends VBoxContainer

export var graph_path:NodePath
onready var graph_node=get_node(graph_path) as RadiationGraph;

func _ready():
	connect("visibility_changed",self,"changed")

func changed():
	if get_parent().visible:
		graph_node.set_zoom_level(40)
		_on_ResetButton_pressed()	
	
func _on_ResetButton_pressed():
	$CSBEnabled.pressed=true;
	$SBOEnabled.pressed=false;
	graph_node.toggle_antenna(true, 1)
	graph_node.toggle_antenna(true, 2)
	graph_node.toggle_antenna(false, 3)
	graph_node.toggle_antenna(false, 4)

	$CSBASpace/ASpaceSlider.value=1720.0
	$CSBASpace/ASpaceSliderButton.pressed=false;
	graph_node.set_pos_with_a_spacing(1720.0, 1, 2)
	$SBOASpace/ASpaceSlider.value=3440.0
	$SBOASpace/ASpaceSliderButton.pressed=false;
	graph_node.set_pos_with_a_spacing(3440.0, 3, 4)
	$CSBPhase/CSBPhaseSlider.value = 0;
	$SBOPhase/SBOPhaseSlider.value = 0;
	graph_node.set_antenna_phase(0,1)
	graph_node.set_antenna_phase(-180,2)
	graph_node.set_antenna_phase(0,3)
	graph_node.set_antenna_phase(-180,4)
	$CSBCurrent/CSBCurrentSlider.value = 1
	$SBOCurrent/SBOCurrentSlider.value = 1
	graph_node.set_antenna_amplitude(1,1)
	graph_node.set_antenna_amplitude(1,2)
	graph_node.set_antenna_amplitude(1,3)
	graph_node.set_antenna_amplitude(1,4)
	
	$HideUnderground.pressed=false
	graph_node.hide_below_ground(false)
	


func _on_CSBEnabled_toggled(button_pressed):
	graph_node.toggle_antenna(button_pressed, 1)
	graph_node.toggle_antenna(button_pressed, 2)


func _on_SBOEnabled_toggled(button_pressed):
	graph_node.toggle_antenna(button_pressed, 3)
	graph_node.toggle_antenna(button_pressed, 4)


func _on_CSBCurrentSlider_value_changed(value):
	graph_node.set_antenna_amplitude(value,1)
	graph_node.set_antenna_amplitude(value,2)


func _on_SBOCurrentSlider_value_changed(value):
	graph_node.set_antenna_amplitude(value,3)
	graph_node.set_antenna_amplitude(value,4)


func _on_CSBPhaseSlider_value_changed(value):
	graph_node.set_antenna_phase(value, 1)
	graph_node.set_antenna_phase(value - 180, 2)


func _on_SBOPhaseSlider_value_changed(value):
	graph_node.set_antenna_phase(value, 3)
	graph_node.set_antenna_phase(value - 180, 4)



func _on_Swap_pressed():
	if $CSBEnabled.pressed:
		$CSBEnabled.pressed=false
		$SBOEnabled.pressed=true
	else:
		$CSBEnabled.pressed=true
		$SBOEnabled.pressed=false
