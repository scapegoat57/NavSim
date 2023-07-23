extends VSlider

@export var graph_path:NodePath
@onready var graph_node=get_node(graph_path) as RadiationGraph;

func _ready():
	graph_node.connect("zoom_level_changed", Callable(self, "zoom_level_changed"))

func zoom_level_changed(new_value):
	if self.value != new_value:
		self.value = new_value;

