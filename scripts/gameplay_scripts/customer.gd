extends CharacterBody3D

@onready var animation_player := $AnimationPlayer
@onready var timer := $Timer
@onready var navigation_agent := $NavigationAgent3D
@onready var customer_manager := get_parent()
@onready var is_moving : bool

@onready var customer_data = {
	"question_type": ["table"].pick_random(),
	"mood": ["nice"].pick_random(),
	"amount_of_people": randi_range(1, 4) + randi_range(0, 2)
}
const FATHER_SPAWNING_CHANCE := 1

signal score_change(change: int)
signal father_spawn()

enum customer_walk_targets{
	customers_window,
	exit,
	resturant_inside
}
var current_customer_walk_target : int 

var reward: int
func _ready() -> void:
	if (customer_manager != null):
		score_change.connect(customer_manager._on_score_change)
		father_spawn.connect(customer_manager._on_father_spawn)
	reward = 30
	
	
	$SpeechBubble/Question.text = customer_data["question_type"] + ": " + str(customer_data["amount_of_people"])
	
	current_customer_walk_target = customer_walk_targets.customers_window
	is_moving = true
	timer.start(2)

func _on_timer_timeout() -> void:
	is_moving = false
	$SpeechBubble.show()
	
	if randf_range(0, 1) <= FATHER_SPAWNING_CHANCE:
		emit_signal("father_spawn")

#helper function for deciding where to go
func get_movement_vector() -> Vector3:
	const GO_RIGHT_VECTOR := Vector3(0, 0, -3.5)
	const GO_LEFT_VECTOR := Vector3(0, 0, 3.5)
	var current_vector : Vector3
	
	match current_customer_walk_target:
		customer_walk_targets.customers_window:
			current_vector =  GO_RIGHT_VECTOR
		customer_walk_targets.resturant_inside:
			current_vector =  GO_RIGHT_VECTOR
		customer_walk_targets.exit:
			current_vector = GO_LEFT_VECTOR
			
	return current_vector


func _physics_process(_delta):
	if is_moving:
		velocity = get_movement_vector()
		
		if !animation_player.is_playing():
			animation_player.play("customer_walk")
		
	else:
		velocity = Vector3.ZERO

	move_and_slide()

func _on_customer_leaving() -> void:
	emit_signal("score_change", -reward)
	$SpeechBubble.hide()
	current_customer_walk_target = customer_walk_targets.exit
	is_moving = true
	timer.start(3)
	
func _on_customer_going_in() -> void:
	emit_signal("score_change", reward)
	
	current_customer_walk_target = customer_walk_targets.resturant_inside
	is_moving = true
	timer.start(3)
	
	
