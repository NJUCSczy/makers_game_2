extends Node2D

var Ball=null
var ForceLevel=0
var MouseInArea=false
var BallInArea=false

func _ready():
    pass # Replace with function body.

func init(_Ball,_ForceLevel=-5,_ForceRange=100,_EffectTime=0.5,_ColdTime=3,_EnergyRate=0,_EnergyCost=0):
    Ball=_Ball
    ForceLevel=_ForceLevel
    $EffectTimer.wait_time=_EffectTime
    $ColdTimer.wait_time=_ColdTime
    $DetectingArea/CollisionShape2D.shape.radius=_ForceRange
    $StaticBody2D.init(_EnergyRate,_EnergyCost)

func _physics_process(delta):
    if Ball==null:
        return
    if MouseInArea and $EffectTimer.time_left and BallInArea:
        Ball.AcceleratedSpeed[self]=(self.global_position-Ball.global_position).normalized()*ForceLevel
    else:
        Ball.AcceleratedSpeed[self]=Vector2()

func _on_DetectingArea_body_entered(body):
    if Ball==body:
        BallInArea=true

func _on_DetectingArea_body_exited(body):
    if Ball==body:
        BallInArea=false

func _input(event):
    if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
        if !$ColdTimer.time_left and !$EffectTimer.time_left and MouseInArea and BallInArea:
            $EffectTimer.start()
            $AnimatedSprite.animation="2"

func _on_ClickArea_mouse_entered():
    MouseInArea=true

func _on_ClickArea_mouse_exited():
    MouseInArea=false

func _on_EffectTimer_timeout():
    $ColdTimer.start()
    $AnimatedSprite.animation="1"
