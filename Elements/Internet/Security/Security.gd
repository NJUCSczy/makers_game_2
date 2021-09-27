extends Node2D

var Ball=null
var MouseInArea=false
var Pressed=false
var Enable=false
var Blocked=false

func init(_Ball):
    Ball=_Ball
    $Collider.modulate.a=0
    $Collider/CollisionShape2D.disabled=true

func _physics_process(delta):
    if Ball==null:
        return
    if Pressed and !Enable:
        test_collision()
    
func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT:
            if event.is_pressed():
                if MouseInArea and !Pressed and !Enable:
                    Pressed=true
                elif MouseInArea and Enable:
                    Pressed=false
                    Enable=false
                    $Collider.modulate.a=0
                    $Collider/CollisionShape2D.disabled=true
            else:
                if Pressed and !Enable:
                    put_collision()
                Pressed=false
        elif event.button_index == BUTTON_RIGHT:
            Pressed=false
            Enable=false
            $Collider.modulate.a=0
            $Collider/CollisionShape2D.disabled=true

func test_collision():
    var MousePos=get_viewport().get_mouse_position()*Global.GameCamera.zoom
    $Collider.rotation=(MousePos-global_position).angle()
    var Corner=$Collider/CollisionShape2D.shape.extents.y*Vector2(cos(PI/2+$Collider.rotation),sin(PI/2+$Collider.rotation))
    var SpaceStatus = get_world_2d().direct_space_state#获取2D空间，准备发射碰撞检测射线
    var collision1=SpaceStatus.intersect_ray(Corner+global_position,Corner+global_position+(MousePos-global_position).normalized()*5000,[self,Ball],0b1)
    var collision2=SpaceStatus.intersect_ray(-Corner+global_position,-Corner+global_position+(MousePos-global_position).normalized()*5000,[self,Ball],0b1)
    if collision1 and collision2:
        var CollisionLength=min((collision1.position-global_position).length(),(collision2.position-global_position).length())
        $Collider/AnimatedSprite.scale.x=CollisionLength/40
        $Collider/CollisionShape2D.shape.extents.x=CollisionLength/2
        $Collider/CollisionShape2D.position.x=$Collider/CollisionShape2D.shape.extents.x
    
    collision1=SpaceStatus.intersect_ray(Corner+global_position,Corner+global_position+(MousePos-global_position).normalized()*5000,[],0b10)
    collision2=SpaceStatus.intersect_ray(-Corner+global_position,-Corner+global_position+(MousePos-global_position).normalized()*5000,[],0b10)
    if collision1 or collision2:
        Blocked=true
        $Collider.modulate.a=0.2
    else:
        Blocked=false
        $Collider.modulate.a=0.5
    
func put_collision():
    if Blocked:
        Pressed=false
        Enable=false
        $Collider.modulate.a=0
        $Collider/CollisionShape2D.disabled=true
    else:
        Pressed=false
        Enable=true
        $Collider.modulate.a=1
        $Collider/CollisionShape2D.disabled=false
        

func _on_ClickArea_mouse_entered():
    MouseInArea=true

func _on_ClickArea_mouse_exited():
    MouseInArea=false
