


GMT.AddCommand("save_data","Saves GM-Tools data",false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,6) then return end
    GMT.Config.Save()
    GMT.PlayerData.Save()
    GMT.SendConsoleMessage("GM-Tools: Saved data",client,Color(255,0,255,255))
end)

GMT.AddCommand("reload_config","Reloads GM-Tools config",false,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,6) then return end
    GMT.SendConsoleMessage("GM-Tools: Reloading config...",client,Color(255,0,255,255))
    if GMT.Config.Load() == true then
        GMT.SendConsoleMessage("GM-Tools: Config reloaded",client,Color(255,0,255,255))
    end
end)