extends Control

@onready var button = $Panel/VBoxContainer/TextureRect2/Button
@onready var price = $Panel/VBoxContainer/TextureRect/HBoxContainer/Price
@onready var timer = $Timer

func _on_timer_timeout():
	self.visible = false

func display(price_value):
	price.text = "%s" % price_value
	self.visible = true
	timer.start()
