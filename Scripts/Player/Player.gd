extends CharacterBody2D
class_name Player

## Movement settings
@export var move_speed: float = 350
@export var slide_speed: float = 960
@export var gravity_intensity: float = 1200
@export var jump_speed: float = 250
@export var power_curve: Curve
@export var eyeline_length: int = 20

## Fall/return settings
@export var buffer_space: int = 10
@export var fall_threshold: float = 100

## Component references
@onready var shop_pop_up = $Shop_Popup
@onready var coin_count: CoinCount = $CoinCount
@onready var fallSound: AudioStreamPlayer = $PlayerSounds
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $StepsTimer

const PlayerFallSound = preload("res://Resources/Sounds/Jumps/Falls/Long_Fall_01.wav")
const EyeGradient: Gradient = preload("res://Resources/Player/EyeGradient.tres")
const falling_threshold: float = 160

## Movement variables
var time_jump_pressed: float = 0
var old_velx: float = 0

## Game mechanic variables
var horizontal_lethargy: float = 0.2
var coins: int = 0
var fall_price: int = 0
var up_y: float = 0
var down_y: float = 0
var flattened:bool = false
var crouching:bool = false
var sliding: bool = false
var falling:bool = false
var highest_platform_reached: KinematicCollision2D
var first_fall: bool = true
var step_sound = true
var fall_sound = false
var eye_points_queue = []
var EyeLiner: Line2D 
var wet_floor: bool = false
var held_item: int = 0

var frozen: bool = false:
	set(new_frozen):
		#print("Frozen velocity", velocity)
		if new_frozen:
			set_physics_process(false)
		else:
			set_physics_process(true)
		frozen = new_frozen

func _ready():
	
	# Eye effect mvoes with player unless it is attached higher up the tree
	EyeLiner = Line2D.new()
	EyeLiner.gradient = EyeGradient
	EyeLiner.width = 1
	get_tree().root.add_child.call_deferred(EyeLiner)
	$AnimatedSprite2D.material.set("shader_param/line_thickness", 0)
	
func _process(_delta):
	var eye_pos = animator.find_eye(position)
	eye_points_queue.push_front(eye_pos)
	if eye_points_queue.size() > eyeline_length:
		eye_points_queue.pop_back()
	
	EyeLiner.clear_points()
	for point in eye_points_queue:
		EyeLiner.add_point(point)
		
		
## Behavior for sliding down slopes.
func slide_down_slope(delta):
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


func charging_visuals():
	if crouching:
		var jump_time_elapsed = Time.get_ticks_msec() - time_jump_pressed
		var jump_factor = clamp(jump_time_elapsed * 0.001,0,1) * 20
		$AnimatedSprite2D.material.set("shader_param/line_thickness", jump_factor)

func reset_charging_visuals():
	$AnimatedSprite2D.material.set("shader_param/line_thickness", 0)


func _physics_process(delta):
	if frozen:
		return
	charging_visuals()
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
		if fall_distance > falling_threshold:
			falling = true
		
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

		if Input.is_action_just_released("move_up"):
			var jump_time_elapsed = Time.get_ticks_msec() - time_jump_pressed
			var jump_factor = clamp(jump_time_elapsed * 0.001,0,1)
			SoundManager.PlayerJump(jump_factor)
			velocity.y = -jump_speed * power_curve.sample(jump_factor)
			crouching = false
			flattened = false
			first_fall = false
			reset_charging_visuals()
		elif Input.is_action_just_pressed("move_up"):
			crouching = true
			time_jump_pressed = Time.get_ticks_msec()
			
		var move_dir = Input.get_axis("move_left","move_right")
		if crouching:
			if move_dir !=0:
				old_velx = move_speed * move_dir
			move_dir = 0
		
		#Walk cycle Sound
		if move_dir != 0:
			flattened = false
			if (animator.frame == 2 || animator.frame == 15) and step_sound:
				for i in get_slide_collision_count():
					var collision = get_slide_collision(i)
					if wet_floor:
						SoundManager.PlayerWalkPuddle()
					else:
						SoundManager.PlayerWalk()
					timer.start()
					step_sound = false
		
		if !fall_sound:
			fall_sound = true
			fallSound.stop()
			falling = false
			if fall_distance > 200:
				SoundManager.PlayerLand("long")
				flattened = true
			else:
				SoundManager.PlayerLand("short")

		velocity.x = lerpf(velocity.x,move_dir * move_speed, horizontal_lethargy)
		if move_dir * move_speed != 0:
			old_velx = move_dir * move_speed
	else:
		velocity.x  = old_velx
	
	
	
	if is_on_wall():
		old_velx = 0
	
	$AnimatedSprite2D.update(self)
	move_and_slide()

## Updates the price based on how far the player fell down.
## TODO: REMOVE MAX IF WE ARE DOING PAY-PER-FALL instead of PAY-FOR-ALL
func calc_fall_price():
	fall_price = max(int((up_y - down_y) / 100), fall_price)

## Response to the popup button being clicked.
func handle_button(actionID):
	if actionID == 1:
		if coins >= shop_pop_up.crowbar_price:
			held_item = 1
			coins -= shop_pop_up.crowbar_price
			shop_pop_up.crowbar_price += 1
			shop_pop_up.price.text = "%s" % shop_pop_up.crowbar_price
			shop_pop_up.item_purchased.emit(1)
	if actionID == 2:
		if coins >= shop_pop_up.wrench_price:
			held_item = 2
			coins -= shop_pop_up.wrench_price
			shop_pop_up.wrench_price += 1
			shop_pop_up.price.text = "%s" % shop_pop_up.wrench_price
			shop_pop_up.item_purchased.emit(2)
	if actionID == 3:
		if coins >= shop_pop_up.cheese_price:
			held_item = 3
			coins -= shop_pop_up.cheese_price
			shop_pop_up.item_purchased.emit(3)


func _on_timer_timeout():
	step_sound = true

func use_item(id):
	if id == 1:
		print("Used crowbar.")
		
	if id == 2:
		print("Used wrench.")
		
	if id == 3:
		print("Used cheese.")
	held_item = 0
	
func shop_display(id):
	shop_pop_up.display(id)
