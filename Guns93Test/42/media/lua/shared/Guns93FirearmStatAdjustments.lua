function GunStatAdjust(player, weapon)
    if not instanceof(player, "IsoPlayer") or instanceof(player, "IsoZombie") then return end
    if not weapon or not instanceof(weapon, "HandWeapon") or not weapon:isRanged() then return end
    if not weapon:hasTag(Gun93Registries.guns93.Guns93) then return end
    local weaponMod = weapon:getModData()
    local baseRecoil = weaponMod.g93_baseRecoil
    local baseHitChance = weaponMod.g93_baseHitChance
    local baseJamChance = weaponMod.g93_baseJamChance
    local baseConChance = weaponMod.g93_baseConChance
    local baseMaxDMG = weaponMod.g93_baseMaxDMG
    local baseMinDMG = weaponMod.g93_baseMinDMG
    local baseRange = weaponMod.g93_baseRange
    local baseCritChance = weaponMod.g93_baseCritChance
    if not baseRecoil or not baseHitChance or not baseJamChance or not baseConChance or not baseMaxDMG or not baseMinDMG or not baseRange or not baseCritChance then
        local baseGunRef = instanceItem(weapon:getFullType())
        local remparts = baseGunRef:getAllWeaponParts()
        for i = remparts:size() - 1, 0, -1 do
            local part = remparts:get(i)
            if part then baseGunRef:detachWeaponPart(part) end
        end
        baseRecoil = baseGunRef:getRecoilDelay()
        baseHitChance = baseGunRef:getHitChance()
        baseJamChance = baseGunRef:getJamGunChance()
        baseConChance = baseGunRef:getConditionLowerChance()
        baseMaxDMG = baseGunRef:getMaxDamage()
        baseMinDMG = baseGunRef:getMinDamage()
        baseRange = baseGunRef:getMaxRange()
        baseCritChance = baseGunRef:getCriticalChance()
        weaponMod.g93_baseRecoil = baseRecoil
        weaponMod.g93_baseHitChance = baseHitChance
        weaponMod.g93_baseJamChance = baseJamChance
        weaponMod.g93_baseConChance = baseConChance
        weaponMod.g93_baseMaxDMG = baseMaxDMG
        weaponMod.g93_baseMinDMG = baseMinDMG
        weaponMod.g93_baseRange = baseRange
        weaponMod.g93_baseCritChance = baseCritChance
    end
    baseMaxDMG = baseMaxDMG * (SandboxVars.Guns93.Guns93DMGAdjust or 1)
    baseMinDMG = baseMinDMG * (SandboxVars.Guns93.Guns93DMGAdjust or 1)
    local hitChance = baseHitChance * (SandboxVars.Guns93.Guns93HitAdjust or 1)
    local recoilDelay = baseRecoil * (SandboxVars.Guns93.Guns93RecoilAdjust or 1)
    local sightMod = 10
    local sightHit = 0
    local totalModifier = 0
    local isSight = false
    local parts = weapon:getAllWeaponParts()
    if parts then
        for i = 0, parts:size() - 1 do
            local part = parts:get(i)
            if part then
                if part:hasTag(Gun93Registries.guns93.UsePrimSight) then
                    isSight = part
                elseif part:hasTag(Gun93Registries.guns93.UseScope) and not (isSight and isSight:hasTag(Gun93Registries.guns93.UsePrimSight)) then
                    isSight = part
                elseif part:hasTag(Gun93Registries.guns93.UseIrons) and not isSight then
                    isSight = part
                else
                    local partMod = part:getModData()
                    if part:getHitChance() then
                        sightHit = sightHit + part:getHitChance()
                    end
                    if part:getRecoilDelay() then
                        totalModifier = totalModifier + part:getRecoilDelay()
                    end                                       
                    if partMod["mod_RangMod"] then
                        baseRange = baseRange + partMod["mod_RangMod"]
                    end
                    if partMod["mod_CritChanceMod"] then
                        baseCritChance = baseCritChance + partMod["mod_CritChanceMod"]
                    end
                    if partMod["mod_JamMod"] then
                        baseJamChance = baseJamChance + partMod["mod_JamMod"]
                    end
                end
            end
        end
    end
    if isSight then
        sightMod = 0
        local partMod = isSight:getModData()
        if isSight:getHitChance() then
            sightHit = sightHit + isSight:getHitChance()
        end                   
        if partMod["mod_RangMod"] then
            baseRange = baseRange + partMod["mod_RangMod"]
        end
        if partMod["mod_CritChanceMod"] then
            baseCritChance = baseCritChance + partMod["mod_CritChanceMod"]
        end
    end
    if not SandboxVars.Guns93.Guns93Fouling and weaponMod.mod_fouling then
        local howDirty = weaponMod.mod_fouling or 0
        if weapon:getBloodLevel() * 100 > howDirty then
            howDirty = weapon:getBloodLevel() * 100
        end
        if howDirty > 80 then
            weapon:setConditionLowerChance(baseConChance * 0.5)
            baseJamChance = (baseJamChance * 1.5)
        elseif howDirty > 60 then
            weapon:setConditionLowerChance(baseConChance * 0.75)
        elseif howDirty > 30 then
            weapon:setConditionLowerChance(baseConChance)
            baseJamChance = (baseJamChance * 0.75)
        else
            weapon:setConditionLowerChance(baseConChance * 1.5)
            baseJamChance = (baseJamChance * 0.5)
        end
    end
    local reqPart = true
    if weapon:hasTag(Gun93Registries.guns93.ReqTrigger) and not weapon:getWeaponPart("Trigger") then
        reqPart = false
    elseif weapon:hasTag(Gun93Registries.guns93.ReqGrip) and not weapon:getWeaponPart("Grip") then
        local stock = weapon:getWeaponPart("Stock")
        if not (stock and stock:hasTag(Gun93Registries.guns93.Sport)) then
            reqPart = false
        end
    elseif weapon:hasTag(Gun93Registries.guns93.ReqStock) and not weapon:getWeaponPart("Stock") then
        reqPart = false
    end
    if not reqPart and weapon:getFireMode() ~= "Safe" then
        weapon:setFireMode("Safe")
    end
    local autoPart = weapon:getWeaponPart("AutoPart") or weapon:getWeaponPart("Trigger")
    local currentMode = weapon:getFireMode()
    if reqPart and autoPart then
        if currentMode == "Safe" then
            weapon:setFireMode("Single")
        elseif currentMode == "Auto" and not autoPart:hasTag(Gun93Registries.guns93.Fullauto) then
            weapon:setFireMode("Single")
        elseif currentMode == "Burst" and not autoPart:hasTag(Gun93Registries.guns93.Burst) then
            weapon:setFireMode("Single")
        elseif currentMode == "Single" and autoPart:hasTag(Gun93Registries.guns93.AutoOnly) then
            weapon:setFireMode("Auto")
        elseif currentMode == "Burst" and autoPart:hasTag(Gun93Registries.guns93.AutoOnly) then
            weapon:setFireMode("Auto")
        end
    end
    weapon:setHitChance(hitChance - sightMod + sightHit)
    recoilDelay = recoilDelay + totalModifier
    if weapon:getSwingAnim() == "Handgun" then
        local minRecoil = SandboxVars.Guns93.Guns93HandgunRecoilMin or 5
        if recoilDelay < minRecoil then recoilDelay = minRecoil end
    elseif weapon:getSwingAnim() == "Rifle" then
        local minRecoil = SandboxVars.Guns93.Guns93LongGunRecoilMin or 10
        if recoilDelay < minRecoil then recoilDelay = minRecoil end
    end
    if recoilDelay < 1 then recoilDelay = 5 end
    if weapon:getFireMode() == "Auto" then
        weapon:setHitChance(hitChance - ((recoilDelay / 2) - sightMod) + sightHit)
    elseif weapon:getFireMode() == "Burst" then
        local partMod = autoPart:getModData()
        local burstCount = weaponMod["modBurst_Num"] or 0
        weapon:setHitChance(hitChance - ((recoilDelay / 3) - sightMod) + sightHit)
        if burstCount == (partMod["modBurst_Num"] - 1) then
            recoilDelay = recoilDelay + 5
            weaponMod["modBurst_Num"] = 0
        else
            recoilDelay = 0
            weaponMod["modBurst_Num"] = burstCount + 1
        end
    end
    weapon:setMaxDamage(baseMaxDMG)
    weapon:setMinDamage(baseMinDMG)
    weapon:setRecoilDelay(recoilDelay)
    weapon:setMaxRange(baseRange)
    weapon:setCriticalChance(baseCritChance)
    weapon:setJamGunChance(baseJamChance)
    if not isClient() and not instanceof(player, "IsoZombie") then
        syncItemModData(player, weapon)
        syncHandWeaponFields(player, weapon)
    end
end

Events.OnWeaponSwing.Add(GunStatAdjust)
Events.OnEquipPrimary.Add(GunStatAdjust)
Events.OnGameStart.Add(function()
    local player = getPlayer()
    local weapon = player:getPrimaryHandItem()
    if player and weapon then
        if weapon:hasTag(Gun93Registries.guns93.Guns93) then 
            GunStatAdjust(player, weapon) 
        end
    end
end)

local function Guns93CleanName(player, weapon)
    if not player or not weapon then return end
    if weapon:hasTag(Gun93Registries.guns93.Guns93) then
        local newName = weapon:getDisplayName()
        newName = string.gsub(newName, " %(.+%)", "")
        newName = string.gsub(newName, getText("Tooltip_dull"), "")
        newName = string.gsub(newName, getText("Tooltip_blunt"), "")
        newName = string.gsub(newName, " %(.+%)", "")
        newName = string.gsub(newName, getText("Tooltip_clothing_bloody"), "")
        weapon:setName(newName)
    end
end

Events.OnEquipPrimary.Add(Guns93CleanName)