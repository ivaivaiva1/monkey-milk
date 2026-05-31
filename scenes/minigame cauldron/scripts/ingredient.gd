extends Node2D

@export var ingredient_name: String
@export var ingredient_texture: Texture2D

@onready var sprite: Sprite2D = %Sprite2D

var selected := false
var mouse_offset := Vector2.ZERO

func _ready() -> void:
	if sprite == null:
		sprite = find_child("Sprite2D", true, false) as Sprite2D
	
	if sprite != null:
		if ingredient_texture == null: return
		sprite.texture = ingredient_texture

func _process(delta):
	if selected:
		follow_mouse()

func follow_mouse():
	position = get_global_mouse_position() + mouse_offset

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			mouse_offset = position - get_global_mouse_position()
			selected = true
		else:
			selected = false


#func _on_area_2d_area_entered(area: Area2D) -> void:
	#if area.name == "Cauldron":
		#get_tree().change_scene_to_file("res://scenes/minigame crafting/crafting_minigame.tscn")
		#queue_free()
