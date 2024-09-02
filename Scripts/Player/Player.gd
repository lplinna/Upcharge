extends CharacterBody2D
class_name Player

## Movement constants
@export var move_speed: float = 350
@export var slide_speed: float = 960
@export var gravity_intensity: float = 1200
@export var jump_speed: float = 250
@export var power_curve: Curve

# Fall/return constants
@export var buffer_space: int = 10
@export var fall_threshold: float = 100

@onready var PopUp = $PopUp
@onready var CoinCount = $CoinCount
@onready var fallSound = $PlayerSounds
@onready var animator = $AnimatedSprite2D
@onready var timer = $StepsTimer

#const PlayerJumpSound = preload("res://Resources/Sounds/player_jump.wav")
#const PlayerWalkSound = preload("res://Resources/Sounds/Player_step.wav")
const PlayerFallSound = preload("res://Resources/Sounds/Jumps/Falls/Long_Fall_01.wav")

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
var step_sound = true
var horizontal_lethargy: float = 0.2
var fall_sound = false

func _ready():
	PopUp.init(self)
	CoinCount.init(self)

## Behavior for sliding down slopes.
func slide_down_slope(delta):
	#print("SLIDING")
	velocity.y += gravity_intensity * delta
	if is_on_floor():
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var way = collision.get_normal().bounce(Vector2.DOWN)
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
	
	#Fall sound player
	if !is_on_floor() and velocity.y > 100:
		var FallVolume = clamp(velocity.y/10,1,80)
		fallSound.volume_db = -80 + FallVolume
		if fall_sound:
			fallSound.stream = PlayerFallSound
			fallSound.play()
			fall_sound = false
		
	
	
	
	if is_on_floor():
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if highest_platform_reached == null or collision.get_position().y < highest_platform_reached.get_position().y:
				highest_platform_reached = collision
			var slide_angle = rad_to_deg(collision.get_collider().transform.get_rotation())
			if slide_angle != 0:
				sliding = true
			
				
				
		if !PopUp.visible and fall_distance > fall_threshold and not first_fall:
			calc_fall_price()
			PopUp.display(self)
			var popup_timer = PopUp.get_node("Timer") as Timer
			popup_timer.start()
			down_y = up_y
			
		if Input.is_action_just_released("move_up"):
			var jump_time_elapsed = Time.get_ticks_msec() - time_jump_pressed
			var jump_factor = clamp(jump_time_elapsed * 0.001,0,1)
			SoundManager.PlayerJump(jump_factor)
			crouching = false
			velocity.y = -jump_speed * power_curve.sample(jump_factor)
			first_fall = false
		elif Input.is_action_just_pressed("move_up"):
			crouching = true
			time_jump_pressed = Time.get_ticks_msec()

			
		$AnimatedSprite2D.update(self)
	
		var move_dir = Input.get_axis("move_left","move_right")
		
		#Walk cycle Sound
		if move_dir != 0:
			if (animator.frame == 2 || animator.frame == 7) and step_sound:
				for i in get_slide_collision_count():
					var collision = get_slide_collision(i)
					if collision.get_collider().name == "BottomGround":
						SoundManager.PlayerWalkPuddle()
					else:
						SoundManager.PlayerWalk()
					timer.start()
					step_sound = false
				#playerSounds.stream = PlayerWalkSound
				#playerSounds.pitch_scale = randf_range(1.1, 1.5)
				#playerSounds.play()
		
		if !fall_sound:
			fall_sound = true
			fallSound.stop()
			if fall_distance > 200:
				SoundManager.PlayerLand("long")
			else:
				SoundManager.PlayerLand("short")
		
		if !fall_sound:
			fall_sound = true
			fallSound.stop()
			if fall_distance > 200:
				SoundManager.PlayerLand("long")
			else:
				SoundManager.PlayerLand("short")
		
		velocity.x = lerpf(velocity.x,move_dir * move_speed, horizontal_lethargy)
		if move_dir * move_speed != 0:
			old_velx = move_dir * move_speed
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


func _on_timer_timeout():
	step_sound = true
