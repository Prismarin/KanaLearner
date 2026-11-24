extends TileMapLayer


@export var bounds: Vector2i = Vector2i(10, 5)


func _physics_process(_delta: float) -> void:
	for cell in get_used_cells_by_id(0, Vector2i(0, 5), 1):
		# print(cell, " → alt ", get_cell_alternative_tile(cell))
		erase_cell(cell)
	
	var selected_cell = local_to_map(to_local(get_global_mouse_position()))
	if selected_cell.x < 0 or selected_cell.y < 0 or selected_cell.x > bounds.x - 1 or selected_cell.y > bounds.y - 1:
		return
	
	if Input.is_action_just_pressed("Select"):
		set_cell(selected_cell, 0, Vector2i(0, 5), 0)
	elif get_cell_source_id(selected_cell) == -1: 
		set_cell(selected_cell, 0, Vector2i(0, 5), 1)
