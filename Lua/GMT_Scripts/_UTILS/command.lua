local module = {}

local utils = require("GMT_Scripts._UTILS.utils")

GMT.AllCommands = {}

function module.SplitCommand(msg)
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
function module.AddCommand(name,help,isCheat,func,help_args,getValidArgs)
    if (utils.CheckFArgs(name,"string")) or
    (utils.CheckFArgs(help,"string")) or
    (utils.CheckFArgs(isCheat,"boolean",true)) or
    (utils.CheckFArgs(help_args,"table",true))
    then
        utils.ThrowError("Bad Argument")
    end

    GMT.HelpData[name] = {name=name,help=help,args=help_args}
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
    if (utils.CheckFArgs(name,"string")) or
    (utils.CheckFArgs(func,"function"))
    then
        utils.ThrowError("Bad Argument")
    end

    Game.AssignOnClientRequestExecute("."..name, func) -- function(args) end
end

--[[ command.AssignServerCommand
"Assigns server usage in server console (For dedicated servers)"
* name: Name of the command (String)
* func: Function to execute (Function)
--]]
function module.AssignServerCommand(name,func)
    if (utils.CheckFArgs(name,"string")) or
    (utils.CheckFArgs(func,"function"))
    then
        utils.ThrowError("Bad Argument")
    end

    Game.AssignOnExecute("."..name, func) -- function(args) end
end



--[[ command.AddChatCommand
"Adds new command into chat"
* name: Name of the command (String)
* help: Help Text in .help (String)
* func: Function to execute (Function)
--]]
function module.AddChatCommand(name,help,func)
    if (utils.CheckFArgs(name,"string")) or
    (utils.CheckFArgs(help,"string")) or
    (utils.CheckFArgs(func,"function"))
    then
        utils.ThrowError("Bad Argument")
    end

    GMT.ChatCommands["."..name] = {name=name,func=func,help=help}
end

function module.GetCommandByString(string)
    for i_1, cmd in ipairs(Game.Commands) do
        if cmd.names[1] == string then
            return cmd
        end
    end
end

return module