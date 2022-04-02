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
