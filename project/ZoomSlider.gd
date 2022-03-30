extends VSlider

export var graph_path:NodePath
onready var graph_node=get_node(graph_path) as RadiationGraph;

func _ready():
	graph_node.connect("zoom_level_changed", self, "zoom_level_changed")

func zoom_level_changed(value):
	if self.value != value:
		self.value = value;

