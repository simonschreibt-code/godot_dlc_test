extends Node

func get_all_files(paths_array : Array[String], path : String, ext : String = "", excludes : Array[String] = []) -> void:
	var dir : DirAccess = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name : String = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				#print("file manager: found dir...." + file_name)
				get_all_files(paths_array, dir.get_current_dir() + "/" + file_name, ext, excludes)
			else:
				if ext == "" or ext == file_name.get_extension():

					var skip_file : bool = false
					for exlude in excludes:
						if file_name.find(exlude) > -1:
							skip_file = true

					if not skip_file:
						var complete_path : String = dir.get_current_dir() + "/" + file_name
						paths_array.append(complete_path)
						#print("file manager: found file..." + complete_path)

			file_name = dir.get_next()
	else:
		print("file manager: An error occurred when trying to access the path: %s" % path)
