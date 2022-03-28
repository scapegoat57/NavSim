extends HBoxContainer

export var coarse_step: float = 10 setget coarse_step_set
export var fine_step: float = 1 setget fine_step_set
export var is_coarse: bool = true setget is_coarse_set

func coarse_step_set(value):
	coarse_step=value
	_update_step()
	
	
func fine_step_set(value):
	fine_step=value
	_update_step()
	
	
func is_coarse_set(value):
	is_coarse=value
	_update_step()


func _on_CoarseToggleButton_toggled(button_pressed):
	is_coarse=button_pressed;
	_update_step()


func _update_step():
	$HSlider.step=coarse_step if is_coarse else fine_step
