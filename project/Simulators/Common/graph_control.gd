extends Control
class_name GraphControl


@export var target: Node

func _ready():
	
	if (target): target.connect("on_property_changed", on_property_changed)

func on_property_changed(property_name):
	var all = true if property_name == "" else false
	if (all or property_name=="aspace"):
		%Graph.set_pos_with_a_spacing(target.get("aspace"), 1,2)
	if (all or property_name == "phase1"):
		%Graph.set_antenna_phase(target.get("phase1"), 1)
	if (all or property_name == "phase2"):
		%Graph.set_antenna_phase(target.get("phase2"), 2)
	if (all or property_name == "current1"):
		%Graph.set_antenna_amplitude(target.get("current1"), 1)
	if (all or property_name == "current2"):
		%Graph.set_antenna_amplitude(target.get("current2"), 2)
	if (all or property_name == "enabled1"):
		%Graph.toggle_antenna(target.get("enabled1"), 1);
	if (all or property_name == "enabled2"):
		%Graph.toggle_antenna(target.get("enabled2"), 2);
	if (all or property_name == "overlay"):
		%Graph.set_overlay(target.get("overlay"));
	if all or property_name == "phase_mode":
		%Graph.set_phase_mode(target.get("phase_mode"))
	if all or property_name == "diagram_mode":
		%Graph.set_diagram_mode(target.get("diagram_mode"))
	if all or property_name == "underground":
		%Graph.hide_below_ground(target.get("underground"))

func toggle_antenna(enabled, index):
	%Graph.toggle_antenna(enabled, index);
