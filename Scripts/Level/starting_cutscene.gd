extends Node2D

func _process(delta):
	if Input.is_action_just_released("skip_cutscene"):
		_on_video_stream_player_finished()

func _on_video_stream_player_finished():
	get_tree().change_scene_to_file("res://Scenes/Level/level_01.tscn")
