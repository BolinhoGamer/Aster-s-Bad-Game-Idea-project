extends GenericButtonSuper

func _pressed() -> void:
	get_parent().state = get_parent().eGlobalGameState.e_ggs_on_credits
