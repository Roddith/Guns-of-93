local SmallContainers = {
    "Base.Bag_ProtectiveCaseSmall",
    "Base.Bag_ProtectiveCaseSmallMilitary",
    "Base.HollowBook",
    "Base.PistolCase1",
    "Base.Cashbox",
    "Base.CigarBox",
    "Base.Shoebox",
    "Base.Suitcase",
    "Base.Handbag",
    "Base.Purse",
    "Base.Bag_BowlingBallBag",
    "Base.Hatbox",
    "Base.Tacklebox",
}

local LargeContainers = {
    "Base.Flightcase",
    "Base.Guitarcase",
    "Base.Bag_RifleCase",
    "Base.Bag_RifleCaseGreen",
    "Base.Bag_RifleCaseCloth",
    "Base.Bag_RifleCaseClothCamo",
}

SpawnPistolCommon = {}
SpawnPistolUncommon = {}
SpawnPistolRare = {}
SpawnPistolVaryRare = {}

SpawnBUGCommon = {}
SpawnBUGUncommon = {}
SpawnBUGRare = {}
SpawnBUGVaryRare = {}

SpawnRevolverCommon = {}
SpawnRevolverUncommon = {}
SpawnRevolverRare = {}
SpawnRevolverVaryRare = {}

SpawnSportShotgunCommon = {}
SpawnSportShotgunUncommon = {}
SpawnSportShotgunRare = {}
SpawnSportShotgunVaryRare = {}

SpawnTacShotgunCommon = {}
SpawnTacShotgunUncommon = {}
SpawnTacShotgunRare = {}
SpawnTacShotgunVaryRare = {}

SpawnSportRifleCommon = {}
SpawnSportRifleUncommon = {}
SpawnSportRifleRare = {}
SpawnSportRifleVaryRare = {}

SpawnTacRifleCommon = {}
SpawnTacRifleUncommon = {}
SpawnTacRifleRare = {}
SpawnTacRifleVaryRare = {}

SpawnPoliceHandgunCommon = {}
SpawnPoliceHandgunUncommon = {}
SpawnPoliceHandgunRare = {}
SpawnPoliceHandgunVaryRare = {}

SpawnPoliceLongGunCommon = {}
SpawnPoliceLongGunUncommon = {}
SpawnPoliceLongGunRare = {}
SpawnPoliceLongGunVaryRare = {}

SpawnSWATLongGunCommon = {}
SpawnSWATLongGunUncommon = {}
SpawnSWATLongGunRare = {}
SpawnSWATLongGunVaryRare = {}

SpawnMilitaryHandgunCommon = {}
SpawnMilitaryHandgunUncommon = {}
SpawnMilitaryHandgunRare = {}
SpawnMilitaryHandgunVaryRare = {}

SpawnMilitaryLongGunCommon = {}
SpawnMilitaryLongGunUncommon = {}
SpawnMilitaryLongGunRare = {}
SpawnMilitaryLongGunVaryRare = {}

SpawnMilitarySniperCommon = {}
SpawnMilitarySniperUncommon = {}
SpawnMilitarySniperRare = {}
SpawnMilitarySniperVaryRare = {}

SpawnStoreHandgunCommon = {}
SpawnStoreHandgunUncommon = {}
SpawnStoreHandgunRare = {}
SpawnStoreHandgunVaryRare = {}

SpawnStoreRifleCommon = {}
SpawnStoreRifleUncommon = {}
SpawnStoreRifleRare = {}
SpawnStoreRifleVaryRare = {}

SpawnStoreShotgunCommon = {}
SpawnStoreShotgunUncommon = {}
SpawnStoreShotgunRare = {}
SpawnStoreShotgunVaryRare = {}

SpawnCnRGunCommon = {}
SpawnCnRGunUncommon = {}
SpawnCnRGunRare = {}
SpawnCnRGunVaryRare = {}

SpawnNFAGunCommon = {}
SpawnNFAGunUncommon = {}
SpawnNFAGunRare = {}
SpawnNFAGunVaryRare = {}

SpawnSBSCommon = {}
SpawnSBSUncommon = {}
SpawnSBSRare = {}
SpawnSBSVaryRare = {}

SpawnSawedRifleCommon = {}
SpawnSawedRifleUncommon = {}
SpawnSawedRifleRare = {}
SpawnSawedRifleVaryRare = {}

SpawnCrimeHandgunCommon = {}
SpawnCrimeHandgunUncommon = {}
SpawnCrimeHandgunRare = {}
SpawnCrimeHandgunVaryRare = {}

SpawnCrimeLongGunCommon = {}
SpawnCrimeLongGunUncommon = {}
SpawnCrimeLongGunRare = {}
SpawnCrimeLongGunVaryRare = {}

local COUNTER_KEY = "Guns93_ItemSpawnCounts"

local MAX_SPAWNS = {
    ["Base.SPAS12"] = 6,
    ["Base.HK91"] = 10,
    ["Base.HK93"] = 10,
}

local function GetSpawnCounters()
    local data = ModData.getOrCreate(COUNTER_KEY)
    if not data.counts then data.counts = {} end
    return data.counts
end

local function CanSpawnItem(fullType)
    if not MAX_SPAWNS[fullType] then return true end
    local counts = GetSpawnCounters()
    return (counts[fullType] or 0) < MAX_SPAWNS[fullType]
end

local function IncrementSpawnCount(fullType)
    if not MAX_SPAWNS[fullType] then return end
    local counts = GetSpawnCounters()
    counts[fullType] = (counts[fullType] or 0) + 1
    ModData.transmit(COUNTER_KEY)
end

