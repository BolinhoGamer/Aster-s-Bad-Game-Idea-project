extends Node3D

#so pressing the same key multiple time would'nt play the same animation
#probobly change event to something else (IDK)
enum events{
	desk,
	customers
}

var last_event = null

func _input(event: InputEvent) -> void:
	if event.is_action("S") and last_event != events.customers:
		$AnimationPlayer.play("desk_to_customers")
		last_event = events.customers

	elif event.is_action("A") and last_event != events.desk:
		$AnimationPlayer.play("customers_to_desk")
		last_event = events.desk
