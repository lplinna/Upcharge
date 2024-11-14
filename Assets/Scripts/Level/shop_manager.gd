extends Node2D

var hints = [
	'''You will need to pay money at the top,
	but if you have the cheese, winning is free!'''
	,
	'Use the crowbar for shortcuts in pipes.'
	]


#Crowbar
func _on_area_crowbar_entered(body):
	if body is Player:
		body.shop_display(1)

func _on_area_crowbar_exited(body):
	if body is Player:
		body.shop_pop_up.visible = false

#Wrench
func _on_area_wrench_entered(body):
	if body is Player:
		body.shop_display(2)
		body.shop_pop_up.item_purchased.connect(func(item: int):
			if item == 2:
				show_hint()
			)

func _on_area_wrench_exited(body):
	if body is Player:
		body.shop_pop_up.visible = false

#Cheese
func _on_area_cheese_entered(body):
	if body is Player:
		body.shop_display(3)

func _on_area_cheese_exited(body):
	if body is Player:
		body.shop_pop_up.visible = false

func show_hint():
	$HintIndicator.visible = true
	$HintIndicator.text = "[center]%s[center]" % hints.pick_random() 

func _process(delta):
	pass
