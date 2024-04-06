extends Node2D

var coords

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_texture(texture: Texture2D):
	$Sprite2D.texture = texture
	
func set_size(new_size):
	var ratio = (Vector2(new_size, new_size) / $Sprite2D.texture.get_size())
	$Sprite2D.set_scale(ratio)
	$CollisionShape2D.set_scale(ratio)