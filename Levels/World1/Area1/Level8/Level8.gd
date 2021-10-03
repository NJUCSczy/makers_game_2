extends Node2D

var Ready=false
var WorldID=1
var AreaID=1
var LevelID=8

func _ready():
    Global.change_camera_zoom(1.2)
    $Obstacles.init(0,0,0)
    $Arrow1.init($Ball,15,2000)
    $Arrow2.init($Ball,15,2000)
    $Arrow3.init($Ball,15,2000)
    
    $AnimationPlayer1.play("1")
    $AnimationPlayer2.play("1")
    Ready=true

func _on_AnimationPlayer1_animation_finished(anim_name):
    $AnimationPlayer1.play("1")

func _on_AnimationPlayer2_animation_finished(anim_name):
    $AnimationPlayer2.play("1")
