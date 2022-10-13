-- launch automaticly when true
local DEV_MODE = false

local mods = Game.GetEnabledContentPackages()
local path = table.pack(...)[1]

for i, mod in ipairs(mods) do
    if path.."/filelist.xml" == mod.Path then
        return
    end
end

if DEV_MODE then
    require("Autorun.gmtools_init")
    return
end

if CLIENT then return end
if SERVER then
    -- Do not run until .gmtools_forcedrun will be executed
    Timer.Wait(function ()
        for key, client in pairs(Client.ClientList) do
            local msg = ChatMessage.Create("", " \nIt seems you didn't enabled GMTools in mod list\nIf you want enable it by force, use command \".gmtools_forcedrun\"\nMod will be launched right now and will be hidden from players\n ", ChatMessageType.Console, nil, nil, nil, Color(255,0,255,255))
            Game.SendDirectChatMessage(msg, client)
        end
    end, 1000)


    Game.AddCommand(".gmtools_forcedrun", "Run in force mode", function () end, nil, false)
    Game.AssignOnClientRequestExecute(".gmtools_forcedrun", function (client,cursor,args)
        if GMT ~= nil then
            local msg = ChatMessage.Create("", "GM-Tools already launched", ChatMessageType.Console, nil, nil, nil, Color(255,0,0,255))
            Game.SendDirectChatMessage(msg, client)
            return
        end
        if not Game.IsDedicated and client.SessionId ~= 1 then
            local msg = ChatMessage.Create("", "This command can be executed only by host", ChatMessageType.Console, nil, nil, nil, Color(255,0,0,255))
            Game.SendDirectChatMessage(msg, client)
            return
        end

        for key, cl in pairs(Client.ClientList) do
            local msg = ChatMessage.Create("", "Launching GMTools in force mod...", ChatMessageType.Console, nil, nil, nil, Color(255,0,255,255))
            Game.SendDirectChatMessage(msg, cl)
        end
        require("Autorun.gmtools_init")
        GMT.ForcedLaunch = true
    end)
end
