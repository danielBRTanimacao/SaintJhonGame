extends Node2D

@onready var labelGlobalTimer = $Player/CanvasLayer/MarginContainer/CountDownText
@onready var timerGlobal = $WordTimer

func _ready() -> void:
	timerGlobal.start()

func time_left_to_live() -> Array:
	var time_left = timerGlobal.time_left
	var minutes = floor(time_left / 60)
	var seconds = int(time_left) % 60
	return [minutes, seconds]

func _process(_delta: float) -> void:
	labelGlobalTimer.text = "%02d:%02d" % time_left_to_live()
	Global.time_left = timerGlobal.time_left
