extends StaticBody2D
signal trigger_dialog
onready var label = $Label
onready var sprite = $Sprite
onready var collision = $CollisionShape2D
onready var detect_near_by = $Area2D/DetectNearBy

export var stage:int =1
export var itemID: int = 0
export var itemPosition: Vector2 = Vector2.ZERO
export var isInteract: bool = false
export var itemScale: Vector2 = Vector2(1, 1)
export var detect_radius: float = 25  # Default detection radius
var player_nearby = false
var itemData = {} 



func _ready():
	add_to_group("items")
	print("add to group")
	load_item_from_file(itemID, stage)
	set_item_on_map()
	set_detec_circle()

	
func _process(delta):
	if player_nearby and Input.is_action_just_pressed("interact"):  
		emit_signal("trigger_dialog", itemData["itemDescription"] )


func load_item_from_file(item_id,stage):
	var file_path = "res://The_Alchemist_Quest/scripts/item-script/item.json"  # Update this path correctly
	var file = File.new()
	if file.file_exists(file_path):  # Check if the file exists
		if file.open(file_path, File.READ) == OK:  # Open the file for reading
			var json_string = file.get_as_text()
			file.close()  # Always close the file after reading

			var json = JSON.parse(json_string)
			if json.error == OK:
				var json_data = json.result
				var stage_key = "stage" + str(stage)
				if json_data.has(stage_key):
					for item in json_data[stage_key]:
						if int(item["itemID"]) == item_id:
							itemData = item  # Store loaded item data
							print("Loaded Item:", itemData)
							# Apply item properties
							if label:
								label.text = item["itemName"]
							# Load texture if "path" exists
							if item.has("path"):
								var texture = load(item["path"])
								if texture and has_node("Sprite"):
									sprite.texture = texture
									set_item_collision(texture)
							break
				else:
					print("Error: Invalid JSON structure.")
			else:
				print("Error: JSON parsing failed.")
		else:
			print("Error: Failed to open file.")
	else:
		print("Error: File does not exist:", file_path)
func set_item_on_map():
	position = itemPosition  
	scale = itemScale
func set_item_collision(texture):
	if collision and collision.shape is RectangleShape2D:
		var texture_size = texture.get_size() * scale
		collision.shape.extents = texture_size / 2 
		
		var label_position = collision.shape.extents.y
		label.rect_position.y = -label_position -15
func set_detec_circle():
	if detect_near_by and detect_near_by.shape is CircleShape2D:
		detect_near_by.shape.radius = detect_radius  # Set the radius
		print("DetectNearBy Radius Set To:", detect_radius)
		


func _on_Area2D_body_entered(body):
	if isInteract and body.is_in_group("player"):
		player_nearby = true
		label.visible = true  # Show the label	


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		player_nearby = false
		label.visible = false  
