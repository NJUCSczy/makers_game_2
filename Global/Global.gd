extends Node2D

var LevelRecord:int=24
var LevelLimit=30

var CurrentScene
var BallSpeedLimit=450
onready var GameCamera=$Camera2D

func _ready():
    CurrentScene=get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 1)
    $Camera2D.current=true
    
func change_scene(scene):
    if scene==CurrentScene:
        return
    $ColorRect.show()
    $AnimationPlayer.play("ChangeScene")
    yield($AnimationPlayer,"animation_finished")
    GameCamera.zoom=Vector2(1,1)
    $LevelClearWindow.scale=Vector2(1,1)
    
    get_tree().paused=false
    $LevelClearWindow.hide()
    $GamePauseWindow.hide()
    
    CurrentScene.queue_free()
    get_tree().get_root().add_child(scene)
    CurrentScene=scene
    if !CurrentScene.Ready:
        yield(CurrentScene,"ready")
    $AnimationPlayer.play_backwards("ChangeScene")
    yield($AnimationPlayer,"animation_finished")
    $ColorRect.hide()

func goto_level(_world:int,_area:int,_level:int):
    var scene=load("res://Levels/World"+String(_world)+"/Area"+String(_area)+"/Level"+String(_level)+"/Level"+String(_level)+".tscn").instance()
    call_deferred("change_scene",scene)

func return_main_menu():
    var scene=load("res://Menus/MainMenu/MainMenu.tscn").instance()
    call_deferred("change_scene",scene)

func goto_world_choose():
    var scene=load("res://Menus/WorldChoose/WorldChoose.tscn").instance()
    call_deferred("change_scene",scene)

func goto_world_scene(WorldID:int):
    var WorldName="World"+String(WorldID)
    var scene=load("res://Menus/Worlds/"+WorldName+"/"+WorldName+".tscn").instance()
    call_deferred("change_scene",scene)

func level_clear(_world:int,_area:int,_level:int):
    GameStatus.finishLevel(_world,_area,_level)
    get_tree().paused=true
    $LevelClearWindow.show()

func change_camera_zoom(_zoom:float):
    GameCamera.zoom=Vector2(1,1)*_zoom
    $LevelClearWindow.scale=Vector2(1,1)*_zoom
    $GamePauseWindow.scale=Vector2(1,1)*_zoom
