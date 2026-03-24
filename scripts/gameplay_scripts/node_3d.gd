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

enum positions{computer, default, paper}
var last_event = events.desk
var current_position = positions.default
var camera_positions = {
	"computer": {
		"position": Vector3(-1.8, 1.66, -2.3),
		"rotation": Vector3(0, 90, 0),
	},
	"default": {
		"position": Vector3(-0.5, 1.6, -1),
		"rotation": Vector3(0, 90, 0),
	},
	"paper": {
		"position": Vector3(-2.6, 1.6, 0.23),
		"rotation": Vector3(-85, 90, 0),
	}
}
var walk_tween: Tween
enum night_end{
	lose,
	win,
	main_menu_pause,
	restart_pause
}

var exit : int

var score := 300

func _ready() -> void:
	walk_player("default")
	animationplayer.play("transition screen fade out")

#func go_to_desk():
	#if last_event == events.customers:
		#animationplayer.play("camera movement/customers_to_desk_new")
	#
	#elif last_event == events.default:
		#animationplayer.play("camera movement/default_to_desk")
#
#
#func go_to_customers():
	#if last_event == events.desk:
		#animationplayer.play("camera movement/desk_to_customers_new")
	#
	#elif last_event == events.default:
		#animationplayer.play("camera movement/default_to_customers")
#
#
#func go_to_default():
	#if last_event == events.desk:
		#animationplayer.play("camera movement/desk_to_default")
	#
	#elif last_event == events.customers:
		#animationplayer.play("camera movement/customers_to_default")

const MOVEMENT_SPEED = 0.6
#func _input(event: InputEvent) -> void:
	## Only accepts inputs if the camera is stopped, so it doesn't snaps
	## brutally to other position in the middle of the animation
	#if not animationplayer.is_playing():
		#if event.is_action("A") and last_event != events.customers:
			#go_to_customers()
			#last_event = events.customers
#
		#elif event.is_action("D") and last_event != events.desk:
			#go_to_desk()
			#last_event = events.desk
		#
		#elif event.is_action("S") and last_event != events.default:
			#go_to_default()
			#last_event = events.default

func _input(event: InputEvent) -> void:
	# Only accepts inputs if the camera is stopped, so it doesn't snaps
	# brutally to other position in the middle of the animation
	if !event:
		return
	if walk_tween and walk_tween.is_running():
		return
	
	if event.is_action("move to computer"):
		walk_player("computer")
		#walk_customers()
	elif event.is_action("move to client"):
		walk_player("default")
		
	elif event.is_action("move to paper"):
		walk_player("paper")

func walk_player(target: String):
	if target in ["computer", "default", "paper"]:
		walk_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		walk_tween.tween_property($Camera3D, "position", camera_positions.get(target).position, MOVEMENT_SPEED)
		walk_tween.parallel().tween_property($Camera3D, "rotation_degrees", camera_positions.get(target).rotation, MOVEMENT_SPEED)
		current_position = positions.get(target)



var dic = {
		"QueuePosition0": null,
		"QueuePosition1": null,
		"QueuePosition2": null,
		"QueuePosition3": null,
		"QueuePosition4": null,
		#"QueuePosition5": null,
	}

#func walk_customers():
	#
	#for x in $CustomersManager/CustomerHolder.get_children():
		#
		#var customer_current_position = x.queue_position
		#var customer_target_position = customer_current_position - 1 
		#if customer_target_position != -1 and!dic["QueuePosition" + str(customer_target_position)]:
			#x.walk(customer_target_position)
			#dic["QueuePosition" + str(customer_target_position)] = x
			#dic["QueuePosition" + str(customer_current_position)] = null
#
#
#func _on_customer_timer_timeout() -> void:
	#walk_customers()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "transition screen fade in":
		if exit == night_end.lose:
			get_tree().change_scene_to_file("res://scenes/game_over_screen.tscn")
		elif exit == night_end.win:
			get_tree().change_scene_to_file("res://scenes/win_screen.tscn")
		elif exit == night_end.main_menu_pause:
			get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
		elif exit == night_end.restart_pause:
			get_tree().change_scene_to_file("res://scenes/gameplay.tscn")


func _on_customers_manager_update_score_counter(new_score: int) -> void:
	score = new_score
	if new_score <= 0:
		animationplayer.play("transition screen fade in")
		exit = night_end.lose


func _on_final_rush_timer_timeout() -> void:
	animationplayer.play("transition screen fade in")
	exit = night_end.win


func _on_main_menu_button_pressed() -> void:
	Engine.time_scale = 1
	animationplayer.play("transition screen fade in")
	exit = night_end.main_menu_pause


func _on_restart_shift_button_pressed() -> void:
	Engine.time_scale = 1
	animationplayer.play("transition screen fade in")
	exit = night_end.restart_pause
