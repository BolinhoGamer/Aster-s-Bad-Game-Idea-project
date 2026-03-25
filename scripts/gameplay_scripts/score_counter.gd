extends RichTextLabel

@onready var final_rush_timer := $FinalRushTimer

#when you lose via score
signal player_lose

var score = 300

func _on_customers_manager_update_score_counter(change: int) -> void:
	update_score(change)

func _on_child_ghost_manager_update_score_counter(change: int) -> void:
	update_score(change)


func update_score(change: int):
	score += change
	
	if score >= 500:
		if final_rush_timer.is_stopped():
			final_rush_timer.start()
		score = 500
		
	elif score <= 0:
		score = 0
		player_lose.emit()
		
	text = String.num(score, 0)
