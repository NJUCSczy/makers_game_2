extends Node2D

var Ready=false
var WorldID=1
var AreaID=2
var LevelID=4

func _ready():
    Global.change_camera_zoom(1.2)
    $Obstacles.init(0,0,0)
    $Arrow1.init($Ball,15,2000)
    $Arrow2.init($Ball,15,2000)

    Ready=true



