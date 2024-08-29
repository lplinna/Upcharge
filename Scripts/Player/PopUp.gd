extends Control

@onready var button = $Panel/VBoxContainer/Button
@onready var price = $Panel/VBoxContainer/HBoxContainer/Price

func _on_timer_timeout():
	self.visible = false

func display(player_ref: Player):
	price.text = "%s" % player_ref.fall_price
	self.visible = true

func init(player_ref: Player):
	button.pressed.connect(player_ref.handle_button)
