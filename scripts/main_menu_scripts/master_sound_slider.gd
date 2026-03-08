extends HSlider

func drag_ended() -> void:
	get_tree().master_sound = tick_count 
	
	
