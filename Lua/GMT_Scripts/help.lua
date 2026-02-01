local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local player = require("GMT_Scripts._UTILS.player")

command.AddCommand("help",GMT.Lang("Help_Help"),false,nil,{{name="command",desc=GMT.Lang("Args_Help_command")}})

command.AssignClientCommand("help",function(client,cursor,args)
    if player.ProcessCooldown(client,3) then
        return
    end

    if #args == 1 and string.lower(args[1]) ~= "all" then
        -- Show list of commands
        local command = args[1]
        local data = GMT.HelpData[command]
        if data ~= nil then
            -- Show info about command
            utils.SendConsoleMessage("==== "..data.name.." ====",client,Color(255,0,255,255))
            utils.SendConsoleMessage(GMT.Lang("CMD_Help_desc")..":   "..data.help,client,Color(255,255,255,255))

            if data.args ~= nil then
                local out = {}
                utils.SendConsoleMessage(GMT.Lang("CMD_Help_args")..":",client,Color(255,255,255,255))
                for i, arg in ipairs(data.args) do
                    table.insert(out,i..". '"..arg.name.."'   >   "..arg.desc)
                end
                utils.SendConsoleMessage(table.concat(out,"\n"),client,Color(178,178,178,255))
            end

        else
            utils.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_Help_unknown",{command}),client,Color(255,0,128,255))
        end
    elseif args[1] ~= nil and string.lower(args[1]) == "all" then
        if args[2] == "chat" then
            -- Show list of chat commands
            utils.SendConsoleMessage("==== "..GMT.Lang("CMD_Help_chatlist").." ====",client,Color(255,0,255,255))
            for k, cmd in pairs(GMT.ChatCommands) do
                utils.SendConsoleMessage("."..cmd.name.."   >        "..cmd.help,client,Color(255,255,255,255))
            end
        else
            -- Show list of commands
            utils.SendConsoleMessage("==== "..GMT.Lang("CMD_Help_list").." ====",client,Color(255,0,255,255))
            for k, cmd in pairs(GMT.HelpData) do
                utils.SendConsoleMessage("."..cmd.name.."   >        "..cmd.help,client,Color(255,255,255,255))
            end
        end
    else
        -- Show help info
        utils.SendConsoleMessage("==== "..GMT.Lang("CMD_Help_help").." ====",client,Color(255,0,255,255))
        utils.SendConsoleMessage(GMT.Lang("CMD_Help_line"),client,Color(255,255,255,255))
        utils.SendConsoleMessage(GMT.Lang("CMD_Help_gmt"),client,Color(255,255,255,158))
    end
end)

command.AssignServerCommand("help",function(args)
    if #args == 1 and string.lower(args[1]) ~= "all" then
        -- Show list of commands
        local command = args[1]
        local data = GMT.HelpData[command]
        if data ~= nil then
            -- Show info about command
            utils.NewConsoleMessage("==== "..data.name.." ====",Color(255,0,255,255))
            utils.NewConsoleMessage(GMT.Lang("CMD_Help_desc")..":   "..data.help,Color(255,255,255,255))

            if data.args ~= nil then
                local out = {}
                utils.NewConsoleMessage(GMT.Lang("CMD_Help_args")..":",Color(255,255,255,255))
                for i, arg in ipairs(data.args) do
                    table.insert(out,i..". '"..arg.name.."'   >   "..arg.desc)
                end
                utils.NewConsoleMessage(table.concat(out,"\n"),Color(178,178,178,255))
            end

        else
            utils.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_Help_unknown",{command}),Color(255,0,128,255))
        end
    elseif args[1] ~= nil and string.lower(args[1]) == "all" then
        if args[2] == "chat" then
            -- Show list of chat commands
            utils.NewConsoleMessage("==== "..GMT.Lang("CMD_Help_chatlist").." ====",Color(255,0,255,255))
            for k, cmd in pairs(GMT.ChatCommands) do
                utils.NewConsoleMessage("."..cmd.name.."   >        "..cmd.help,Color(255,255,255,255))
            end
        else
            -- Show list of commands
            utils.NewConsoleMessage("==== "..GMT.Lang("CMD_Help_list").." ====",Color(255,0,255,255))
            for k, cmd in pairs(GMT.HelpData) do
                utils.NewConsoleMessage("."..cmd.name.."   >        "..cmd.help,Color(255,255,255,255))
            end
        end
    else
        -- Show help info
        utils.NewConsoleMessage("==== "..GMT.Lang("CMD_Help_help").." ====",Color(255,0,255,255))
        utils.NewConsoleMessage(GMT.Lang("CMD_Help_line"),Color(255,255,255,255))
        utils.NewConsoleMessage(GMT.Lang("CMD_Help_gmt"),Color(255,255,255,158))
    end
end)