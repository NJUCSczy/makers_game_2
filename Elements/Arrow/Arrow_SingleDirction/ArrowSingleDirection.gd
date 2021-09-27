extends Node2D

var Direction=Vector2(1,0)
var Ball
var ForceLevel=0
var MouseInArea=false
var Pressed=false
var BallInArea=false

func _ready():
    pass # Replace with function body.

func init(_Ball,_Direction:Vector2=Vector2(1,0),_ForceLevel=0,_ForceRange=250):
    Ball=_Ball
    ForceLevel=_ForceLevel
    $DetectingArea/CollisionShape2D.shape.radius=_ForceRange
    Direction=_Direction.normalized()
    $AnimatedSprite.rotation=Direction.angle()
        
func _physics_process(delta):
    if Ball==null:
        return
    if MouseInArea and Pressed and BallInArea:
        Ball.AcceleratedSpeed[self]=Direction.normalized()*ForceLevel
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
        if event.is_pressed() and MouseInArea:
            Pressed=true
        else:
            Pressed=false

func _on_ClickArea_mouse_entered():
    MouseInArea=true

func _on_ClickArea_mouse_exited():
    MouseInArea=false

