extends HBoxContainer

func _process(_delta: float) -> void:
	var starScore = $"../../..".score
	
	for x in get_children():
		x.hide()
	if starScore >= 100:
		$Star1.show()
	if starScore >= 200:
		$Star2.show()
	if starScore >= 300:
		$Star3.show()
	if starScore >= 400:
		$Star4.show()
	if starScore >= 500:
		$Star5.show()
	#print(_int_to_array(1, 123)) # prints 2
	#print(starScore)
	#print(_int_to_array(-1, starScore))
	if _int_to_array(-2, starScore) >= 5:
		$HalfStar.show()

func _int_to_array(index, temp):
	if temp.len() < abs(index):
		return 0
	return int(str(temp)[index])
