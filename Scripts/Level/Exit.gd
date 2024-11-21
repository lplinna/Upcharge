extends Node2D

@onready var grate: AnimatedSprite2D = $Grate
@onready var ladder: Sprite2D = $Ladder

@export var ladder_final_pos: Vector2

func _on_guard_toll_paid() -> void:
	grate.play()


func _on_grate_animation_finished() -> void:
	ladder.visible = true
	var tween = create_tween()

	var start_position = ladder.position
	var end_position = Vector2(start_position.x, start_position.y + 100) # Move down by 100 pixels
	var duration = 1.0 # 1 second

	# Start the tween
	tween.tween_property(ladder, "position", ladder_final_pos, 3.0)
	tween.play()
