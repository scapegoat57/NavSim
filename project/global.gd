extends Node

signal intel_changed
signal reference_output
signal variable_output
signal reference_trigger

var lighthouse
var sweep_time = 3.6
var blink_time = 0.1
var intel_level = 0

var reference_antenna
var variable_antenna

func set_intel_level(value):
	intel_level=value
	emit_signal("intel_changed", intel_level)
