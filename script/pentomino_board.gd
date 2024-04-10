extends Control

@export var tile_scene: PackedScene

#data for the board
const width = 11
const height = 11
const tile_size = 80

var solution = [
	[0,0,0,0,1,1,1,0,0,0,0],
	[0,0,0,0,1,1,1,0,0,0,0],
	[0,0,0,0,1,1,1,0,0,0,0],
	[0,0,0,1,1,1,1,1,0,0,0],
	[1,1,1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,0,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1,1,1],
	[0,0,0,1,1,1,1,1,0,0,0],
	[0,0,0,0,1,1,1,0,0,0,0],
	[0,0,0,0,1,1,1,0,0,0,0],
	[0,0,0,0,1,1,1,0,0,0,0],
]

var filled = []
#array of tile entities
var tiles = []
var previewtiles = []

@onready var start = $TextureRect.position

signal level_won()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#var tile = tile_scene.instantiate()
	#tile.generate(shared.cells[0])
	#tile.placed = true
	#tiles.append(tile)
	#add_child(tile)
	#tile.position = Vector2(500, 500)
	var i=0
	for cell in shared.cells:
		filled.append([])
		var previewtile = tile_scene.instantiate()
		previewtile.id = i
		i+=1
		previewtile.generate(cell)
		previewtiles.append(previewtile)
		previewtile.change_size(32)
		previewtile.kms.connect(tilepop)
		previewtile.placed = false
		var centercontainer = CenterContainer.new()
		$ScrollContainer/HBoxContainer.add_child(centercontainer)
		centercontainer.add_child(previewtile)
		centercontainer.custom_minimum_size = Vector2(50, 200)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func tilepop(tile_data, pos, pickoffset, id):
	#print(tile_data)
	#print(pos)
	var tile = tile_scene.instantiate()
	tile.generate(tile_data)
	tile.global_position = pos
	tile.placed=true
	tile.moving=true
	tile.pickoffset = pickoffset
	tile.id = id
	tile.checkwin.connect(checkwin)
	tiles.append(tile)
	add_child(tile)

func checkwin(tile_data, pos, id):
	#i love sphagetti mamma mia!
	print("tiledata: " , str(tile_data))
	var corner = ((pos-start-Vector2(tile_size/2,tile_size/2))/tile_size).round()
	filled[id]=[]
	for i in tile_data:
		filled[id].append(i+corner)
	#print(filled)
	var tempfilled = []
	for i in range(height):
		tempfilled.append([])
		for j in range(width):
			tempfilled[i].append(0)
	for i in filled:
		for j in i:
			if 0<=j.x and j.x<width and 0<=j.y and j.y<height:
				tempfilled[j.y][j.x]=1
	print(tempfilled)
	var solved = true
	for i in range(height):
		for j in range(width):
			if (solution[i][j]==1 and tempfilled[i][j] != 1):
				solved = false
	if solved:
		print("you won")
		emit_signal("level_won")
		queue_free()
