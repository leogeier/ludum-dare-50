extends Node2D

export(int, 0, 2000) var max_plants = 500


func _ready():
	for plant in $Plants.get_children():
		plant.max_plants = max_plants

func _process(_delta):
	$CanvasModulate.color = Color.white.linear_interpolate(Color.black, $Plants.get_child_count() / float(max_plants))
