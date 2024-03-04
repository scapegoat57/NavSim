extends Range

@export var target: Node
@export var target_property: String


# Called when the node enters the scene tree for the first time.
func _ready():
	target.connect("on_property_changed", on_property_changed)

func on_property_changed(property_name):
	if (property_name == "" or property_name == target_property):
		set_value_no_signal(target.get(target_property))

func _value_changed(new_value):
	target.set(target_property, new_value)
