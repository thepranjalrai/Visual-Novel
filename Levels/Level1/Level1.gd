extends Control

var runtime_data = {
	"Finished Shop 1" : false,
	"Finished Shop 2" : false
}

var questions: Dictionary = {
	"1" : "Do you want to talk to your friend Ron?",
	"default" : "(Choose your response.)"
}

var responses: Dictionary = {
	"1" : ["Yes, No"],
	"2" : ["Very Good, I visited India with my parents, played various games with friends, read some books, went on hiking trip, How was your summer?", "Actually, very good. How was your summer?"],
	"3" : ["Oh, okay.", "Oh, What happened?"],
	"4" : ["Yeah", "I am excited, but nervous also. Last year wasn’t very great one for me. I hope this year will be different and more fun. I am ready mentally, but there are still stuff that I need to buy before getting all set for the school."],
	"5" : ["Oh, poor Ron.", "Oh, Ron. I feel sorry for you. Maybe next time we can spend our summer together, that way it would be fun for both of us."]
}


func _ready():
	#Make a level data file
	var runtime_datafile = File.new()
	runtime_datafile.open("user://Level1/runtime_data.json", File.WRITE)
	
	if(!runtime_datafile.is_open()):
		print("ERROR! Cant access runtime data!")
		return
	
	$diagon_alley_branch/shop_button_1.connect("pressed", self, "focus_node", [$shop_1_branch])
	$diagon_alley_branch/shop_button_2.connect("pressed", self, "focus_node", [$shop_2_branch])
	pass # Replace with function body.
	
func focus_node(var _node):
	print("Focusing on : ", _node.get_path())
	
	var dbox: Control
	for node in get_children():
		if(node == _node):
			dbox = node.get_node("DialogBox")
			funcref(dbox, "initialize").call_func(4,7)
			node.visible = true
		else:
			node.visible = false
	
	dbox.connect("dialog_over", self, "popup_qn", [1])
	pass
	
func popup_qn(var qn: int):
	print("Poppping up the first")
	var qna_popup = UtilityFuncs.QnA.instance()
	add_child(qna_popup)
	qna_popup.popup(questions["default"], responses["2"][0], responses["2"][1])
	pass
