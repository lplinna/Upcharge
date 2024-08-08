extends RigidBody2D

@export var move_speed: float = 7

func _physics_process(delta):
	var move_dir: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down", 0.1)
	move_dir *= move_speed
	move_and_collide(move_dir)
	
