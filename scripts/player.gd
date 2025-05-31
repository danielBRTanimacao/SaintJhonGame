extends CharacterBody2D

@export var islived: bool = true
@export var isSafeArea: bool = true
@export var inventory: Array = []
@export var playerSpeed: int = 400

func player_movement() -> void:
	var input_direction = Input.get_vector(
		"moveLeft", "moveRight", "moveUp", "moveDown"
	)
	velocity = input_direction * playerSpeed

func _physics_process(delta: float) -> void:
	player_movement()
	move_and_slide()
