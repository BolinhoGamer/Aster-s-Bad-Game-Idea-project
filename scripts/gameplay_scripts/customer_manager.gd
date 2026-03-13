extends Node3D

@export var waiting_customer: PackedScene
#the number will decide the chance for a customer to enter 
@export var customer_entering_chance : float

@onready var customer_wait_timer := $CustomerWaitTimer
@onready var customer_walk_timer := $CustomerWalkTimer
@onready var final_rush_timer := $FinalRushTimer
@onready var main_node := get_parent()
@onready var score :int = main_node.score

signal customer_leaving()
signal customer_going_in()
signal update_score_counter(new_score: int)

var current_customer = null
func _ready() -> void:
	customer_spawn_loop()
	
func customer_spawn_loop() -> void:
	await get_tree().create_timer(1).timeout
	debugvar = randf_range(0, 1)
	if debugvar <= customer_entering_chance:
		customer_spawn()
	else:
		customer_spawn_loop()

var debugvar : float
var is_customer_walking := false
func customer_spawn() -> void:
	is_customer_walking = true
	current_customer = waiting_customer.instantiate()
	add_child(current_customer)
	customer_leaving.connect(current_customer._on_customer_leaving)
	customer_going_in.connect(current_customer._on_customer_going_in)
	
	current_customer.position = Vector3(-5,0,7)
	customer_walk_timer.start(2)
	await customer_walk_timer.timeout
	is_customer_walking = false
	
	customer_wait_timer.start(2)


func _input(event: InputEvent) -> void:
	if current_customer != null and is_customer_walking == false:
		if event.is_action("make customer leave") :
			customer_wait_timer.stop()
			emit_signal("customer_leaving")
			
			is_customer_walking = true
			customer_walk_timer.start(3)
			await customer_walk_timer.timeout
			
			is_customer_walking = false
			current_customer.queue_free()
			customer_spawn_loop()
		
		if event.is_action("make customer wait") :
			customer_wait_timer.stop()
			customer_wait_timer.start(15)
			
		
		if event.is_action("make customer go inside") :
			customer_wait_timer.stop()
			emit_signal("customer_going_in")
			
			is_customer_walking = true
			customer_walk_timer.start(3)
			await customer_walk_timer.timeout
			
			is_customer_walking = false
			current_customer.queue_free()
			customer_spawn_loop()

func _on_score_change(change):
	await customer_walk_timer.timeout
	score += change
	if score >= 500:
		score = 500
		final_rush_timer.start(60)
	emit_signal("update_score_counter", score)
	
	


func _on_customer_wait_timer_timeout() -> void:
	#Input.action_press("make customer leave")
	emit_signal("customer_leaving")
	is_customer_walking = true
	
	customer_walk_timer.start(2)
	await customer_walk_timer.timeout
	is_customer_walking = false
	
	current_customer.queue_free()
	customer_spawn_loop()
