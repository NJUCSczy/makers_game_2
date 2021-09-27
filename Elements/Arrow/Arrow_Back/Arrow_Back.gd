extends Node2D

var Ball=null
var MouseInArea=false

func init(_Ball):
    Ball=_Ball

func _input(event):
    if MouseInArea and event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
        if !$ColdTimer.time_left:
            $ColdTimer.start()
            function()

func _on_ClickArea_mouse_entered():
    MouseInArea=true

func _on_ClickArea_mouse_exited():
    MouseInArea=false

func function():
    if Ball!=null:
        Ball.global_position=global_position
        $AnimatedSprite.animation="2"

func _on_ColdTimer_timeout():
    $AnimatedSprite.animation="1"
