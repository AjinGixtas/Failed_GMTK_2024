extends Button

@export var index : int = 0
@onready var game_manager : GameManager = $"../../.."
func _on_pressed():
	game_manager.selected_index = index
