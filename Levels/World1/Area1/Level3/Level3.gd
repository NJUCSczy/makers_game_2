extends Node2D

var Ready=false
var WorldID=1
var AreaID=1
var LevelID=3

func _ready():
    $Obstacles.init(0,0,0)
    $Arrow1.init($Ball,15,2000)
    $Arrow2.init($Ball,15,2000)
    Ready=true

