extends Control

var runtime_data = {
	"Finished Shop 1" : false,
	"Finished Shop 2" : false
}
var player_details: Dictionary
var questions: Dictionary
var responses: Dictionary

var thread: Thread
var sem: int

func _ready():
	sem = 0
	#Make a level data file
	var runtime_datafile = File.new()
	runtime_datafile.open("user://Level1/runtime_data.json", File.WRITE)
	
	if(!runtime_datafile.is_open()):
		print("ERROR! Cant access runtime data!")
		return
	
	$diagon_alley_branch/shop_button_1.connect("pressed", self, "focus_node", [$shop_1_branch])
	$diagon_alley_branch/shop_button_2.connect("pressed", self, "focus_node", [$shop_2_branch])
	
	player_details = UtilityFuncs.read_player_info()
	questions = {
		1 : "Do you want to talk to your friend Ron?",
		2 : "Ron: Hello, " + player_details["name"] + ". How was your summer break?",
		3 : "Ron: Great " + player_details["name"] + ". My summer was not that good. I enjoyed the first month very much. But then, afterwards I got very bored.",
		4 : "Ron: Are you excited and ready for the school?",
		5 : "Ron: Earlier my sibling were there with me so first month was really fun. But, as soon as they left, I was alone and had nothing to do but to help mom with all house work",
		"default" : "(Choose your response.)"
	}
	responses = {
		1 : ["Yes", "No"],
		2 : ["Very Good, I visited India with my parents, played various games with friends, read some books, went on hiking trip, How was your summer?", "Actually, very good. How was your summer?"],
		3 : ["Oh, okay.", "Oh, What happened?"],
		4 : ["Yeah", "I am excited, but nervous also. Last year wasn’t very great one for me. I hope this year will be different and more fun. I am ready mentally, but there are still stuff that I need to buy before getting all set for the school."],
		5 : ["Oh, poor Ron.", "Oh, Ron. I feel sorry for you. Maybe next time we can spend our summer together, that way it would be fun for both of us."]
	}
	pass
	
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
	
	dbox.connect("dialog_over", self, "qna_manager")
	pass
	
func qna_manager():
	thread = Thread.new()
	thread.start(self, "popup_qn", 1)
	OS.delay_msec(500)
	thread = Thread.new()
	thread.start(self, "popup_qn", 2)
	pass
	
func popup_qn(var qn: int):
	while(sem > 0):
		OS.delay_msec(100)
		print("Qn", qn, "is waiting.")
	sem += 1
	print("Sem = ", sem)
	
	print("Poppping up the first")
	var qna_popup = UtilityFuncs.QnA.instance()
	add_child(qna_popup)
	qna_popup.popup(qn, questions[qn], responses[qn][0], responses[qn][1])
	qna_popup.connect("qna_over", self, "reduce_dialogbox_sem")
	pass
	
func reduce_dialogbox_sem():
	sem -= 1
	print("Sem = ", sem)
	pass
