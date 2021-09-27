extends KinematicBody2D

var Endurance=10
var AcceleratedSpeed:Dictionary={}
var Speed:Vector2=Vector2()
var Pressed:bool=false

var BounceIgnore={}

func _physics_process(delta):
    if Endurance<=0:
        return
    var OriginPosition=global_position
    for key in AcceleratedSpeed.keys():
        Speed+=AcceleratedSpeed[key]
        if Speed.length()>Global.BallSpeedLimit:
            Speed=Speed.normalized()*Global.BallSpeedLimit
    var collision=move_and_collide(Speed*delta)
    if collision and (collision.collider in BounceIgnore.keys()):
        collision=0
    var LengthLeft=(Speed*delta).length()-(global_position-OriginPosition).length()
    while collision and LengthLeft>0 and (Speed*delta).length()>0: 
        if collision.collider.collision_layer & 0b100:
            Endurance=0
            return
        elif collision.collider.collision_layer & 0b1000:
            collision.collider.block_break()
        if collision.collider.name.find("BounceBlock")!=-1:
            collision.collider.bounce_animation()
        var angle1=(-Speed).angle()
        var angle2=collision.normal.angle()
        var angle3=2*angle2-angle1
        var SpeedCost
        if collision.collider.name.find("Mail")!=-1 or collision.collider.name.find("Ball")!=-1:
            SpeedCost=Vector2()
            global_position=(OriginPosition-collision.collider.global_position).normalized()*($CollisionShape2D.shape.radius+collision.collider.get_node("CollisionShape2D").shape.radius)+collision.collider.global_position
            ball_collision(collision.collider)
        else:
            SpeedCost=collision.normal.normalized()*(collision.collider.CollisionEnergyCostRate*Speed.length()*cos(angle1-angle2)+collision.collider.CollisionEnergyExtraCost)
        if SpeedCost.length()>=Speed.length()*cos(angle1-angle2):
            SpeedCost=Speed.length()*cos(angle1-angle2)*collision.normal.normalized()
        if collision.collider.name.find("Mail")==-1 and collision.collider.name.find("Ball")==-1:
            Speed=Vector2(cos(angle3),sin(angle3))*Speed.length()
        Speed-=SpeedCost
        if collision.collider.get("CollisionBounceSpeed") and collision.collider.CollisionBounceSpeed:
            Speed+=collision.normal*collision.collider.CollisionBounceSpeed
            Speed=Speed.normalized()*Global.BallSpeedLimit
        if (global_position-OriginPosition).length()<1:
            global_position=OriginPosition
        OriginPosition=global_position
        if (Speed*delta).length()>1e-5:
            collision=move_and_collide((Speed*delta).normalized()*LengthLeft)
        else:
            collision=0
        if collision and (collision.collider in BounceIgnore.keys()):
            collision=0
        LengthLeft-=(global_position-OriginPosition).length()
        
    for key in BounceIgnore.keys():
        if (key.global_position-global_position).length()>$CollisionShape2D.shape.radius+key.get_node("CollisionShape2D").shape.radius:
            BounceIgnore.erase(key)
    
func ball_collision(target):
    var speed1=Vector2()
    var speed2=Vector2()
    var vect1=target.global_position-global_position
    if Speed!=Vector2():
        var angle1=Speed.angle_to(vect1)
        speed1=Speed.length()*cos(angle1)*(vect1.normalized())
    if target.Speed!=Vector2():
        var angle1=target.Speed.angle_to(-vect1)
        speed2=target.Speed.length()*cos(angle1)*(-vect1.normalized())
    Speed=Speed-speed1+speed2
    target.Speed=target.Speed-speed2+speed1
    target.BounceIgnore[self]=1
    BounceIgnore[target]=1
