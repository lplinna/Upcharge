extends RigidBody2D

@export var move_speed: float = 7
@export var floor_y: float = 560

@onready var PopUp = $PopUp

func _physics_process(_delta):
	var move_dir: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down", 0.1)
	move_dir *= move_speed
	move_and_collide(move_dir)

func _process(_delta: float):
	if !PopUp.visible and position.y > floor_y:
		print('fall detected')
		PopUp.visible = true
