
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
	var file = File.new()
	return file.file_exists(save_file_path)

#
# Saves the current game state to disk
#
func save(data):
	var file = File.new()
	var error = file.open(save_file_path, File.WRITE)
	if error == OK:
		file.store_var(data)
		file.close()
	else:
		print("File open for save failed, error code: ", error)

#
# Loads the game state from disk and sets it as the current state.
#
func load():
	if save_file_exists():
		var file = File.new()
		var error = file.open(save_file_path, File.READ)
		if error == OK:
			var data = file.get_var()
			print("Load data: ", data)
			file.close()
			return data
		else:
			print("File open for read state failed, error code: ", error)
	return null
