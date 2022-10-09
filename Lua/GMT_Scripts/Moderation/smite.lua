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
    GMT.SendConsoleMessage(GMT.Lang("CMD_Smite_SmiteList"), executor, Color(255,128,0,255))
    for name, smite in pairs(smites) do
        GMT.SendConsoleMessage("* "..name.."  >  "..smite.help, executor, Color(255,255,255,255))
    end
end)




GMT.AddCommand("smite",GMT.Lang("Help_Smite"),true,function(client,cursor,args)
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
        char = client.Character
        if char == nil or char.IsDead then
            GMT.SendConsoleMessage("GM-Tools: "..GMT.Lang("Error_CharacterNotFound"),client,Color(255,0,0,255))
            return
        end
    end

    local smite = smites[args[1]]
    if smite == nil then
        GMT.SendConsoleMessage("GMTools: "..GMT.Lang("CMD_Smite_Unknown"),client,Color(255,0,0,255))
        return
    end

    smite.func(client, char)
end,{
{name="smite",desc=GMT.Lang("Args_Smite_smite")},
{name="client",desc=GMT.Lang("Args_Smite_client")}})