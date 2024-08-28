extends Node2D


var win_state: bool = false

func _on_area_2d_body_entered(body):
	if body is Player and not win_state:
		print("YOU WIN!")
		$CenterContainer.visible = true
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
