extends CharacterBody2D
 
@export var is_safe: bool = Global.player_is_safe
@export var player_speed: int = 200 

var final_direction = "idle-down"

func _process(_delta: float) -> void:
	Global.player_target = get_node("CollisionShape2D").global_transform.origin
	if !Global.is_alive:
		get_tree().change_scene_to_file("res://scenes/play_ui.tscn")
		Global.is_alive = true

func player_movement() -> void:
	var input_direction = Input.get_vector(
		"moveLeft", "moveRight", "moveUp", "moveDown"
	)
	
	if input_direction.x < 0:
		final_direction = "idle-left"
		$AnimationPlayer.play("run-left")
	elif input_direction.x > 0:
		final_direction = "idle-right"
		$AnimationPlayer.play("run-right")
	elif input_direction.y < 0:
		final_direction = "idle-up"
		$AnimationPlayer.play("run-up")
	elif input_direction.y > 0:
		final_direction = "idle-down"
		$AnimationPlayer.play("run-down")
	
	velocity = input_direction * player_speed
	
	if velocity.x == 0 and velocity.y == 0:
		$AnimationPlayer.play(final_direction)

func _physics_process(_delta: float) -> void:
	player_movement()
	move_and_slide()
