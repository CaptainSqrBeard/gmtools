GMT.AddCommand("nearchars",GMT.Lang("Help_NearChars"),true,function(client,cursor,args)
    if GMT.Player.ProcessCooldown(client,4) then return end
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
        if (GMT.InRange(pos.x,cursor.x-size,cursor.x+size)) and (GMT.InRange(pos.y,cursor.y-size,cursor.y+size)) then
            GMT.SendConsoleMessage(GMT.Lang("CMD_NearChars_char",{char.Name, char.ID}),client,Color(255,255,255,255))
        end
    end
end,{
{name="size",desc=GMT.Lang("Args_NearChars_size")}})