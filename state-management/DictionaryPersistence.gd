
class_name DictionaryPersistence

# ----------------
# Persistance code
# todo: seperate class please
# ----------------

var save_file_path = ""

func _init(file_path):
	save_file_path = file_path
	

#
# Tests if a save file exists for the game
#
func save_file_exists():
	return FileAccess.file_exists(save_file_path)

#
# Saves the current game state to disk
#
func save(data):
	var file: FileAccess = FileAccess.open(save_file_path, FileAccess.WRITE)
	if file != null:
		file.store_var(data)
		file.close()
	else:
		print("File open for save failed, error code: ", FileAccess.get_open_error())

#
# Loads the game state from disk and sets it as the current state.
#
func load():
	if save_file_exists():
		var file = FileAccess.open(save_file_path, FileAccess.READ)
		if file != null:
			var data = file.get_var()
			print("Load data: ", data)
			file.close()
			return data
		else:
			print("File open for read state failed, error code: ", FileAccess.get_open_error())
	return null
