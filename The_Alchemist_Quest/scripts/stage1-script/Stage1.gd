extends Node

onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	stage1_newgame()

func stage1_newgame():
	player.set_position(Vector2(300, 300)) 

