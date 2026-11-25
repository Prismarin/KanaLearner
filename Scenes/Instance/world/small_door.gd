extends AnimatedSprite2D


func open() -> void:
	play("default")


func close() -> void:
	play_backwards("default")


func is_open() -> bool:
	return frame == 2
