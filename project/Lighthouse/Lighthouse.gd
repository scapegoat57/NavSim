extends Node2D


var blink_tween
var sweep_tween
var cont_tween

signal sweeping
signal blinking

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.lighthouse=self;
	pass

func _process(_delta):
	if (sweep_tween and sweep_tween.is_running()):
		emit_signal("sweeping", $Beam.rotation_degrees+90);


func blink():
	if (blink_tween):
		blink_tween.kill();
	blink_tween=get_tree().create_tween()
	emit_signal("blinking")
	blink_tween.tween_callback(Callable(self, "stop_blink")).set_delay(1)
	$GreenLight.visible=true;

func stop_blink():
	$GreenLight.visible=false;

func sweep():
	if sweep_tween:
		sweep_tween.kill();
	$Beam.rotation_degrees=-90
	sweep_tween=get_tree().create_tween()#.set_trans(Tween.TRANS_LINEAR)
	sweep_tween.tween_property($Beam,"rotation_degrees",270, Global.sweep_time);
	sweep_tween.tween_callback(Callable(self, "stop_sweep"));
	$Beam.visible=true;
	#sweep_tween.set_speed_scale(.01);
	
func stop_sweep():
	$Beam.visible = false;

func sweep_and_blink():
	sweep()
	blink()

func cycle_toggled(button_pressed):
	if (button_pressed):
		sweep_and_blink()
		cont_tween=get_tree().create_tween()
		cont_tween.tween_callback(Callable(self, "sweep_and_blink")).set_delay(Global.sweep_time)
		cont_tween.set_loops();
	else:
		if cont_tween:
			cont_tween.kill();
