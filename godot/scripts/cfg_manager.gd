extends Node


# Source: https://www.reddit.com/r/godot/comments/hf5yko/comment/fvymsv1/
func update_export_preset() -> void:
	var export_config : ConfigFile = ConfigFile.new()
	var error : Error = export_config.load("res://export_presets.cfg")
	if error == OK:
		for preset in export_config.get_sections():
			for dlc_export_name : String in DlcManager.dlc_directories:
				var dlc_files : Array[String] = []
				FileManager.get_all_files(dlc_files, DlcManager.dlc_directories[dlc_export_name], "", [".import"])

				if dlc_export_name in str(export_config.get_value(preset, "name", "")):
					print("cfg manager: set files for %s: %s" % [dlc_export_name, dlc_files])
					export_config.set_value(preset, "export_files", dlc_files)
					export_config.save("res://export_presets.cfg")
