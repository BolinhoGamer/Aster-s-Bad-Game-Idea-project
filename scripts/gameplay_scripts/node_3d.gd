extends Node3D

#so pressing the same key multiple time would'nt play the same animation
#probobly change event to something else (IDK)

# (Cake) shouldn't it be this way? why pressing the same key multiple
# times do something? I don't get it

@onready var animationplayer =  $AnimationPlayer


enum events{
	desk,
	customers,
	default
}

var last_event = events.desk

enum night_end{
	lose,
	win
}

var exit : int

var score := 300

func _ready() -> void:
	animationplayer.play("transition screen fade out")

func go_to_desk():
	if last_event == events.customers:
		animationplayer.play("camera movement/customers_to_desk_new")
	
	elif last_event == events.default:
		animationplayer.play("camera movement/default_to_desk")


func go_to_customers():
	if last_event == events.desk:
		animationplayer.play("camera movement/desk_to_customers_new")
	
	elif last_event == events.default:
		animationplayer.play("camera movement/default_to_customers")


func go_to_default():
	if last_event == events.desk:
		animationplayer.play("camera movement/desk_to_default")
	
	elif last_event == events.customers:
		animationplayer.play("camera movement/customers_to_default")


func _input(event: InputEvent) -> void:
	# Only accepts inputs if the camera is stopped, so it doesn't snaps
	# brutally to other position in the middle of the animation
	if not animationplayer.is_playing():
		if event.is_action("A") and last_event != events.customers:
			go_to_customers()
			last_event = events.customers

		elif event.is_action("D") and last_event != events.desk:
			go_to_desk()
			last_event = events.desk
		
		elif event.is_action("S") and last_event != events.default:
			go_to_default()
			last_event = events.default


func _on_customers_manager_update_score_counter(new_score: int) -> void:
	if new_score <= 0:
		animationplayer.play("transition screen fade in")
		exit = night_end.lose


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "transition screen fade in":
		if exit == night_end.lose:
			get_tree().change_scene_to_file("res://scenes/game_over_screen.tscn")
		elif exit == night_end.win:
			get_tree().change_scene_to_file("res://scenes/win_screen.tscn")


func _on_final_rush_timer_timeout() -> void:
	animationplayer.play("transition screen fade in")
	exit = night_end.win
