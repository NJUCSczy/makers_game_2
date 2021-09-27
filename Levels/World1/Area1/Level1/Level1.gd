extends Node2D

var Ready=false
var WorldID=1
var AreaID=1
var LevelID=1

func _ready():
    $Obstacles.init(0,0,0)
    $Arrow1and2.init($Ball,15,2000)
    Ready=true


