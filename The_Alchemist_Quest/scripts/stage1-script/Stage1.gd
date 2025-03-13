extends Node

onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	stage1_newgame()
	for item in get_tree().get_nodes_in_group("items"):  
		item.connect("trigger_dialog", self, "_on_trigger_dialog") 
		
func _on_trigger_dialog(dialog):
	print("dsss",dialog)
			

func stage1_newgame():
	player.set_position(Vector2(300, 300)) 

