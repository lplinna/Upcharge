extends CharacterBody2D

@export var move_speed: float = 700/2
@export var gravity_intensity: float = 300*4
@export var jump_speed = 2000/8


func _physics_process(delta):
	velocity.y += gravity_intensity * delta

	if is_on_floor():
		if Input.is_action_just_released("move_up"):
			velocity.y = -jump_speed
			print("JUMPING")
		var move_dir = Input.get_axis("move_left","move_right")
		velocity.x = move_dir * move_speed
		
		
	print(velocity.y)
	move_and_slide()

	
