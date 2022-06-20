local smites = {}

local function addSmite(name,help,func)
    smites[string.lower(name)] = {help=help,func=func}
end


-- Smites
addSmite("gib","Kills players in a bloody epic way :sunglasses:",function (executor, client)
    local char = client.Character
    if char == nil then
        GMT.SendConsoleMessage("GM-Tools: Player doesn't have character under control", executor, Color(255,0,0,255))
        return
    end

    --TrySeverLimbJoints(limbHit, attack.SeverLimbsProbability, attackResult.Damage, allowBeheading: attacker == null || attacker.IsHuman || attacker.IsPlayer, attacker: attacker);
    char.Kill(CauseOfDeathType.Pressure)
    for i, limb in ipairs(char.AnimController.Limbs) do
        char.TrySeverLimbJoints(limb, 1, 999, true)
    end
end)

addSmite("gigacancer","Gives player giant radiation sickness",function (executor, client)
    local char = client.Character
    if char == nil then
        GMT.SendConsoleMessage("GM-Tools: Player doesn't have character under control", executor, Color(255,0,0,255))
        return
    end
    local limb = char.AnimController.MainLimb
    local rad = AfflictionPrefab.Prefabs["radiationsickness"]
    char.CharacterHealth.ApplyAffliction(limb, rad.Instantiate(200), true)
end)

addSmite("drunk","Makes player drunk",function (executor, client)
    local char = client.Character
    if char == nil then
        GMT.SendConsoleMessage("GM-Tools: Player doesn't have character under control", executor, Color(255,0,0,255))
        return
    end
    local limb = char.AnimController.MainLimb
    local drunk = AfflictionPrefab.Prefabs["drunk"]
    local nausea = AfflictionPrefab.Prefabs["nausea"]
    char.CharacterHealth.ApplyAffliction(limb, drunk.Instantiate(100), true)
    char.CharacterHealth.ApplyAffliction(limb, nausea.Instantiate(100), true)
end)

addSmite("orangeboy","Turns player in orangeboy",function (executor, client)
    local char = client.Character
    if char == nil then
        GMT.SendConsoleMessage("GM-Tools: Player doesn't have character under control", executor, Color(255,0,0,255))
        return
    end
    local limb = char.AnimController.MainLimb
    local stun = AfflictionPrefab.Prefabs["stun"]
    char.CharacterHealth.ApplyAffliction(limb, stun.Instantiate(30), true)

    local boi = Character.Create("orangeboy", client.Character.WorldPosition,0)
    client.SetClientCharacter(boi)
end)

addSmite("longstun","Stuns player for 30 seconds",function (executor, client)
    local char = client.Character
    if char == nil then
        GMT.SendConsoleMessage("GM-Tools: Player doesn't have character under control", executor, Color(255,0,0,255))
        return
    end
    local limb = char.AnimController.MainLimb
    local stun = AfflictionPrefab.Prefabs["stun"]
    char.CharacterHealth.ApplyAffliction(limb, stun.Instantiate(30), true)
end)

addSmite("help","Gives list of smites",function (executor, client)
    GMT.SendConsoleMessage("Smite list", executor, Color(255,128,0,255))
    for name, smite in pairs(smites) do
        GMT.SendConsoleMessage("* "..name.."  >  "..smite.help, executor, Color(255,255,255,255))
    end
end)




GMT.AddCommand("smite","We do a little trolling (Doing funi things with players)",false,function(client,cursor,args)
    local player = GMT.GetClientByString(args[2])
    if args[2] == nil then
        player = client
    else
        player = GMT.GetClientByString(args[2])
        if player == nil then
            GMT.SendConsoleMessage("GM-Tools: Player not found",client)
            return
        end
    end

    local smite = smites[args[1]]
    if smite == nil then
        GMT.SendConsoleMessage("GMTools: Unknown smite",client,Color(255,0,0,255))
        return
    end

    smite.func(client, player)
end,{
{name="mode",desc="Smite to do. Type \"help\" here to get list of smites"},
{name="client",desc="Who will suffer"}})