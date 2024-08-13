extends Control

func _on_timer_timeout():
	print('timeout')
	self.visible = false
