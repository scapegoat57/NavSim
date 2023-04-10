extends VBoxContainer

export var graph_path:NodePath
onready var graph_node=get_node(graph_path) as RadiationGraph;

func _ready():
	connect("visibility_changed",self,"changed")

func changed():
	if get_parent().visible:
		graph_node.set_zoom_level(10)
		graph_node.set_origin(Vector2.ZERO)
#		$PhaseModeButton.pressed=true
		_on_ResetButton_pressed()
	

func _on_SipButton_pressed():
	$Antenna1Phase/Antenna1PhaseSlider.value=0;
	$Antenna2Phase/Antenna2PhaseSlider.value=0;
	
	
func _on_SopButton_pressed():
	$Antenna1Phase/Antenna1PhaseSlider.value=0;
	$Antenna2Phase/Antenna2PhaseSlider.value=180;
	
	
func _on_ResetButton_pressed():
	$Antenna1Enabled.pressed=true;
	$Antenna2Enabled.pressed=true;
	graph_node.toggle_antenna(true, 1)
	graph_node.toggle_antenna(true, 2)
	graph_node.toggle_antenna(false, 3)
	graph_node.toggle_antenna(false, 4)

	$ASpaceHBox/ASpaceSlider.value=0
	$ASpaceHBox/ASpaceSliderButton.pressed=true;
	graph_node.set_pos_with_a_spacing(0, 1, 2)
	$Antenna1Phase/Antenna1PhaseSlider.value = 0;
	graph_node.set_antenna_phase(0,1)
	$Antenna2Phase/Antenna2PhaseSlider.value = 0;
	graph_node.set_antenna_phase(0,2)
	$Antenna1Current/Antenna1CurrentSlider.value = 1
	graph_node.set_antenna_amplitude(1,1)
	$Antenna2Current/AntennaCurrentSlider.value = 1
	graph_node.set_antenna_amplitude(1,2)
	
	graph_node.set_antenna_pos(1,Vector2.ZERO)
	graph_node.set_antenna_pos(2,Vector2.ZERO)
	graph_node.set_antenna_pos(3,Vector2.ZERO)
	graph_node.set_antenna_pos(4,Vector2.ZERO)
	
	$HideUnderground.pressed=false
	graph_node.hide_below_ground(false)
	graph_node.set_show_vor_circle(false);
	


func _on_Button_pressed():
	$"../../..".queue_free();
	get_tree().root.add_child(load("res://Lighthouse/Lighthouse_player.tscn").instance())
