extends Control

func _ready():
	$skip_intro_button.connect("pressed", self, "_skip_intro")
	$clear_progress_button.connect("pressed", self, "_clear_progress")
	
	pass # Replace with function body.

func _clear_progress():
	var paths = UtilityFuncs.traverse_dir("user://")
	print(paths)
	
	var deleter = Directory.new()
	for path in paths:
		if (path[-1] != "."):
			print("Deleting ", path)
			deleter.remove(path)
	pass

func _skip_intro():
	start_game()
	pass
	
func start_game() -> bool:
	#Check if user://player_info.json is correct
	var file = File.new()
	file.open("user://player_info.json", File.READ)
	
	if(file.is_open()):
		var player_info = parse_json(file.get_line())
		if(player_info['name'] == "null" or player_info['age'] == "-1"):
			file.close()
			return false		
		file.close()
		print("Changing scene..")
		return true
	else:
		file.close()
		return false
	pass
