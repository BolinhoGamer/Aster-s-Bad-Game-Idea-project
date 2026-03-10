extends Node3D

@export var waiting_customer: PackedScene
#the number will decide the chance for a customer to enter 
@export var customer_entering_chance : float

@onready var timer := $Timer

signal customer_leaving()
signal customer_going_in()


var current_customer = null
func _process(_delta: float) -> void:
	await get_tree().create_timer(1.0).timeout
	if current_customer == null:
		customer_spawn()
		

var is_customer_walking := false
func customer_spawn() -> void:
	if randf() <= customer_entering_chance:
		is_customer_walking = true
		current_customer = waiting_customer.instantiate()
		add_child(current_customer)
		customer_leaving.connect(current_customer._on_customer_leaving)
		customer_going_in.connect(current_customer._on_customer_going_in)
	
		current_customer.position = Vector3(-5,0,7)
		await get_tree().create_timer(2.0).timeout
		is_customer_walking = false
		
		timer.wait_time = 2
		timer.start()

func _input(event: InputEvent) -> void:
	if current_customer != null and is_customer_walking == false:
		if event.is_action("make customer leave") :
			timer.stop()
			emit_signal("customer_leaving")
			
			is_customer_walking = true
			await get_tree().create_timer(3.0).timeout
			
			is_customer_walking = false
			current_customer.queue_free()
		
		if event.is_action("make customer wait") :
			timer.stop()
			timer.wait_time = 15
			timer.start()
		
		if event.is_action("make customer go inside") :
			emit_signal("customer_going_in")
			
			is_customer_walking = true
			await get_tree().create_timer(3.0).timeout
			
			is_customer_walking = false
			current_customer.queue_free()


func _on_timer_timeout() -> void:
	#Input.action_press("make customer leave")
	emit_signal("customer_leaving")
	is_customer_walking = true
	
	await get_tree().create_timer(3.0).timeout
	is_customer_walking = false
	
	current_customer.queue_free()
