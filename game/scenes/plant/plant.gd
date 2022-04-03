extends Node2D

signal removed

export(float, 0.1, 2) var grow_speed = 1
export(float, 0, 1) var child_grow_speed_variance = 0.25
export(float, 0, 1) var growth_likelihood = 0.01
export var immortal = false
export(int) var max_plants = 500

onready var	sprout_points = $SproutPoints.get_children()
onready var plant_scene = load("res://scenes/plant/plant.tscn")

var r
var is_grown = false
var origin_sprout_point

func grow():
	if sprout_points.empty() or !is_grown or get_tree().get_nodes_in_group("plant").size() > max_plants:
		return
	var idx = randi() % sprout_points.size()
	var sprout_point = sprout_points[idx]
	sprout_points.remove(idx)

	var plant = plant_scene.instance()
	plant.global_position = sprout_point.get_sprout_position()
	plant.rotation = sprout_point.get_sprout_rotation()
	plant.grow_speed = clamp(grow_speed + r.randf_range(-child_grow_speed_variance, child_grow_speed_variance), 0.75, 1.25)
	plant.origin_sprout_point = sprout_point
	plant.connect("removed", self, "on_plant_removed")
	get_parent().add_child(plant)

func on_plant_removed(origin_sprout_point):
	sprout_points.append(origin_sprout_point)

func remove_plant():
	emit_signal("removed", origin_sprout_point)
	queue_free()

func on_tween_completed(_object, _key):
	is_grown = true

func _ready():
	r = RandomNumberGenerator.new()
	r.randomize()
	scale = Vector2.ZERO
	$Tween.interpolate_property(self, "scale", Vector2.ZERO, Vector2.ONE, grow_speed, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.start()

func _process(_delta):
	if !sprout_points.empty():
		if growth_likelihood > r.randf():
			grow()
	# if Input.is_action_just_pressed("use"):
	# 	grow()
	# 	pass

