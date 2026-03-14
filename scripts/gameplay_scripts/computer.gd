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
	
	if event.is_action("change camera to no 1"):
		state = eComputerState.e_cmp_0
		print('Q')
		
	elif event.is_action("change camera to no 2"):
		state = eComputerState.e_cmp_1
		print('W')
	
	elif event.is_action("change camera to no 3"):
		state = eComputerState.e_cmp_2
		print('E')
		
	elif event.is_action("change camera to no 4"):
		state = eComputerState.e_cmp_3
		print('R')
