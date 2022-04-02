extends Node2D

signal changed_tool

enum Tool {SHEARS, SCYTHE, FLAMETHROWER}

export(NodePath) var player_path
export(float, 0, 1) var smoothness = 0.5
export(Tool) var active_tool = Tool.SHEARS setget set_active_tool

onready var player = get_node(player_path)

var tool_scenes = {
	Tool.SHEARS: preload("res://scenes/shears/shears.tscn"),
	Tool.SCYTHE: preload("res://scenes/scythe/scythe.tscn"),
	Tool.FLAMETHROWER: preload("res://scenes/flamethrower/flamethrower.tscn"),
	}

func reset_active_tool():
	for child in get_children():
		child.queue_free()
	add_child(tool_scenes[active_tool].instance())
	emit_signal("changed_tool", active_tool == Tool.FLAMETHROWER)

func set_active_tool(new_tool):
	active_tool = new_tool
	reset_active_tool()

func _ready():
	reset_active_tool()

func _process(_delta):
	if Input.is_action_just_pressed("switch_tools"):
		match active_tool:
			Tool.SHEARS:
				set_active_tool(Tool.FLAMETHROWER)
			Tool.FLAMETHROWER:
				set_active_tool(Tool.SHEARS)

func _physics_process(_delta):
	position = player.get_tool_position() * smoothness + position * (1 - smoothness)
	rotation = player.get_tool_rotation()

