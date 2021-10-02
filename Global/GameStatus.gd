extends Node

var LevelStatus:Array=[             #0代表未解锁，1代表已解锁但未通过，2代表已通过但未完成额外目标，3代表完成额外目标
    [
        [1,0,0,0,0,0,0,0],                  #1_1
        [0,0,0,0,0,0,0],                  #1_2
        [0,0,0,0,0,0],                  #1_3
        [0,0,0,0,0,0]                   #1_4
       ],
    [
        [0,0,0,0],                  #2_1
        [0,0,0,0],                  #2_2
        [0,0,0,0],                  #2_3
        [0,0,0,0]                   #2_4
       ]
    ]

var LevelHasBounce:Array=[          #代表关卡是否有额外目标
    [
        [false,false,false,false,false,false,false,false],  #1_1
        [false,false,false,false,false,false,false],  #1_2
        [false,false,false,false,false,false],  #1_3
        [false,false,false,false,false,false]   #1_4
       ],
    [
        [false,false,false,false],  #2_1
        [false,false,false,false],  #2_2
        [false,false,false,false],  #2_3
        [false,false,false,false]   #2_4
       ]
   ]

var Precondition:Dictionary={
    "1_2":[1],
    "1_3":[1],
    "1_4":[2,3],
    "2_2":[1],
    "2_3":[2],
    "2_4":[3],
   }

var WorldUnlockRequirement=[0,0,0,0]    #解锁每一大关需要的星星数量
var WorldMaxBounce=[100,10,0,0]         #每一大关的星星总数

func _ready():
    FileManager.load_file()

    
    
func getLevelStatus(_world:int,_area:int=-1,_level:int=-1):
    if _world<=0:
        return 2
    if _area<0:
        if !LevelStatus[_world-1][0][0]:
            return 0
        for i in range(LevelStatus[_world-1].size()):
            if getLevelStatus(_world,i+1)<2:
                return 1
        return 2
    elif _level<0:
        if !LevelStatus[_world-1][_area-1][0]:
            return 0
        for i in range(LevelStatus[_world-1][_area-1].size()):
            if LevelStatus[_world-1][_area-1][i]<2:
                return 1
        return 2
    else:
        return LevelStatus[_world-1][_area-1][_level-1]
        
func getBounceNumber(_world:int=-1,_area:int=-1):
    var res=0
    if _world<0:
        for i in LevelStatus.size():
            for j in LevelStatus[i].size():
                res+=getBounceNumber(i+1)
    elif _area<0:
        for i in LevelStatus[_world-1].size():
            res+=getBounceNumber(_world,i+1)
    else:
        for i in LevelStatus[_world-1][_area-1].size():
            if LevelHasBounce[_world-1][_area-1][i] and LevelStatus[_world-1][_area-1]==3:
                res+=1
    return res
              
func updateLevelStatus(_world:int=-1,_area:int=-1):
    if _world<0:
        for i in LevelStatus.size():
            updateLevelStatus(i+1)
    elif _area<0:
        if _world>1 and getLevelStatus(_world-1)==2 and !LevelStatus[_world-1][0][0] and WorldUnlockRequirement[_world-1]<=getBounceNumber():
            LevelStatus[_world-1][0][0]=1
        for i in LevelStatus[_world-1].size():
            updateLevelStatus(_world,i+1)
    else:
        if getLevelStatus(_world,_area)==0:
            if Precondition.get(String(_world)+"_"+String(_area))==null and getLevelStatus(_world-1)>=2:
                LevelStatus[_world-1][_area-1][0]=1
            elif Precondition.get(String(_world)+"_"+String(_area))!=null and !LevelStatus[_world-1][_area-1][0]:
                LevelStatus[_world-1][_area-1][0]=1
                for i in Precondition[String(_world)+"_"+String(_area)]:
                    if getLevelStatus(_world,i)<2:
                        LevelStatus[_world-1][_area-1][0]=0
                        break
        for j in range(LevelStatus[_world-1][_area-1].size()-1):
                    if LevelStatus[_world-1][_area-1][j]>=2 and LevelStatus[_world-1][_area-1][j+1]==0:
                        LevelStatus[_world-1][_area-1][j+1]=1
                
                
                      
func finishLevel(_world:int,_area:int,_level:int,_bounce:bool=false):
    LevelStatus[_world-1][_area-1][_level-1]=2
    if _bounce:
        LevelStatus[_world-1][_area-1][_level-1]=3
    updateLevelStatus()
    FileManager.call_deferred("save_file")
