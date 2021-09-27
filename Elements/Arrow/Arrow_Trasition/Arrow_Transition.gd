extends Node2D

var Ball=null
var MouseInArea=false
var BallInArea=false

func _ready():
    pass # Replace with function body.

func init(_Ball,_ForceRange=250):
    Ball=_Ball
    $DetectingArea/CollisionShape2D.shape.radius=_ForceRange

func _physics_process(delta):
    if Ball==null:
        return

func _on_DetectingArea_body_entered(body):
    if Ball==body:
        BallInArea=true

func _on_DetectingArea_body_exited(body):
    if Ball==body:
        BallInArea=false

func _input(event):
    if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
        if event.is_pressed() and MouseInArea and BallInArea:
            function()

func _on_ClickArea_mouse_entered():
    MouseInArea=true

func _on_ClickArea_mouse_exited():
    MouseInArea=false

func function():
    if Ball==null:
        return
    if MouseInArea  and BallInArea:
        Ball.global_position=2*global_position-Ball.global_position
        Ball.move_and_collide(Vector2())
