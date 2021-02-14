extends Control

export var question: String  = "//No Qn//"
export var agree_text: String = "??"
export var disagree_text: String = "??"
export var question_number: int = 0

var data = {}

func _ready():
	self.visible = false
	$RichTextLabel.bbcode_text = "[center]" + question + "[/center]"
	$button_agree.text = agree_text
	$button_disagree.text = disagree_text
	
	print($button_agree.connect("pressed", self, "save_ans", ["agree"]))
	print($button_disagree.connect("pressed", self, "save_ans", ["disagree"]))
	pass # Replace with function body.

func popup(q, a_t, d_t):
	question = q
	$RichTextLabel.bbcode_text = "[center]" + question + "[/center]"
	
	var agree_button = $button_agree #.text = a_t
	var disagree_button = $button_disagree #.text = d_t
	
	# HAS TO BE FIXED
	agree_button.text = a_t
	agree_button.get("custom_fonts/font").set_size(100 - (a_t.length()/30)*10)
	print("1st button font size : ", 100 - a_t.length()/2)
	
	disagree_button.text = d_t
	disagree_button.get("custom_fonts/font").set_size(100 - (d_t.length()/30)*10)
	print("2st button font size : ", 100 - a_t.length()/2)
	
	self.visible = true	
	pass

func save_ans(ans: String):
	var data_file = File.new()
	
	if data_file.file_exists("user://QnA_data.json"):
		data_file.open("user://QnA_data.json", File.READ)
		var file_data = parse_json(data_file.get_line())
		if(file_data): data = file_data
		print("Data read : ", data)
		data_file.close()
	
	data_file.open("user://QnA_data.json", File.WRITE)
	
	if(data_file.is_open()):
		#data["lol"] = "hihhi"
		var key = str(question)
		var value = ans
		
		data[key] = value
	else:
		print("Error: File not open")
	
	data_file.store_line(to_json(data))
	print("Data written : ", to_json(data))
	
	data_file.close()
	self.queue_free()
	pass
