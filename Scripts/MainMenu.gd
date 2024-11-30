extends Control

@onready var main_menu = $ActualMainMenu
@onready var instructions = $Instructions
@onready var credits = $Credits

var sounds = preload("res://Scripts/sound.gd")

func _on_start_pressed():
	var jump = SoundManager.PlayerJump(2)
	await jump.finished
	get_tree().change_scene_to_file("res://Scenes/Level/StartingCutscene.tscn")


func _on_how_to_pressed():
	SoundManager.PlayerJump(2)
	main_menu.visible = false
	instructions.visible = true

func _on_instructions_return_pressed():
	SoundManager.PlayerJump(2)
	instructions.visible = false
	main_menu.visible = true

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level/Credits.tscn")

func _on_exit_pressed():
	var land = SoundManager.PlayerLand("long")
	await land.finished
	get_tree().quit()

func _on_mouse_entered():
	SoundManager.CoinCollect()
