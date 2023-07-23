extends StaticBody2D

var sweep_armed=true;
var is_timer_running;
var time_start;
var measured_time=0;
var measured_course;
var omni_course;
var m_a=0;
var dragging=false;
var drag_offset
var ref_points=[]
var ref_invalidated=false;
var var_points=[]
var var_invalidated=false;

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("intel_changed", Callable(self, "intel_changed"));
#	intel_changed(Global.intel_level);
	Global.connect("reference_output", Callable(self, "reference_output_received"))
	Global.connect("variable_output", Callable(self, "variable_output_received"))
	for i in 160:
		ref_points.append(Vector2(i/2.0,0))
		var_points.append(Vector2(i/2.0, 0))
	$"%ReferenceLine".points=PackedVector2Array(ref_points);
	$"%VariableLine".points = PackedVector2Array(var_points);

func _physics_process(delta):
	m_a=rad_to_deg(self.position.angle_to_point(Global.reference_antenna.position))+90
	if m_a < 0:
		m_a+=360
	if ref_invalidated:
		for i in ref_points.size():
			ref_points[i].x=i/2.0;
		$"%ReferenceLine".points=PackedVector2Array(ref_points);
	if var_invalidated:
		for i in var_points.size():
			var_points[i].x=i/2.0;
		$"%VariableLine".points=PackedVector2Array(var_points);

func reference_output_received(value):
	ref_points.append(Vector2(0,value * 20))
	ref_points.remove(0)
	ref_invalidated=true;
	if not is_timer_running and value>0:
		blink()

func variable_output_received(angle):
	var diff=(angle-m_a) * 4.0
	diff = clamp(diff, -180, 180)
	var value=cos(deg_to_rad(diff)) * 0.75;
	if angle ==-1 or value < 0:
		value=0;
	var_points.append(Vector2(0, value * 20))
	var_points.append(Vector2(0, -value * 20))
	var_points.remove(0)
	var_points.remove(0)
	var_invalidated=true;
	
	if value > 0.749 and is_timer_running:
		measured_time = (Time.get_ticks_msec()-time_start)/1000.0
		$"%TimerLabel".text=String(measured_time).pad_decimals(2).pad_zeros(1);
		omni_course=measured_time / Global.sweep_time * 360
		$"%CourseLabel".text=String(omni_course).pad_decimals(1).pad_zeros(3)
		$"%ALabel".text=String(m_a).pad_decimals(1).pad_zeros(3)
		$"%ErrorLabel".text = String(omni_course - m_a).pad_decimals(2).pad_zeros(1)
#			ce = oc - ma
#			oc=detected azimuth
#			ma= actual azimuth
		is_timer_running=false;
	

func intel_changed(value):
	$"%Bubble".visible= value >0;
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
	is_timer_running=true;
	time_start=Time.get_ticks_msec();
