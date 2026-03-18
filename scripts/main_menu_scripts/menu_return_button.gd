extends GenericButtonSuper

@onready var main_node := $".."

func _pressed() -> void:
	main_node.state = main_node.eGlobalGameState.e_ggs_on_main_menu
