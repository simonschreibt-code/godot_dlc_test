extends Node

var dlc_directory : String = "dlcs"
# you can't use res:// because it points to the project root 
# but the dlcs-folder is one level higher!
var project_directory : String = ProjectSettings.globalize_path("res://")
var dlcs_paths : Array[String] = []
var dlcs_content_paths : Array[String] = []
var dlc_content : Dictionary

func _ready() -> void:
	# Find all PCK/ZIP
	print("dlc manager: project directory: %s" % project_directory)
	get_all_files(dlcs_paths, project_directory + dlc_directory)

	# Load all PCK/ZIP into the project
	for path in dlcs_paths:
		load_dlc(path)

	# Store all content which was included in the DLCs in a list
	get_all_files(dlcs_content_paths, "res://" + dlc_directory)
	
	for path in dlcs_content_paths:
		var new_path : String = path.replace(".remap", "").replace(".import", "")
		dlc_content[new_path] = load(new_path)
		print("dlc manager: content added to DB: %s" % new_path)


func load_dlc(path : String) -> void:
	var result : bool = ProjectSettings.load_resource_pack(path)
	print("dlc manager: %s loaded: %s" % [path, result])


func get_all_files(paths_array : Array[String], path : String, ext : String = "") -> void:
	var dir : DirAccess = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name : String = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("dlc manager: found dir...." + file_name)
				get_all_files(paths_array, dir.get_current_dir() + "/" + file_name, ext)
			else:
				if ext == "" or ext == file_name.get_extension():
					var complete_path : String = dir.get_current_dir() + "/" + file_name
					paths_array.append(complete_path)
					print("dlc manager: found file..." + complete_path)

			file_name = dir.get_next()
	else:
		print("dlc manager: An error occurred when trying to access the path: %s" % path)
