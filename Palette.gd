extends Node2D

class_name Palette

const black = Color("000000")
const blue = Color("0c0c72")
const cyan = Color("0c7272")
const green = Color("0c720c")
const red = Color("720c0c")
const white = Color("727272")
const yellow = Color("72720c")
const magenta = Color("720c72")

const bright_black = Color("0c0c0c")
const bright_blue = Color("0000ff")
const bright_cyan = Color("00ffff")
const bright_green = Color("00ff00")
const bright_red = Color("ff0000")
const bright_white = Color("ffffff")
const bright_yellow = Color("ffff00")
const bright_magenta = Color("ff00ff")


# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.editor_hint == false:
		queue_free()

