extends Control

func _ready():
	#print($PipeBody.size)
	$PipeBody/PipeMiddle.visible = false
	place_rivet_rings()

func place_rivet_rings():
	var rivets = floor($PipeBody.size.x / 454)
	if rivets > 0:
		$PipeBody/PipeMiddle.visible = true
		$PipeBody/PipeMiddle.position.x = 454 - 32
	if rivets > 1:
		var offset = 454
		for i in range(rivets):
			var clone = $PipeBody/PipeMiddle.duplicate()
			clone.position.x = 454 + (i * 454) - 32
			$PipeBody.add_child(clone)
