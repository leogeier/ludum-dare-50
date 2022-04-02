extends Node2D

var curve

func _ready():
	pass

func _process(_delta):
	var group = get_tree().get_nodes_in_group("flamethrower-connector")
	if group.size() > 0:
		var flamethrower_connector = group[0]
		curve = Curve2D.new()
		curve.add_point($Connector.position, Vector2.ZERO, $ConnectorDir.position)
		curve.add_point(to_local(flamethrower_connector.global_position), Vector2.LEFT * 4)
		update()

func _draw():
	if curve == null:
		return

	draw_polyline(curve.get_baked_points(), Color.black)
	
