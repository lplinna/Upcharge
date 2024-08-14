extends Control

@onready var button = $Panel/VBoxContainer/Button

func _on_timer_timeout():
	self.visible = false

func init(player_ref: Player):
	button.pressed.connect(player_ref.handle_button)
