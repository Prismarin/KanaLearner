@tool
class_name Enemy extends Sprite2D


@export var hp: int = 5
@export var attack: int = 1

var level: Level


func _ready() -> void:
	level = get_parent().get_parent()
	await level.ready
	assert(level.is_in_group("LevelRoot"))
	
	global_position = level.center_pos_to_tilemap(global_position)
