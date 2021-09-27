extends Node2D

var Ready=false
var WorldID=1
var AreaID=4
var LevelID=4

func _ready():
    $Obstacles.init(0,0,0)
    $ArrowSingleDirection1.init($Ball,Vector2(0,1),15,2000)
    $Arrow_Back1.init($Ball)
    $Arrow_Back2.init($Ball)
    $Arrow_Back3.init($Ball)
    $Arrow_Back4.init($Ball)
#    $PluseCore.init($Ball,-5,100,0.5,3)
#    $ElectricFieldBlaster.init($Ball,-1,100,1,3)
    Ready=true


