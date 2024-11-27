extends Node2D

@onready var max_player_location: Vector2 = Vector2(0,INF)

var waiting_for_e: bool = false

func _on_player_player_fell() -> void:
	if "Legacy Mechanic" in get_parent().items:
		%PopUp.display()
		waiting_for_e = true
		
func _on_player_player_landed() -> void:
	if get_parent().position.y < max_player_location.y:
		max_player_location = get_parent().position
		#print(max_player_location)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("return") and waiting_for_e and %PopUp.visible:
		get_parent().position = max_player_location
