extends CharacterBody2D

#==========================================================================================================================
#WARN1NG - Mudança no tempo da animação, para voltar a original basta ir em: AnimationPlayer ---> Speed Scale ---> "0.5".
#WARN1NG - Mudança no Z-index do novo "World", para alterar basta ir em: World ---> Structures ---> Ordering ---> Z-Index.
#==========================================================================================================================
 
#Mudança nos nomes das variáveis para seguir o padrão "Snake Case".
@export var is_alive: bool = true
@export var is_safe: bool = Global.player_is_safe #Sincroniza o estado de proteção do player com script Global.
@export var player_speed: int = 200 

var final_direction = "idle-down"

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
