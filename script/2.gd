extends Button

@onready var ui = get_tree().get_first_node_in_group("ui")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	ui.start_level(1)
	pass # Replace with function body.
