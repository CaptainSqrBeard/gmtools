local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local lang = require("GMT_Scripts._UTILS.lang")

function module.initialize()
    module.submarineLocks = {}

    command.AddCommand("sublock",lang.Lang("Help_SubmarineLock"),true,nil,{
        {name="submarine",desc=lang.Lang("Args_SubmarineLock_submarine")},
        {name="axis",desc=lang.Lang("Args_SubmarineLock_axis"),optional=true}
    })

    command.AssignSharedCommand("sublock",function (args, interface)
        if #args == 0 then
            interface.showMessage("GMTools: "..lang.Lang("Error_NotEnoughArguments").."\n"..command.GetCommandUsageHelp("sublock"),Color(255,0,128,255))
            return
        end

        local sub_id = tonumber(args[1])
        local sub = Submarine.Loaded[sub_id]
        if sub == nil then
            interface.showMessage("GMTools: "..lang.Lang("Error_SubmarineNotFound"),Color(255,0,128,255))
            return
        end

        if module.submarineLocks[sub] == nil then
            module.submarineLocks[sub] = {x = false, y = false}
        end

        if args[2] == nil or args[2] == "xy" then
            if module.submarineLocks[sub].x and module.submarineLocks[sub].y then
                module.submarineLocks[sub].x = false
                module.submarineLocks[sub].y = false
                interface.showMessage(lang.Lang("CMD_SubmarineLocked_FullUnlock"),Color(255,0,255,255))
            else
                module.submarineLocks[sub].x = true
                module.submarineLocks[sub].y = true
                interface.showMessage(lang.Lang("CMD_SubmarineLocked_FullLock"),Color(255,0,255,255))
            end
        elseif args[2] == "x" then
            module.submarineLocks[sub].x = not module.submarineLocks[sub].x
            if module.submarineLocks[sub].x then
                interface.showMessage(lang.Lang("CMD_SubmarineLocked_XLock"),Color(255,0,255,255))
            else
                interface.showMessage(lang.Lang("CMD_SubmarineLocked_XUnlock"),Color(255,0,255,255))
            end
        elseif args[2] == "y" then
            module.submarineLocks[sub].y = not module.submarineLocks[sub].y
            if module.submarineLocks[sub].y then
                interface.showMessage(lang.Lang("CMD_SubmarineLocked_YLock"),Color(255,0,255,255))
            else
                interface.showMessage(lang.Lang("CMD_SubmarineLocked_YUnlock"),Color(255,0,255,255))
            end
        end
    end)

    Hook.Add("roundEnd", "gmtools.on_round_end", function ()
        module.submarineLocks = {}
    end)

    Hook.Patch("Barotrauma.SubmarineBody", "CalculateBuoyancy", function (instance, ptable)
        if module.submarineLocks[instance.Submarine] ~= nil and module.submarineLocks[instance.Submarine].y == true then
            ptable.PreventExecution = true
            return Vector2.Zero
        end
    end, Hook.HookMethodType.Before)
    
    Hook.Patch("Barotrauma.Submarine", "Update", function (instance, ptable)
        if module.submarineLocks[instance] ~= nil then
            local patched_x = instance.subBody.Body.LinearVelocity.x
            local patched_y = instance.subBody.Body.LinearVelocity.y
            if module.submarineLocks[instance].x == true then
                patched_x = 0
            end
            if module.submarineLocks[instance].y == true then
                patched_y = 0
            end
            instance.subBody.Body.LinearVelocity = Vector2(patched_x, patched_y)
        end
    end, Hook.HookMethodType.After)
end

return module