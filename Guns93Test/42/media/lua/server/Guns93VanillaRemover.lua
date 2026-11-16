Guns93RemoveItems = {
    "Base.FiberglassStock",
---    "Base.Bag_RifleCaseClothCamo",
    "Base.Pistol",
    "Base.Pistol2",
    "Base.Pistol3",
    "Base.Revolver",
    "Base.Revolver_Short",
    "Base.Revolver_Long",
    "Base.TrapperCarbine",
    "Base.L94_Rifle",
    "Base.L92_Carbine",
    "Base.VarmintRifle",
    "Base.HuntingRifle",
    "Base.MSR7T_Rifle",
    "Base.JS14_Rifle",
    "Base.AssaultRifle",
    "Base.AssaultRifle2",
    "Base.Shotgun",
    "Base.ShotgunSawnoff",
    "Base.DoubleBarrelShotgun",
    "Base.DoubleBarrelShotgunSawnoff",
    "Base.JS3T_Shotgun",
    "Base.9mmClip",
    "Base.45Clip",
    "Base.44Clip",
    "Base.JS14_Clip",
    "Base.556Clip",
    "Base.308Clip",
    "Base.M14Clip"
}

local function guns93DistItemName(name)
    if not name then return nil end
    name = tostring(name)
    name = name:gsub("^Base%.", "")
    return name
end

local function guns93BuildRemoveSet(removeList)
    local set = {}
    if not removeList then return set end
    for _, name in ipairs(removeList) do
        local n = guns93DistItemName(name)
        if n and n ~= "" then
            set[n] = true
        end
    end
    return set
end

local function RemoveItemFromItemsList(items, itemName)
    if type(items) ~= "table" or not itemName then
        return 0
    end
    local removed = 0
    local i = 1
    while i <= #items do
        if items[i] == itemName then
            table.remove(items, i)
            if type(items[i]) == "number" then
                table.remove(items, i)
            end
            removed = removed + 1
        else
            i = i + 1
        end
    end
    return removed
end

local function guns93IsDistItemsList(t)
    if type(t) ~= "table" or #t < 2 then
        return false
    end
    for i = 1, math.min(#t, 6), 2 do
        if type(t[i]) == "string" and type(t[i + 1]) == "number" then
            return true
        end
    end
    return false
end

local function guns93StripItemsList(items, removeSet)
    if not items or not removeSet then return 0 end
    local total = 0
    for name in pairs(removeSet) do
        total = total + RemoveItemFromItemsList(items, name)
    end
    return total
end

local function guns93StripDistributions(root, removeList)
    local removeSet = guns93BuildRemoveSet(removeList)
    local totalRemoved = 0
    local visited = {}

    local function walk(node, path)
        if type(node) ~= "table" or visited[node] then
            return
        end
        visited[node] = true
        if guns93IsDistItemsList(node) then
            totalRemoved = totalRemoved + guns93StripItemsList(node, removeSet)
            return
        end

        for k, v in pairs(node) do
            if type(v) == "table" then
                walk(v, path .. "." .. tostring(k))
            end
        end
    end
    walk(root, "SuburbsDistributions")
    return totalRemoved
end

local function ModifyAllLootTables()
    guns93StripDistributions(SuburbsDistributions, Guns93RemoveItems)
end

Events.OnPreDistributionMerge.Add(ModifyAllLootTables)