extends Label

@export var target:Node
@export var target_property:String
@export var format_string:String

# Called when the node enters the scene tree for the first time.
func _ready():
	target.connect("on_property_changed", on_property_changed)

func on_property_changed(property_name):
	if (property_name == "" or property_name == target_property):
		text=format_string % target.get(target_property)

func value_changed(value):
	if (!format_string):
		format_string=text;
	text=format_string % value
