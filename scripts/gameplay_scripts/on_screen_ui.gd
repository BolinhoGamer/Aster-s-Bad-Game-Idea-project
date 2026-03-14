extends Control

@onready var pause_menu := $PauseMenu

var is_paused := false
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause game"):
		if is_paused == true:
			pause_menu.hide()
			Engine.time_scale = 1
			is_paused = false
		else:
			pause_menu.show()
			Engine.time_scale = 0
			is_paused = true
		
