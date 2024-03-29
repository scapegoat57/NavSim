extends Button

@export var coarse_step: float = 10: set = coarse_step_set
@export var fine_step: float = 1: set = fine_step_set
@export var is_coarse: bool = true: set = is_coarse_set
@export var slider: Slider


func _ready():
	is_coarse=self.button_pressed
	_update_step()

func coarse_step_set(value):
	coarse_step=value
	_update_step()
	
	
func fine_step_set(value):
	fine_step=value
	_update_step()
	
	
func is_coarse_set(value):
	is_coarse=value
	_update_step()


func _toggled(value):
	is_coarse=value;
	_update_step()


func _update_step():
	if slider:
		slider.step=coarse_step if is_coarse else fine_step
