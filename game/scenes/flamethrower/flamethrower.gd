extends Node2D


func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("use"):
		$AudioStreamPlayer.play()
		$Movables/Particles2D.emitting = true
		$Movables/Light2D.enabled = true
		$MovablesTween.stop_all()
		$MovablesTween.interpolate_property($Movables, "position", $Movables.position, Vector2(-5, 0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$MovablesTween.start()
	if Input.is_action_just_released("use"):
		$AudioStreamPlayer.stop()
		$Movables/Particles2D.emitting = false
		$Movables/Light2D.enabled = false
		$MovablesTween.stop_all()
		$MovablesTween.interpolate_property($Movables, "position", $Movables.position, Vector2(0, 0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$MovablesTween.start()
