extends Node2D

var Ball=null
var ForceLevel=0
var MouseInArea=false
var BallInArea=false
var Selected=false

func _ready():
    pass

func init(_Ball,_ForceLevel=-1,_EffectWidth=10,_EffectTime=0.5,_ColdTime=3,_EnergyRate=0,_EnergyCost=0):
    Ball=_Ball
    ForceLevel=_ForceLevel
    $EffectTimer.wait_time=_EffectTime
    $ColdTimer.wait_time=_ColdTime
    $StaticBody2D.init(_EnergyRate,_EnergyCost)
    $DetectingArea/CollisionShape2D.shape.extents.y=_EffectWidth/2

func _physics_process(delta):
    if Ball==null:
        return
    if $EffectTimer.time_left and BallInArea:
        Ball.AcceleratedSpeed[self]=(self.global_position-Ball.global_position).normalized()*ForceLevel
    else:
        Ball.AcceleratedSpeed[self]=Vector2()
     
func _process(delta):
    $TargetPosition.global_position=get_viewport().get_mouse_position()*Global.GameCamera.zoom
    if Selected:
        $ElectricFieldArea.scale=Vector2(($TargetPosition.global_position-global_position).length()/2*2/$ElectricFieldArea.texture.get_width(),$DetectingArea/CollisionShape2D.shape.extents.y*2/$ElectricFieldArea.texture.get_height())
        $ElectricFieldArea.rotation=($TargetPosition.global_position-global_position).angle()
        $ElectricFieldArea.offset.x=($TargetPosition.global_position-global_position).length()/2/$ElectricFieldArea.scale.x
        $ElectricFieldArea.show()
        if MouseInArea:
            $ElectricFieldArea.hide()   
    
func _on_DetectingArea_body_entered(body):
    if Ball==body:
        BallInArea=true

func _on_DetectingArea_body_exited(body):
    if Ball==body:
        BallInArea=false

func _input(event):
    if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
        if !$ColdTimer.time_left and !$EffectTimer.time_left and MouseInArea and !Selected:
            Selected=true
            $TargetPosition.show()
            $AnimatedSprite.animation="2"
            $ElectricFieldArea.scale=Vector2(($TargetPosition.global_position-global_position).length()/2*2/$ElectricFieldArea.texture.get_width(),$DetectingArea/CollisionShape2D.shape.extents.y*2/$ElectricFieldArea.texture.get_height())
            $ElectricFieldArea.rotation=($TargetPosition.global_position-global_position).angle()
            $ElectricFieldArea.offset.x=($TargetPosition.global_position-global_position).length()/2/$ElectricFieldArea.scale.x
            $ElectricFieldArea.show()
            $ElectricFieldArea.modulate.a/=3
        elif Selected:
            $ElectricFieldArea.modulate.a*=3
            Selected=false
            if MouseInArea:
                $ElectricFieldArea.hide()
                return
            $AnimatedSprite.animation="1"
            $TargetPosition.hide()
            $DetectingArea/CollisionShape2D.shape.extents.x=($TargetPosition.global_position-global_position).length()/2
            $DetectingArea/CollisionShape2D.position.x=$DetectingArea/CollisionShape2D.shape.extents.x
            $DetectingArea.rotation=($TargetPosition.global_position-global_position).angle()
            $EffectTimer.start()
            
func _on_ClickArea_mouse_entered():
    MouseInArea=true

func _on_ClickArea_mouse_exited():
    MouseInArea=false

func _on_EffectTimer_timeout():
    $ColdTimer.start()
    $AnimatedSprite.animation="1"
    $DetectingArea/CollisionShape2D.shape.extents.x=0
    $DetectingArea/CollisionShape2D.position.x=0
    $ElectricFieldArea.hide()


