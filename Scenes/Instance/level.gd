class_name Level extends Node2D


@onready var floor_map: TileMapLayer = $Floor
@onready var enemy_block_map: TileMapLayer = $EnemyBlock


func _ready() -> void:
	assert(floor_map.tile_set.tile_size.x == floor_map.tile_set.tile_size.y)
	
	calculate_enemy_blocks()
	
	for node in $Enemies.get_children():
		if not node is Enemy:
			continue
		
		var enemy: Enemy = node as Enemy
		enemy.tree_exited.connect(calculate_enemy_blocks)


# use with global positions
func pos_to_cell(glob_pos: Vector2) -> Vector2i:
	return floor_map.local_to_map(floor_map.to_local(glob_pos))


func is_cell_floor(cell: Vector2i) -> bool:
	return floor_map.get_cell_source_id(cell) != -1


func is_cell_blocked(cell: Vector2i) -> bool:
	return enemy_block_map.get_cell_source_id(cell) != -1


func center_pos_to_tilemap(glob_pos: Vector2) -> Vector2:
	var tilesize := floor_map.tile_set.tile_size.x
	return Vector2((floor(glob_pos.x / tilesize) * tilesize) + tilesize / 2.0,
				   (floor(glob_pos.y / tilesize) * tilesize) + tilesize / 2.0)


func get_tilesize() -> int:
	return floor_map.tile_set.tile_size.x


func calculate_enemy_blocks() -> void:
	enemy_block_map.clear()
	
	var enemies: Node2D = $Enemies
	for node: Node in enemies.get_children():
		if not node is Node:
			continue
		
		var enemy: Enemy = node as Enemy
		var enemy_cell := pos_to_cell(enemy.global_position)
		
		enemy_block_map.set_cell(enemy_cell + Vector2i.UP, 0, Vector2i(1, 5))
		enemy_block_map.set_cell(enemy_cell + Vector2i.DOWN, 0, Vector2i(1, 5))
		enemy_block_map.set_cell(enemy_cell + Vector2i.LEFT, 0, Vector2i(1, 5))
		enemy_block_map.set_cell(enemy_cell + Vector2i.RIGHT, 0, Vector2i(1, 5))
