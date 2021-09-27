extends Node2D

var Ball=null
var ForceLevel
var MouseInArea=false
var BallInArea=false
var Enable:bool=false

func init(_Ball,_ForceLevel:int=15,_ForceRange=250):
    Ball=_Ball
    ForceLevel=_ForceLevel
    $EffectArea/CollisionShape2D.shape.radius=_ForceRange

func _physics_process(delta):
    if Ball==null:
        return
    if Enable and BallInArea:
        Ball.AcceleratedSpeed[self]=(global_position-Ball.global_position).normalized()*ForceLevel
    else:
        Ball.AcceleratedSpeed[self]=Vector2()

func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT:
            if event.is_pressed():
                if MouseInArea:
                    Enable=!Enable
                    if Enable:
                        $AnimatedSprite.animation="2"
                    else:
                        $AnimatedSprite.animation="1"


func _on_ClickArea_mouse_entered():
    MouseInArea=true

func _on_ClickArea_mouse_exited():
    MouseInArea=false

func _on_EffectArea_body_entered(body):
    BallInArea=true

func _on_EffectArea_body_exited(body):
    BallInArea=false
