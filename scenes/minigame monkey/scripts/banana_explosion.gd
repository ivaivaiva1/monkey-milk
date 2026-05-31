extends Node2D

var bananas: Array[Banana] = []

func _ready() -> void:
	for child in get_children(): 
		if child is Banana:
			bananas.append(child)
	
	throw_bananas()


func throw_bananas():
	for banana in bananas:
		banana.direction = (banana.global_position - global_position).normalized()



func _on_timer_timeout() -> void:
	print("morri")
	queue_free()
