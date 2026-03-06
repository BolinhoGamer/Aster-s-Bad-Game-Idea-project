extends Node3D


func _input(event: InputEvent) -> void:
	if event.is_action("S"):
		$AnimationPlayer.play("desk_to_customers")
	elif event.is_action("A"):
		$AnimationPlayer.play("customers_to_desk")
