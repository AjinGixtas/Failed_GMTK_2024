extends Area2D

@onready var thumbnail : Sprite2D = $Thumbnail
@onready var building_scene : PackedScene = preload("res://Floors/Building.tscn")
@onready var game_manager : GameManager = $"../.."
@onready var building_container = $".."
@export var index_position = 0
func _on_mouse_entered():
	thumbnail.self_modulate = Color(1, 1, 1, .667)
func _on_mouse_exited():
	thumbnail.self_modulate = Color(1, 1, 1, .333)
var building = null
func _on_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("ui_left_click"): 
		building = building_scene.instantiate()
		building_container.add_child(building)
		building.global_position = Vector2(300 * index_position, 0)
		game_manager.buildings[index_position] = building
		index_position += 1 if index_position > 0 else -1
		global_position = Vector2(300 * index_position, 0)
		thumbnail.self_modulate = Color(1, 1, 1, .333)
