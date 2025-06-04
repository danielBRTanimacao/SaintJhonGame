extends StaticBody2D

var max_capacity: int = 300
@export var camp_damage: int = 1
var isPLayerInArea = false

func _process(_delta: float) -> void:
	if isPLayerInArea && Input.is_action_just_pressed("action"):
		if !Global.inventory.is_empty():
			var allFuels = Global.inventory.size() * 5
			max_capacity += allFuels
			Global.inventory.clear()

func _on_timer_dmg_timeout() -> void:
	max_capacity -= camp_damage
	if Global.time_left <= 600:
		camp_damage = 5

func _on_safe_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Control/Sprite2D.visible = true
		isPLayerInArea = true

func _on_safe_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Control/Sprite2D.visible = false
		isPLayerInArea = false
