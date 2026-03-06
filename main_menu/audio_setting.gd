extends Control

func _ready() -> void:
	$MasterSoundSlider.value = db_to_linear(AudioServer.get_bus_channels(0))
	$MusicSlider.value = db_to_linear(AudioServer.get_bus_channels(1))
	$SFXSlider.value = db_to_linear(AudioServer.get_bus_channels(2))



func _on_master_sound_slider_mouse_exited() -> void:
	release_focus()


func _on_music_slider_mouse_exited() -> void:
	release_focus()


func _on_sfx_slider_mouse_exited() -> void:
	release_focus()
