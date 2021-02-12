extends Control

var runtime_data = {
	"Finished Shop 1" : false,
	"Finished Shop 2" : false
}

func _ready():
	#Make a level data file
	var runtime_datafile = File.new()
	runtime_datafile.open("user://Level1/runtime_data.json", File.WRITE)
	
	if(!runtime_datafile.is_open()):
		print("ERROR! Cant access runtime data!")
		return
	
	$diagon_alley_branch/shop_button_1.connect("pressed", self, "enter_shop_1")
	$diagon_alley_branch/shop_button_2.connect("pressed", self, "enter_shop_2")
	pass # Replace with function body.
	
func enter_shop_1():
	for node in get_children():
		if(node.name == "shop_1_branch"):
			node.visible = true
		else:
			node.visible = false
	pass

func enter_shop_2():
	for node in get_children():
		if(node.name == "shop_2_branch"):
			node.visible = true
		else:
			node.visible = false
	pass
