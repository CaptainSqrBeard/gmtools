local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local files = require("GMT_Scripts._UTILS.files")
local legacyConfig = require("GMT_Scripts.Migration.legacyConfig")
local main = require("GMT_Scripts.main")

module.configValues = {}
local configFilePath = files.getPath().."config.json"
local legacyConfigFilePath = files.getPath().."config.txt"

local defaultConfig

function module.GetDefaultConfig()
    local newConfig = {}

    newConfig.config_version = 1
    newConfig.player_commands = {".list",".help",".ping",".ahelp",".cls",".clock"}
    newConfig.player_permissions = {}
    newConfig.ahelp_enabled = true
    newConfig.lowest_job = "assistant"
    newConfig.language = "en"
    newConfig.stack_job_bans = true
    newConfig.debug_mode = false
    newConfig.print_startup_message = true
    newConfig.admin_warnings = false

    return newConfig
end

function module.GetDefaultJSONConfig()
    return json.serialize(defaultConfig)
end

defaultConfig = module.GetDefaultConfig()

function module.ValidateConfigTable(configTable)
    local validatedTable = {}
    
    module.ValidateValue("config_version", "number", validatedTable, configTable)
    module.ValidateValue("player_commands", "table", validatedTable, configTable)
    module.ValidateValue("player_permissions", "table", validatedTable, configTable)
    module.ValidateValue("ahelp_enabled", "boolean", validatedTable, configTable)
    module.ValidateValue("lowest_job", "string", validatedTable, configTable)
    module.ValidateValue("language", "string", validatedTable, configTable)
    module.ValidateValue("stack_job_bans", "boolean", validatedTable, configTable)
    module.ValidateValue("debug_mode", "boolean", validatedTable, configTable)
    module.ValidateValue("print_startup_message", "boolean", validatedTable, configTable)
    module.ValidateValue("admin_warnings", "boolean", validatedTable, configTable)

    return validatedTable
    --module.ValidateValue(validatedTable, configTable, "do_bwoink", "bool")
end

function module.ValidateValue(name, parameterType, validatedTable, rawTable)
    if rawTable[name] ~= nil and type(rawTable[name]) == parameterType then
        validatedTable[name] = rawTable[name]
    else
        validatedTable[name] = defaultConfig[name]
    end
end

function module.LoadDefault()
    module.configValues = module.GetDefaultConfig()
end

function module.Load()
    -- When config is not present
    if not File.Exists(configFilePath) then
        -- Migration: Check if there's legacy config and try to migrate
        if File.Exists(legacyConfigFilePath) then
            local legacyConfigTable = legacyConfig.MigrateConfigLegacy(File.Read(legacyConfigFilePath))
            if legacyConfigTable ~= nil then
                utils.SendConsoleMessageAdminLevel('GM-Tools: Migrating from legacy config',Color(255,128,0,255))
                module.configValues = module.ValidateConfigTable(legacyConfigTable)
                module.Save()
                files.backupFile(legacyConfigFilePath)
                File.Delete(legacyConfigFilePath)
                return
            end
        end
        
        -- Create default config
        files.validateFile(configFilePath, module.GetDefaultJSONConfig())
        module.configValues = module.GetDefaultConfig()
        --utils.SendConsoleMessageAdminLevel('GM-Tools: Config file not present. Generating default config.',Color(255,64,0,255))
        return
    end


    -- Try to parse config
    local parsedTable
    local content = File.Read(configFilePath)
    local status, err = pcall(function ()
        parsedTable = json.parse(content)
    end)

    -- If parse failed, backup config and load default one
    if err ~= nil then
        local backupName, backupPath = files.backupFile(configFilePath)
        main.SendWarningMessage('GM-Tools: Could not parse config file. Loading default config:\n|   '..err..'\nBackup of old config was made: '..backupPath..backupName)
        module.configValues = module.GetDefaultConfig()
        module.Save()
        return
    end

    -- Validate and load config
    module.configValues = module.ValidateConfigTable(parsedTable)
end

function module.Save()
    File.Write(configFilePath, json.serialize(module.configValues))
end

return module