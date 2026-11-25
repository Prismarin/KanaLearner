class_name KanaContainer extends Node2D


const kana_label = preload("res://Scenes/Instance/fight/kana_grid_label.tscn")

@export var bounds: Vector2i = Vector2i(10, 5)

var contained_kana: Dictionary[Vector2i, Label] = {}


func _ready() -> void:
	var kana := ReadingData.create_kana_list(25)
	kana.shuffle()
	for y in range(bounds.y):
		for x in range(bounds.x):
			var c: Label = kana_label.instantiate()
			c.text = kana.pop_front()
			c.position = Vector2(x * c.custom_maximum_size.x, y * c.custom_maximum_size.y)
			add_child(c)
			contained_kana[Vector2i(x, y)] = c


func remove_kana(pos: Vector2i) -> void:
	if contained_kana[pos]:
		contained_kana[pos].queue_free()
		contained_kana[pos] = null


func check_if_same_reading(pos1: Vector2i, pos2: Vector2i) -> bool:
	if not contained_kana[pos1] or not contained_kana[pos2]:
		return false 
	
	return ReadingData.is_same_reading(contained_kana[pos1].text, contained_kana[pos2].text)
