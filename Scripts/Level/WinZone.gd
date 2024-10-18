extends Node2D

@export var coins_to_win: int = 4

var win_state: bool = false

func _on_area_2d_body_entered(body):
	if body is Player and not win_state:
		if body.coins >= coins_to_win or body.held_item == 3:
			win_state = true
			$CenterContainer/YouWin.visible = true
			$CenterContainer/NotEnough.visible = false
			await get_tree().create_timer(2.0).timeout
			get_tree().change_scene_to_file("res://Scenes/Level/MainMenu.tscn")
		else:
			$CenterContainer/NotEnough.visible = true
			await get_tree().create_timer(2.0).timeout
			$CenterContainer/NotEnough.visible = false
			get_tree().change_scene_to_file("res://Scenes/Level/level_01.tscn")
