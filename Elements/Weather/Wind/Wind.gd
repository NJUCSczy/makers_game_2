extends Node2D

var Ball=null
var ForceLevel
var MouseInArea=false
var BallInArea=false
var Pressed=false
var Enable:bool
var Direction:Vector2=Vector2()

func init(_Ball,_ForceLevel:int):
    Ball=_Ball
    ForceLevel=_ForceLevel
    $EffectArea.modulate.a=0
    Enable=false

func _physics_process(delta):
    if Ball==null:
        return
    if (Enable or Pressed) and BallInArea:
        var collision=get_world_2d().direct_space_state.intersect_ray(global_position,Ball.global_position,[self,Ball],0b1)
        if !collision:
            Ball.AcceleratedSpeed[self]=Vector2(cos($EffectArea.rotation),sin($EffectArea.rotation))*ForceLevel
        else:
            Ball.AcceleratedSpeed[self]=Vector2()
    else:
            Ball.AcceleratedSpeed[self]=Vector2()
    if !Enable:
        test_collision()
    
func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT:
            if event.is_pressed():
                if MouseInArea and !Pressed and !Enable:
                    Pressed=true
                    $EffectArea.modulate.a=0.5
                elif MouseInArea and Enable:
                    Enable=false
                    $EffectArea.modulate.a=0
            else:
                if Pressed and !Enable:
                    Enable=true
                    $EffectArea.modulate.a=1
                Pressed=false
        elif event.button_index == BUTTON_RIGHT:
            if Pressed and !Enable:
                Pressed=false
                $EffectArea.modulate.a=0

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
    
    
func _on_ClickArea_mouse_entered():
    MouseInArea=true

func _on_ClickArea_mouse_exited():
    MouseInArea=false

func _on_EffectArea_body_entered(body):
    BallInArea=true

func _on_EffectArea_body_exited(body):
    BallInArea=false
