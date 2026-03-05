extends Button

class_name GenericButtonSuper


var scale_factor:       float = 1
var targ_scale_factor:  float = 1

const MIN_SCALE_TARGET: float = 1
const MAX_SCALE_TARGET: float = 1.1


func _process(delta: float) -> void:
	# Changes the button size when hovering
	targ_scale_factor = MIN_SCALE_TARGET
	if is_hovered():
		targ_scale_factor = MAX_SCALE_TARGET
	
	scale_factor += (targ_scale_factor - scale_factor) * 5 * delta
	scale_factor = clamp(scale_factor, MIN_SCALE_TARGET, MAX_SCALE_TARGET)
	scale = Vector2(scale_factor, scale_factor)


func _pressed() -> void:
	print('Pressed!')
