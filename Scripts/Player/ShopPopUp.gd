extends Control

@onready var button = $Panel/VBoxContainer/TextureRect2/Button
@onready var price = $Panel/VBoxContainer/TextureRect/HBoxContainer/Price
@onready var player_ref: Player = get_parent()

var crowbar_price = 1
var wrench_price = 1
var cheese_price = 50

func display(id):
	if id == 1:
		button.text = "Crowbar"
		price.text = "%s" % crowbar_price
	if id == 2:
		button.text = "Wrench"
		price.text = "%s" % wrench_price
	if id == 3:
		button.text = "Cheese"
		price.text = "%s" % cheese_price
	self.visible = true

func init():
	button.pressed.connect(player_ref.handle_button)

func _process(delta):
	if self.visible and Input.is_action_just_released("return"):
		if button.text == "Crowbar":
			player_ref.handle_button(1)
		if button.text == "Wrench":
			player_ref.handle_button(2)
		if button.text == "Cheese":
			player_ref.handle_button(3)
