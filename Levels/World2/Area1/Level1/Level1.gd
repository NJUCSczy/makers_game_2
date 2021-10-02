extends Node2D

var Ready=false
var WorldID=2
var AreaID=1
var LevelID=1

func _ready():
    Global.change_camera_zoom(1.2)
    $Wind.init($Ball,15)
    Ready=true


