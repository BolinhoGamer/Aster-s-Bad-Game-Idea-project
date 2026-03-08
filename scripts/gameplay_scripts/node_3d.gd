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

var last_event = events.desk


func go_to_desk():
	if last_event == events.customers:
		$AnimationPlayer.play("customers_to_desk_new")
	
	elif last_event == events.default:
		$AnimationPlayer.play("default_to_desk")


func go_to_customers():
	if last_event == events.desk:
		$AnimationPlayer.play("desk_to_customers_new")
	
	elif last_event == events.default:
		$AnimationPlayer.play("default_to_customers")


func go_to_default():
	if last_event == events.desk:
		$AnimationPlayer.play("desk_to_default")
	
	elif last_event == events.customers:
		$AnimationPlayer.play("customers_to_default")


func _input(event: InputEvent) -> void:
	# Only accepts inputs if the camera is stopped, so it doesn't snaps
	# brutally to other position in the middle of the animation
	if not $AnimationPlayer.is_playing():
		if event.is_action("A") and last_event != events.customers:
			go_to_customers()
			last_event = events.customers

		elif event.is_action("D") and last_event != events.desk:
			go_to_desk()
			last_event = events.desk
		
		elif event.is_action("S") and last_event != events.default:
			go_to_default()
			last_event = events.default
