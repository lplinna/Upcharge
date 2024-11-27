extends Control

@onready var button = $Panel/VBoxContainer/TextureRect2/Button
@onready var price = $Panel/VBoxContainer/TextureRect/HBoxContainer/Price
@onready var player_ref: Player = get_parent()
@onready var timer = $Timer

func _on_timer_timeout():
	self.visible = false

func display():
	price.text = "%s" % player_ref.fall_price
	self.visible = true
	timer.start()

func init():
	button.pressed.connect(player_ref.handle_button)
