extends Node2D

var WorldID:int
var Ready=false

func _ready():
    WorldID=name.substr(5).to_int()
    Ready=true

func _on_BackButton_pressed():
    Global.goto_world_choose()
