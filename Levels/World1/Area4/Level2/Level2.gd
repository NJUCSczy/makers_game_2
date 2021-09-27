extends Node2D

var Ready=false
var WorldID=1
var AreaID=4
var LevelID=2


func _ready():
    $Obstacles.init(0,0,0)
    $Arrow1.init($Ball,15,2000)
    $Arrow2.init($Ball,15,2000)
    $Arrow3.init($Ball,15,2000)
    $Arrow4.init($Ball,15,2000)
    $Arrow_Back.init($Ball)
    Ready=true
    
    
