extends Node2D

var Ready=false
var WorldID=2
var AreaID=1
var LevelID=2

func _ready():
    Global.change_camera_zoom(1.2)
    $Wind1.init($Ball,15)
    $Wind2.init($Ball,15)
    $Arrow1.init($Ball,15,2000)
    Ready=true


