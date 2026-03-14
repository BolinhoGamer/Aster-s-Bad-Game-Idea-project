extends Control

@onready var animationplayer = $"../../../AnimationPlayer"


func _on_resume_game_button_pressed() -> void:
	var InputAction = InputEventAction.new()
	InputAction.action = "pause game"
	InputAction.pressed = true
	Input.parse_input_event(InputAction)

func _on_exit_game_button_pressed() -> void:
	animationplayer.play("transition screen fade in")
	get_tree().quit()
