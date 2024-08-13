extends Sprite2D

# Don't load the resource here! It's done BEFORE the Autoload-DlcManager gets active!
#@onready var my_texture : CompressedTexture2D = preload("res://dlcs/kitty/kitty.jpg")


func _ready() -> void:
	print("try to assign texture")

	texture = DlcManager.dlc_content["res://dlcs/sheepy/sheepy.png"]

	var new_scene : Node2D = DlcManager.dlc_content["res://dlcs/corgi/corgi.tscn"].instantiate()
	add_child(new_scene)
