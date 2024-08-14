extends Node

# Used by CfgManager. It links Export Presets with the DLC folders
var dlc_directories : Dictionary = {
	"dlc_default" = "res://dlcs/default",
	"dlc_corgi" = "res://dlcs/corgi",
	"dlc_kitty" = "res://dlcs/kitty",
	"dlc_sheepy" = "res://dlcs/sheepy"
}

var dlc_main_directory : String = "dlcs"

# ProjectSettings.globalize_path because you can't use just res:// because 
# it points to the project root but the dlcs-folder is one level higher!
var project_directory : String = ProjectSettings.globalize_path("res://")
var dlcs_paths : Array[String] = []
var dlcs_content_paths : Array[String] = []
var dlc_content_DB : Dictionary
var dlc_content_DB_backgrounds : Dictionary
var dlc_content_DB_scenes : Dictionary

func _init() -> void:
	# Find all PCK/ZIP
	print("dlc manager: project directory: %s" % project_directory)
	FileManager.get_all_files(dlcs_paths, project_directory + dlc_main_directory)

	# Load all PCK/ZIP into the project
	for path in dlcs_paths:
		load_dlc_from_pck_or_zip(path)

	# Load resources into Dictionaries to access them later
	load_dlc_content_into_DB()


func load_dlc_from_pck_or_zip(path : String) -> void:
	var result : bool = ProjectSettings.load_resource_pack(path)
	print("dlc manager: %s loaded: %s" % [path, result])


func load_dlc_content_into_DB() -> void:
	# Find all DLC Files which have been added to the Project
	FileManager.get_all_files(dlcs_content_paths, "res://" + dlc_main_directory)

	# Load all DLC files as resources and store them into a Dictionary as Database
	for path in dlcs_content_paths:
		var new_path : String = path.replace(".remap", "").replace(".import", "")
		dlc_content_DB[new_path] = load(new_path)
		print("dlc manager: content added to DB: %s" % new_path)

		if new_path.find("/background/") > -1:
			dlc_content_DB_backgrounds[new_path] = load(new_path)
			print("dlc manager: content added to Background DB: %s" % new_path)

		if new_path.find("/scenes/") > -1:
			dlc_content_DB_scenes[new_path] = load(new_path)
			print("dlc manager: content added to Scenes DB: %s" % new_path)


func get_scene(path : String) -> PackedScene:
	return dlc_content_DB_scenes.get(path)


func get_background(path : String) -> CompressedTexture2D:
	return dlc_content_DB_backgrounds.get(path)


func get_background_last() -> CompressedTexture2D:
	if dlc_content_DB_backgrounds.size() > 0:
		var last_dlc_id : int = DlcManager.dlc_content_DB_backgrounds.size()-1
		var last_dlc_path : String = DlcManager.dlc_content_DB_backgrounds.keys()[last_dlc_id]
		return dlc_content_DB_backgrounds.get(last_dlc_path)

	return null



