extends Node2D

var Ready=false
var WorldID=1
var AreaID=3
var LevelID=1

func _ready():
    $Obstacles.init(0,0,0)
    $ArrowSingleDirection1.init($Ball,Vector2(1,0),15,2000)
    Ready=true
    



