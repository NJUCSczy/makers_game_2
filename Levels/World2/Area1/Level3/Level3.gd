extends Node2D

var Ready=false
var WorldID=2
var AreaID=1
var LevelID=3

func _ready():
    Global.GameCamera.zoom=Vector2(1,1)*1.2
    Global.get_node("LevelClearWindow").scale=Vector2(1,1)*1.2
    $Wind1.init($Ball,15)
    $Wind2.init($Ball,15)
    $Wind3.init($Ball,15)
    $Wind4.init($Ball,15)
    $Arrow1.init($Ball,-15,2000)
    Ready=true


