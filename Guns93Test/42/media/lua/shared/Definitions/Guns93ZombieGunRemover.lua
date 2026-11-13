local Guns93RemoveZedItems = {
    "FiberglassStock",
    "Pistol",
    "Pistol2",
    "Pistol3",
    "Revolver",
    "Revolver_Short",
    "Revolver_Long",
    "TrapperCarbine",
    "L94_Rifle",
    "L92_Carbine",
    "VarmintRifle",
    "HuntingRifle",
    "MSR7T_Rifle",
    "JS14_Rifle",
    "AssaultRifle",
    "AssaultRifle2",
    "Shotgun",
    "ShotgunSawnoff",
    "DoubleBarrelShotgun",
    "DoubleBarrelShotgunSawnoff",
    "JS3T_Shotgun",
    "9mmClip",
    "45Clip",
    "44Clip",
    "JS14_Clip",
    "556Clip",
    "308Clip",
    "M14Clip",
    "556Bullets",
    "556Box",
    "308Bullets",
    "308Box",
    "3030Bullets",
    "3030Box",
    "Bullets9mm",
    "Bullets9mmBox",
    "Bullets38",
    "Bullets38Box",
    "Bullets44",
    "Bullets44Box",
    "Bullets45",
    "Bullets45Box",
    "Bullets357",
    "Bullets357Box",
    "ShotgunShells",
    "ShotgunShellsBox"
}

local function guns93FullTypeKey(name)
    if not name then return nil end
    name = tostring(name)
    local short = name:gsub("^Base%.", "")
    return name, short, "Base." .. short
end

local function guns93BuildAttachedRemoveZedItems(removeList)
    local set = {}
    if not removeList then return set end
    for _, name in ipairs(removeList) do
        local full, short, base = guns93FullTypeKey(name)
        if short and short ~= "" then
            set[short] = true
            set[base] = true
            set[full] = true
        end
    end
    return set
end

local function RemoveFromWeaponsList(weapons, Guns93RemoveZedItems)
    if type(weapons) ~= "table" or not Guns93RemoveZedItems then
        return 0
    end
    local removed = 0
    local i = 1
    while i <= #weapons do
        local w = weapons[i]
        local key = tostring(w or "")
        local short = key:gsub("^Base%.", "")
        if Guns93RemoveZedItems[key] or Guns93RemoveZedItems[short] or Guns93RemoveZedItems["Base." .. short] then
            table.remove(weapons, i)
            removed = removed + 1
        else
            i = i + 1
        end
    end
    return removed
end

local function ModifyAttachedWeaponDefinitions()
    local Guns93RemoveZedItems = guns93BuildAttachedRemoveZedItems(Guns93RemoveItems)
    local total = 0
    for defName, def in pairs(AttachedWeaponDefinitions) do
        if type(def) == "table" and type(def.weapons) == "table" then
            local n = RemoveFromWeaponsList(def.weapons, Guns93RemoveZedItems)
            if n > 0 then
                total = total + n
                if #def.weapons == 0 then
                    def.chance = 0
                end
            end
        end
    end
end

Events.OnPreDistributionMerge.Add(ModifyAttachedWeaponDefinitions)