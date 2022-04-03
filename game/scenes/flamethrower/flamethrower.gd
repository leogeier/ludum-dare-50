extends Node2D

export(float, 0, 1) var remove_chance = 0.1

onready var light_position = $Movables/Light2D.position

func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("use"):
		$AudioStreamPlayer.play()
		$Movables/Particles2D.emitting = true
		$Movables/Light2D.enabled = true
		$MovablesTween.stop_all()
		$MovablesTween.interpolate_property($Movables, "position", $Movables.position, Vector2(-5, 0), 0.1, Tween.TRANS_CIRC, Tween.EASE_OUT)
		$MovablesTween.start()
	if Input.is_action_just_released("use"):
		$AudioStreamPlayer.stop()
		$Movables/Particles2D.emitting = false
		$Movables/Light2D.enabled = false
		$MovablesTween.stop_all()
		$MovablesTween.interpolate_property($Movables, "position", $Movables.position, Vector2(0, 0), 0.1, Tween.TRANS_CIRC, Tween.EASE_OUT)
		$MovablesTween.start()
	
	$Movables/Light2D.position = light_position + Vector2.RIGHT.rotated(OS.get_ticks_msec() * 0.05) * 0.25

	if Input.is_action_pressed("use"):
		for body in $Movables/Area2D.get_overlapping_bodies():
			if body.is_in_group("plant_area") and !body.is_immortal():
				if remove_chance > randf():
					body.remove_plant()
