extends Node2D

var id: int = randi()
var bananas: Array[Banana] = []

func _ready() -> void:
	for child in get_children(): 
		if child is Banana:
			bananas.append(child)
			child.id = id
	
	throw_bananas()


func throw_bananas():
	for banana in bananas:
		banana.direction = (banana.global_position - global_position).normalized()



func _on_timer_timeout() -> void:
	queue_free()
