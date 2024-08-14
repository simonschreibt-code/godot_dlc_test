extends Sprite2D

# Works in Editor, Fails in Build
#@onready var my_texture : CompressedTexture2D = preload("res://dlcs/kitty/background/kitty.png") 

# Works in Editor and Build
# Use get() to receive NULL when key does not exist. Direct access via dictionary[key] will stop the game 
@onready var my_dlc_texture_01 : CompressedTexture2D = DlcManager.dlc_content_DB.get("res://dlcs/sheepy/background/sheepy1.png") 

func _ready() -> void:
	# Update DLC file list for Export Presets
	if OS.has_feature("editor"):
		CfgManager.update_export_preset()

	# From all DLC Backgrounds, give me the last one
	var my_dlc_texture_02 : CompressedTexture2D
	my_dlc_texture_02 = DlcManager.get_background("res://dlcs/corgi/background/corgi.png")
	my_dlc_texture_02 = DlcManager.get_background_last()
	
	print("try to assign texture")
	texture = my_dlc_texture_02

	# Test for instancing a DLC scene
	var new_packed_scene : PackedScene = DlcManager.get_scene("res://dlcs/corgi/scenes/corgi.tscn")
	if new_packed_scene != null:
		var new_scene : Node2D = new_packed_scene.instantiate()
		add_child(new_scene)
