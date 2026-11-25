extends TileMapLayer


@export var bounds: Vector2i = Vector2i(10, 5)

signal selected(tiles: Array[Vector2i])


func _physics_process(_delta: float) -> void:
	for cell in get_used_cells_by_id(0, Vector2i(0, 5), 1):
		erase_cell(cell)
	
	var selected_cell = local_to_map(to_local(get_global_mouse_position()))
	if selected_cell.x < 0 or selected_cell.y < 0 or selected_cell.x > bounds.x - 1 or selected_cell.y > bounds.y - 1:
		return
	
	if Input.is_action_just_pressed("Select"):
		set_cell(selected_cell, 0, Vector2i(0, 5), 0)
		
		var selection = get_used_cells_by_id(0, Vector2i(0, 5), 0)
		if selection.size() >= 2:
			assert(selection.size() == 2, "More than 2 cells selected, should not be possible.")
			selected.emit(selection[0], selection[1])
	elif get_cell_source_id(selected_cell) == -1: 
		set_cell(selected_cell, 0, Vector2i(0, 5), 1)
