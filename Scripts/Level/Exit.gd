extends Node2D

@onready var grate: AnimatedSprite2D = $Grate
@onready var ladder: Sprite2D = $Ladder
@onready var win_zone: CollisionShape2D = $Area2D/CollisionShape2D

@export var ladder_final_pos: Vector2
@export var fade_duration: float = 2.5

var is_fading := false

func _ready() -> void:
	win_zone.disabled = true

func _on_guard_toll_paid() -> void:
	grate.play()

func _on_grate_animation_finished() -> void:
	ladder.visible = true
	var tween = create_tween()

	var start_position = ladder.position
	var end_position = start_position + ladder_final_pos # Move down by 100 pixels
	var duration = 1.0 # 1 second

	# Start the tween
	tween.tween_property(ladder, "position", end_position, 3.0)
	tween.play()
	win_zone.disabled = false
	await tween.finished
	%TheE.visible = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("return") and %TheE.visible == true:
		%TheE.visible = false
		fade_to_black()

func fade_to_black():
	if is_fading:
		return
	is_fading = true
	visible = true
	
	var fade_rect := ColorRect.new()
	fade_rect.color = Color(0, 0, 0, 0)
	fade_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	
	# pls ignore magic numbers
	fade_rect.size = Vector2(3000, 3000)
	fade_rect.position = Vector2(-1000, -2000)
	
	get_tree().root.add_child(fade_rect)
	
	var tween := get_tree().create_tween()
	tween.tween_property(fade_rect, "color:a", 1.0, fade_duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	
	tween.finished.connect(func(): _on_fade_complete(fade_rect))

func _on_fade_complete(rect):
	rect.queue_free()
	get_tree().change_scene_to_file("res://Scenes/Level/Credits.tscn")
