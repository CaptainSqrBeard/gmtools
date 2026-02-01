local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local lang = require("GMT_Scripts._UTILS.lang")

command.AddCommand("sublock",lang.Lang("Help_SubmarineLock"),true,nil,{
    {name="submarine",desc=lang.Lang("Args_SubmarineLock_submarine")},
    {name="axis",desc=lang.Lang("Args_SubmarineLock_axis")}})

command.AssignClientCommand("sublock",function(client,cursor,args)
    if #args == 0 then
        utils.SendConsoleMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments"),client,Color(255,0,128,255))
        return
    end

    local sub_id = tonumber(args[1])
    local sub = Submarine.Loaded[sub_id]
    if sub == nil then
        utils.SendConsoleMessage("GMTools: "..lang.Lang("Error_SubmarineNotFound"),client,Color(255,0,128,255))
        return
    end

    if args[2] == nil or args[2] == "xy" then
        if sub.LockX and sub.LockY then
            sub.LockX = false
            sub.LockY = false
            utils.SendConsoleMessage(lang.Lang("CMD_SubmarineLocked_FullUnlock"),client,Color(255,0,255,255))
        else
            sub.LockX = true
            sub.LockY = true
            utils.SendConsoleMessage(lang.Lang("CMD_SubmarineLocked_FullLock"),client,Color(255,0,255,255))
        end
    elseif args[2] == "x" then
        sub.LockX = not sub.LockX
        if sub.LockX then
            utils.SendConsoleMessage(lang.Lang("CMD_SubmarineLocked_XLock"),client,Color(255,0,255,255))
        else
            utils.SendConsoleMessage(lang.Lang("CMD_SubmarineLocked_XUnlock"),client,Color(255,0,255,255))
        end
    elseif args[2] == "y" then
        sub.LockY = not sub.LockY
        if sub.LockY then
            utils.SendConsoleMessage(lang.Lang("CMD_SubmarineLocked_YLock"),client,Color(255,0,255,255))
        else
            utils.SendConsoleMessage(lang.Lang("CMD_SubmarineLocked_YUnlock"),client,Color(255,0,255,255))
        end
    end
end)

command.AssignServerCommand("sublock",function(args)
    if #args == 0 then
        utils.NewConsoleMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments"),Color(255,0,128,255))
        return
    end

    local sub_id = tonumber(args[1])
    local sub = Submarine.Loaded[sub_id]
    if sub == nil then
        utils.NewConsoleMessage("GMTools: "..lang.Lang("Error_SubmarineNotFound"),Color(255,0,128,255))
        return
    end

    if args[2] == nil or args[2] == "xy" then
        if sub.LockX and sub.LockY then
            sub.LockX = false
            sub.LockY = false
            utils.NewConsoleMessage(lang.Lang("CMD_SubmarineLocked_FullUnlock"),Color(255,0,255,255))
        else
            sub.LockX = true
            sub.LockY = true
            utils.NewConsoleMessage(lang.Lang("CMD_SubmarineLocked_FullLock"),Color(255,0,255,255))
        end
    elseif args[2] == "x" then
        sub.LockX = not sub.LockX
        if sub.LockX then
            utils.NewConsoleMessage(lang.Lang("CMD_SubmarineLocked_XLock"),Color(255,0,255,255))
        else
            utils.NewConsoleMessage(lang.Lang("CMD_SubmarineLocked_XUnlock"),Color(255,0,255,255))
        end
    elseif args[2] == "y" then
        sub.LockY = not sub.LockY
        if sub.LockY then
            utils.NewConsoleMessage(lang.Lang("CMD_SubmarineLocked_YLock"),Color(255,0,255,255))
        else
            utils.NewConsoleMessage(lang.Lang("CMD_SubmarineLocked_YUnlock"),Color(255,0,255,255))
        end
    end
end)