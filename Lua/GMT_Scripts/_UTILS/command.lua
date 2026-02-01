local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local lang = require("GMT_Scripts._UTILS.lang")

GMT.AllCommands = {}

function module.ListAllCommands()
    local list = {}
    for i, cmd in ipairs(GMT.AllCommands) do
        table.insert(list, cmd)
    end
    return list
end

function module.SplitCommand(msg)
    utils.Expect(1, msg, "string")

    local split = {}
    local piece = ""
    
    local inQuotes = false
    local escape = 0

    for i = 1, msg:len(), 1 do

        if msg:sub(i,i) == '\\' then
            if escape == 0 then
                escape = 2
            else
                piece = piece..'\\'
            end

        elseif msg:sub(i,i) == '"' then
            if escape == 0 then
                inQuotes = not inQuotes
            else
                piece = piece..'"'
            end

        elseif (msg:sub(i,i) == ' ' and not inQuotes) and (piece ~= "") then
            table.insert(split,piece)
            piece = ""
        
        -- Any other symbol
        elseif escape == 0 then
            piece = piece..msg:sub(i,i)
        end

        -- Escape
        if escape > 0 then
            escape = escape-1
        end
    end

    if piece ~= "" then
        table.insert(split,piece)
    end

    return split
end


--[[ command.AddCommand
"Adds new command into console"
* name: Name of the command (String)
* help: Help Text in help (String)
* isCheat: Will this command execute only with enabled cheats (Bool, nil)
* func: Function to execute (Function)
* help_args: Arguments description in help <cmd> (Table)
--]]
function module.AddCommand(name,help,isCheat,func,help_args,getValidArgs,usage)
    utils.Expect(1, name, "string")
    utils.Expect(2, help, "string")
    utils.Expect(3, isCheat, "boolean", "nil")
    utils.Expect(4, func, "function", "nil")
    utils.Expect(5, help_args, "table", "nil")
    utils.Expect(6, usage, "string", "nil")

    if usage == nil and help_args ~= nil then
        if help_args[1].optional then
            usage = "["..help_args[1].name.."]"
        else
            usage = "<"..help_args[1].name..">"
        end

        for i = 2, #help_args, 1 do
            if help_args[i] then
                usage = usage.." ["..help_args[i].name.."]"
            else
                usage = usage.." <"..help_args[i].name..">"
            end
        end
    end

    GMT.HelpData[name] = {name=name, help=help, args=help_args, usage=usage}
    table.insert(GMT.AllCommands,"."..name)

    Game.AddCommand("."..name, help, function () end, getValidArgs, isCheat)
    if type(func) == "function" then
        module.AssignClientCommand(name, func) -- function(client,cursor,args) end
    end
end


--[[ command.AssignClientCommand
"Assigns client usage in console"
* name: Name of the command (String)
* func: Function to execute (Function)
--]]
function module.AssignClientCommand(name,func)
    utils.Expect(1, name, "string")
    utils.Expect(2, func, "function")

    Game.AssignOnClientRequestExecute("."..name, func) -- function(args) end
end

--[[ command.AssignServerCommand
"Assigns server usage in server console (For dedicated servers)"
* name: Name of the command (String)
* func: Function to execute (Function)
--]]
function module.AssignServerCommand(name,func)
    utils.Expect(1, name, "string")
    utils.Expect(2, func, "function")

    Game.AssignOnExecute("."..name, func) -- function(args) end
end

--[[ GMT.AssignSharedCommand
"Assigns usage in both server console and client console."
* name: Name of the command (String)
* func: Function to execute (Function)
--]]
function module.AssignSharedCommand(name,func)
    utils.Expect(1, name, "string")
    utils.Expect(2, func, "function")

    Game.AssignOnClientRequestExecute("."..name, function (client,cursor,args)
        local interface = module.NewClientCMDInterface(client,cursor)
        func(args, interface)
    end)

    Game.AssignOnExecute("."..name, function (args)
        local interface = module.NewServerCMDInterface()
        func(args, interface)
    end)
end

--[[ GMT.NewClientCMDInterface
"Creates interface to use for clients"
* client: Executor
* cursor: World position of cursor
--]]
function module.NewClientCMDInterface(client,cursor)
    return {
        isServer = false,
        executor = client,
        cursor = cursor,
        showMessage = function (text, color)
            utils.SendConsoleMessage(text, client, color)
        end
    }
end

--[[ GMT.NewServerCMDInterface
"Creates interface to use for server console"
--]]
function module.NewServerCMDInterface()
    return {
        isServer = true,
        executor = nil,
        cursor = nil,
        showMessage = function (text, color)
            utils.NewConsoleMessage(text, color)
        end
    }
end

--[[ command.AddChatCommand
"Adds new command into chat"
* name: Name of the command (String)
* help: Help Text in .help (String)
* func: Function to execute (Function)
--]]
function module.AddChatCommand(name,help,func)
    utils.Expect(1, name, "string")
    utils.Expect(2, help, "string")
    utils.Expect(3, func, "function")
    utils.Expect(4, usage, "string", "nil")

    GMT.ChatCommands["."..name] = {name=name,func=func,help=help,usage=usage}
end

function module.GetCommandByString(string)
    utils.Expect(1, string, "string")

    for i, cmd in ipairs(Game.Commands) do
        if cmd.names[1] == string then
            return cmd
        end
    end
end

function module.GetCommandUsageHelp(command)
    utils.Expect(1, command, "string")

    if GMT.HelpData[command].usage == nil then
        return lang.Lang("Usage").."."..command
    end
    return lang.Lang("Usage").."."..command.." "..GMT.HelpData[command].usage
end

function module.GetChatCommandUsageHelp(command)
    utils.Expect(1, command, "string")

    if GMT.ChatCommands[command].usage == nil then
        return lang.Lang("Usage")..command
    end
    return lang.Lang("Usage")..command.." "..GMT.ChatCommands[command].usage
end
return module