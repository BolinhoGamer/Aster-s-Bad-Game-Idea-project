extends Sprite3D

@onready var buzz_sound := $Buzz
@onready var ComputerUI := $"../CanvasLayer/ComputerUI/Control"

const SELECTED_COLOR = Color(1, 1, 1)
const UNSELECTED_COLOR = Color(0, 0, 0)

enum eComputerState {
	e_cmp_0,
	e_cmp_1,
	e_cmp_2,
	e_cmp_3
}

var state: eComputerState = eComputerState.e_cmp_0

func _input(event: InputEvent) -> void:
	# *------------------------* #
	# | Computer state manager | #
	# *------------------------* #
	for x in ComputerUI.get_children():
		if "Key" in x.name:
			x.self_modulate = UNSELECTED_COLOR
	if event.is_action("change camera to no 1"):
		state = eComputerState.e_cmp_0
		print('Q')
		ComputerUI.find_child("QKey").self_modulate = SELECTED_COLOR
	elif event.is_action("change camera to no 2"):
		state = eComputerState.e_cmp_1
		print('W')
		ComputerUI.find_child("WKey").self_modulate = SELECTED_COLOR
	elif event.is_action("change camera to no 3"):
		state = eComputerState.e_cmp_2
		print('E')
		ComputerUI.find_child("EKey").self_modulate = SELECTED_COLOR
	elif event.is_action("change camera to no 4"):
		state = eComputerState.e_cmp_3
		print('R')
		ComputerUI.find_child("RKey").self_modulate = SELECTED_COLOR
func _on_father_spawn():
	buzz_sound.play()
	
