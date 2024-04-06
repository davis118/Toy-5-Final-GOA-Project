extends Control

@export var tile_scene: PackedScene

#data for the board
var board = []
#array of tile entities
var tiles = []
var previewtiles = []


# Called when the node enters the scene tree for the first time.
func _ready():
	var tile = tile_scene.instantiate()
	tile.generate(shared.cells[0])
	tiles.append(tile)
	add_child(tile)
	tile.position = Vector2(500, 500)
	
	for cell in shared.cells:
		var previewtile = tile_scene.instantiate()
		previewtile.generate(cell)
		previewtiles.append(previewtile)
		previewtile.change_size(32)
		var centercontainer = CenterContainer.new()
		$ScrollContainer/HBoxContainer.add_child(centercontainer)
		centercontainer.add_child(previewtile)
		centercontainer.custom_minimum_size = Vector2(50, 200)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
