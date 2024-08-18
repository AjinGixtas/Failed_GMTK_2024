extends Area2D

@onready var thumbnail : Sprite2D = $Thumbnail
@onready var building : Building = $".."
var thumbnails : Array[Resource] = [ load("res://Sprites/ElectricFloor.png"), load("res://Sprites/IndustrialFloor.png"), load("res://Sprites/LogisticFloor.png"), load("res://Sprites/MilitaryFloor.png") ]

func _on_mouse_entered():
	thumbnail.texture = thumbnails[building.game_manager.selected_index]
	thumbnail.visible = true
func _on_mouse_exited():
	thumbnail.visible = false
func _on_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("ui_left_click"): building.add_floor(building.game_manager.selected_index)
	elif event.is_action_pressed("ui_right_click"): building.remove_floor()
