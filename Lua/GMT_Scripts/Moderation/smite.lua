local smites = {}

local function addSmite(name,help,func)
    smites[string.lower(name)] = {help=help,func=func}
end


-- Smites
addSmite("gib",GMT.Lang("CMD_Smite_gib"),function (executor, char)

    char.Kill(CauseOfDeathType.Pressure)
    for i, limb in ipairs(char.AnimController.Limbs) do
        char.TrySeverLimbJoints(limb, 1, 999, true)
    end
end)

addSmite("gigacancer",GMT.Lang("CMD_Smite_gigacancer"),function (executor, char)
    local limb = char.AnimController.MainLimb
    local rad = AfflictionPrefab.Prefabs["radiationsickness"]
    char.CharacterHealth.ApplyAffliction(limb, rad.Instantiate(200), true)
end)

addSmite("drunk",GMT.Lang("CMD_Smite_drunk"),function (executor, char)
    local limb = char.AnimController.MainLimb
    local drunk = AfflictionPrefab.Prefabs["drunk"]
    local nausea = AfflictionPrefab.Prefabs["nausea"]
    char.CharacterHealth.ApplyAffliction(limb, drunk.Instantiate(100), true)
    char.CharacterHealth.ApplyAffliction(limb, nausea.Instantiate(100), true)
end)

addSmite("orangeboy",GMT.Lang("CMD_Smite_orangeboy"),function (executor, char)
    char.Kill(CauseOfDeathType.Affliction, AfflictionPrefab.Prefabs["nausea"].Instantiate(100))
    local boi = Character.Create("orangeboy", char.WorldPosition,0)

    local client = GMT.GetCharacterClient(char.ID)
    if client ~= nil then
        client.SetClientCharacter(boi)
    end
end)

addSmite("longstun",GMT.Lang("CMD_Smite_longstun"),function (executor, char)
    local limb = char.AnimController.MainLimb
    local stun = AfflictionPrefab.Prefabs["stun"]
    char.CharacterHealth.ApplyAffliction(limb, stun.Instantiate(30), true)
end)

addSmite("help",GMT.Lang("CMD_Smite_help"),function (executor, char)
    if executor ~= nil then
        GMT.SendConsoleMessage(GMT.Lang("CMD_Smite_SmiteList"), executor, Color(255,128,0,255))
        for name, smite in pairs(smites) do
            GMT.SendConsoleMessage("* "..name.."  >  "..smite.help, executor, Color(255,255,255,255))
        end
    else
        GMT.NewConsoleMessage(GMT.Lang("CMD_Smite_SmiteList"), Color(255,128,0,255), false)
        for name, smite in pairs(smites) do
            GMT.NewConsoleMessage("* "..name.."  >  "..smite.help, Color(255,255,255,255), false)
        end
    end
end)




GMT.AddCommand("smite",GMT.Lang("Help_Smite"),true,nil,{
{name="smite",desc=GMT.Lang("Args_Smite_smite")},
{name="character",desc=GMT.Lang("Args_Smite_character")}})

GMT.AssignClientCommand("smite",function(client,cursor,args)
    if #args == 0 then
        smites["help"].func(client, nil)
        return
    end
    local char
    if args[2] ~= nil then
        char = GMT.GetCharacterByString(args[2])
        if char == nil or char.IsDead then
            GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("Error_CharacterNotFound"),client,Color(255,0,0,255))
            return
        end
    else
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),client,Color(255,0,0,255))
        return
    end

    local smite = smites[args[1]]
    if smite == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_Smite_Unknown"),client,Color(255,0,0,255))
        return
    end

    smite.func(client, char)
end)

GMT.AssignServerCommand("smite",function(args)
    if #args == 0 then
        smites["help"].func(nil, nil)
        return
    end
    local char
    if args[2] ~= nil then
        char = GMT.GetCharacterByString(args[2])
        if char == nil or char.IsDead then
            GMT.NewConsoleMessage("GM-Tools: "..GMT.Lang("Error_CharacterNotFound"),Color(255,0,0,255),false)
            return
        end
    else
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments"),Color(255,0,0,255),false)
        return
    end

    local smite = smites[args[1]]
    if smite == nil then
        GMT.NewConsoleMessage("GMTools: "..GMT.Lang("CMD_Smite_Unknown"),Color(255,0,0,255),false)
        return
    end

    smite.func(nil, char)
end)