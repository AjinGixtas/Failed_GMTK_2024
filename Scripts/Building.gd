class_name Building extends Node2D

enum FloorType { ELECTRIC = 0, MILITARY = 1, INDUSTRY = 2, LOGISTIC = 3 }
var position_x = 0
var current_bullet = 0
@export var game_manager : GameManager = null
@export var floors : Array[FloorType] = []
@export var floor_constructed = 0
@export var floor_powered = 0
func intialize(_game_manager : GameManager, _position_x : int):
	game_manager = _game_manager
	position_x = _position_x
func add_industry_token() -> bool:
	if floor_constructed == len(floors): return false # I don't need more industry token!
	floor_constructed += 1
	return true
func add_electric_token() -> bool:
	if floor_powered == floor_constructed: return false # I don't need more electric token!
	floor_powered += 1
	return true
func on_production_cycle_finished():
	var products_data = [0, 0, 0, 0]
	floor_powered = 3
	for i in range(floor_powered):
		if   floors[i] == FloorType.ELECTRIC: products_data[FloorType.ELECTRIC] += 4
		elif floors[i] == FloorType.MILITARY: products_data[FloorType.MILITARY] += 3
		elif floors[i] == FloorType.INDUSTRY: products_data[FloorType.INDUSTRY] += 1
		elif floors[i] == FloorType.LOGISTIC: products_data[FloorType.LOGISTIC] += 1
	current_bullet = products_data[FloorType.MILITARY]
	game_manager.distribute_token(products_data[FloorType.INDUSTRY], products_data[FloorType.ELECTRIC], position_x, products_data[FloorType.LOGISTIC])
