extends Control

@onready var button = $Panel/VBoxContainer/TextureRect2/Button
@onready var price = $Panel/VBoxContainer/TextureRect/HBoxContainer/Price
@onready var player_ref: Player = get_parent()

signal item_purchased(item: int)

var crowbar_price = 5
var wrench_price = 1
var cheese_price = 50
var current_id: int = 0

func display(id):
	current_id = id
	if id == 1:
		button.text = "Buy this to\nplay the old way  (E to Return after falling)                             "
		price.text = "%s" % crowbar_price
	if id == 2:
		button.text = "Hint"
		price.text = "%s" % wrench_price
	if id == 3:
		button.text = "Cheese"
		price.text = "%s" % cheese_price
	self.visible = true

func init():
	button.pressed.connect(player_ref.handle_button)

func _input(event: InputEvent):
	if self.visible and event.is_action_pressed("return"):
		player_ref.handle_button(current_id)
