extends Sprite2D


var level: Level

const fight_scene = preload("res://Scenes/Instance/fight.tscn")


func _ready() -> void:
	level = get_parent()
	await level.ready
	assert(level.is_in_group("LevelRoot"))
	
	# center player
	global_position = level.center_pos_to_tilemap(global_position)
	
	# check if start tile is floor
	assert(level.is_cell_floor(level.pos_to_cell(global_position)))


func _physics_process(_delta: float) -> void:
	move()


func move() -> void:
	var input: Vector2i = Vector2i.ZERO
	if Input.is_action_just_pressed("MOVE_UP"):
		input += Vector2i.UP
	if Input.is_action_just_pressed("MOVE_LEFT"):
		input += Vector2i.LEFT
	if Input.is_action_just_pressed("MOVE_DOWN"):
		input += Vector2i.DOWN
	if Input.is_action_just_pressed("MOVE_RIGHT"):
		input += Vector2i.RIGHT
	
	if input == Vector2i.ZERO:
		return # no movement
	
	var next_pos := level.pos_to_cell(global_position) + input
	# check base collision
	if not level.is_cell_floor(next_pos):
		return
	
	position += Vector2(input) * level.get_tilesize()
	
	# TODO door logic
	
	if level.is_cell_blocked(next_pos):
		print("FIGHT!")
		enter_fight()


func enter_fight() -> void:
	var fight = fight_scene.instantiate()
	add_child(fight)
