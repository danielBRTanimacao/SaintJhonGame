extends StaticBody2D

var isPlayerArea = false

func _process(_delta: float) -> void:
	if isPlayerArea && Input.is_action_just_pressed("action"):
		if Global.inventory.size() < 7:
			Global.inventory.append(5)
			queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Control/ButtonSprite.visible = true
		isPlayerArea = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Control/ButtonSprite.visible = false
		isPlayerArea = false
