extends Node2D

var Ready=false

func _ready():
    Ready=true

func _on_QuitGameButton_pressed():
    get_tree().call_deferred("quit")


func _on_CreditButton_pressed():
    pass # Replace with function body.


func _on_StartGameButton_pressed():
    Global.goto_world_choose()
