extends Node

func load_file():
    var SaveFile=File.new()
    SaveFile.open("res://save/save.txt",File.READ)
    while !SaveFile.eof_reached():
        var TempLine=SaveFile.get_line()
        if TempLine.find("World")!=-1:
            var WorldID:int=TempLine.replace("World","").to_int()
            var AreaID=1
            TempLine=SaveFile.get_line()
            while(TempLine!="@end"):
                var contents=TempLine.split(",")
                for i in contents.size():
                    GameStatus.LevelStatus[WorldID-1][AreaID-1][i]=contents[i].to_int()
                AreaID+=1
                TempLine=SaveFile.get_line()
                
    if GameStatus.LevelStatus[0][0][0]==0:
        GameStatus.LevelStatus[0][0][0]=1

func save_file():
    var SaveFile=File.new()
    SaveFile.open("res://save/save.txt",File.WRITE)
    for i in GameStatus.LevelStatus.size():
        SaveFile.store_string("World"+String(i+1)+"\n")
        for j in GameStatus.LevelStatus[i].size():
            for k in GameStatus.LevelStatus[i][j].size():
                SaveFile.store_string(String(GameStatus.LevelStatus[i][j][k]))
                if k<GameStatus.LevelStatus[i][j].size()-1:
                    SaveFile.store_string(",")
            SaveFile.store_string("\n")
        SaveFile.store_string("@end\n")
