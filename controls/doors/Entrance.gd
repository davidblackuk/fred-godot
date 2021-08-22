tool
extends Node2D


export(Color, RGB) var door_tint = Color.white 

onready var roller = $Roller
onready var door_top = $"Door Top"
onready var door_bottom = $"Door Bottom"



func _ready():
	roller.modulate = door_tint
	door_top.modulate = door_tint
	door_bottom.modulate = door_tint
