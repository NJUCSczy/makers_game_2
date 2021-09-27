extends Node2D

var WorldID:int
var AreaID:int
var LevelID:int

func _ready():
    WorldID=get_parent().get_parent().get_parent().name.replace("World","").to_int()
    AreaID=get_parent().name.replace("Area","").to_int()
    LevelID=name.replace("Area","").to_int()
    if !GameStatus.getLevelStatus(WorldID,AreaID,LevelID):
        hide()

func _on_StartButton_pressed():
    Global.goto_level(WorldID,AreaID,LevelID)
