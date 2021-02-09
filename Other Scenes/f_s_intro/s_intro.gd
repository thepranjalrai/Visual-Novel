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
	print("Changing scene..")
	pass
