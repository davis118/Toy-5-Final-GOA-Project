extends Control

var tile_data
var pieces = []
var tile_size = 100
@export var piece_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func generate(tile_data):
	for cell in tile_data:
		var piece = piece_scene.instantiate()
		piece.set_size(tile_size)
		piece.position = cell * tile_size
		piece.coords = cell
		add_child(piece)
		pieces.append(piece)

func change_size(new_size):
	tile_size = new_size
	for piece in pieces:
		piece.position = piece.coords * tile_size
		piece.set_size(new_size)

func set_texture(texture):
	for piece in pieces:
		piece.set_texture(texture)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initialize (i):
	pass


func _on_mouse_entered():
	print("entered")
