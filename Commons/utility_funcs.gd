extends Node

var QnA = preload("res://Commons/f_s_qna/QnA.tscn")

static func traverse_dir(path: String, recursive := false):
	var paths = []
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
				paths.append(path + file_name)
				if(recursive):
					if (file_name != "." and file_name != ".."):
						traverse_dir(path + file_name + "/")
			else:
				print("Found file: " + file_name)
				paths.append(path + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
		
	return paths
	pass

func read_dialogs(filepath: String):
	var dialog_file = File.new()
	dialog_file.open(filepath, File.READ)
	
	var content = []
	if dialog_file:
		while(!dialog_file.eof_reached()):
			content.append(dialog_file.get_line())
	else:
		print("Dialogs file not found..")
		
	#print(content)
	return content
	pass
