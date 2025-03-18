extends Control

var data: PackedFloat32Array
var points: PackedVector2Array
var envelope_points:PackedVector2Array
var demod_points:PackedVector2Array
var sweep_length:float = .016 #seconds
var sweep_index=0;
var resolution:float = 2048
var effect:AudioEffectCapture
var pause=false
var mix_rate
@onready var scope: Line2D = $scope
@onready var envelope: Line2D = %envelope
@onready var demod: Line2D = %Demod

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mix_rate=AudioServer.get_mix_rate()
	var idx = AudioServer.get_bus_index("premix")
	effect = AudioServer.get_bus_effect(idx, 0)

	
	data.resize(resolution)
	data.fill(0)
	
	points.clear()
	points.resize(resolution)
	scope.points=points
	
	envelope_points.clear()
	envelope_points.resize(resolution*2)
	envelope.points=points
	
	demod_points.clear()
	demod_points.resize(resolution)
	demod.points=demod_points
	
	sweep_length=%SweepSlider.value
	%RichTextLabel.text=str(sweep_length)
	%PacerPlayer.stream_paused=true

func update_points()->void:
	var overmod=false
	for n in resolution:
		var x = n/resolution*800
		var modulated = (1* (1+1*-data[n]))
		points[n]=(Vector2(x, data[n]*50))
		var carrier=Vector2(x, modulated*-50)
		if modulated<-0.01:
			overmod=true
		envelope_points[n*2]=carrier
		envelope_points[n*2+1]=carrier
		envelope_points[n*2+1].y*=-1
		demod_points[n]=Vector2(x, (abs(modulated)-1)*-50)
		
	scope.points=points
	envelope.points=envelope_points
	demod.points=demod_points
	
	%OvermodLabel.visible=overmod

func _process(delta: float) -> void:
	if pause:
		return
		
	var frames = effect.get_frames_available()
	if (frames == 0):
		return

	var buffer = effect.get_buffer(frames)
	var elapsed_time=frames / mix_rate
	var frames_length:float=elapsed_time/sweep_length * resolution

	
	for i in frames_length:
		data[sweep_index]=buffer[floor(i/frames_length * frames)].x
		sweep_index+=1
		sweep_index%=resolution as int

	#if true:
		#var generator:AudioStreamGeneratorPlayback =  %DemodPlayer.get_stream_playback()
		#if (generator.can_push_buffer(frames)):
			#for i in frames:
				#if buffer[i].y<-1.01:
					##print(buffer[i].y)
					#buffer[i].y=-buffer[i].y-1
			#generator.push_buffer(buffer)
		#print(generator.get_frames_available(), "   ",frames)

	update_points()
	

func _on_pause_toggled(toggled_on: bool) -> void:
	pause=toggled_on
	


func _on_h_slider_value_changed(value: float) -> void:
	sweep_length=value;
	%RichTextLabel.text="%.3f" % value


func _on_90hz_button_toggled(toggled_on: bool) -> void:
	%"90hzPlayer".playing=toggled_on


func _on_150hz_button_toggled(toggled_on: bool) -> void:
	%"150hzPlayer".playing=toggled_on


func _on_1020hz_button_toggled(toggled_on: bool) -> void:
	%"1020hzPlayer".playing=toggled_on


func _on_microphone_button_toggled(toggled_on: bool) -> void:
	%MicrophonePlayer.playing=toggled_on


func _on_mod_90_value_changed(value: float) -> void:
	%"90hzPlayer".volume_db = linear_to_db(value)


func _on_mod_150_value_changed(value: float) -> void:
	%"150hzPlayer".volume_db = linear_to_db(value)


func _on_mod_1020_value_changed(value: float) -> void:
	%"1020hzPlayer".volume_db = linear_to_db(value)


func _on_modmic_value_changed(value: float) -> void:
	%"MicrophonePlayer".volume_db = linear_to_db(value)


func _on_pre_mix_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("premix"),toggled_on)


func _on_mod_pacer_value_changed(value: float) -> void:
	%PacerPlayer.volume_db = linear_to_db(value)


func _on_pacer_button_toggled(toggled_on: bool) -> void:
	%PacerPlayer.stream_paused=not toggled_on
