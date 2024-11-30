extends Control

@onready var text = $RichTextLabel
@export var crawl_duration: float = 5.0

func _ready() -> void:
	var tween := get_tree().create_tween()
	var dest = text.position - Vector2(0, 1100)
	tween.tween_property(text, "position", dest, crawl_duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(func(): get_tree().change_scene_to_file("res://Scenes/Level/MainMenu.tscn"))
