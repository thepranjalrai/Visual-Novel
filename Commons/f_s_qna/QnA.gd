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

func popup(q, a_t, d_t, q_no):
	$RichTextLabel.bbcode_text = "[center]" + q + "[/center]"
	$button_agree.text = a_t
	$button_disagree.text = d_t
	question_number = q_no
	
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
		var key = str(question_number)
		var value = ans
		
		data[key] = value
	else:
		print("Error: File not open")
	
	data_file.store_line(to_json(data))
	print("Data written : ", to_json(data))
	
	data_file.close()
	self.queue_free()
	pass
