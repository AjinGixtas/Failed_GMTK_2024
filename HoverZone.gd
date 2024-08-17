extends Area2D

@onready var thumbnail : Sprite2D = $Thumbnail


func _on_mouse_entered():
	thumbnail.visible = true

func _on_mouse_exited():
	thumbnail.visible = false
