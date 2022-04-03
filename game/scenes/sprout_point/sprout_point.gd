tool

extends Node2D

export(float, 0, 3.14) var span = 0.5

onready var r = RandomNumberGenerator.new()

func get_sprout_position():
	return global_position

func get_sprout_rotation():
	if get_child_count() == 0:
		return 0
	var child = get_child(0)

	var angle = child.position.angle()
	return global_rotation + angle + r.randf_range(0, span) - span / 2

func _ready():
	r.randomize()

func _process(_delta):
	update()

func _draw():
	if !Engine.is_editor_hint() or get_child_count() == 0:
		return
	var child = get_child(0)

	var angle = child.position.angle()
	var half_span = span / 2
	var begin_angle = angle - half_span
	var end_angle = angle + half_span
	var radius = child.position.length()
	draw_arc(Vector2.ZERO, radius, begin_angle, end_angle, 10, Color.red)
	draw_line(Vector2.ZERO, Vector2.RIGHT.rotated(begin_angle) * radius, Color.red)
	draw_line(Vector2.ZERO, Vector2.RIGHT.rotated(end_angle) * radius, Color.red)
