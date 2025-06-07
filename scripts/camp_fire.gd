extends StaticBody2D

@export var camp_damage: int = 1

#=======================================================================
#WARN1NG - fuel_capacity foi alterado para testes (Valor inicial = 300).
#=======================================================================

var fuel_capacity: int = 10 #Ficou no lugar do max_capacity (que remetia a limite, e não a valor atual).

var is_in_reload_area: bool = false #Dita se o player está na área de recarga.
var is_camp_fire_on: bool = true #Dita se a fogueira está acesa.
var can_damage: bool = true #Dita se a fogueira pode levar dano.

func _process(_delta: float) -> void:
	if is_in_reload_area && Input.is_action_just_pressed("action"):
		if !Global.inventory.is_empty():
			var allFuels = Global.inventory.size() * 5
			fuel_capacity += allFuels
			Global.inventory.clear()
			
			$Control/Sprite2D.visible = false #Deixa o Label invisível qunado o inventátio é esvaziado.
			
	#Muda em tempo real a animação e a capacidade. (Pode causar Lag)
	verify_capacity()
	update_animation()
	
	#Se Quiser ver o estado de proteção do player em tempo real.
	#print(Global.player_is_safe)

#Verifica se a capacidade é maior que 0. Evita que a capacidade da fogueira se torne negativa.
func verify_capacity():
	if fuel_capacity >= camp_damage:
		$SafeArea.monitoring = true #Garante que a área segura esteja ativada.
		
		is_camp_fire_on = true #Diz que a fogueira está ativada.
		can_damage = true #Diz que a fogueira pode levar dano.

	elif fuel_capacity <= 0: #Garante que a capacidade sempre fique em 0, e não negativa.
		fuel_capacity = 0
		
		$SafeArea.monitoring = false #Desativa a área segura pois não há combustível para manter a fogueira acesa.
		
		is_camp_fire_on = false #Diz que a fogueira está desativada.
		can_damage = false #Desativa o dano da fogueira.
	
	else:
		$SafeArea.monitoring = false #Desativa a área segura pois não há combustível para manter a fogueira acesa.
		
		is_camp_fire_on = false #Diz que a fogueira está desativada.
		can_damage = false #Desativa o dano da fogueira.

#Verifica quanto tempo falta para o tempo do jogo acabar. (Intervalo referente a 2 minutos)
func verify_time_left() -> void:
	if Global.time_left <= 600:
		camp_damage = 3
		
	elif Global.time_left <= 480:
		camp_damage = 5
	
	elif Global.time_left <= 360:
		camp_damage = 7
	
	elif Global.time_left <= 360:
		pass
	
	elif Global.time_left <= 240:
		pass
	
	elif Global.time_left <= 120:
		pass

#Atualiza as animações com base no combustível da fogueira.
func update_animation() -> void:
	if is_camp_fire_on == true:
		$AnimationPlayer.play("active")
	
	else:
		$AnimationPlayer.play("desative")

#Verifica se pode dar dano da fogueira (foi separada para melhorar a componentização e fluidez).
func camp_fire_damage() -> void: 
	if can_damage == true:
		fuel_capacity -= camp_damage

#A cada pulso a fogueira leva dano e é verificada o estágio de tempo do jogo. 
func _on_timer_dmg_timeout() -> void:
	camp_fire_damage()
	verify_time_left()
	
	#Debug - Os dados podem sofrer delay pela ordem de chamada das funções.
	print(fuel_capacity) #Debug - Mostra a capacidade da fogueira
	print(Global.player_is_safe) #Debug - Mostra o Estado de proteção do player

#Verifica se o player está na área segura (essa lógica vai ser útil para o monstro verificar se pode atacar ou não).
#	Além de ser usada na lógica da fogueira apagando.
func _on_safe_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.player_is_safe = true

func _on_safe_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.player_is_safe = false

#Verifica se o Player está na área de recarga.
func _on_reload_fuel_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and Global.inventory.size() != 0: #A layer só aparece se o inventário tiver itens.
		$Control/Sprite2D.visible = true
		is_in_reload_area = true

func _on_reload_fuel_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"): #Precisa verificar se é um player pois o node da fogueira  um body e pode conflitar com a légica.
		$Control/Sprite2D.visible = false
		is_in_reload_area = false










#    _____      ____
#   /\/\/\/\   | "o \ 
# <|\/\/\/\/|_/ /___/
#  |___________/     
#  |_|_|  /_/_/
