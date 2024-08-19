extends Control

@onready var main_menu: Node2D = $AspectRatioContainer/ActualMainMenu
@onready var instructions = $AspectRatioContainer/Instructions
@onready var credits = $AspectRatioContainer/Credits

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")


func _on_how_to_pressed():
	#hide main menu
	main_menu.visible = false


func _on_credits_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	pass # Replace with function body.
