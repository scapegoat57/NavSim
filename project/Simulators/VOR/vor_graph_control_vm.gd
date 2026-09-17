
extends Control


@export var target: Node
@export var point: DragPoint

func _ready():
	if (target): target.connect("on_property_changed", on_property_changed, CONNECT_DEFERRED)


#func _input(event):
#	if event is InputEventMouseMotion:
#		if event.button_mask == MOUSE_BUTTON_MASK_RIGHT:
#			point.graph_pos=%Graph.world_to_graph(event.position)
#	if event is InputEventMouseButton:
#		if event.pressed and event.button_mask == MOUSE_BUTTON_MASK_RIGHT:
#			point.graph_pos=%Graph.world_to_graph(event.position)


func on_property_changed(property_name):
	var all = true if property_name == "" else false
	if (all or property_name=="frequency"):
		%Graph.set_frequency(target.get("frequency"))
	if (all or property_name=="aspace"):
		%Graph.set_NESW_with_a_space(target.get("aspace"))
		%Graph.set_NWSE_with_a_space(target.get("aspace"))
	if (all or property_name=="phase1" or property_name=="phase_preset"):
		if target.get("phase_preset")=="sideband":
			%Graph.set_antenna_phase(target.get("phase1")+180+135, 1)
			%Graph.set_antenna_phase(target.get("phase1")+135, 2)
		else:
			%Graph.set_antenna_phase(target.get("phase1"), 1)
			%Graph.set_antenna_phase(target.get("phase1"), 2)
	if (all or property_name=="phase2" or property_name== "phase_preset"):
		if target.get("phase_preset")=="sideband":
			%Graph.set_antenna_phase(target.get("phase2")-270+135, 3)
			%Graph.set_antenna_phase(target.get("phase2")-90+135, 4)
		else:
			%Graph.set_antenna_phase(target.get("phase2"), 3)
			%Graph.set_antenna_phase(target.get("phase2"), 4)
	if (all or property_name=="enabled1"):
		%Graph.toggle_antenna(target.get("enabled1"), 1)
		%Graph.toggle_antenna(target.get("enabled1"), 2)
	if (all or property_name=="enabled2"):
		%Graph.toggle_antenna(target.get("enabled2"), 3)
		%Graph.toggle_antenna(target.get("enabled2"), 4)
	if (all or property_name=="current1"):
		%Graph.set_antenna_amplitude(target.get("current1"), 1)
		%Graph.set_antenna_amplitude(target.get("current1"), 2)
	if (all or property_name=="current2"):
		%Graph.set_antenna_amplitude(target.get("current2"), 3)
		%Graph.set_antenna_amplitude(target.get("current2"), 4)
	if (all or property_name == "overlay"):
		%Graph.set_overlay(target.get("overlay"));
	if all or property_name == "phase_mode":
		%Graph.set_phase_mode(target.get("phase_mode"))
	%Graph.set_show_vor_circle(true)

func toggle_antenna(enabled, index):
	%Graph.toggle_antenna(enabled, index);
