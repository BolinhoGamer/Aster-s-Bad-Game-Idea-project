extends HSlider

func drag_ended() -> void:
	get_tree().mouse_sensetivity = tick_count 
