class_name Building extends Node2D

enum FloorType { ELECTRIC = 0, INDUSTRY = 1, LOGISTIC = 2, MILITARY = 3 }
var position_x = 0
@onready var game_manager : GameManager = $"../.."
@onready var hover_zone = $HoverZone
@onready var floor_scene = preload("res://Floors/Floor.tscn")
@onready var stat_displayer : Node2D = $StatDisplayer
@onready var stat_displayers : Array[Label] = [$StatDisplayer/ElectricToken/StatDisplay, $StatDisplayer/IndustryToken/StatDisplay, $StatDisplayer/LogisticToken/StatDisplay]
@export var floors : Array[FloorType] = []
@export var floor_constructed = 0
@export var floor_powered = 0
var floor_graphic_display : Array[Node2D] = []
func intialize(_game_manager : GameManager, _position_x : int):
	game_manager = _game_manager
	position_x = _position_x
func add_industry_token() -> bool:
	if floor_constructed == len(floors): return false # I don't need more industry token!
	floor_graphic_display[floor_constructed].animation_player.play('bounce')
	floor_constructed += 1
	return true
func add_electric_token() -> bool:
	if floor_powered == floor_constructed: return false # I don't need more electric token!
	floor_powered += 1
	stat_displayers[FloorType.ELECTRIC].text = str(floor_powered) + '/' + str(len(floors))
	return true
func on_production_cycle_finished():
	if len(floors) == 0: return # There's no floor in this building!
	var products_data = [3, 1, 1]
	for i in range(min(floor_powered, len(floors))):
		if   floors[i] == FloorType.ELECTRIC: products_data[FloorType.ELECTRIC] += 4
		elif floors[i] == FloorType.INDUSTRY: products_data[FloorType.INDUSTRY] += 1
		elif floors[i] == FloorType.LOGISTIC: products_data[FloorType.LOGISTIC] += 1
	stat_displayers[FloorType.INDUSTRY].text = str(products_data[FloorType.INDUSTRY])
	stat_displayers[FloorType.LOGISTIC].text = str(products_data[FloorType.LOGISTIC])
	game_manager.distribute_token(products_data[FloorType.INDUSTRY], products_data[FloorType.ELECTRIC], position_x, products_data[FloorType.LOGISTIC])
	
var thumbnails : Array[Resource] = [ load("res://Sprites/ElectricFloor.png"), load("res://Sprites/IndustrialFloor.png"), load("res://Sprites/LogisticFloor.png"), load("res://Sprites/MilitaryFloor.png") ]
func add_floor(floor_type : int):
	floors.append(floor_type)
	floor_graphic_display.append(floor_scene.instantiate())
	add_child(floor_graphic_display.back())
	floor_graphic_display.back().sprite2D.texture = thumbnails[floor_type]
	floor_graphic_display.back().position = Vector2(0, -70.0 - 40.0 * (len(floors) - 1))
	hover_zone.position = Vector2(0.0, -70 - 40.0 * len(floors))
	stat_displayer.position = Vector2(0.0, - 100 - 40.0 * len(floors))
	hover_zone.thumbnail.visible = false
func remove_floor():
	floors.pop_back()
	hover_zone.position = Vector2(0.0, -70 - 40.0 * len(floors))
	stat_displayer.position = Vector2(0.0, -100 - 40.0 * len(floors))
