extends VSlider

func _ready():
	%Graph.connect("zoom_level_changed", zoom_level_changed)

func zoom_level_changed(new_value):
	if self.value != new_value:
		self.value = new_value;
