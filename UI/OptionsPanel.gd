extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$VolumeControl/GeneralVolumeSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ApplyOptionsButton_pressed():
	print($VolumeControl/GeneralVolumeSlider.value)
	
	if($VolumeControl/GeneralVolumeSlider.value< -34):
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
		pass
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		pass
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), $VolumeControl/GeneralVolumeSlider.value)
	pass # Replace with function body.


func _on_GeneralVolumeSlider_value_changed(value):
	if($VolumeControl/GeneralVolumeSlider.value< -34):
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
		pass
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		pass
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), $VolumeControl/GeneralVolumeSlider.value)
	$VolumeControl/VolumePercentLabel.text = str(int(($VolumeControl/GeneralVolumeSlider.value+35)/0.41))
	pass # Replace with function body.


func _on_CancelOptionsButton_pressed():
	visible = false
	pass # Replace with function body.
