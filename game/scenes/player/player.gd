extends KinematicBody2D

export(float, 0, 400) var max_velocity = 100.0
export(float, 0, 100) var accelaration = 10.0

var velocity = 0
var last_dir = Vector2.RIGHT

func get_tool_position():
	return $ToolPosition.global_position

func get_tool_rotation():
	return rotation

func _ready():
	pass

func on_changed_tool(is_flamethrower):
	$FuelPack.visible = is_flamethrower

func _process(_delta):
	if velocity > 0:
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")

func _physics_process(_delta):
	look_at(get_global_mouse_position())

	var dir = Vector2.ZERO

	if Input.is_action_pressed("left"):
		dir.x = -1
	if Input.is_action_pressed("right"):
		dir.x = 1
	if Input.is_action_pressed("up"):
		dir.y = -1
	if Input.is_action_pressed("down"):
		dir.y = 1

	dir = dir.normalized()
	last_dir = dir

	if dir == Vector2.ZERO:
		velocity -= accelaration
	else:
		velocity += accelaration
	velocity = clamp(velocity, 0, max_velocity)
	
	move_and_slide(velocity * dir)

