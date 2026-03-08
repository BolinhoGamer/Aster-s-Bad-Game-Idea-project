extends Control

func _on_volume_slider_value_changed(value: float) -> void:
	if value <= -20.0:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -1000000)
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
