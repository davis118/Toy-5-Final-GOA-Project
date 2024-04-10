extends Control

const FOLLOW_SPEED=25

var tile_data
var pieces = []
var tile_size = 80
var moving = false
var pickoffset
var placed
var debug = false
var id

signal kms(tile_data: Array, pos, pickoffset: Vector2, id)
signal checkwin(tile_data: Array, pos: Vector2, id)

@export var piece_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func generate(new_tile_data):
	tile_data=new_tile_data
	for cell in tile_data:
		var piece = piece_scene.instantiate()
		piece.set_size(tile_size)
		piece.position = cell * tile_size
		piece.coords = cell
		piece.picked.connect(picked)
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
	if moving:
		if not Input.is_action_pressed("left_mouse_button"):
			emit_signal("checkwin", tile_data, global_position, id)
			moving=false
		else:
			#global_position = position.lerp(get_global_mouse_position() + pickoffset, delta*FOLLOW_SPEED)
			global_position = get_global_mouse_position() + pickoffset

func initialize (i):
	pass

func picked():
	pickoffset = global_position - get_global_mouse_position()
	if not placed:
		emit_signal("kms", tile_data, global_position, pickoffset, id)
		queue_free()
	else:
		moving = true

