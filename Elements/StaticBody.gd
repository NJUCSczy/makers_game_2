extends Node2D

var CollisionEnergyCostRate:float=0         #小球撞击此方块之后损耗的速度比例，0~1
var CollisionEnergyExtraCost:float=0        #小球撞击此方块之后损耗的速度定值（沿碰撞面法线方向），不能太小，否则没有效果
var CollisionBounceSpeed:float=-1            #小球撞击此方块后速度强制变为此值，如果为负数则不影响

func init(_EnergyRate=0,_EnergyCost=0,_BounceSpeed=0):
	CollisionEnergyCostRate=_EnergyRate
	CollisionEnergyExtraCost=_EnergyCost
	CollisionBounceSpeed=_BounceSpeed
