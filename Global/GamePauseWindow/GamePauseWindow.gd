extends Node2D

func _input(event):
    if event.is_action_pressed("ui_cancel"):
        if !get_tree().paused and Global.CurrentScene.name.find("Level")!=-1:
            show()
            get_tree().paused=true
        elif self.visible and get_tree().paused:
            hide()
            get_tree().paused=false

func _on_QuitButton_pressed():
    Global.goto_world_scene(Global.CurrentScene.WorldID)
        
func _on_RestartButton_pressed():
    Global.goto_level(Global.CurrentScene.WorldID,Global.CurrentScene.AreaID,Global.CurrentScene.LevelID)
        
func _on_ContinueButton_pressed():
    if self.visible and get_tree().paused:
        hide()
        get_tree().paused=false
