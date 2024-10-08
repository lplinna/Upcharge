extends Control

@onready var button = $Panel/VBoxContainer/TextureRect2/Button
@onready var price = $Panel/VBoxContainer/TextureRect/HBoxContainer/Price
@onready var player_ref: Player = get_parent()

func _on_timer_timeout():
	self.visible = false

func display():
	price.text = "%s" % player_ref.fall_price
	self.visible = true

func init():
	button.pressed.connect(player_ref.handle_button)

func _process(delta):
	if self.visible and Input.is_action_just_released("return"):
		player_ref.handle_button(0)
