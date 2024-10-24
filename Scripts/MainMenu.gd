extends Control

@onready var main_menu = $ActualMainMenu
@onready var instructions = $Instructions
@onready var credits = $Credits

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level/StartingCutscene.tscn")


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
