extends CanvasLayer
class_name  Tutorial

@onready var milk_counter: Label = %MilkCounter

var monkey_minigame: MonkeyMinigame



func _ready():
	if !Globals.need_tutorial: 
		call_deferred("skip_tutorial")
		return
	self.visible = true
	milk_counter.visible = false


func _on_start_button_button_down() -> void:
	skip_tutorial()


func skip_tutorial():
	if Globals.need_tutorial: Globals.need_tutorial = false
	visible = false
	get_tree().paused = false
	monkey_minigame.start_game()
