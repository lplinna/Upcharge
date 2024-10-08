extends Sprite2D


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

func _process(delta):
	pass
