extends Node2D

var Ready=false
var WorldID=1
var AreaID=4
var LevelID=1

func _ready():
    Global.change_camera_zoom(1.2)
    $Obstacles.init(0,0,0)
    $ArrowSingleDirection1.init($Ball,Vector2(1,0),15,2000)
    $Arrow_Back.init($Ball)
    Ready=true
    



