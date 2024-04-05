extends Control

var tile_data
var pieces = []
var tile_size = 100
@export var piece_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	tile_data = shared.cells[1]
	for cell in tile_data:
		var piece = piece_scene.instantiate()
		piece.set_size(tile_size)
		piece.position = cell * tile_size
		add_child(piece)
		pieces.append(piece)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initialize (i):
	pass
