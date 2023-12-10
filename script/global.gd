extends Node

var dialog_number = 1

var dialog_finished = true

var lara_pos = 0

var end = false

#Index do dialogoo
func get_dialog_number():
	return(dialog_number)

func set_num(new_num):
	dialog_number = new_num

#Indicador do término do dialogo
func get_dialog_status():
	return dialog_finished
	
func set_dialog_status(status):
	dialog_finished = status

#Indicador do fim da demo
func get_end():
	return end
	
func set_end():
	end = true

#Posição da Lara
func get_lara_pos():
	return lara_pos
	
func set_lara_pos(pos):
	lara_pos = pos
