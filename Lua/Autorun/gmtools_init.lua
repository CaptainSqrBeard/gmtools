if SERVER then
    local main = require("GMT_Scripts.main")

    local path = table.pack(...)[1]

    local contentPackage
    for i, mod in ipairs(Game.GetEnabledContentPackages()) do
        if path.."/filelist.xml" == mod.Path then
            contentPackage = mod
        end
    end


    main.initialize(contentPackage, false, path)
end

if CLIENT then
    --print("Client-Side Lua")
end