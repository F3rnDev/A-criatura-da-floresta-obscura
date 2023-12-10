extends Node

var dialog_number = 1

var dialog_finished = true

var end = false

func get_dialog_number():
	return(dialog_number)

func set_num(new_num):
	dialog_number = new_num

func set_dialog_status(status):
	dialog_finished = status

func get_dialog_status():
	return dialog_finished

func set_end():
	end = true

func get_end():
	return end
