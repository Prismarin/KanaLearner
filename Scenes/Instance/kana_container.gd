extends GridContainer

const TILE := 32
const KANA := "あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをん"  # hier deine 50 Zeichen


func _ready() -> void:
	for k in KANA:
		var l := Label.new()
		l.text = k
		l.custom_minimum_size = Vector2(TILE, TILE)
		l.size_flags_horizontal = 0   # kein Expand, sonst wachsen die Zellen
		l.size_flags_vertical = 0
		l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		l.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		add_child(l)
