extends Node3D

#so pressing the same key multiple time would'nt play the same animation
#probobly change event to something else (IDK)

# (Cake) shouldn't it be this way? why pressing the same key multiple
# times do something? I don't get it

enum events{
	desk,
	customers,
	default
}

var last_event = null

func _input(event: InputEvent) -> void:
	# Only accepts inputs if the camera is stopped, so it doesn't snaps
	# brutally to other position in the middle of the animation
	if not $AnimationPlayer.is_playing():
		if event.is_action("A") and last_event != events.customers:
			$AnimationPlayer.play("desk_to_customers_new")
			last_event = events.customers

		# FIXME: Figure out how to switch "S" to "D"
		elif event.is_action("S") and last_event != events.desk and last_event != null:
			$AnimationPlayer.play("customers_to_desk_new")
			last_event = events.desk
		
		# TODO: Change to the default view with "S"
		elif false:
			#$AnimationPlayer.play()
			last_event = events.default
