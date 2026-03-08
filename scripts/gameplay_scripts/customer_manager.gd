extends Node3D

@export var waiting_customer: PackedScene
#the number will decide the chance for a customer to enter 
@export var customer_entering_chance : float

signal customer_leaving()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	await get_tree().create_timer(1.0).timeout
	customer_spawn()


var is_customer_walking := false
var customer = null
func customer_spawn() -> void:
	
	if customer == null:
		if randf() <= customer_entering_chance:
			is_customer_walking = true
			customer = waiting_customer.instantiate()
			add_child(customer)
			customer_leaving.connect(customer._on_customer_leaving)
		
			customer.position = Vector3(-5,0,7)
			await get_tree().create_timer(2.0).timeout
			is_customer_walking = false

func _input(event: InputEvent) -> void:
	if event.is_action("(temp) make customer walk away") and customer != null and is_customer_walking == false:
		emit_signal("customer_leaving")
		is_customer_walking = true
		
		await get_tree().create_timer(3.0).timeout
		is_customer_walking = false
		
		customer.queue_free()
		
		
