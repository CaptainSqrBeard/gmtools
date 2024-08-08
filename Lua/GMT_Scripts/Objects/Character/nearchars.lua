GMT.AddCommand("nearchars",GMT.Lang("Help_NearChars"),true,nil,{
{name="size",desc=GMT.Lang("Args_NearChars_size"),optional=true}})

GMT.AssignClientCommand("nearchars",function(client,cursor,args)
    local size = 100

    -- Checking size
    if args[1] ~= nil then
        size = tonumber(args[1])
        if size == nil then
            GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_NearChars_badrange"),client,Color(255,0,128,255))
            return
        end
    end
    
    GMT.SendConsoleMessage(GMT.Lang("CMD_NearChars_nearchars",{size}),client,Color(255,0,255,255))
    for i, char in ipairs(Character.CharacterList) do
        local pos = char.WorldPosition
        if (GMT.SquaredDistance(cursor.x,cursor.y,pos.x,pos.y) < size*size) then
            GMT.SendConsoleMessage(GMT.Lang("CMD_NearChars_char",{char.Name, char.ID, GMT.GetLocalizedTeam(char.TeamID)}),client,Color(255,255,255,255))
        end
    end
end)

GMT.AssignServerCommand("nearchars",function(args)
    GMT.NewConsoleMessage("GMTools: "..GMT.Lang("Error_bad_console"),Color(255,0,0,255))
end)