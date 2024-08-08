extends CharacterBody2D

@export var move_speed: float = 700/2
@export var gravity_intensity: float = 300*4
@export var jump_speed = 2000/8
@export var floor_y: int = 500

var time_jump_pressed: float = 0

var old_velx: float = 0

@onready var PopUp = $PopUp

func _physics_process(delta):
	velocity.y += gravity_intensity * delta

	if is_on_floor():
		if Input.is_action_just_released("move_up"):
			var jump_time_elapsed = Time.get_ticks_msec() - time_jump_pressed
			var jump_factor = clamp(jump_time_elapsed/250,1,2)
			print(jump_factor)
			velocity.y = -jump_speed * jump_factor
		if Input.is_action_just_pressed("move_up"):
			time_jump_pressed = Time.get_ticks_msec()
			
			
		var move_dir = Input.get_axis("move_left","move_right")
		velocity.x = move_dir * move_speed
		if velocity.x != 0:
			old_velx = velocity.x
	else:
		velocity.x  = old_velx
	
	if is_on_wall():
		old_velx = 0
		
	move_and_slide()


func _process(_delta: float):
	if !PopUp.visible and position.y > floor_y:
		print('fall detected')
		PopUp.visible = true
