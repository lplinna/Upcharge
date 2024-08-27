extends CharacterBody2D
class_name Player

## Movement constants
@export var move_speed: float = 700/2
@export var gravity_intensity: float = 300*4
@export var jump_speed = 2000/8

# Fall/return constants
@export var buffer_space: int = 10
@export var fall_threshold: float = 100

@onready var PopUp = $PopUp
@onready var CoinCount = $CoinCount
@onready var playerSounds = $PlayerSounds
@onready var animator = $AnimatedSprite2D

const PlayerJumpSound = preload("res://Resources/player_jump.wav")
const PlayerWalkSound = preload("res://Resources/Player_step.wav")

## Movement variables
var time_jump_pressed: float = 0
var old_velx: float = 0

## Game mechanic variables
var coins: int = 0
var fall_price: int = 0
var up_y: float = 0
var down_y: float = 0
var crouching:bool = false
var highest_platform_reached: KinematicCollision2D
var first_fall: bool = true

func _ready():
	PopUp.init(self)
	CoinCount.init(self)

func _physics_process(delta):
	velocity.y += gravity_intensity * delta

	if (velocity.y < 0):
		down_y = global_position.y
	else:
		up_y = global_position.y
		
	var fall_distance = up_y - down_y

	if is_on_floor():
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if highest_platform_reached == null or collision.get_position().y < highest_platform_reached.get_position().y:
				highest_platform_reached = collision
				
		if !PopUp.visible and fall_distance > fall_threshold and not first_fall:
			calc_fall_price()
			PopUp.display(self)
			var timer = PopUp.get_node("Timer") as Timer
			timer.start()
			down_y = up_y
			
		if Input.is_action_just_released("move_up"):
			var jump_time_elapsed = Time.get_ticks_msec() - time_jump_pressed
			var jump_factor = clamp(jump_time_elapsed/250,1,2)
			playerSounds.stream = PlayerJumpSound
			playerSounds.pitch_scale = (3.0 - jump_factor)
			playerSounds.play()
			crouching = false
			velocity.y = -jump_speed * jump_factor
			first_fall = false
		elif Input.is_action_just_pressed("move_up"):
			crouching = true
			time_jump_pressed = Time.get_ticks_msec()

			
		$AnimatedSprite2D.update(self)
	
		var move_dir = Input.get_axis("move_left","move_right")
		if move_dir != 0:
			if animator.frame == 1 || animator.frame == 3:
				playerSounds.stream = PlayerWalkSound
				playerSounds.pitch_scale = randf_range(1.1, 1.5)
				playerSounds.play()
		
		velocity.x = move_dir * move_speed
		if velocity.x != 0:
			old_velx = velocity.x
	else:
		velocity.x  = old_velx
	
	
	if is_on_wall():
		old_velx = 0
		
	move_and_slide()

## Updates the price based on how far the player fell down.
## TODO: REMOVE MAX IF WE ARE DOING PAY-PER-FALL instead of PAY-FOR-ALL
func calc_fall_price():
	fall_price = max(int((up_y - down_y) / 100), fall_price)

## Response to the popup button being clicked.
func handle_button():
	if coins >= fall_price:
		position = highest_platform_reached.get_position() + buffer_space * Vector2.UP
		PopUp.visible = false
		coins -= fall_price
