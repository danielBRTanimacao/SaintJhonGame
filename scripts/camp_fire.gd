extends StaticBody2D

@export var camp_damage: int = 1

var fuel_capacity: int = 300

var is_in_reload_area: bool = false
var is_camp_fire_on: bool = true
var can_damage: bool = true

func _process(_delta: float) -> void:
	if is_in_reload_area && Input.is_action_just_pressed("action"):
		if !Global.inventory.is_empty():
			var allFuels = Global.inventory.size() * 5
			fuel_capacity += allFuels
			Global.inventory.clear()
			
			$Control/Sprite2D.visible = false
			
	verify_capacity()
	update_animation()
	update_light()

func verify_capacity():
	if fuel_capacity >= camp_damage:
		$SafeArea.monitoring = true
		
		is_camp_fire_on = true
		can_damage = true

	elif fuel_capacity <= 0:
		fuel_capacity = 0
		
		$SafeArea.monitoring = false
		
		is_camp_fire_on = false
		can_damage = false
	
	else:
		$SafeArea.monitoring = false
		
		is_camp_fire_on = false
		can_damage = false

func verify_time_left() -> void:
	
	if Global.time_left <= 310:
		camp_damage = 3
		
	elif Global.time_left <= 280:
		camp_damage = 5
	
	elif Global.time_left <= 160:
		camp_damage = 7
	
	elif Global.time_left <= 60:
		camp_damage = 10
	
	elif Global.time_left <= 15:
		camp_damage = 15

func update_animation() -> void:
	if is_camp_fire_on == true:
		$AnimationPlayer.play("active")
	else:
		$AnimationPlayer.play("desative")

func camp_fire_damage() -> void: 
	if can_damage == true:
		fuel_capacity -= camp_damage

func update_light() -> void:
	var current_light_ratio: float = 0.0
	if camp_damage > 0:
		current_light_ratio = float(fuel_capacity) / float(camp_damage * (300 / camp_damage))
	
	current_light_ratio = max(0.0, current_light_ratio)
	
	if $"SafeArea/PointLight2D":
		$"SafeArea/PointLight2D".texture_scale = 1.0 * current_light_ratio

func _on_timer_dmg_timeout() -> void:
	camp_fire_damage()
	verify_time_left()

func _on_safe_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.player_is_safe = true

func _on_safe_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.player_is_safe = false

func _on_reload_fuel_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and Global.inventory.size() != 0:
		$Control/Sprite2D.visible = true
		is_in_reload_area = true

func _on_reload_fuel_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Control/Sprite2D.visible = false
		is_in_reload_area = false
