extends RichTextLabel

# STOP MESSING UP WITH THIS, FOR THE LOVE OF GOD, I DON'T WANT TO FIX IT AGAIN
# I'VE FIXED IT YESTERDAY...
@onready var final_rush_timer := $"/root/Main/CustomersManager/FinalRushTimer"

#when you lose via score
signal player_lose

var score = 300

func _on_customers_manager_update_score_counter(change: int) -> void:
	update_score(change)

func _on_ghost_child_manager_update_score_counter(change: int) -> void:
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
