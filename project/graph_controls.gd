extends VBoxContainer

export var graph_path:NodePath
onready var graph_node=get_node(graph_path) as RadiationGraph;

var vor_timer=0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	_on_ResetButton_pressed()
	
func _process(delta):
	vor_timer+=delta;
	var sideband1_amplitude=sin(vor_timer)+.01
	graph_node.set_antenna_amplitude(1,sideband1_amplitude)
	graph_node.set_antenna_amplitude(2,sideband1_amplitude)
	
	var sideband2_amplitude=-cos(vor_timer)+.01
	graph_node.set_antenna_amplitude(3,sideband2_amplitude)
	graph_node.set_antenna_amplitude(4,sideband2_amplitude)



func _on_ASpaceToggle_toggled(button_pressed):
	$ASpaceHBox/ASpaceSlider.step = 45.0 if button_pressed else 0.5


func _on_Antenna1Enabled_toggled(button_pressed):
	graph_node.toggle_antenna(1,button_pressed)


func _on_Antenna2Enabled_toggled(button_pressed):
	graph_node.toggle_antenna(2,button_pressed)


func _on_SipButton_toggled(button_pressed):
	graph_node.toggle_SIP(button_pressed)


func _on_ResetButton_pressed():
	$SipButton.pressed=true;
	$Antenna1Enabled.pressed=true;
	$Antenna2Enabled.pressed=true;
	$Antenna3Enabled.pressed=false;
	$Antenna4Enabled.pressed=false;
	$ASpaceHBox/ASpaceSlider.value=0
	$ASpaceHBox/ASpaceToggle.pressed=true;
	$Antenna1PhaseSlider.value = 0;
	$Antenna2PhaseSlider.value = 0;
	


func _on_PauseButton_toggled(button_pressed):
	graph_node.toggle_paused(button_pressed)


func _on_ASpaceSlider_value_changed(value):
	$ASpaceLabel.text="a spacing: "+String(value)
#	graph_node.set_NWSE_with_a_space(value)
	graph_node.set_pos_with_a_spacing(value)


func _on_ResetTimeButton_pressed():
	graph_node.reset_time()


func _on_Antenna1PhaseSlider_value_changed(value):
	graph_node.set_antenna_phase(1,value)
	$Antenn1PhaseLabel.text="Phase: " + ("+" if value>0 else "") + String(value)


func _on_Antenna2PhaseSlider_value_changed(value):
	graph_node.set_antenna_phase(2,value)
	$Antenn2PhaseLabel.text="Phase: " + ("+" if value>0 else "") + String(value)

func _on_SopButton_pressed():
	$Antenna1PhaseSlider.value=0;
	$Antenna2PhaseSlider.value=180;


func _on_SipButton_pressed():
	$Antenna1PhaseSlider.value=0;
	$Antenna2PhaseSlider.value=0;


func _on_Antenna3Enabled_toggled(button_pressed):
	graph_node.toggle_antenna(3,button_pressed)


func _on_Antenna4Enabled_toggled(button_pressed):
	graph_node.toggle_antenna(4,button_pressed)


func _on_VorButton_pressed():
	graph_node.set_NWSE_with_a_space(27.5)
	graph_node.set_NESW_with_a_space(27.5)
	$Antenna1PhaseSlider.value=180.0
	$Antenna2PhaseSlider.value=0.0
	$Antenna3PhaseSlider.value=180.0
	$Antenna4PhaseSlider.value=0.0


func _on_Antenna3PhaseSlider_value_changed(value):
	graph_node.set_antenna_phase(3,value)
	$Antenn3PhaseLabel.text="Phase: " + ("+" if value>0 else "") + String(value)


func _on_Antenna4PhaseSlider_value_changed(value):
	graph_node.set_antenna_phase(4,value)
	$Antenn4PhaseLabel.text="Phase: " + ("+" if value>0 else "") + String(value)
