extends Sprite

var blink_timer=0;

func _ready():
	Global.reference_antenna = self;

func _physics_process(delta):
	if blink_timer >0:
		blink_timer-=delta;
		var value=sin(blink_timer/ Global.blink_time * PI) * 0.75
		Global.emit_signal("reference_output",value)
		Global.emit_signal("reference_output",-value)
	else:
		Global.emit_signal("reference_output",0.0)
		Global.emit_signal("reference_output",0.0)
		$GreenLight.visible=false;

func blink():
	blink_timer=Global.blink_time
	$GreenLight.visible=true;
