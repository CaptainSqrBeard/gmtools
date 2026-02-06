local module = {}

local utils = require("GMT_Scripts._UTILS.utils")

local path = "LocalMods/_GMT_Config/"

-- How to do file things:
-- File.CreateDirectory('LocalMods/Test')
-- File.Read('LocalMods/Test')
-- File.Delete('LocalMods/Test')
-- File.Write('LocalMods/Test')
-- File.Exists('LocalMods/Test')

function module.initialize(defaultConfig)
    module.validateFolder(path)
    module.validateFolder(path.."Backup/")
    module.validateFolder(path.."Backup/Players")
end

function module.validateFile(path, defaultContent)
    if not File.Exists(path) then
        File.Write(path, defaultContent)
    end
end

function module.validateFolder(path)
    if not File.DirectoryExists(path) then
        File.CreateDirectory(path)
    end
end

function module.backupFile(filePath, directory)
    local backupPath = path.."Backup/"
    module.validateFolder(backupPath)

    if directory ~= nil then
        backupPath = backupPath..directory.."/"
        module.validateFolder(backupPath)
    end

    local fileName = module.fileName(filePath)
    local backupName = fileName.." "..os.date("%d-%m-%y %H-%M-%S", os.time())..".backup"
    File.Write(backupPath..backupName, File.Read(filePath))

    return backupName, backupPath
end

function module.fileName(filePath)
    local names = utils.Split(filePath, "/")
    return names[#names]
end

function module.getPath()
    return path
end

return module