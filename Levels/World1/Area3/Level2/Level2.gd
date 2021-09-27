extends Node2D

var Ready=false
var WorldID=1
var AreaID=3
var LevelID=2

func _ready():
    Global.GameCamera.zoom=Vector2(1,1)*1.2
    Global.get_node("LevelClearWindow").scale=Vector2(1,1)*1.2
    $Obstacles.init(0,0,0)
    $ArrowSingleDirection1.init($Ball,Vector2(1,0),15,2000)
    $ArrowSingleDirection2.init($Ball,Vector2(0,1),15,2000)
    $ArrowSingleDirection3.init($Ball,Vector2(-1,0),15,2000)
    $ArrowSingleDirection4.init($Ball,Vector2(0,-1),15,2000)
    Ready=true
    



