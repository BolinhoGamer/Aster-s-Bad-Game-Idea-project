extends Sprite3D


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
	
	if event.is_action("Q"):
		state = eComputerState.e_cmp_0
		print('Q')
		
	elif event.is_action("W"):
		state = eComputerState.e_cmp_1
		print('W')
	
	elif event.is_action("E"):
		state = eComputerState.e_cmp_2
		print('E')
		
	elif event.is_action("R"):
		state = eComputerState.e_cmp_3
		print('R')
