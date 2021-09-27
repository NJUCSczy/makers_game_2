extends Node2D

var StarNumber:int=0
var StarNumberLeft:int=0

func _ready():
    StarNumberLeft=get_child_count()

func get_star():
    StarNumber+=1
    StarNumberLeft-=1
    if StarNumberLeft<=0:
        Global.level_clear(get_parent().WorldID,get_parent().AreaID,get_parent().LevelID)
