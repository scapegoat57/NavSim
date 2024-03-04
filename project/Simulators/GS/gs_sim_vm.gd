extends Node

signal on_property_changed(property_name:String)

@export var graph: GraphControl
@export var aspaceCSB: float=1720: 
	set(value):
		if aspaceCSB==value: return
		aspaceCSB=value
		emit_signal("on_property_changed", "aspaceCSB")
@export var aspaceSBO: float=3440: 
	set(value):
		if aspaceSBO==value: return
		aspaceSBO=value
		emit_signal("on_property_changed", "aspaceSBO")
@export var phaseCSB: float: 
	set(value):
		if phaseCSB == value: return
		phaseCSB = value
		emit_signal("on_property_changed", "phaseCSB")
@export var currentCSB: float=1.0: 
	set(value):
		if currentCSB == value: return
		currentCSB = value
		emit_signal("on_property_changed", "currentCSB")
@export var enabledCSB: bool=true: 
	set(value):
		if enabledCSB == value: return
		enabledCSB=value
		emit_signal("on_property_changed", "enabledCSB")
@export var enabledSBO: bool=false: 
	set(value):
		if enabledSBO == value: return
		enabledSBO=value
		emit_signal("on_property_changed", "enabledSBO")
@export var phaseSBO: float:
	set(value):
		if phaseSBO == value: return
		phaseSBO = value
		emit_signal("on_property_changed", "phaseSBO")
@export var currentSBO: float=1.0:
	set(value):
		if currentSBO == value: return
		currentSBO = value
		emit_signal("on_property_changed", "currentSBO")
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
@export var underground: bool = true:
	set(value):
		if underground == value: return
		underground=value;
		emit_signal("on_property_changed","underground")
@export var insert_phase: float:
	set(value):
		if insert_phase == value: return
		insert_phase=value
		emit_signal("on_property_changed", "insert_phase")

func _ready():
	call_deferred("emit_signal","on_property_changed","")


func _on_reset_button_pressed():
	aspaceCSB=1720;
	aspaceSBO=3440
	phaseCSB=0;
	phaseSBO=0;
	currentCSB=1;
	currentSBO=1;
	enabledCSB=true;
	enabledSBO=true;
	overlay=false;
	phase_mode=false;
	underground=false;

func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_swap_button_pressed():
	if enabledCSB:
		enabledCSB=false;
		enabledSBO=true;
	else:
		enabledCSB=true
		enabledSBO=false


func _on_insert_changed(button_pressed, added):
	insert_phase = added if button_pressed else 0
