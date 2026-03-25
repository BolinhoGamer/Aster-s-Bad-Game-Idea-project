extends Control

@onready var anim_player = $CanvasLayer/Transition

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	anim_player.play("fade out")

func _on_button_pressed() -> void:
	anim_player.play("fade in")


func _on_transition_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade in":
		get_tree().change_scene_to_file("res://scenes/gameplay.tscn")
