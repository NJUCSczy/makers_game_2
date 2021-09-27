extends Node2D

var Ready=false
var WorldID=1
var AreaID=2
var LevelID=5

func _ready():
    Global.GameCamera.zoom=Vector2(1,1)*1.2
    Global.get_node("LevelClearWindow").scale=Vector2(1,1)*1.2
    $Obstacles.init(0,0,0)
    $Arrow1.init($Ball,-15,2000)
    $Arrow2.init($Ball,-15,2000)
    $Arrow3.init($Ball,-15,2000)
    Ready=true
    


