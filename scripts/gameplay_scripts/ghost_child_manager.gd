extends Node3D

@export var ghost_child_entering_chance : float
@export var ghost_child_crying_spped : float

@onready var computer := $".."

enum eComputerState {
	e_cmp_0,
	e_cmp_1,
	e_cmp_2,
	e_cmp_3
}

signal update_score_counter(change: int)

func _ready() -> void:
	ghost_child_spawn_loop()
	
func ghost_child_spawn_loop() -> void:
	await get_tree().create_timer(10).timeout
	if randf_range(0, 1) <= ghost_child_entering_chance:
		ghost_child_spawn()
	else:
		ghost_child_spawn_loop()

var child_ghost_loc : eComputerState
func ghost_child_spawn() -> void:
	if randf_range(0, 1) <= 0.5:
		child_ghost_loc = eComputerState.e_cmp_0
	else:
		child_ghost_loc = eComputerState.e_cmp_3
	
	is_ghost_child_crying = true
	ghost_child_cry()

var is_ghost_child_crying := false 
func ghost_child_cry() -> void:
	await get_tree().create_timer(ghost_child_crying_spped).timeout
	update_score_counter.emit(-1)
	if is_ghost_child_crying == true:
		ghost_child_cry()
	else:
		ghost_child_spawn_loop()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("light camera") and computer.state == child_ghost_loc:
		is_ghost_child_crying = false
