extends Node2D

var UsageTime:int=-1
var Ball=null
var MouseInArea=false

func _ready():
    pass # Replace with function body.

func init(_Ball,_UsageTime=-1):
    Ball=_Ball
    UsageTime=_UsageTime

func _process(delta):
    update()
       
func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT:
            if event.is_pressed():
                if MouseInArea and !$ColdTimer.time_left and !$AnimationTimer.time_left:
                    function()
                    $AnimationTimer.start()

func _draw():
    if $AnimationTimer.time_left:
        draw_line(Vector2(),$CollisionBody.position,Color.blue,10)

func function():
    if !UsageTime:
        return
    UsageTime-=1
    $CollisionBody.collision_mask=0b1
    $CollisionBody.position=Vector2()
    var Collision=$CollisionBody.move_and_collide(Ball.global_position-global_position)
    if Collision and Collision.collider==Ball:
        Ball.Speed=(Ball.global_position-$CollisionBody.global_position).normalized()*Global.BallSpeedLimit
        $CollisionBody.show()
    $CollisionBody.collision_mask=0

func _on_ClickArea_mouse_entered():
    MouseInArea=true

func _on_ClickArea_mouse_exited():
    MouseInArea=false

func _on_ColdTimer_timeout():
    $AnimatedSprite.animation="1"

func _on_AnimationTimer_timeout():
    $CollisionBody.hide()
    $CollisionBody.position=Vector2()
    $AnimatedSprite.animation="2"
    $ColdTimer.start()
