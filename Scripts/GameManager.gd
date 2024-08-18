class_name GameManager extends Node2D

@export var buildings : Dictionary
var selected_index = 0
func _ready():
	buildings[0] = $BuildingContainer/Building
func distribute_token(industry:int, electric:int, _position:int, logistic:int):
	var building = null
	for i in range(logistic):
		# Try adding token to the right position
		building = buildings.get(_position + i, null)
		if building != null and building.add_industry_token():
			while building.add_industry_token(): # Repeatedly adding token till it's full
				industry -= 1
				if industry == 0: break

		# Try adding token to the left position
		building = buildings.get(_position - i, null)
		if building != null:
			while building.add_industry_token(): # Repeatedly adding token till it's full
				industry -= 1
				if industry == 0: break
		
	
	for i in range(logistic):
		# Try adding token to the right position
		building = buildings.get(_position + i, null)
		if building != null:
			while building.add_electric_token(): # Repeatedly adding token till it's full
				electric -= 1
				if electric == 0: break

		# Try adding token to the left position
		building = buildings.get(_position - i, null)
		if building != null:
			while building.add_electric_token(): # Repeatedly adding token till it's full
				electric -= 1
				if electric == 0: break

