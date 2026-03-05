extends Node2D

enum eGlobalGameState {
	e_ggs_on_main_menu,
	e_ggs_on_settings,
	e_ggs_on_credits
}

var state = eGlobalGameState.e_ggs_on_main_menu


func _on_ideophobia_ready() -> void:
	$Ideophobia.play()
	

func _process(delta: float) -> void:
	if state == eGlobalGameState.e_ggs_on_settings:
		$Camera2D.position = $Camera2D.SETTINGS_MENU_POS
		
	elif state == eGlobalGameState.e_ggs_on_credits:
		$Camera2D.position = $Camera2D.CREDITS_SCREEN_POS
