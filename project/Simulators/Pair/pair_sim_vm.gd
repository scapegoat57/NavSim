extends Node

signal on_property_changed(property_name:String)

@export var graph: Node
@export var aspace: float: 
	set(value):
		if aspace==value: return
		aspace=value
		emit_signal("on_property_changed", "aspace")
@export var phase1: float: 
	set(value):
		if phase1 == value: return
		phase1 = value
		emit_signal("on_property_changed", "phase1")
@export var current1: float=1.0: 
	set(value):
		if current1 == value: return
		current1 = value
		emit_signal("on_property_changed", "current1")
@export var enabled1: bool=true: 
	set(value):
		if enabled1 == value: return
		enabled1=value
		emit_signal("on_property_changed", "enabled1")
@export var enabled2: bool=true: 
	set(value):
		if enabled2 == value: return
		enabled2=value
		emit_signal("on_property_changed", "enabled2")
@export var phase2: float:
	set(value):
		if phase2 == value: return
		phase2 = value
		emit_signal("on_property_changed", "phase2")
@export var current2: float=1.0:
	set(value):
		if current2 == value: return
		current2 = value
		emit_signal("on_property_changed", "current2")
@export var overlay: bool = false:
	set(value):
		if overlay == value: return
		overlay=value;
		emit_signal("on_property_changed","overlay")
@export var phase_mode: bool = false:
	set(value):
		if phase_mode == value: return
		phase_mode=value;
		emit_signal("on_property_changed","phase_mode")
@export var diagram_mode: bool = false:
	set(value):
		if diagram_mode == value: return
		diagram_mode=value;
		emit_signal("on_property_changed","diagram_mode")
@export var underground: bool = false:
	set(value):
		if underground == value: return
		underground=value;
		emit_signal("on_property_changed","underground")

func _ready():
	graph.call_deferred("toggle_antenna",false, 3)
	graph.call_deferred("toggle_antenna",false, 4)
	emit_signal("on_property_changed","")


func _on_reset_button_pressed():
	aspace=0;
	phase1=0;
	phase2=0;
	current1=1;
	current2=1;
	enabled1=true;
	enabled2=true;
	overlay=false;
	phase_mode=false;
	underground=false;


func _on_sip_button_pressed():
	phase1=0
	phase2=0


func _on_sop_button_pressed():
	phase1=0;
	phase2=180;


func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
