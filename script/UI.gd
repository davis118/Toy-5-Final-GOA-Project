extends Control

#var level1 = preload("res://scene/level1.tscn")
var levels = [preload("res://scene/Board/board.tscn"), preload("res://scene/pentomino_board.tscn")]
var l0 = false
var level0done = preload("res://resources/button2done.png")
var level1done = preload("res://resources/button1done.png")
var l1 = false

@onready var button_sound = $ButtonSound
@onready var win_sound = $WinSound

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

func _on_level_won(i):
	if i==1:
		$"levelmenu/level1(pentomino)".texture_normal = level1done
		l1=true
	if i==0:
		$"levelmenu/level0(slide)".texture_normal = level0done
		l0=true
	_on_play_pressed()
	if l1&&l0:
		$"levelmenu/key".visible=true
	win_sound.play()

func _on_mainmenu_pressed():
	$mainmenu.visible=true
	$credits.visible=false
	button_sound.play()

func start_level(i):
	button_sound.play()
	var newlevel = levels[i].instantiate()
	newlevel.level_won.connect(_on_level_won)
	get_tree().get_root().add_child(newlevel)
	$levelmenu.visible=false
	pass # Replace with function body.


func _on_startbutton_pressed():
	$mainmenu.visible=false
	$credits.visible=false
	$levelmenu.visible=true
	button_sound.play()
	pass # Replace with function body.


func _on_creditsbutton_pressed():
	$mainmenu.visible=false
	$credits.visible=true
	$levelmenu.visible=false
	pass # Replace with function body.


func _on_key_pressed():
	$levelmenu.visible=false
	$winmenu.visible=true
	pass # Replace with function body.
