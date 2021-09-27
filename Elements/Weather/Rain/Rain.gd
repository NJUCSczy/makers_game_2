extends Node2D

var Ball=null
var MouseInArea=false
var BallInArea=false

func init(_Ball,_ForceRange=250):
    Ball=_Ball
    $EffectArea/CollisionShape2D.shape.radius=_ForceRange


func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT:
            if event.is_pressed():
                if MouseInArea and !$ColdTimer.time_left:
                    $ColdTimer.start()
                    if BallInArea:
                        if Ball.Status=="hot":
                            Ball.change_status("normal")
                        elif Ball.Status=="normal":
                            Ball.change_status("wet")


func _on_ClickArea_mouse_entered():
    MouseInArea=true

func _on_ClickArea_mouse_exited():
    MouseInArea=false

func _on_EffectArea_body_entered(body):
    BallInArea=true

func _on_EffectArea_body_exited(body):
    BallInArea=false
