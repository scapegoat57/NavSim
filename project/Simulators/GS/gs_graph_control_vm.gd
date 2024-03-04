
extends Control


@export var target: Node
@export var point: DragPoint

func _ready():
	if (target): target.connect("on_property_changed", on_property_changed, CONNECT_DEFERRED)
	%Graph/PEW.visible=true;
	%Graph/GlidePath.visible=true;
	%Graph/PW.visible=true;

func _input(event):
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_RIGHT:
			point.graph_pos=%Graph.world_to_graph(event.position)
	if event is InputEventMouseButton:
		if event.pressed and event.button_mask == MOUSE_BUTTON_MASK_RIGHT:
			point.graph_pos=%Graph.world_to_graph(event.position)


func on_property_changed(property_name):
	var all = true if property_name == "" else false
	if (all or property_name=="aspaceCSB"):
		%Graph.set_pos_with_a_spacing(target.get("aspaceCSB"), 1,2)
	if (all or property_name=="aspaceSBO"):
		%Graph.set_pos_with_a_spacing(target.get("aspaceSBO"), 3,4)
	if (all or property_name == "phaseCSB"):
		%Graph.set_antenna_phase(target.get("phaseCSB"), 1)
		%Graph.set_antenna_phase(target.get("phaseCSB")+180, 2)
	if (all or property_name == "phaseSBO" or property_name == "insert_phase"):
		%Graph.set_antenna_phase(target.get("phaseSBO") + target.get("insert_phase"), 3)
		%Graph.set_antenna_phase(target.get("phaseSBO") + target.get("insert_phase") +180, 4)
	if (all or property_name == "currentCSB"):
		%Graph.set_antenna_amplitude(target.get("currentCSB"), 1)
		%Graph.set_antenna_amplitude(target.get("currentCSB"), 2)
	if (all or property_name == "currentSBO"):
		%Graph.set_antenna_amplitude(target.get("currentSBO"), 3)
		%Graph.set_antenna_amplitude(target.get("currentSBO"), 4)
	if (all or property_name == "enabledCSB"):
		%Graph.toggle_antenna(target.get("enabledCSB"), 1);
		%Graph.toggle_antenna(target.get("enabledCSB"), 2);
	if (all or property_name == "enabledSBO"):
		%Graph.toggle_antenna(target.get("enabledSBO"), 3);
		%Graph.toggle_antenna(target.get("enabledSBO"), 4);
	if (all or property_name == "overlay"):
		%Graph.set_overlay(target.get("overlay"));
	if all or property_name == "phase_mode":
		%Graph.set_phase_mode(target.get("phase_mode"))
	if all or property_name == "underground":
		%Graph.hide_below_ground(target.get("underground"))

func toggle_antenna(enabled, index):
	%Graph.toggle_antenna(enabled, index);
