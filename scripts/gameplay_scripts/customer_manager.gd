extends Node3D

@export var waiting_customer: PackedScene
#the number will decide the chance for a customer to enter 
@export var customer_entering_chance : float

@onready var customer_wait_timer := $CustomerWaitTimer
@onready var customer_walk_timer := $CustomerWalkTimer
@onready var main_node := get_parent()
@onready var score_counter := $"../CanvasLayer/OnScreenUI/ScoreCounter"
@onready var computer := $"../Computer"

signal customer_leaving()
signal customer_going_in()
signal update_score_counter(change: int)

var current_customer = null

func _ready() -> void:
	customer_spawn_loop()
	update_table_checks()
	
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
	#handles the time the customer waits based on mood
	var customer_wait_time = 0
	match current_customer.customer_data.mood:
		"nice":
			customer_wait_time = 20
	
	customer_wait_timer.start(customer_wait_time)


func _input(event: InputEvent) -> void:
	if current_customer != null and is_customer_walking == false:
		if current_customer.customer_data.question_type == "table":
			if event.is_action("1"):
				_on_table_button_1_pressed()
			elif event.is_action("2"):
				_on_table_button_2_pressed()
			elif event.is_action("3"):
				_on_table_button_3_pressed()
			elif event.is_action("4"):
				_on_table_button_4_pressed()
			elif event.is_action("5"):
				_on_table_button_5_pressed()
			#elif event.is_action("6"):
				#customer_go_to_table(6, current_customer.customer_data.amount_of_people)
			#elif event.is_action("7"):
				#customer_go_to_table(7, current_customer.customer_data.amount_of_people)
			#elif event.is_action("8"):
				#customer_go_to_table(8, current_customer.customer_data.amount_of_people)
			#elif event.is_action("9"):
				#customer_go_to_table(9, current_customer.customer_data.amount_of_people)
			#elif event.is_action("0"):
				#customer_go_to_table(0, current_customer.customer_data.amount_of_people)
			
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
	emit_signal("update_score_counter", change)
	

func _on_father_spawn():
	computer._on_father_spawn()

func _on_customer_wait_timer_timeout() -> void:
	var InputAction = InputEventAction.new()
	InputAction.action = "make customer leave"
	InputAction.pressed = true
	Input.parse_input_event(InputAction)

func _on_succesfully_question_awnsered():
	var InputAction = InputEventAction.new()
	InputAction.action = "make customer go inside"
	InputAction.pressed = true
	Input.parse_input_event(InputAction)

func customer_go_to_table(table_index, amount_of_people):
	var current_table_data = $"..".table_data[str(table_index)]
	if amount_of_people <= current_table_data.maxSize and current_table_data.currentCustomersSeated == 0:
		print("succesfully moved customers to table: " + str(amount_of_people))
		$"..".table_data[str(table_index)].currentCustomersSeated = amount_of_people
		var time_before_customer_leaves = randf_range(3, 5) * ($"..".table_data[str(table_index)].maxSize + amount_of_people)
		$TableTimers.find_child("TableTimer" + str(table_index)).start(time_before_customer_leaves)
		_on_succesfully_question_awnsered()
	else:
		print("failed to move customers to table: " + str(amount_of_people))
		_on_customer_wait_timer_timeout()
	update_table_checks()

func update_table_checks():
	for x in 5:
		if $"..".table_data.get(str(x+1)).currentCustomersSeated != 0:
			$"../CanvasLayer/PaperUI".get_child(x).get_child(0).show()
		else:
			$"../CanvasLayer/PaperUI".get_child(x).get_child(0).hide()


func _on_table_button_1_pressed() -> void:
	check_if_taken(1)

func _on_table_button_2_pressed() -> void:
	check_if_taken(2)

func _on_table_button_3_pressed() -> void:
	check_if_taken(3)

func _on_table_button_4_pressed() -> void:
	check_if_taken(4)

func _on_table_button_5_pressed() -> void:
	check_if_taken(5)

func check_if_taken(table):
	if !current_customer:
		return
	var targetCustomersSeated = $"..".table_data.get(str(table)).currentCustomersSeated
	if targetCustomersSeated == 0:
		customer_go_to_table(table, current_customer.customer_data.amount_of_people)
	else:
		kick_out_customer_at_table(table)

func kick_out_customer_at_table(table: int):
	var targetCustomersSeated = $"..".table_data.get(str(table)).currentCustomersSeated
	if targetCustomersSeated == 0:
		return
	## lose 10 score per customer kicked out
	emit_signal("update_score_counter", -10 * targetCustomersSeated)
	$"..".table_data.get(str(table)).currentCustomersSeated = 0
	update_table_checks()


func _on_table_timer_1_timeout() -> void:
	$"..".table_data["1"].currentCustomersSeated = 0
	update_table_checks()


func _on_table_timer_2_timeout() -> void:
	$"..".table_data["2"].currentCustomersSeated = 0
	update_table_checks()

func _on_table_timer_3_timeout() -> void:
	$"..".table_data["3"].currentCustomersSeated = 0
	update_table_checks()

func _on_table_timer_4_timeout() -> void:
	$"..".table_data["4"].currentCustomersSeated = 0
	update_table_checks()

func _on_table_timer_5_timeout() -> void:
	$"..".table_data["5"].currentCustomersSeated= 0
	update_table_checks()
