extends CharacterBody2D
class_name Player

## Movement constants
@export var move_speed: float = 700/2
@export var slide_speed: float = 1200
@export var gravity_intensity: float = 300*4
@export var jump_speed = 2000/8

# Fall/return constants
@export var buffer_space: int = 10
@export var fall_threshold: float = 100

@onready var PopUp = $PopUp
@onready var CoinCount = $CoinCount
@onready var playerSounds = $PlayerSounds

const PlayerJumpSound = preload("res://Resources/player_jump.wav")

## Movement variables
var time_jump_pressed: float = 0
var old_velx: float = 0

## Game mechanic variables
var coins: int = 0
var fall_price: int = 0
var up_y: float = 0
var down_y: float = 0
var crouching:bool = false
var sliding: bool = false
var highest_platform_reached: KinematicCollision2D
var first_fall: bool = true

func _ready():
	PopUp.init(self)
	CoinCount.init(self)


func slide_down_slope(delta):
	#print("SLIDING")
	velocity.y += gravity_intensity * delta
	#velocity.x = old_velx
	if is_on_floor():
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var way = collision.get_normal().bounce(Vector2.DOWN)
			print(way.y)
			velocity.x  = way.x * slide_speed
			velocity.y  = way.y * slide_speed
			
			if rad_to_deg(collision.get_angle()) < 15:
				sliding = false
	
	
	move_and_slide()


func _physics_process(delta):
	if sliding:
		slide_down_slope(delta)
		return
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
			var slide_angle = rad_to_deg(collision.get_angle())
			if slide_angle > 15 and slide_angle < 90:
				sliding = true
			
				
				
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
