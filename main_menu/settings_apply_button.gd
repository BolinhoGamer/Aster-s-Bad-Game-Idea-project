extends GenericButtonSuper


func _pressed() -> void:
	#Audio
	AudioServer.set_bus_volume_db(0, linear_to_db($"../AudioSetting/MasterSoundSlider".value))
	AudioServer.set_bus_volume_db(1, linear_to_db($"../AudioSetting/MusicSlider".value))
	AudioServer.set_bus_volume_db(2, linear_to_db($"../AudioSetting/SFXSlider".value))
