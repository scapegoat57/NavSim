extends Label

@export var slider_path:NodePath
var slider:Slider
var format_string:String

# Called when the node enters the scene tree for the first time.
func _ready():
	slider=get_node(slider_path)
	format_string=text
# warning-ignore:return_value_discarded
	(slider as Range).connect("value_changed", Callable(self, "value_changed"))
	update_text()

func update_text():
	if (format_string):
		text=format_string % slider.value

func value_changed(_value):
	update_text()
