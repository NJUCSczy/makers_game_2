extends KinematicBody2D

var CollisionEnergyCostRate:float=0         #小球撞击此方块之后损耗的速度比例，0~1
var CollisionEnergyExtraCost:float=0        #小球撞击此方块之后损耗的速度定值（沿碰撞面法线方向），不能太小，否则没有效果
var CollisionBounceSpeed:float=450         #小球撞击此方块后速度强制变为此值，如果为0则不影响

func _ready():
    match $AnimatedSprite.animation:
        "1":
            $CollisionShape2D.shape.extents.x=100
        "2":
            $CollisionShape2D.shape.extents.x=160
        "3":
            $CollisionShape2D.shape.extents.x=200

func bounce_animation():
    $AnimatedSprite.play($AnimatedSprite.animation,false)
    yield($AnimatedSprite,"animation_finished")
    $AnimatedSprite.call_deferred("play",$AnimatedSprite.animation,true)
    yield($AnimatedSprite,"animation_finished")
    $AnimatedSprite.stop()
    $AnimatedSprite.frame=0
