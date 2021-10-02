extends Node2D

var Ready=false
var WorldID=1
var AreaID=4
var LevelID=3


func _ready():
    Global.change_camera_zoom(1.2)
    $Obstacles.init(0,0,0)
    $Arrow_Back1.init($Ball)
    $Arrow_Back2.init($Ball)
    $ArrowSingleDirection1.init($Ball,Vector2(-1,0),15,2000)
    Ready=true
    $AnimationPlayer.play("animation")
    
func _on_AnimationPlayer_animation_finished(anim_name):
    $AnimationPlayer.play("animation")


