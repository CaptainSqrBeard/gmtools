local module = {}

module.InstalledAddons = {}

--[[
# RegisterAddon()
Registers addon to GM Tools. Returns true if registration was successful.
* contentPackage - Content package of that addon.
--]]
function module.RegisterAddon(contentPackage)
    table.insert(module.InstalledAddons, {ContentPackage=contentPackage})
    return true
end

return module