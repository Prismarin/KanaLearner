class_name FightManager extends Control


@export var enemy: Enemy
@export var player: Player

@onready var kana_container: KanaContainer = $Kana
@onready var selection: TileMapLayer = $Selection

signal fight_end


func _ready() -> void:
	if not enemy:
		enemy = Enemy.new()


func on_selection_made(pos1: Vector2i, pos2: Vector2i) -> void:
	if kana_container.check_if_same_reading(pos1, pos2):
		kana_container.remove_kana(pos1)
		kana_container.remove_kana(pos2)
		
		enemy.hp -= player.attack
		print(enemy.hp)
		
		if enemy.hp < 1:
			fight_end.emit()
			enemy.queue_free()
			queue_free()
	
	selection.clear()
