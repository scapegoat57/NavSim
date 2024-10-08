extends VBoxContainer

@export var graph_path:NodePath
@onready var graph_node=get_node(graph_path) as RadiationGraph;

func _ready():
# warning-ignore:return_value_discarded
	connect("visibility_changed", Callable(self, "changed"))

func changed():
	if get_parent().visible:
		graph_node.set_zoom_level(10)
		graph_node.set_origin(Vector2.ZERO)
		_on_ResetButton_pressed()

func _on_ResetButton_pressed():
	$Antenna1Enabled.button_pressed=true;
	$Antenna2Enabled.button_pressed=true;
	$Antenna3Enabled.button_pressed=true;
	$Antenna4Enabled.button_pressed=true;
	graph_node.toggle_antenna(true, 1)
	graph_node.toggle_antenna(true, 2)
	graph_node.toggle_antenna(true, 3)
	graph_node.toggle_antenna(true, 4)
	$ASpaceHBox/ASpaceSlider.value=27.5
	graph_node.set_NESW_with_a_space(27.5)
	graph_node.set_NWSE_with_a_space(27.5)
	$ASpaceHBox/ASpaceSliderButton.button_pressed=true;
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

	graph_node.hide_below_ground(false)
	graph_node.set_show_vor_circle(false)
	self.set_show_error(false)

func _on_ASpaceSlider_value_changed(value):
	graph_node.set_NWSE_with_a_space(value)
	graph_node.set_NESW_with_a_space(value)



func _on_CarrierButton_pressed():
	$Antenna1Enabled.button_pressed=true;
	$Antenna2Enabled.button_pressed=true;
	$Antenna3Enabled.button_pressed=true;
	$Antenna4Enabled.button_pressed=true;
	graph_node.toggle_antenna(true, 1)
	graph_node.toggle_antenna(true, 2)
	graph_node.toggle_antenna(true, 3)
	graph_node.toggle_antenna(true, 4)
	$ASpaceHBox/ASpaceSlider.value=27.5
	graph_node.set_NESW_with_a_space(27.5)
	graph_node.set_NWSE_with_a_space(27.5)
	$ASpaceHBox/ASpaceSliderButton.button_pressed=true;
	$Antenna1Phase/Antenna1PhaseSlider.value = 225.0;
	$Antenna2Phase/Antenna2PhaseSlider.value = 225.0;
	$Antenna3Phase/Antenna3PhaseSlider.value = 225.0;
	$Antenna4Phase/Antenna4PhaseSlider.value = 225.0;
	graph_node.set_antenna_phase(225.0,1)
	graph_node.set_antenna_phase(225.0,2)
	graph_node.set_antenna_phase(225.0,3)
	graph_node.set_antenna_phase(225.0,4)
	
	$Antenna1Current/Antenna1CurrentSlider.value=1.0
	$Antenna2Current/AntennaCurrentSlider.value=1.0
	$Antenna3Current/AntennaCurrentSlider.value=1.0
	$Antenna4Current/AntennaCurrentSlider.value=1.0
	graph_node.set_antenna_amplitude(1,1)
	graph_node.set_antenna_amplitude(1,2)
	graph_node.set_antenna_amplitude(1,3)
	graph_node.set_antenna_amplitude(1,4)

	graph_node.hide_below_ground(false)
	


func _on_SidebandButton_pressed():
#	_on_ResetButton_pressed()
	$Antenna1Enabled.button_pressed=true;
	$Antenna2Enabled.button_pressed=true;
	$Antenna3Enabled.button_pressed=true;
	$Antenna4Enabled.button_pressed=true;
	graph_node.toggle_antenna(true, 1)
	graph_node.toggle_antenna(true, 2)
	graph_node.toggle_antenna(true, 3)
	graph_node.toggle_antenna(true, 4)
	$ASpaceHBox/ASpaceSlider.value=27.5
	graph_node.set_NESW_with_a_space(27.5)
	graph_node.set_NWSE_with_a_space(27.5)
	$ASpaceHBox/ASpaceSliderButton.button_pressed=true;
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

func set_show_error(value):
	$"%PhaseReaders".visible=value;
