extends Node


const hiragana := "あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをん"


func _ready() -> void:
	print(hiragana)
	print(to_katakana(hiragana))


func to_katakana(s: String) -> String:
	var out := ""
	for i in s.length():
		var c := s.unicode_at(i)
		if c >= 0x3041 and c <= 0x3096:
			c += 0x60 # offset zwischen hiragana und katakana
		out += String.chr(c)
	return out


## Expecting one hiragana and one katakana.
## Returing false if the same kana is given twice.
func is_same_reading(s1: String, s2: String) -> bool:
	assert(s1.length() == 1 and s2.length() == 1)
	
	if s1 == s2:
		return false
	
	if hiragana.contains(s1):
		return s2 == to_katakana(s1)
	
	if hiragana.contains(s2):
		return s1 == to_katakana(s2)
	
	return false


func create_kana_list(n: int) -> Array[String]:
	var ret: Array[String] = []
	for i in range(n):
		var c := hiragana.unicode_at(randi_range(0, hiragana.length() - 1))
		var hir: String = String.chr(c)
		ret.append(hir)
		ret.append(to_katakana(hir))
	return ret
