extends Control

@export var board_size = 4
@export var tile_size = 80
@export var tile_scene: PackedScene 
@export var slide_duration = 0.15

@onready var slide_sound = $SlideSound
@onready var timer = $Timer

var board = []
var tiles = []
var empty = Vector2()
var tiles_animating = 0

var move_count = 0
var number_visible = true
var background_texture = null

enum GAME_STATES {
	NOT_STARTED,
	STARTED,
	WON
}
var game_state = GAME_STATES.NOT_STARTED

signal game_started
signal level_won
signal moves_updated

func gen_board():
	var value = 1
	board = []
	for r in range(board_size):
		board.append([])
		for c in range(board_size):
			if (value == board_size*board_size):
				board[r].append(0)
				empty = Vector2(c, r)
			else:
				board[r].append(value)

				# Check if tile_scene is not null before calling instance()
				if tile_scene:
					var tile_instance = tile_scene.instantiate() # Corrected line
					var tile = tile_instance as TextureButton # Assuming TextureButton is the correct type
					tile.set_position(Vector2(c * tile_size, r * tile_size))
					tile.set_text(int(value))
					if background_texture:
						tile.set_sprite_texture(background_texture)
					tile.set_sprite(value-1, board_size, tile_size)
					tile.set_number_visible(number_visible)
					tile.connect("tile_pressed", _on_Tile_pressed)
					add_child(tile)
					tiles.append(tile)
				else:
					print("Error: tile_scene is not initialized.")
			value += 1

func is_board_solved():
	print(board)
	var count = 1
	for r in range(board_size):
		for c in range(board_size):
			if (board[r][c] != count):
				if r == c and c == board_size - 1 and board[r][c] == 0:
					return true
				else:
					return false
			count += 1
	return true

func value_to_coords(value):
	for r in range(board_size):
		for c in range(board_size):
			if (board[r][c] == value):
				return Vector2(c, r)
	return null

func get_tile_by_coords(value):
	for tile in tiles:
		if str(tile.number) == str(value):
			return tile
	return null

#properly initializes board sizes
func _ready():
	tile_size = floor(get_size().x / board_size)
	set_size(Vector2(tile_size*board_size, tile_size*board_size))
	gen_board()

func _on_Tile_pressed(number):
	# check if game is not started
	if game_state == GAME_STATES.NOT_STARTED:
		scramble_board()
		game_state = GAME_STATES.STARTED
		emit_signal('game_started')
		return
	# check if game is won
	if game_state == GAME_STATES.WON:
		game_state = GAME_STATES.STARTED
		reset_move_count()
		scramble_board()
		emit_signal('game_started')
		return
	# check if tile clicked can actually be slid
	if (value_to_coords(number).distance_to(empty) != 1):
		return
	
	var target = value_to_coords(number)
	
	#updates board
	board[empty.y][empty.x] = number
	board[target.y][target.x] = 0
	
	#slides
	
	# slide sound
	slide_sound.play()
	timer.wait_time = slide_duration
	timer.start()
	
	# slide
	get_tile_by_coords(number).slide_to(empty*tile_size, slide_duration)
	empty = target

	# check win
	var is_solved = is_board_solved()
	if is_solved:
		game_state = GAME_STATES.WON
		emit_signal("level_won")
		print("won")

func check_solvable(temp_board: Array):
	var inversioncounter = 0
	for i in range(board_size*board_size-1):
		for j in range(i):
			if(temp_board[j] > temp_board[i]):
				inversioncounter += 1
	return !(inversioncounter%2)

func scramble_board():
	reset_board()
	
	#Explanation of the math
	#If N is odd, then puzzle instance is solvable if number of inversions is even in the input state.
	#If N is even, puzzle instance is solvable if 
	#the blank is on an even row counting from the bottom (second-last, fourth-last, etc.) and number of inversions is odd.
	#the blank is on an odd row counting from the bottom (last, third-last, fifth-last, etc.) and number of inversions is even.
	#For all other cases, the puzzle instance is not solvable.
	#Proof of this at https://www.geeksforgeeks.org/check-instance-15-puzzle-solvable/
	#Putting tiles are in a 1-D array, an inversion =  a pair of consecutive tiles are not correctly ordered
	#For example, 2 1 5 3 4 would have two inversions: 2 1, and 5 3
	#To make things simple, assume that the empty space is bottom-right. Then, the number of inversions should be even.
	
	#Generates array 1 to N^2-1
	var temp_board = []
	for i in range(1,board_size*board_size):
		temp_board.append(i)

	#Shuffles elements until solvable
	temp_board.shuffle()
	while(!check_solvable(temp_board)):
		temp_board.shuffle()
	
	
	temp_board.append(0)
	
	print(temp_board)
	
	# convert flat 1d board to 2d board
	for r in range(board_size):
		for c in range(board_size):
			board[r][c] = temp_board[r*board_size + c]
			if board[r][c] != 0:
				set_tile_position(r, c, board[r][c])
	empty = value_to_coords(0)

func reset_board():
	reset_move_count()
	board = []
	for r in range(board_size):
		board.append(([]))
		for c in range(board_size):
			board[r].append(r*board_size + c + 1)
			if r*board_size + c + 1 == board_size * board_size:
				board[r][c] = 0
			else:
				set_tile_position(r, c, board[r][c])
	empty = value_to_coords(0)

func set_tile_position(r: int, c: int, val: int):
	var object: TextureButton = get_tile_by_coords(val)
	object.set_position(Vector2(c, r) * tile_size)

func _process(_delta):
	var is_pressed = true
	var dir = Vector2.ZERO
	if (Input.is_action_just_pressed("move_left")):
		dir.x = -1
	elif (Input.is_action_just_pressed("move_right")):
		dir.x = 1
	elif (Input.is_action_just_pressed("move_up")):
		dir.y = -1
	elif (Input.is_action_just_pressed("move_down")):
		dir.y = 1
	else:
		is_pressed = false
	if is_pressed:
		empty = value_to_coords(0)

		var nr = empty.y + dir.y
		var nc = empty.x + dir.x
		if (nr == -1 or nc == -1 or nr >= board_size or nc >= board_size):
			return
		var tile_pressed = board[nr][nc]
		print("pressed:" + str(tile_pressed))
		_on_Tile_pressed(tile_pressed)

func reset_move_count():
	move_count = 0
	emit_signal("moves_updated", move_count)

func set_tile_numbers(state):
	number_visible = state
	for tile in tiles:
		tile.set_number_visible(state)

func update_board_size(new_board_size):
	board_size = int(new_board_size)
	print('updating board size ', board_size)

	tile_size = floor(get_size().x / board_size)
	for tile in tiles:
		tile.queue_free()
	tiles = []
	gen_board()
	game_state = GAME_STATES.NOT_STARTED
	reset_move_count()

func update_background_texture(texture):
	background_texture = texture
	for tile in tiles:
		tile.set_sprite_texture(texture)
		tile.update_board_size(board_size, tile_size)


func _on_timer_timeout():
	slide_sound.stop()
