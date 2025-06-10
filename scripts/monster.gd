extends CharacterBody2D

@export var monster_speed: int = 3
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent

func _physics_process(delta: float) -> void:
	var direction = Vector3()
	
	navigation_agent.target_position = Global.player_target
	direction = navigation_agent.get_next_path_position() - global_position
	direction.normalized()
	
	velocity = velocity.lerp(direction * monster_speed, delta)
	move_and_slide()
