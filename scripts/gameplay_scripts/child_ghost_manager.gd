extends Node3D

@onready var current_state := $".."
@onready var child_spawning_chance := 0.4
@onready var is_there_child := false

enum eComputerState {
	e_cmp_0,
	e_cmp_1,
	e_cmp_2,
	e_cmp_3
}

signal update_score_counter(change : int)

#starting the loop
func _ready() -> void:
	child_spawning_loop()

#main loop, every 5 second by chance decides: 
#either repeat itself or spawning the child
var debugvar : float
func child_spawning_loop() -> void:
	await get_tree().create_timer(50000000000).timeout
	debugvar = randf_range(0, 1)
	if debugvar <= child_spawning_chance:
		spawn_child()
	else:
		child_spawning_loop()

#"spawns" the child in one of the two locations
var child_placement : eComputerState
func spawn_child():
	debugvar = randf_range(0, 1)
	if debugvar < 0.5:
		child_placement =  eComputerState.e_cmp_1
	else:
		child_placement =  eComputerState.e_cmp_3
		
	is_there_child = true
	child_cry()

#deducing 10 points a second 
#until the player lights the correct camera 
func child_cry():
	emit_signal("update_score_counter", -1)
	await get_tree().create_timer(0.1).timeout
	if is_there_child:
		child_cry()
	else:
		child_spawning_loop()

func _input(event: InputEvent) -> void:
	if event.is_action("light camera") and current_state.state == child_placement:
			is_there_child = false
