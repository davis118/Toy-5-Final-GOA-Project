extends Control

#var level1 = preload("res://scene/level1.tscn")
var levels = [preload("res://scene/Board/board.tscn"), preload("res://scene/pentomino_board.tscn")]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	$mainmenu.visible=false
	$levelmenu.visible=true


func _on_credits_pressed():
	$mainmenu.visible=false
	$credits.visible=true


func _on_mainmenu_pressed():
	$mainmenu.visible=true
	$credits.visible=false


func start_level(i):
	var newlevel = levels[i].instantiate()
	get_tree().get_root().add_child(newlevel)
	$levelmenu.visible=false
	pass # Replace with function body.