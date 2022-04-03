extends StaticBody2D

func is_immortal():
	return get_parent().immortal

func remove_plant():
	get_parent().remove_plant()
