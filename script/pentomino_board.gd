extends Control

@export var tile_scene: PackedScene

#data for the board
var board = []
#array of tile entities
var tiles = []


# Called when the node enters the scene tree for the first time.
func _ready():
	var tile = tile_scene.instantiate()
	tiles.append(tile)
	add_child(tile)
	tile.position = Vector2(500, 500)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
