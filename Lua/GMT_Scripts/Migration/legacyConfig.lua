local module = {}

local utils = require("GMT_Scripts._UTILS.utils")

local parameter_load = {}

-- For loading values from file
parameter_load["ahelp_enabled"] = function (line)
    if line == "false" then
        return false
    elseif line == "true" then
        return true
    else
        return true
    end
end
parameter_load["player_commands"] = function (line)
    local list = utils.Split(line,";")
    local out = {}
    for i, cmd in ipairs(list) do
        table.insert(out,cmd)
    end
    return out
end
parameter_load["lowest_job"] = function (line)
    if line == "" then
        return "assistant"
    end
    return line
end
parameter_load["language"] = function (line)
    return line
end
parameter_load["do_bwoink"] = function (line)
    if line == "false" then
        return false
    elseif line == "true" then
        return true
    else
        return false
    end
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

function module.MigrateConfigLegacy(data)
    local newConfig = {}
    local lines = utils.Split(data,'\n')

    for i, line in ipairs(lines) do
        local parameter, value = read_value(line)
        if parameter == false then
            return
        end
        if parameter ~= nil then
            --module.configValues[parameter] = value
            local func = parameter_load[parameter]
            if func ~= nil then
                newConfig[parameter] = func(value)
            end
        end
    end

    return newConfig
end

return module