local function pick(t)
    if not t or #t == 0 then return nil end
    return t[ZombRand(#t) + 1]
end

local function Guns93GunPicker(_, Guns)
    if not Guns then return nil end
    local fullType = Guns:getFullType()
    local name = fullType:gsub("Base%.Guns93", ""):gsub("Spawner", "")
    local common   = _G["Spawn" .. name .. "Common"]   or {}
    local uncommon = _G["Spawn" .. name .. "Uncommon"] or {}
    local rare     = _G["Spawn" .. name .. "Rare"]     or {}
    local varyRare = _G["Spawn" .. name .. "VaryRare"] or {}
    local attempts = 0
    local maxAttempts = 5
    while attempts < maxAttempts do
        local roll = ZombRand(0, 100)
        local candidate

        if roll > 65 and #common > 0 then
            candidate = pick(common)
        elseif roll > 35 and #uncommon > 0 then
            candidate = pick(uncommon)
        elseif roll > 5 and #rare > 0 then
            candidate = pick(rare)
        elseif #varyRare > 0 then
            candidate = pick(varyRare)
        end
        if candidate and CanSpawnItem(candidate) then
            return candidate
        end
        attempts = attempts + 1
    end
    return nil
end

local function applyAutoParts(gun)
    if isClient() then return end
    if not gun:getFireModePossibilities() then return end
    local md = gun:getModData()
    local partToUse = nil
    if md.hasAutoTrigger and md.hasAutoPart then
        local trigger = gun:getWeaponPart("Trigger")
        if ZombRand(10) > 5 and not (trigger:hasTag(Gun93Registries.guns93.Fullauto) or trigger:hasTag(Gun93Registries.guns93.Burst)) then
            partToUse = md.hasAutoPart
        else
            partToUse = md.hasAutoTrigger
        end
    else
        partToUse = md.hasAutoTrigger or md.hasAutoPart
    end
    if partToUse then
        local partItem = instanceItem(partToUse)
        gun:detachWeaponPart(partItem:getPartType())
        gun:attachWeaponPart(partItem)
    end
    if md.hasSpcPart then
        gun:attachWeaponPart(instanceItem(md.hasSpcPart))
    end
    if md.hasSpcPart2 and ZombRand(0, 50) > 25 then
        gun:attachWeaponPart(instanceItem(md.hasSpcPart2))
    end
end

local function SetMagazineStats(weapon)
    if not weapon or not weapon:hasTag(Gun93Registries.guns93.Guns93) then return end
    local clip = weapon:getWeaponPart("Clip")
    local magExten1 = weapon:getWeaponPart("BarrelItem")
    local magExten2 = weapon:getWeaponPart("MagExten")
    local hasPart = false
    if clip and (clip:hasTag(Gun93Registries.guns93.Guns93Mag) or clip:hasTag(Gun93Registries.guns93.MagExten)) then
        hasPart = true
    end
    if magExten1 and (magExten1:hasTag(Gun93Registries.guns93.Guns93Mag) or magExten1:hasTag(Gun93Registries.guns93.MagExten)) then
        hasPart = true
    end
    if magExten2 and (magExten2:hasTag(Gun93Registries.guns93.Guns93Mag) or magExten2:hasTag(Gun93Registries.guns93.MagExten)) then
        hasPart = true
    end
    if hasPart then
        if clip and clip:hasTag(Gun93Registries.guns93.Guns93Mag) then
            weapon:setMagazineType(clip:getFullType())
            weapon:setMaxAmmo(clip:getMaxAmmo())
        elseif magExten1 or magExten2 then
            weapon:setMaxAmmo((magExten1 or magExten2):getMaxAmmo())
        end
    else
        local baseCount = weapon:getModData().isBaseAmmo
        if baseCount then
            weapon:setMaxAmmo(baseCount)
        end
    end
end

local function setGunCondition(gun, spawner)
    if isClient() or not gun then return end
    if spawner:hasTag(Gun93Registries.guns93.NewGun) then
        gun:setCondition(ZombRand(1, 10) > 5 and ZombRand(15, 20) or 20)
    else
        gun:setCondition(ZombRand(7, 20))
    end
end

local function ammoPickerSpawner(gun, spawner, ammoType)
    if ammoType == nil then
        ammoType = Guns93RemoveAmmoType(gun)
    end
    if ammoType == nil then
        ammoType = gun:getAmmoType():getItemKey()
    end
    if type(ammoType) ~= "string" then
        ammoType = tostring(ammoType)
    end
    local list
    local fullType = spawner:getFullType()
    if fullType == "Base.Guns93MilitaryHandgunSpawner" or fullType == "Base.Guns93MilitaryLongGunSpawner" or fullType == "Base.Guns93MilitarySniperSpawner" then
        list = MilAmmoSpawnList[ammoType]
    elseif fullType == "Base.Guns93PoliceHandgunSpawner" or fullType == "Base.Guns93PoliceLongGunSpawner" or fullType == "Base.Guns93SWATLongGunSpawner" then
        list = DefAmmoSpawnList[ammoType]
    else
        list = AmmoSpawnList[ammoType]
    end
    if list then
        return list[ZombRand(0, #list) + 1]
    end
    return ammoType
end

local function ammoZedPickerSpawner(gun, ammoType)
    if ammoType == nil then
        ammoType = Guns93RemoveSpentAmmo(gun)
    end
    if ammoType == nil then
        ammoType = gun:getAmmoType():getItemKey()
    end
    local list
    local gunType = gun:getFullType()
    if gunType == "Base.M16A2" or gunType == "Base.M24" or gunType == "Base.M14308" or gunType == "Base.M249" or gunType == "Base.M60" or gunType == "Base.M3GreaseGun" or gunType == "Base.M9" or gunType == "Base.M1911" or gunType == "Base.M727" or gunType == "Base.M723" or gunType == "Base.M733" or gunType == "Base.M870" or gunType == "Base.M590" or gunType == "Base.Moss590" or gunType == "Base.Rem870P" or gunType == "Base.Rem1187P" or gunType == "Base.SPAS12" or gunType == "Base.Ithaca37MP" or gunType == "Base.Ithaca37Riot" then
        list = MilAmmoSpawnList[ammoType]
    else
        list = AmmoSpawnList[ammoType]
    end
    if list then
        return list[ZombRand(0, #list) + 1]
    end
    return nil
end

local function addLoadedItem(container, itemType, newAmmo, forceFull)
    local item = instanceItem(itemType)
    if not item then return end
    if forceFull then
        local ammoCount = item:getMaxAmmo()
        item:setCurrentAmmoCount(ammoCount)
        if newAmmo then
            while ammoCount > 0 do
                Guns93AddAmmoTypes(item, newAmmo)
                ammoCount = ammoCount - 1
            end
        end
    end
    DynamicMagClip(item)
    container:AddItem(item)
    sendAddItemToContainer(container, item)
end

local function spawnMagazinesAndClips(gun, targetContainer, spawner, newAmmo, isLoadedMags)
    if not targetContainer then return end
    local isMoreMags = spawner:hasTag(Gun93Registries.guns93.MoreMags)
    local isSmallOrLarge = spawner:hasTag(Gun93Registries.guns93.SmallContainer) or spawner:hasTag(Gun93Registries.guns93.LargeContainer)
    if gun:getMagazineType() then
        local magType = gun:getMagazineType()
        local refItem = instanceItem(gun:getFullType())
        local fallbackMagType = refItem and refItem:getMagazineType() or magType

        if magType == "Base.EblocClip" then
            for _ = 1, ZombRand(0, 8) do
                addLoadedItem(targetContainer, magType, newAmmo, false)
            end
            for _ = 1, ZombRand(8, 12) do
                addLoadedItem(targetContainer, magType, newAmmo, isLoadedMags)
            end
        else
            local mag1 = instanceItem(magType)
            local mag2 = instanceItem(fallbackMagType)
            local rareMag  = mag1 and mag1:hasTag(Gun93Registries.guns93.RareMag)
            local rareMag2 = mag2 and mag2:hasTag(Gun93Registries.guns93.RareMag)
            local roll = ZombRand(11)
            if roll > 3 or isSmallOrLarge then
                addLoadedItem(targetContainer, magType, newAmmo, isLoadedMags)
            end
            if roll > 5 and not rareMag2 then
                addLoadedItem(targetContainer, fallbackMagType, newAmmo, isLoadedMags)
            end
            if isMoreMags then
                if roll > 2 and not rareMag then
                    addLoadedItem(targetContainer, magType, newAmmo, isLoadedMags)
                end
                if roll > 3 and not rareMag2 then
                    addLoadedItem(targetContainer, fallbackMagType, newAmmo, isLoadedMags)
                end
            end
        end
    end
    if gun:getModData().hasClip then
        local clipType = gun:getModData().hasClip
        local clipCount = ZombRand(1, 3)
        if instanceItem(clipType):hasTag(Gun93Registries.guns93.StripperClip) then
            clipCount = ZombRand(4, 10)
        end
        for _ = 1, clipCount do
            addLoadedItem(targetContainer, clipType, newAmmo, isLoadedMags)
        end
    end
    if gun:getModData().hasLoader then
        local loaderType
        if ZombRand(0, 11) > 8 then
            loaderType = gun:getModData().hasLoader
        elseif ZombRand(0, 11) > 9 and gun:getModData().hasLoader2 then
            loaderType = gun:getModData().hasLoader2
        elseif ZombRand(0, 11) > 9 and gun:getModData().hasLoader3 then
            loaderType = gun:getModData().hasLoader3
        end
        if loaderType then
            for _ = 1, ZombRand(1, 3) do
                local force = isLoadedMags and ZombRand(11) > 5
                addLoadedItem(targetContainer, loaderType, newAmmo, force)
            end
        end
    end
    if gun:hasTag(Gun93Registries.guns93.SurplusAmmo) then
        local box = ammoPickerSpawner(gun, spawner, gun:getAmmoBox())
        if box then
            local spawnBox = instanceItem(box)
            targetContainer:AddItem(spawnBox)
            sendAddItemToContainer(targetContainer, spawnBox)
        end
    end
    if not spawner:hasTag(Gun93Registries.guns93.NoAmmo) then
        local roll = ZombRand(11)
        if roll > 2 then
            local box = ammoPickerSpawner(gun, spawner, gun:getAmmoBox())
            if box then
                local spawnBox = instanceItem(box)
                targetContainer:AddItem(spawnBox)
                sendAddItemToContainer(targetContainer, spawnBox)
            end
        end
        if roll > 4 then
            local box = ammoPickerSpawner(gun, spawner, gun:getAmmoBox())
            if box then
                local ammoBox = instanceItem(box)
                if ammoBox then
                    targetContainer:AddItem(ammoBox)
                    sendAddItemToContainer(targetContainer, ammoBox)
                end
            end
            if gun:getModData().modAlt_AmmoBox and spawner:getFullType() ~= "Base.Guns93MilitaryLongGunSpawner" then
                local altBox = ammoPickerSpawner(gun, spawner, gun:getModData().modAlt_AmmoBox)
                if altBox then
                    if roll > 4 then
                        local spawnBox = instanceItem(altBox)
                        targetContainer:AddItem(spawnBox)
                        sendAddItemToContainer(targetContainer, spawnBox)
                    end
                    if roll > 6 then
                        local spawnBox = instanceItem(altBox)
                        targetContainer:AddItem(spawnBox)
                        sendAddItemToContainer(targetContainer, spawnBox)
                    end
                end
            end
        end
        if spawner:hasTag(Gun93Registries.guns93.MoreAmmo) then
            if roll > 5 then
                local box = ammoPickerSpawner(gun, spawner, gun:getAmmoBox())
                if box then
                    local spawnBox = instanceItem(box)
                    targetContainer:AddItem(spawnBox)
                    sendAddItemToContainer(targetContainer, spawnBox)
                end
            end
            if roll > 6 then
                local box = ammoPickerSpawner(gun, spawner, gun:getAmmoBox())
                if box then
                    local spawnBox = instanceItem(box)
                    targetContainer:AddItem(spawnBox)
                    sendAddItemToContainer(targetContainer, spawnBox)
                end
            end
        end
    end
end

local function loadedGun(gun, spawner)
    if isClient() then return end
    if not spawner:hasTag(Gun93Registries.guns93.GunLoaded) then return end
    local roll = ZombRand(11)
    if roll <= 5 then return end
    local newAmmo = ammoPickerSpawner(gun, spawner)
    local ammoCount = ZombRand(1, gun:getMaxAmmo())
    gun:setCurrentAmmoCount(ammoCount)
    if newAmmo then
        while ammoCount > 0 do
            Guns93AddAmmoTypes(gun, newAmmo)
            ammoCount = ammoCount - 1
        end
    end
    if roll > 7 and gun:haveChamber() then
        gun:setRoundChambered(true)
        if newAmmo then
            local modData = gun:getModData()
            if modData then
                modData.Guns93Chambered = newAmmo
            end
        end
    end
    if gun:isManuallyRemoveSpentRounds() then
        local spent = gun:getMaxAmmo() - gun:getCurrentAmmoCount()
        gun:setSpentRoundCount(spent)
        if newAmmo then
            while spent > 0 do
                Guns93AddSpentAmmo(gun, newAmmo)
                spent = spent - 1
            end
        end
    end
end

local function createCase(spawner)
    if isClient() then return nil end
    if ZombRand(11) <= 5 then return nil end
    local hasSmall = spawner:hasTag(Gun93Registries.guns93.SmallContainer)
    local hasLarge = spawner:hasTag(Gun93Registries.guns93.LargeContainer)
    if not hasSmall and not hasLarge then return nil end
    local pool = hasLarge and LargeContainers or SmallContainers
    if #pool == 0 then return nil end
    local case = instanceItem(pool[ZombRand(#pool) + 1])
    return case, case:getInventory()
end

local function finalizeGun(gun, spawner, targetContainer)
    if isClient() then return end
    IncrementSpawnCount(gun:getFullType())
    if spawner:hasTag(Gun93Registries.guns93.MGun) then
        applyAutoParts(gun)
    end
    SetMagazineStats(gun)
    setGunCondition(gun, spawner)
    local newAmmo = ammoPickerSpawner(gun, spawner)
    local isLoadedMags = spawner:hasTag(Gun93Registries.guns93.LoadedMags)
    if targetContainer then
        spawnMagazinesAndClips(gun, targetContainer, spawner, newAmmo, isLoadedMags)
        targetContainer:AddItem(gun)
        sendAddItemToContainer(targetContainer, gun)
    end
    loadedGun(gun, spawner)
end

local function finalizeZedGun(Gun, spawner, targetContainer)
    if isClient() then return end
    if not Gun:hasTag(Gun93Registries.guns93.Guns93) then return end

    Gun:setCondition(ZombRand(5, 20))
    local ammoCount = ZombRand(0, Gun:getMaxAmmo())
    Gun:setCurrentAmmoCount(ammoCount)
    local newAmmo = ammoPickerSpawner(Gun, spawner)
    if newAmmo then
        while ammoCount > 0 do
            Guns93AddAmmoTypes(Gun, newAmmo)
            ammoCount = ammoCount - 1
        end
    end
    if Gun:haveChamber() and Gun:getCurrentAmmoCount() > 0 then
        if ZombRand(0, 10) > 6 then
            Gun:setJammed(true)
            Gun:setSpentRoundChambered(true)
        else
            Gun:setRoundChambered(true)
            if newAmmo then
                local modData = Gun:getModData()
                if modData then
                    modData.Guns93Chambered = newAmmo
                end
            end
        end
    end
    if Gun:isManuallyRemoveSpentRounds() then
        local spent = Gun:getMaxAmmo() - Gun:getCurrentAmmoCount()
        Gun:setSpentRoundCount(spent)
    end
    if Gun:getAttachmentType() == "Rifle" then
        Gun:attachWeaponPart(instanceItem("Base.Sling"))
    end
    targetContainer:AddItem(Gun)
    sendAddItemToContainer(targetContainer, Gun)
    if Gun:getMagazineType() then
        local GunMag = instanceItem(Gun:getMagazineType())
        local RareMag2 = GunMag and GunMag:hasTag(Gun93Registries.guns93.RareMag)

        if Gun:getMagazineType() == "Base.EblocClip" then
            local clipNum = ZombRand(0, 7)
            for _ = 0, clipNum - 1 do
                addLoadedItem(targetContainer, Gun:getMagazineType(), newAmmo, true)
            end
        else
            local magsD10 = ZombRand(0, 10)
            if magsD10 > 2 then
                local ammo = ZombRand(0, GunMag:getMaxAmmo())
                GunMag:setCurrentAmmoCount(ammo)
                if newAmmo then
                    while ammo > 0 do
                        Guns93AddAmmoTypes(GunMag, newAmmo)
                        ammo = ammo - 1
                    end
                end
                DynamicMagClip(GunMag)
                targetContainer:AddItem(GunMag)
                sendAddItemToContainer(targetContainer, GunMag)
                if not RareMag2 then
                    for _ = 0, ZombRand(1, 3) - 1 do
                        local newMag = instanceItem(Gun:getMagazineType())
                        local ammo2 = ZombRand(0, newMag:getMaxAmmo())
                        newMag:setCurrentAmmoCount(ammo2)
                        if newAmmo then
                            while ammo2 > 0 do
                                Guns93AddAmmoTypes(newMag, newAmmo)
                                ammo2 = ammo2 - 1
                            end
                        end
                        DynamicMagClip(newMag)
                        targetContainer:AddItem(newMag)
                        sendAddItemToContainer(targetContainer, newMag)
                    end
                end
            end
        end
    else
        local looseCount = ZombRand(20)
        if newAmmo then
            for _ = 1, looseCount do
                local ammo = instanceItem(newAmmo)
                if ammo then
                    targetContainer:AddItem(ammo)
                    sendAddItemToContainer(targetContainer, ammo)
                end
            end
        end
    end
    if Gun:getModData().hasClip then
        local clip = Gun:getModData().hasClip
        local clipNum = ZombRand(1, 3)
        if instanceItem(clip):hasTag(Gun93Registries.guns93.StripperClip) then
            clipNum = ZombRand(4, 10)
        end
        for _ = 0, clipNum - 1 do
            local newClip = instanceItem(clip)
            local ammo = ZombRand(0, newClip:getMaxAmmo())
            newClip:setCurrentAmmoCount(ammo)
            if newAmmo then
                while ammo > 0 do
                    Guns93AddAmmoTypes(newClip, newAmmo)
                    ammo = ammo - 1
                end
            end
            DynamicMagClip(newClip)
            targetContainer:AddItem(newClip)
            sendAddItemToContainer(targetContainer, newClip)
        end
    end
    if Gun:getModData().hasLoader then
        local loader
        if ZombRand(0, 10) > 7 then
            loader = Gun:getModData().hasLoader
        elseif ZombRand(0, 10) > 8 and Gun:getModData().hasLoader2 then
            loader = Gun:getModData().hasLoader2
        elseif ZombRand(0, 10) > 8 and Gun:getModData().hasLoader3 then
            loader = Gun:getModData().hasLoader3
        end
        if loader then
            for _ = 0, ZombRand(1, 3) - 1 do
                local newLoader = instanceItem(loader)
                if ZombRand(0, 10) > 5 then
                    local ammo = newLoader:getMaxAmmo()
                    newLoader:setCurrentAmmoCount(ammo)
                    if newAmmo then
                        while ammo > 0 do
                            Guns93AddAmmoTypes(newLoader, newAmmo)
                            ammo = ammo - 1
                        end
                    end
                end
                DynamicMagClip(newLoader)
                targetContainer:AddItem(newLoader)
                sendAddItemToContainer(targetContainer, newLoader)
            end
        end
    end
end

local function Guns93ItemPickerContainer(roomType, containerType, container, spawner, zed)
    if isClient() then return end
    if not container then return end
    if zed == nil and roomType ~= "armystorage" and roomType ~= "armytent" and containerType ~= "Bag_ProtectiveCaseSmallMilitary_Pistol1" and containerType ~= "Bag_RifleCaseGreen" and containerType ~= "Bag_ShotgunCaseGreen" then
        local fullType = spawner:getFullType()
        local isMilitary = fullType:match("Base.Guns93MilitaryHandgunSpawner") or fullType:match("Base.Guns93MilitaryLongGunSpawner") or fullType:match("Base.Guns93MilitarySniperSpawner")
        if isMilitary then
            local replacement = "Base.Guns93SBSSpawner"
            if ZombRand(10) > 3 then
                replacement = "Base.Guns93NFAGunSpawner"
            end
            spawner = instanceItem(replacement)
        end
    end
    local pickedType = Guns93GunPicker(nil, spawner)
    if not pickedType then return end
    local gun = instanceItem(pickedType)
    if not gun then return end
    local target = container
    local case, caseInv = createCase(spawner)
    if case and caseInv then
        target = caseInv
        container:AddItem(case)
        sendAddItemToContainer(container, case)
    end
    if zed == true then
        finalizeZedGun(gun, spawner, target)
    else
        finalizeGun(gun, spawner, target)
    end
end

local function Guns93ItemPickerFloor(roomType, square, spawner)
    if isClient() then return end
    local fullType = spawner:getFullType()
    local isMilitary = fullType:match("Base.Guns93MilitaryHandgunSpawner") or fullType:match("Base.Guns93MilitaryLongGunSpawner") or fullType:match("Base.Guns93MilitarySniperSpawner")
    if isMilitary and (roomType ~= "armystorage" and roomType ~= "armytent") then
        local replacement = "Base.Guns93SBSSpawner"
        if ZombRand(10) > 3 then
            replacement = "Base.Guns93NFAGunSpawner"
        end
        spawner = instanceItem(replacement)
    end
    local pickedType = Guns93GunPicker(nil, spawner)
    if not pickedType then return end
    local gun = instanceItem(pickedType)
    finalizeGun(gun, spawner, nil)
    local zHeight = 0
    local objects = square:getObjects()
    for i = 0, objects:size() - 1 do
        local obj = objects:get(i)
        local props = obj:getProperties()
        if props and props:getSurface() then
            local isTall = (props:getSurface() * 0.01) + 0.01
            if isTall > zHeight then
                zHeight = isTall
            end
        end
    end
    square:AddWorldInventoryItem(gun, ZombRandFloat(0.2, 0.8), ZombRandFloat(0.2, 0.8), zHeight)
end

local function Guns93VanillaReplacerFloor(roomType, square, spawner)
    if isClient() then return end
    local fullType = spawner:getFullType()
    local pickedType = nil
    if fullType == "Base.Pistol" or fullType == "Base.Pistol2" or fullType == "Base.Pistol3" then
        pickedType = "Base.Guns93PistolSpawner"
    elseif fullType == "Base.Revolver" or fullType == "Base.Revolver_Short" or fullType == "Base.Revolver_Long" then
        pickedType = "Base.Guns93RevolverSpawner"
    elseif fullType == "Base.TrapperCarbine" or fullType == "Base.L94_Rifle" or fullType == "Base.L92_Carbine" or fullType == "Base.VarmintRifle" or fullType == "Base.HuntingRifle" or fullType == "Base.JS14_Rifle" then
        pickedType = "Base.Guns93SportRifleSpawner"
    elseif fullType == "Base.MSR7T_Rifle" or fullType == "Base.AssaultRifle" or fullType == "Base.AssaultRifle2" then
        if roomType ~= "armystorage" and roomType ~= "armytent" then
            if ZombRand(10) > 3 then
                pickedType = "Base.Guns93NFAGunSpawner"
            else
                pickedType = "Base.Guns93TacRifleSpawner"
            end
        else
            pickedType = "Base.Guns93MilitaryLongGunSpawner"
        end
    elseif fullType == "Base.Shotgun" or fullType == "Base.ShotgunSawnoff" or fullType == "Base.DoubleBarrelShotgun" or fullType == "Base.DoubleBarrelShotgunSawnoff" then
        pickedType = "Base.Guns93SportShotgunSpawner"
    elseif fullType == "Base.JS3T_Shotgun" then
        pickedType = "Base.Guns93TacShotgunSpawner"
    end
    if not pickedType then return end
    local gun = instanceItem(pickedType)
    local zHeight = 0
    local objects = square:getObjects()
    for i = 0, objects:size() - 1 do
        local obj = objects:get(i)
        local props = obj:getProperties()
        if props and props:getSurface() then
            local isTall = (props:getSurface() * 0.01) + 0.01
            if isTall > zHeight then
                zHeight = isTall
            end
        end
    end
    square:AddWorldInventoryItem(gun, ZombRandFloat(0.2, 0.8), ZombRandFloat(0.2, 0.8), zHeight)
    return true
end

local function Guns93ProcessInventory(roomType, inventory, zed)
    if not inventory then return end
    local items = inventory:getItems()
    local toRemove = {}
    for i = 0, items:size() - 1 do
        local item = items:get(i)
        if item then
            if item:hasTag(Gun93Registries.guns93.Guns93Spawner) and instanceof(item, "HandWeapon") then
                Guns93ItemPickerContainer(roomType, nil, inventory, item, zed)
                table.insert(toRemove, item)
            elseif item:getFullType() == "Base.Guns93Junk" then
                table.insert(toRemove, item)
            elseif instanceof(item, "InventoryContainer") and item:getInventory() then
                Guns93ProcessInventory(roomType, item:getInventory(), zed)
            elseif not SandboxVars.Guns93.Guns93VanillaGuns then
                for _, badItem in ipairs(Guns93RemoveItems or {}) do
                    if item:getFullType() == badItem then
                        table.insert(toRemove, item)
                        break
                    end
                end
            end
        end
    end
    for _, item in ipairs(toRemove) do
        if inventory:contains(item) then
            inventory:DoRemoveItem(item)
            sendRemoveItemFromContainer(inventory, item)
            inventory:setDirty(true)
            inventory:setExplored(true)
        end
    end
end

local function Guns93SpawnerItem(roomType, containerType, container, zed)
    if isClient() then return end
    if not instanceof(container, "ItemContainer") then return end
    local items = container:getItems()
    local toRemove = {}
    for i = 0, items:size() - 1 do
        local item = items:get(i)
        if item then
            if item:getFullType() == "Base.Guns93Junk" then
                table.insert(toRemove, item)
            elseif instanceof(item, "HandWeapon") and item:hasTag(Gun93Registries.guns93.Guns93Spawner) then
                Guns93ItemPickerContainer(roomType, containerType, container, item, zed)
                table.insert(toRemove, item)
            elseif not SandboxVars.Guns93.Guns93VanillaGuns then
                for _, badItem in ipairs(Guns93RemoveItems or {}) do
                    if item:getFullType() == badItem then
                        table.insert(toRemove, item)
                        break
                    end
                end
            end
        end
    end
    for _, item in ipairs(toRemove) do
        if container:contains(item) then
            container:DoRemoveItem(item)
            sendRemoveItemFromContainer(container, item)
        end
    end
end

Events.OnFillContainer.Add(Guns93SpawnerItem)

local function Guns93ZombieGunSpawns(zombie)
    if isClient() or not zombie then return end
    for i = zombie:getAttachedItems():size() - 1, 0, -1 do
        local zomGun = zombie:getAttachedItems():get(i)
        if zomGun then
            local Guns = zomGun:getItem()
            if Guns and Guns:hasTag(Gun93Registries.guns93.Guns93Spawner) then
                local GunLocation = zomGun:getLocation()
                local Gun = Guns93GunPicker(nil, Guns)
                if Gun then
                    zombie:setAttachedItem(GunLocation, nil)
                    local spawn = instanceItem(Gun)
                    IncrementSpawnCount(spawn:getFullType())
                    if spawn:getAttachmentType() == "Rifle" then
                        spawn:attachWeaponPart(instanceItem("Base.Sling"))
                    end
                    zombie:setAttachedItem(GunLocation, spawn)
                end
            end
            if not SandboxVars.Guns93.Guns93VanillaGuns then
                for _, badItem in ipairs(Guns93RemoveItems or {}) do
                    if Guns and Guns:getFullType() == badItem then
                        zombie:setAttachedItem(zomGun:getLocation(), nil)
                    end
                end
            end
            zombie:transmitModData()
            zombie:resetModel()
            zombie:resetModelNextFrame()
        end
    end
end

local function Guns93ZombieDrops(zombie)
    if isClient() then return end
    Guns93SpawnerItem(nil, nil, zombie:getInventory(), true)
    for i = zombie:getAttachedItems():size() - 1, 0, -1 do
        local zomGun = zombie:getAttachedItems():get(i)
        local Gun = zomGun:getItem()
        if Gun and Gun:hasTag(Gun93Registries.guns93.Guns93) then
            local newAmmo = ammoZedPickerSpawner(Gun)
            Gun:setCondition(ZombRand(5, 20))
            local ammoCount = ZombRand(0, Gun:getMaxAmmo())
            Gun:setCurrentAmmoCount(ammoCount)
            if newAmmo then
                while ammoCount > 0 do
                    Guns93AddAmmoTypes(Gun, newAmmo)
                    ammoCount = ammoCount - 1
                end
            end
            if Gun:haveChamber() and Gun:getCurrentAmmoCount() > 0 then
                if ZombRand(0, 10) > 6 then
                    Gun:setJammed(true)
                    Gun:setSpentRoundChambered(true)
                else
                    Gun:setRoundChambered(true)
                    if newAmmo then
                        local modData = Gun:getModData()
                        if modData then
                            modData.Guns93Chambered = newAmmo
                        end
                    end
                end
            end
            if Gun:isManuallyRemoveSpentRounds() then
                local spent = Gun:getMaxAmmo() - Gun:getCurrentAmmoCount()
                Gun:setSpentRoundCount(spent)
            end
            if Gun:getMagazineType() then
                local GunMag = instanceItem(Gun:getMagazineType())
                local RareMag2 = GunMag and GunMag:hasTag(Gun93Registries.guns93.RareMag)

                if Gun:getMagazineType() == "Base.EblocClip" then
                    local clipNum = ZombRand(0, 8)
                    for _ = 0, clipNum - 1 do
                        addLoadedItem(zombie:getInventory(), Gun:getMagazineType(), newAmmo, true)
                    end
                else
                    local magsD10 = ZombRand(0, 10)
                    if magsD10 > 2 then
                        local ammo = ZombRand(0, GunMag:getMaxAmmo())
                        GunMag:setCurrentAmmoCount(ammo)
                        if newAmmo then
                            while ammo > 0 do
                                Guns93AddAmmoTypes(GunMag, newAmmo)
                                ammo = ammo - 1
                            end
                        end
                        DynamicMagClip(GunMag)
                        zombie:getInventory():AddItem(GunMag)
                        sendAddItemToContainer(zombie:getInventory(), GunMag)
                        if not RareMag2 then
                            for _ = 0, ZombRand(1, 3) - 1 do
                                local newMag = instanceItem(Gun:getMagazineType())
                                local ammo2 = ZombRand(0, newMag:getMaxAmmo())
                                newMag:setCurrentAmmoCount(ammo2)
                                if newAmmo then
                                    while ammo2 > 0 do
                                        Guns93AddAmmoTypes(newMag, newAmmo)
                                        ammo2 = ammo2 - 1
                                    end
                                end
                                DynamicMagClip(newMag)
                                zombie:getInventory():AddItem(newMag)
                                sendAddItemToContainer(zombie:getInventory(), newMag)
                            end
                        end
                    end
                end
            else
                local looseCount = ZombRand(20)
                if newAmmo then
                    for _ = 1, looseCount do
                        local spawnAmmo = zombie:getInventory():AddItem(newAmmo)
                        sendAddItemToContainer(zombie:getInventory(), spawnAmmo)
                    end
                end
            end
            if Gun:getModData().hasClip then
                local clip = Gun:getModData().hasClip
                local clipNum = ZombRand(1, 3)
                if instanceItem(clip):hasTag(Gun93Registries.guns93.StripperClip) then
                    clipNum = ZombRand(4, 10)
                end
                for _ = 0, clipNum - 1 do
                    local newClip = instanceItem(clip)
                    local ammoCount = newClip:getMaxAmmo()
                    newClip:setCurrentAmmoCount(ammoCount)
                    if newAmmo then
                        while ammoCount > 0 do
                            Guns93AddAmmoTypes(newClip, newAmmo)
                            ammoCount = ammoCount - 1
                        end
                    end
                    DynamicMagClip(newClip)
                    zombie:getInventory():AddItem(newClip)
                    sendAddItemToContainer(zombie:getInventory(), newClip)
                end
            end
            if Gun:getModData().hasLoader then
                local loader
                if ZombRand(0, 10) > 7 then
                    loader = Gun:getModData().hasLoader
                elseif ZombRand(0, 10) > 8 and Gun:getModData().hasLoader2 then
                    loader = Gun:getModData().hasLoader2
                elseif ZombRand(0, 10) > 8 and Gun:getModData().hasLoader3 then
                    loader = Gun:getModData().hasLoader3
                end
                if loader then
                    for _ = 0, ZombRand(1, 3) - 1 do
                        local newLoader = instanceItem(loader)
                        if ZombRand(0, 10) > 5 then
                            local ammoCount = newLoader:getMaxAmmo()
                            newLoader:setCurrentAmmoCount(ammoCount)
                            if newAmmo then
                                while ammoCount > 0 do
                                    Guns93AddAmmoTypes(newLoader, newAmmo)
                                    ammoCount = ammoCount - 1
                                end
                            end
                        end
                        DynamicMagClip(newLoader)
                        zombie:getInventory():AddItem(newLoader)
                        sendAddItemToContainer(zombie:getInventory(), newLoader)
                    end
                end
            end
        end
    end
end

Events.OnZombieUpdate.Add(Guns93ZombieGunSpawns)
Events.OnZombieDead.Add(Guns93ZombieDrops)
Events.OnZombieCreate.Add(Guns93ZombieGunSpawns)

local lastPlayerPos = {}

local function hasPlayerMoved(player, threshold)
    threshold = threshold or 5
    local id = player:getOnlineID() or player:getUsername() or tostring(player)
    local px, py, pz = player:getX(), player:getY(), player:getZ()
    local last = lastPlayerPos[id]
    if not last then
        lastPlayerPos[id] = {x = px, y = py, z = pz}
        return true
    end
    local dx = math.abs(px - last.x)
    local dy = math.abs(py - last.y)
    local dz = math.abs(pz - last.z)
    if dx >= threshold or dy >= threshold or dz >= 1 then
        last.x, last.y, last.z = px, py, pz
        return true
    end
    return false
end

local function Guns93SpawnerItemScanner()
    if isClient() then return end
    local playersToCheck = {}
    local onlinePlayers = getOnlinePlayers()
    if onlinePlayers and onlinePlayers:size() > 0 then
        for i = 0, onlinePlayers:size() - 1 do
            table.insert(playersToCheck, onlinePlayers:get(i))
        end
    else
        local player = getPlayer()
        if player then
            table.insert(playersToCheck, player)
        end
    end
    for _, player in ipairs(playersToCheck) do
        if not player:getVehicle() and hasPlayerMoved(player, 5) then 
            local playerSquare = player:getSquare()
            if playerSquare then
                local cell = getCell()
                local SEARCH_RADIUS = 8
                for dx = -SEARCH_RADIUS, SEARCH_RADIUS do
                    for dy = -SEARCH_RADIUS, SEARCH_RADIUS do
                        for dz = -1, 1 do
                            local x = math.floor(player:getX() + dx)
                            local y = math.floor(player:getY() + dy)
                            local z = math.floor(player:getZ() + dz)
                            local square = cell:getGridSquare(x, y, z)
                            if square then
                                local roomType = square:getRoom() and square:getRoom():getName() or nil
                                local worldObjects = square:getWorldObjects()
                                local toProcess = {}
                                local toRemove = {}
                                for j = 0, worldObjects:size() - 1 do
                                    local worldItem = worldObjects:get(j)
                                    if worldItem and not (instanceof(worldItem, "IsoDeadBody") or instanceof(worldItem, "IsoZombie")) then
                                        local item = worldItem:getItem()
                                        table.insert(toProcess, {worldItem = worldItem, item = item})
                                    end
                                end
                                local movingObjects = square:getMovingObjects()
                                if movingObjects then
                                    for i = 0, movingObjects:size() - 1 do
                                        local mover = movingObjects:get(i)
                                        if mover then
                                            if instanceof(mover, "BaseVehicle") then
                                                for p = 0, mover:getPartCount() - 1 do
                                                    local part = mover:getPartByIndex(p)
                                                    if part and part:getItemContainer() then
                                                        Guns93ProcessInventory(roomType, part:getItemContainer())
                                                    end
                                                end
--                                            elseif instanceof(mover, "IsoZombie") then
--                                                Guns93ZombieGunSpawns(mover)
                                            end
                                        end
                                    end
                                end
                                for _, entry in ipairs(toProcess) do
                                    local item = entry.item
                                    local worldItem = entry.worldItem
                                    if item:hasTag(Gun93Registries.guns93.Guns93Spawner) then
                                        Guns93ItemPickerFloor(roomType, square, item)
                                        table.insert(toRemove, worldItem)
                                    elseif item:getFullType() == "Base.Guns93Junk" then
                                        table.insert(toRemove, worldItem)
                                    elseif instanceof(item, "InventoryContainer") and item:getInventory() then
                                        Guns93ProcessInventory(roomType, item:getInventory())
                                    elseif not SandboxVars.Guns93.Guns93VanillaGuns then
                                        if instanceof(item, "HandWeapon") and item:isRanged() and not item:hasTag(Gun93Registries.guns93.Guns93) then
                                            Guns93VanillaReplacerFloor(roomType, square, item)
                                        end
                                        for _, badItem in ipairs(Guns93RemoveItems or {}) do
                                            if item:getFullType() == badItem then
                                                table.insert(toRemove, worldItem)
                                            end
                                        end
                                    end
                                end
                                for _, worldItem in ipairs(toRemove) do
                                    if worldItem then
                                        local sq = worldItem:getSquare()
                                        if sq then
                                            sq:removeWorldObject(worldItem)
                                            sq:transmitRemoveItemFromSquare(worldItem)
                                        end
                                    end
                                end
                                local objects = square:getObjects()
                                for i = 0, objects:size() - 1 do
                                    local obj = objects:get(i)
                                    local zed = instanceof(obj, "IsoDeadBody") or instanceof(obj, "IsoZombie")
                                    local container = obj:getContainer() or (obj.getItemContainer and obj:getItemContainer())
                                    if container then
                                        Guns93ProcessInventory(roomType, container, zed)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local TICK_DELAY = 240
local tickTimer = TICK_DELAY

local function Guns93SpawnerOnTickDelay()
    if isClient() then return end
    tickTimer = tickTimer - 1
    if tickTimer <= 0 then
        Guns93SpawnerItemScanner()
        tickTimer = TICK_DELAY
    end
end

Events.OnTick.Add(Guns93SpawnerOnTickDelay)

local function Guns93AmmoSwap(roomType, containerType, container)
    if isClient() then return end
    if not instanceof(container, "ItemContainer") then return end
    local items = container:getItems()
    local toRemove = {}
    for i = 0, items:size() - 1 do
        local ammo = items:get(i)
        if ammo and ammo:getDisplayCategory() == "Ammo" then
            local ammoType = tostring(ammo:getFullType())
            local list
            if containerType == "ArmyInstructor" or containerType == "ArmyServiceUniform" or containerType == "ArmyCamoDesert" or containerType == "ArmyCamoGreen" or roomType == "armystorage" or roomType == "armysurplus" or roomType == "armytent" or containerType == "Bag_AmmoBox_9mm" or containerType == "Bag_AmmoBox_308" or containerType == "Bag_AmmoBox" or containerType == "Bag_AmmoBox_45" or containerType == "Bag_AmmoBox_ShotgunShells" or containerType == "Bag_ProtectiveCaseSmallMilitary_Pistol1" or containerType == "Bag_RifleCaseGreen" or containerType == "Bag_ShotgunCaseGreen" then
                list = MilAmmoSpawnList[ammoType]
            elseif containerType == "Sheriff_Deputy" or containerType == "Police" or containerType == "PoliceRiot" or containerType == "PoliceState" or containerType == "Police_SWAT" or containerType == "GloveBox" or containerType == "SeatFrontRight" or containerType == "SeatFrontLeft" or containerType == "SeatRearRight" or containerType == "SeatRearLeft" or containerType == "TruckBed" or roomType == nil or roomType == "policegunstorage" or roomType == "policelocker" or roomType == "policeoffice" or roomType == "policeoutfitstorage" or roomType == "policestorage" or roomType == "policeswat" or containerType == "AmmoStrap_Bullets" or containerType == "AmmoStrap_Shells" or containerType == "AmmoStrap_Bullets_308" or containerType == "Bag_Police" or containerType == "Bag_SWAT" or containerType == "Bag_Sheriff" then
                list = DefAmmoSpawnList[ammoType]
            else
                list = AmmoSpawnList[ammoType]
            end
            if list then
                local index = ZombRand(1, #list)
                local newAmmo = list[index]
                if newAmmo ~= ammoType then
                    local spawnAmmo = instanceItem(newAmmo)
                    container:AddItem(spawnAmmo)
                    sendAddItemToContainer(container, spawnAmmo)
                    table.insert(toRemove, ammo)
                end
            end
        end
        if instanceof(ammo, "InventoryContainer") or instanceof(ammo, "ItemContainer") then
            Guns93AmmoSwap(roomType, containerType, ammo:getInventory())
        end
    end
    for _, ammo in ipairs(toRemove) do
        if container:contains(ammo) then
            container:DoRemoveItem(ammo)
            sendRemoveItemFromContainer(container, ammo)
        end
    end
end

Events.OnFillContainer.Add(Guns93AmmoSwap)