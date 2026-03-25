extends GenericButtonSuper

@onready var anim_player = $Transition

func _ready() -> void:
	anim_player.play("fade out")

func _pressed() -> void:
	anim_player.play("fade in")
	GlobalScript.shifts = 0
	# (Cake) I have no idea on what ButtonClicked is, but it doesn't seem to
	# exist, so it simply just crashes the game. (´。＿。｀)
	#$ButtonClicked.play()

func _on_transition_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade in":
		get_tree().change_scene_to_file("res://scenes/gameplay.tscn")
