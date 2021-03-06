extends Node2D

var Ball=null
var ForceLevel
var MouseInArea=false
var BallInArea=false
var Pressed=false
var Direction:Vector2=Vector2()

func init(_Ball,_ForceLevel:int):
    Ball=_Ball
    ForceLevel=_ForceLevel
    $EffectArea.modulate.a=0

func _physics_process(delta):
    if Ball==null:
        return
    if Pressed and BallInArea:
        var collision=get_world_2d().direct_space_state.intersect_ray(global_position,Ball.global_position,[self,Ball],0b1)
        if !collision:
            function()
        else:
            Ball.AcceleratedSpeed[self]=Vector2()
    else:
            Ball.AcceleratedSpeed[self]=Vector2()
    test_collision()
    
func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT:
            if event.is_pressed():
                if MouseInArea and !Pressed:
                    Pressed=true
                    $EffectArea.modulate.a=1
            else:
                if Pressed:
                    $EffectArea.modulate.a=0
                    Pressed=false

func test_collision():
    var MousePos=get_viewport().get_mouse_position()*Global.GameCamera.zoom
    $EffectArea.rotation=(MousePos-global_position).angle()
    var Corner=$EffectArea/CollisionShape2D.shape.extents.y*Vector2(cos(PI/2+$EffectArea.rotation),sin(PI/2+$EffectArea.rotation))
    var SpaceStatus = get_world_2d().direct_space_state#获取2D空间，准备发射碰撞检测射线
    var collision1=SpaceStatus.intersect_ray(Corner+global_position,Corner+global_position+(MousePos-global_position).normalized()*5000,[self,Ball],0b1)
    var collision2=SpaceStatus.intersect_ray(-Corner+global_position,-Corner+global_position+(MousePos-global_position).normalized()*5000,[self,Ball],0b1)
    if collision1 and collision2:
        var CollisionLength=max((collision1.position-global_position).length(),(collision2.position-global_position).length())
        $EffectArea/AnimatedSprite.scale.x=CollisionLength/80
        $EffectArea/CollisionShape2D.shape.extents.x=CollisionLength/2
        $EffectArea/CollisionShape2D.position.x=$EffectArea/CollisionShape2D.shape.extents.x
    
func function():
    var MaxLength=$EffectArea/CollisionShape2D.shape.extents.y+Ball.get_node("CollisionShape2D").shape.radius    
    var TempDistance=abs((Ball.global_position-global_position).length()*sin((Ball.global_position-global_position).angle()-$EffectArea.rotation))
    var value=pow(TempDistance/MaxLength,2)
    var Force1:Vector2=Vector2(cos($EffectArea.rotation),sin($EffectArea.rotation))*(1-value)*ForceLevel
    var Force2:Vector2=-(Ball.global_position-global_position-Force1.normalized()*(Ball.global_position-global_position).length()*cos((Ball.global_position-global_position).angle()-$EffectArea.rotation)).normalized()*ForceLevel*value
    Ball.AcceleratedSpeed[self]=Force1+Force2

func _on_ClickArea_mouse_entered():
    MouseInArea=true

func _on_ClickArea_mouse_exited():
    MouseInArea=false

func _on_EffectArea_body_entered(body):
    BallInArea=true

func _on_EffectArea_body_exited(body):
    BallInArea=false
