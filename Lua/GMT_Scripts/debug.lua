local module = {}

local utils = require("GMT_Scripts._UTILS.utils")
local command = require("GMT_Scripts._UTILS.command")
local lang = require("GMT_Scripts._UTILS.lang")
local files = require("GMT_Scripts._UTILS.files")

function module.initialize()
    command.AddCommand("json_language", "dump language to json", true, nil)

    command.AssignSharedCommand("json_language",function (args, interface)
        interface.showMessage("Dumping all language to json in _GMT_Config")

        File.Write(files.getPath().."language_dump.json", json.serialize(lang.GetLocalizationTable()))
    end)
end

return module