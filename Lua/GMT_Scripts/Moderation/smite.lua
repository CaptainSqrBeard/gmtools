local smites = {}

local function addSmite(name, help, func)
    smites[string.lower(name)] = {help=help, func=func}
end


-- Smites
addSmite("gib",GMT.Lang("CMD_Smite_gib"), function (char, interface)

    char.Kill(CauseOfDeathType.Pressure)
    for i, limb in ipairs(char.AnimController.Limbs) do
        char.TrySeverLimbJoints(limb, 1, 999, true)
    end
end)

addSmite("gigacancer",GMT.Lang("CMD_Smite_gigacancer"), function (char, interface)
    local limb = char.AnimController.MainLimb
    local rad = AfflictionPrefab.Prefabs["radiationsickness"]
    char.CharacterHealth.ApplyAffliction(limb, rad.Instantiate(200), true)
end)

addSmite("drunk",GMT.Lang("CMD_Smite_drunk"), function (char, interface)
    local limb = char.AnimController.MainLimb
    local drunk = AfflictionPrefab.Prefabs["drunk"]
    local nausea = AfflictionPrefab.Prefabs["nausea"]
    char.CharacterHealth.ApplyAffliction(limb, drunk.Instantiate(100), true)
    char.CharacterHealth.ApplyAffliction(limb, nausea.Instantiate(100), true)
end)

addSmite("orangeboy",GMT.Lang("CMD_Smite_orangeboy"), function (char, interface)
    char.Kill(CauseOfDeathType.Affliction, AfflictionPrefab.Prefabs["nausea"].Instantiate(100))
    local boi = Character.Create("orangeboy", char.WorldPosition,0)

    local client = GMT.GetCharacterClient(char.ID)
    if client ~= nil then
        client.SetClientCharacter(boi)
    end
end)

addSmite("longstun",GMT.Lang("CMD_Smite_longstun"), function (char, interface)
    local limb = char.AnimController.MainLimb
    local stun = AfflictionPrefab.Prefabs["stun"]
    char.CharacterHealth.ApplyAffliction(limb, stun.Instantiate(30), true)
end)

GMT.AddCommand("smite",GMT.Lang("Help_Smite"),true,nil,{
{name="smite",desc=GMT.Lang("Args_Smite_smite")},
{name="character",desc=GMT.Lang("Args_Smite_character")}})

GMT.AssignSharedCommand("smite",function (args, interface)
    if #args == 0 or args[1] == "help" then
        interface.showMessage(GMT.Lang("CMD_Smite_SmiteList"), Color(255,128,0,255))
        for name, smite in pairs(smites) do
            interface.showMessage("* "..name.."  >  "..smite.help, Color(255,255,255,255))
        end
        interface.showMessage(GMT.GetCommandUsageHelp("smite"), Color(255,196,128,255))
        return
    end

    local smite = smites[args[1]]
    if smite == nil then
        interface.showMessage("GMTools: "..GMT.Lang("CMD_Smite_Unknown"),Color(255,0,0,255))
        return
    end
    
    local char
    if args[2] ~= nil then
        char = GMT.GetCharacterByString(args[2])
        if char == nil or char.IsDead then
            interface.showMessage("GM-Tools: "..GMT.Lang("Error_CharacterNotFound"),Color(255,0,0,255))
            return
        end
    else
        interface.showMessage("GMTools: "..GMT.Lang("Error_NotEnoughArguments").."\n"..GMT.GetCommandUsageHelp("smite"),Color(255,0,0,255))
        return
    end
    
    smite.func(char, interface)
    interface.showMessage(GMT.Lang("CMD_Smite_Applied",{args[1], char.Name}),Color(255,0,255,255))
end)
