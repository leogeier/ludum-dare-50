extends Node2D

func _on_ClosedTimer_timeout():
	$OpenSprite.visible = true
	$ClosedSprite.visible = false

func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("use") and $CooldownTimer.is_stopped():
		$OpenSprite.visible = false
		$ClosedSprite.visible = true
		$ClosedTimer.start()
		$CooldownTimer.start()
		$AudioStreamPlayer.play()

		var plant_bodies = []
		for body in $Area2D.get_overlapping_bodies():
			if body.is_in_group("plant_area") and !body.is_immortal():
				plant_bodies.append(body)
		if !plant_bodies.empty():
			plant_bodies[randi() % plant_bodies.size()].remove_plant()
