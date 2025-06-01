extends StaticBody2D

var max_capacity: int = 300
@export var camp_damage: int = 1

func _on_timer_dmg_timeout() -> void:
	max_capacity -= camp_damage
