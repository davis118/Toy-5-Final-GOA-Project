extends Control

#var level1 = preload("res://scene/level1.tscn")
var levels = [preload("res://scene/Board/board.tscn"), preload("res://scene/pentomino_board.tscn")]

@onready var button_sound = $ButtonSound

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_pressed():
	$mainmenu.visible=false
	$levelmenu.visible=true
	button_sound.play()

func _on_credits_pressed():
	$mainmenu.visible=false
	$credits.visible=true
	button_sound.play()

func _on_mainmenu_pressed():
	$mainmenu.visible=true
	$credits.visible=false
	button_sound.play()

func start_level(i):
	button_sound.play()
	var newlevel = levels[i].instantiate()
	newlevel.level_won.connect(_on_play_pressed)
	get_tree().get_root().add_child(newlevel)
	$levelmenu.visible=false
	pass # Replace with function body.
