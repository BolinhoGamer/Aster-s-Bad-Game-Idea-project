extends Node


func _on_rain_sound_effect_finished() -> void:
	$RainTimer.start(randi_range(10, 100))


func _on_rain_timer_timeout() -> void:
	$RainSoundEffect.pitch_scale = randf_range(0.98, 1.02)
	$RainSoundEffect.play()
