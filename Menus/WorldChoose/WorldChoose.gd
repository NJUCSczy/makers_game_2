extends Node2D

var Ready=false

func _ready():
    for world in $Worlds.get_children():
        var worldID=world.name.substr(5).to_int()
        world.get_node("BounceNumber").text="Bounce:"+String(GameStatus.getBounceNumber(worldID))+"/"+String(GameStatus.WorldMaxBounce[worldID-1])
    Ready=true

func _on_BackButton_pressed():
    Global.return_main_menu()
    
func _on_World1Button_pressed():
    Global.goto_world_scene(1)
    
func _on_World2Button_pressed():
    if GameStatus.getLevelStatus(2):
        Global.goto_world_scene(2)
