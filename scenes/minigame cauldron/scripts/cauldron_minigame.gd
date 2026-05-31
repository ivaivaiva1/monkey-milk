extends Node2D

const CRAFTING_SCENE = preload("res://scenes/minigame crafting/crafting_minigame.tscn")

@onready var overlay_container: Control = $OverlayContainer
#@onready var blur_shader: ColorRect = $BlurShader


var ingredients_added:= 0
var required_ingredients:= 3

func ingredient_added(ingredient):
	ingredient.queue_free()
	
func open_crafting():
	#$BlurShader.visible = true
	
	var crafting = CRAFTING_SCENE.instantiate()
	
	crafting.caudron_scene = self
	
	overlay_container.add_child(crafting)

func _on_crafting_finished():
	#blur_shader.visible = false
	print("crafting terminou")
	
	ingredients_added += 1
	
	if ingredients_added >= required_ingredients:
		print("acabou")
