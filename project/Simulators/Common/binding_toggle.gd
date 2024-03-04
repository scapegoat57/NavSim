extends Button

@export var target:Node
@export var target_property:String

# Called when the node enters the scene tree for the first time.
func _ready():
	target.connect("on_property_changed", on_property_changed)

func on_property_changed(property_name):
	if (property_name == "" or property_name == target_property):
		set_pressed_no_signal(target.get(target_property))

func _toggled(value):
	target.set(target_property, value)
