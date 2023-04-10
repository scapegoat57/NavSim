extends StaticBody2D

var is_timer_running;
var time_start;
var measured_time=0;
var measured_course;
var omni_course;
var m_a;
var dragging=false;
var drag_offset

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("intel_changed", self, "intel_changed");
	intel_changed(Global.intel_level);
	if Global.lighthouse:
		Global.lighthouse.connect("blinking", self, "blink");
		Global.lighthouse.connect("sweeping", self, "sweep");

func intel_changed(value):
	$"%Bubble".visible= value >0;
	$Bubble/VBoxContainer/LightsContainer.visible = value >= 1 and value <=3
	$Bubble/VBoxContainer/Label.visible = value >=2 and value <=4
	$"%TimerLabel".visible = value >= 2 and value <= 4
	$Bubble/VBoxContainer/Label3. visible = value >= 3 and value < 6
	$Bubble/VBoxContainer/OCContainer.visible = value >= 3and value < 6
	$Bubble/VBoxContainer/Label5.visible = value >= 4and value < 6
	$Bubble/VBoxContainer/AzContainer.visible = value >= 4and value < 6
	$Bubble/VBoxContainer/Label4.visible = value >= 5
	$Bubble/VBoxContainer/ErrorContainer.visible = value >= 5

func _input(event):
	if event is InputEventMouseMotion:
		if dragging:
			position=drag_offset+event.position
	if event is InputEventMouseButton:
		if dragging:
			if not event.pressed:
				position=drag_offset+event.position
				dragging=false;
		
		
func _process(delta):
	if (is_timer_running):
		measured_time = (Time.get_ticks_msec()-time_start)/1000.0
		$"%TimerLabel".text=String(measured_time).pad_decimals(2).pad_zeros(1);
	pass

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		dragging=event.pressed
		drag_offset=position-event.position;


func blink():
	$"%GreenPlayer".play("blink")
	is_timer_running=true;
	time_start=Time.get_ticks_msec();

func sweep(value):		
	if is_timer_running:
		m_a=rad2deg(self.position.angle_to_point(Global.lighthouse.position))+90
		if m_a < 0:
			m_a+=360
		if (value>=m_a):
			measured_time = (Time.get_ticks_msec()-time_start)/1000.0
			$"%TimerLabel".text=String(measured_time).pad_decimals(2).pad_zeros(1);
			omni_course=measured_time / Global.sweep_time * 360
			$"%RedPlayer".play("blink")
			$"%CourseLabel".text=String(omni_course).pad_decimals(1).pad_zeros(3)
			$"%ALabel".text=String(m_a).pad_decimals(1).pad_zeros(3)
			$"%ErrorLabel".text = String(omni_course - m_a).pad_decimals(2).pad_zeros(1)
#			ce = oc - ma
#			oc=detected azimuth
#			ma= actual azimuth
			is_timer_running=false;
