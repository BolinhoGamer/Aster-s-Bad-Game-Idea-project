extends CharacterBody3D

@onready var animationplayer := $AnimationPlayer
@onready var timer := $Timer
@onready var is_moving : bool
const SPEED := -3.5

func _ready() -> void:
	is_moving = true
	timer.wait_time = 2
	timer.start()
	

func _physics_process(delta):
	if is_moving:
		velocity = Vector3(0, 0, SPEED)
		
		if !animationplayer.is_playing():
			animationplayer.play("customer_walk")
		
	else:
		velocity = Vector3.ZERO		

	move_and_slide()

func _on_timer_timeout() -> void:
	is_moving = false

func _on_customer_leaving() -> void:
	is_moving = true
	timer.wait_time = 3
	timer.start()
