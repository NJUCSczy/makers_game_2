extends Node2D

var Ready=false
var WorldID=1
var AreaID=1
var LevelID=2

func _ready():
    Global.change_camera_zoom(1.2)
    $Obstacles.init(0,0,0)
    $Arrow1.init($Ball,15,2000)
#    $PluseCore.init($Ball,-5,100,0.5,3)
#    $ElectricFieldBlaster.init($Ball,-1,100,1,3)
    Ready=true


