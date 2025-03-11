extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

func new_game():
	$Player.set_position(Vector2(300, 300)) 
	#$Player.start($Position2D.position )
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
