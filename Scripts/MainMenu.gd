extends Control

@onready var main_menu = $AspectRatioContainer/ActualMainMenu
@onready var instructions = $AspectRatioContainer/Instructions
@onready var credits = $AspectRatioContainer/Credits

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level/level_01.tscn")


func _on_how_to_pressed():
	main_menu.visible = false
	instructions.visible = true

func _on_instructions_return_pressed():
	instructions.visible = false
	main_menu.visible = true

func _on_credits_pressed():
	main_menu.visible = false
	credits.visible = true

func _on_credits_return_pressed():
	credits.visible = false
	main_menu.visible = true
	
func _on_exit_pressed():
	get_tree().quit()
