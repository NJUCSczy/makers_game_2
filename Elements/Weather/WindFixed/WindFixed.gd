extends Node2D

var Ball=null
var ForceLevel
var MouseInArea=false
var BallInArea=false
var Enable:bool

func init(_Ball,_Direction:Vector2,_ForceLevel:int):
    Ball=_Ball
    ForceLevel=_ForceLevel
    $EffectArea.rotation=_Direction.angle()
    $EffectArea.hide()
    Enable=false

func _physics_process(delta):
    if Ball==null:
        return
    if Enable and BallInArea:
        var collision=get_world_2d().direct_space_state.intersect_ray(global_position,Ball.global_position,[self,Ball],0b1)
        if !collision:
            function()
        else:
            Ball.AcceleratedSpeed[self]=Vector2()
    else:
        Ball.AcceleratedSpeed[self]=Vector2()
        
func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT and event.is_pressed() and MouseInArea:
            if Enable:
                Enable=false
                $EffectArea.hide()
            else:
                Enable=true
                $EffectArea.show()
                test_collision()

func test_collision():
    var Corner=$EffectArea/CollisionShape2D.shape.extents.y*Vector2(cos(PI/2+$EffectArea.rotation),sin(PI/2+$EffectArea.rotation))
    var SpaceStatus = get_world_2d().direct_space_state#获取2D空间，准备发射碰撞检测射线
    var collision1=SpaceStatus.intersect_ray(Corner+global_position,Corner+global_position+Vector2(cos($EffectArea.rotation),sin($EffectArea.rotation)).normalized()*5000,[self,Ball],0b1)
    var collision2=SpaceStatus.intersect_ray(-Corner+global_position,-Corner+global_position+Vector2(cos($EffectArea.rotation),sin($EffectArea.rotation)).normalized()*5000,[self,Ball],0b1)
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
