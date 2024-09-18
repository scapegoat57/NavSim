extends Sprite2D

var sweep_tween
var cont_tween

signal sweeping

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.variable_antenna=self;
	pass


func _physics_process(delta):
	if (sweep_tween and sweep_tween.is_running()):
		Global.emit_signal("variable_output", $Beam.rotation_degrees+90);
	else:
		Global.emit_signal("variable_output", -1)

func sweep():
	if sweep_tween:
		sweep_tween.kill();
	$Beam.rotation_degrees = -90;
	sweep_tween=get_tree().create_tween()
	sweep_tween.tween_property($Beam,"rotation_degrees",270.0, Global.sweep_time);
	sweep_tween.tween_callback(Callable(self, "stop_sweep"));
	$Beam.visible=true;

func step(value):
	print($Beam.rotation+90)
	sweep_tween.kill()
	
func stop_sweep():
	$Beam.visible = false;

func cycle_toggled(button_pressed):
	if (button_pressed):
#		sweep_and_blink()
		cont_tween=get_tree().create_tween()
		cont_tween.tween_callback(Callable(self, "sweep_and_blink")).set_delay(3.60)
		cont_tween.set_loops();
	else:
		if cont_tween:
			cont_tween.kill();
