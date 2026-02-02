-- This is my first time that i doing something like this

-- How to do file things:
-- File.CreateDirectory('LocalMods/Test')
-- File.Read('LocalMods/Test')
-- File.Delete('LocalMods/Test')
-- File.Write('LocalMods/Test')
-- File.Exists('LocalMods/Test')
local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")

local default = 
"ahelp_enabled:true\n"..
"player_commands:.list;.help;.ping;.ahelp;.cls\n"..
"lowest_job:assistant\n"..
"language:en\n"..
"do_bwoink:true"

module.configValues = {}
local path = "LocalMods/_GMT_Config/"

function module.CheckFiles()
    if not File.DirectoryExists(path) then
        File.CreateDirectory(path)
        File.Write(path.."config.txt", default)
        File.Write(path.."players.txt", '')
        return true
    end
    if not File.Exists(path.."players.txt") then
        File.Write(path.."players.txt", '')
        return true
    end
    if not File.Exists(path.."config.txt") then
        File.Write(path.."config.txt", default)
        return true
    end
    return false
end

local parameter_load = {}
local parameter_save = {}

-- For loading values from file
parameter_load["ahelp_enabled"] = function (line)
    if line == "false" then
        module.configValues.ahelp_enabled = false
    elseif line == "true" then
        module.configValues.ahelp_enabled = true
    else
        module.configValues.ahelp_enabled = true
        for i, client in ipairs(Client.ClientList) do
            utils.SendConsoleMessage('GM-Tools: Warning! Unknown value in config at parameter "ahelp_enabled". Using default value',client,Color(255,64,0,255))
            return false
        end
    end
end
parameter_load["player_commands"] = function (line)
    local list = utils.Split(line,";")
    local out = {}
    for i, cmd in ipairs(list) do
        table.insert(out,cmd)
    end
    module.configValues.player_commands = out
end
parameter_load["lowest_job"] = function (line)
    if line == "" then
        module.configValues.lowest_job = "assistant"
        return
    end
    module.configValues.lowest_job = line
end
parameter_load["language"] = function (line)
    module.configValues.language = line
end
parameter_load["do_bwoink"] = function (line)
    if line == "false" then
        module.configValues.do_bwoink = false
    elseif line == "true" then
        module.configValues.do_bwoink = true
    else
        module.configValues.do_bwoink = true
        for i, client in ipairs(Client.ClientList) do
            utils.SendConsoleMessage('GM-Tools: Warning! Unknown value in config at parameter "do_bwoink". Using default value',client,Color(255,64,0,255))
            return false
        end
    end
end

-- For saving files
parameter_save["ahelp_enabled"] = function ()
    if module.configValues.ahelp_enabled == true then
        return "true"
    else
        return "false"
    end
end
parameter_save["player_commands"] = function ()
    return table.concat(module.configValues.player_commands,';')
end
parameter_save["lowest_job"] = function ()
    return module.configValues.lowest_job
end
parameter_save["language"] = function ()
    return module.configValues.language
end
parameter_save["do_bwoink"] = function ()
    if module.configValues.do_bwoink == true then
        return "true"
    else
        return "false"
    end
end



function module.CreateConfig()
    File.Write(path.."config.txt", default)
end

function module.LoadDefault()
    module.configValues = {}
    module.configValues.player_commands = {".list",".help",".ping",".ahelp",".cls",".clock"}
    module.configValues.ahelp_enabled = true
    module.configValues.lowest_job = "assistant"
    module.configValues.language = "en"
    module.configValues.do_bwoink = true
end

local function read_value(line)
    local parameter
    local value
    if line == '' or line:sub(1,2) == '##' then
        return nil,nil
    end
    for i = 1, #line, 1 do
        if line:sub(i,i) == ':' then
            parameter = line:sub(1,i-1)
            value = line:sub(i+1,#line)
            return parameter,value
        end
    end
    if parameter == nil or value == nil then
        return false, nil
    end
    return parameter,nil
end



function module.Load()
    module.LoadDefault()

    if module.CheckFiles() then
        return
    end
    if File.Exists(path.."config.txt") then
        local lines = utils.Split(File.Read(path.."config.txt"),'\n')
        for i, line in ipairs(lines) do
            local parameter, value = read_value(line)
            if parameter == false then
                for i, client in ipairs(Client.ClientList) do
                    utils.SendConsoleMessage('GM-Tools: Syntax Error in config. Loading default one',client,Color(255,0,0,255))
                    return false
                end
                module.LoadDefault()
            end
            if parameter ~= nil then
                --module.configValues[parameter] = value
                local func = parameter_load[parameter]
                if func ~= nil then
                    func(value)
                else
                    for i, client in ipairs(Client.ClientList) do
                        utils.SendConsoleMessage('GM-Tools: Warning! Unknown parameter in config "'..parameter..'". Skipping it',client,Color(255,64,0,255))
                    end
                end
            end

        end
    else
        module.CreateConfig()
        module.LoadDefault()
        for i, client in ipairs(Client.ClientList) do
            utils.SendConsoleMessage('GM-Tools: Config is not exists. Creating default one',client,Color(255,0,0,255))
        end
        return false
    end
    return true
end



function module.Save()
    module.CheckFiles()
    local txt = ""
    for k, val in pairs(module.configValues) do
        txt = txt..k..":"..parameter_save[k]().."\n"
    end
    File.Write(path.."config.txt",txt)
end



function module.CheckPlayerCommands()
    local out = {}
    for i, cmd in ipairs(module.configValues.player_commands) do
        if utils.Contains(command.ConsoleCommands,cmd) then
            table.insert(out,cmd)
        else
            for i, client in ipairs(Client.ClientList) do
                utils.SendConsoleMessage('GM-Tools: Warning! Unknown GM-Tools command "'..cmd..'" in config at parameter "player_commands". Ignoring it.',client,Color(255,64,0,255))
            end
        end
    end
    module.configValues.player_commands = out
end

return module