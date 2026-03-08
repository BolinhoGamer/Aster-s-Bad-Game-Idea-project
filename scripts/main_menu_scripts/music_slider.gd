extends HSlider

func drag_ended() -> void:
	get_tree().music = tick_count 
