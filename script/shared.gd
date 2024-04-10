extends Node

var cells = [
	#topleft is 0,0
	#1
	[Vector2(0,0), Vector2(0,1), Vector2(0,2), Vector2(1,1), Vector2(2,1)],
	#2
	[Vector2(0,0), Vector2(1,0), Vector2(2,0), Vector2(2,1), Vector2(3,1)],
	#3
	[Vector2(0,1), Vector2(1,0), Vector2(1,1), Vector2(1,2), Vector2(2,2)],
	#4
	[Vector2(0,0), Vector2(1,0), Vector2(1,1), Vector2(1,2), Vector2(2,2)],
	#5
	[Vector2(0,0), Vector2(1,0), Vector2(2,0), Vector2(2,1), Vector2(2,2)],
	#6
	[Vector2(0,1), Vector2(1,0), Vector2(1,1), Vector2(2,1), Vector2(1,2)],
	#7
	[Vector2(1,0), Vector2(2,0), Vector2(0,1), Vector2(1,1), Vector2(2,1)],
	#8
	[Vector2(0,0), Vector2(1,0), Vector2(2,0), Vector2(3,0), Vector2(4,0)],
	#9
	[Vector2(0,0), Vector2(1,0), Vector2(2,0), Vector2(3,0), Vector2(0,1)],
	#10
	[Vector2(1,0), Vector2(1,1), Vector2(1,2), Vector2(1,3), Vector2(0,2)],
	#11
	[Vector2(0,0), Vector2(1,0), Vector2(1,1), Vector2(2,1), Vector2(2,2)],
	#12
	[Vector2(0,0), Vector2(0,1), Vector2(1,1), Vector2(2,1), Vector2(2,0)],
]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
