extends GenericButtonSuper


var was_pressed := false
func _pressed() -> void:
	if was_pressed == false:
		was_pressed = true
	#a second press means cancel listening
	else:
		was_pressed = false

#(mutedfish)to much work for me rn, will do later
#func _input(event: InputEvent) -> void:
#	if event is InputEventKey and event.is_pressed() and is_valid_key(event):
#		InputHelper.
