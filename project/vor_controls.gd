extends VBoxContainer

export var graph_path:NodePath
onready var graph_node=get_node(graph_path) as RadiationGraph;

func _ready():
# warning-ignore:return_value_discarded
	connect("visibility_changed",self,"changed")

func changed():
	if get_parent().visible:
		_on_ResetButton_pressed()

func _on_ResetButton_pressed():
	$Antenna1Enabled.pressed=true;
	$Antenna2Enabled.pressed=true;
	$Antenna3Enabled.pressed=true;
	$Antenna4Enabled.pressed=true;
	graph_node.toggle_antenna(true, 1)
	graph_node.toggle_antenna(true, 2)
	graph_node.toggle_antenna(true, 3)
	graph_node.toggle_antenna(true, 4)
	$ASpaceHBox/ASpaceSlider.value=27.5
	graph_node.set_NESW_with_a_space(27.5)
	graph_node.set_NWSE_with_a_space(27.5)
	$ASpaceHBox/ASpaceSliderButton.pressed=true;
	$Antenna1Phase/Antenna1PhaseSlider.value = 180.0;
	$Antenna2Phase/Antenna2PhaseSlider.value = 0.0;
	$Antenna3Phase/Antenna3PhaseSlider.value = -270.0;
	$Antenna4Phase/Antenna4PhaseSlider.value = -90.0;
	graph_node.set_antenna_phase(180.0,1)
	graph_node.set_antenna_phase(0,2)
	graph_node.set_antenna_phase(-270.0,3)
	graph_node.set_antenna_phase(-90.0,4)
	
	$Antenna1Current/Antenna1CurrentSlider.value=1.0
	$Antenna2Current/AntennaCurrentSlider.value=1.0
	$Antenna3Current/AntennaCurrentSlider.value=1.0
	$Antenna4Current/AntennaCurrentSlider.value=1.0
	graph_node.set_antenna_amplitude(1,1)
	graph_node.set_antenna_amplitude(1,2)
	graph_node.set_antenna_amplitude(1,3)
	graph_node.set_antenna_amplitude(1,4)


func _on_ASpaceSlider_value_changed(value):
	graph_node.set_NWSE_with_a_space(value)
	graph_node.set_NESW_with_a_space(value)

