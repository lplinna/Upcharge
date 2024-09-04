extends AnimatedSprite2D

enum animation_state {
	WALK_RIGHT,
	WALK_LEFT,
	AIRBORN,
	JUMPING,
	CROUCHING,
	TROUBLED,
	IDLE
}

const IDLE_THRESHOLD: float = 40

## Current animation state of the Player.
var state: animation_state = animation_state.IDLE:
	set(new_state):
		if state != new_state:
			#print(new_state)
			state = new_state
			state_response()

## Main "animation tree" for the player.
func update(player: Player):
	var velx = player.velocity.x
	if player.sliding:
		state = animation_state.AIRBORN
		return
	if player.crouching:
		if abs(velx) < IDLE_THRESHOLD:
			state = animation_state.CROUCHING 
		if velx > IDLE_THRESHOLD:
			state = animation_state.WALK_RIGHT
		if velx < -IDLE_THRESHOLD:
			state = animation_state.WALK_LEFT
	else:
		if player.velocity.y < 0:
			state = animation_state.AIRBORN
		else:
			if abs(velx) < IDLE_THRESHOLD :
				state = animation_state.IDLE
			if velx > IDLE_THRESHOLD:
				state = animation_state.WALK_RIGHT
			if velx < -IDLE_THRESHOLD:
				state = animation_state.WALK_LEFT

## Response for changing the animation state.
func state_response():
	match state:
		animation_state.JUMPING:
			self.play("Jumping")
		animation_state.IDLE:
			self.play("Idle")
		animation_state.WALK_RIGHT:
			self.play("WalkLeft")
			self.flip_h = true
		animation_state.WALK_LEFT:
			self.play("WalkLeft")
			self.flip_h = false
		animation_state.AIRBORN:
			self.play("Airborn")
		animation_state.CROUCHING:
			self.play("Crouching")
