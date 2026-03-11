extends RichTextLabel


func _on_customers_manager_update_score_counter(new_score) -> void:
	text = String.num(new_score, 0)
