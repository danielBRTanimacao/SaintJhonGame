extends StaticBody2D

var max_capacity: int = 300
@export var camp_damage: int = 1

func _on_timer_dmg_timeout() -> void:
	max_capacity -= camp_damage
	if Global.time_left <= 600:
		camp_damage = 5


func _on_safe_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("aoooba")
		
