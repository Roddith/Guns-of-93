function GunStatAdjust(player, weapon)
    if not instanceof(player, "IsoPlayer") or instanceof(player, "IsoZombie") then return end
    if not weapon or not instanceof(weapon, "HandWeapon") or not weapon:isRanged() then return end
    if not weapon:hasTag(Gun93Registries.guns93.Guns93) then return end
    local weaponMod = weapon:getModData()
    local baseJamChance = weaponMod.g93_baseJamChance
    local baseConChance = weaponMod.g93_baseConChance
    local baseHitcount = weaponMod.g93_baseHitcount
    local baseAimingPerkCrit = weaponMod.g93_baseAimingPerkCrit
    local baseHitChance = weaponMod.g93_baseHitChance
    local baseRecoil = weaponMod.g93_baseRecoil
    local baseDoorDamage = weaponMod.g93_baseDoorDamage
    local baseMinDMG = weaponMod.g93_baseMinDMG
    local baseMaxDMG = weaponMod.g93_baseMaxDMG
    local baseCritChance = weaponMod.g93_baseCritChance
    local baseCritDmgMultiplier = weaponMod.g93_baseCritDmgMultiplier
    local baseStopPower = weaponMod.g93_baseStopPower
    local basePushBackMod = weaponMod.g93_basePushBackMod
    local baseRange = weaponMod.g93_baseRange
    local baseKnockdownMod = weaponMod.g93_baseKnockdownMod
    local baseProjectileCount = weaponMod.g93_baseProjectileCount
    local baseProjectileSpread = weaponMod.g93_baseProjectileSpread
    local baseProjectileWeightCenter = weaponMod.g93_baseProjectileWeightCenter
    if not baseHitcount or not baseAimingPerkCrit or not baseRecoil or not baseHitChance or not baseDoorDamage or not baseJamChance or not baseConChance or not baseMaxDMG or not baseMinDMG or not baseRange or not baseCritChance or not baseCritDmgMultiplier then
        local baseGunRef = instanceItem(weapon:getFullType())
        local remparts = baseGunRef:getAllWeaponParts()
        for i = remparts:size() - 1, 0, -1 do
            local part = remparts:get(i)
            if part then baseGunRef:detachWeaponPart(part) end
        end
        baseJamChance = baseGunRef:getJamGunChance()
        baseConChance = baseGunRef:getConditionLowerChance()
        baseHitcount = baseGunRef:getMaxHitCount()
        baseAimingPerkCrit = baseGunRef:getAimingPerkCritModifier()
        baseHitChance = baseGunRef:getHitChance()
        baseRecoil = baseGunRef:getRecoilDelay()
        baseDoorDamage = baseGunRef:getDoorDamage()
        baseMinDMG = baseGunRef:getMinDamage()
        baseMaxDMG = baseGunRef:getMaxDamage()
        baseCritChance = baseGunRef:getCriticalChance()
        baseCritDmgMultiplier = baseGunRef:getCriticalDamageMultiplier()
        baseStopPower = baseGunRef:getStopPower()
        basePushBackMod = baseGunRef:getPushBackMod()
        baseRange = baseGunRef:getMaxRange()
        baseKnockdownMod = baseGunRef:getKnockdownMod()
        baseProjectileCount = baseGunRef:getProjectileCount()
        baseProjectileSpread = baseGunRef:getProjectileSpread()
        baseProjectileWeightCenter = baseGunRef:getProjectileWeightCenter()
    end
    local currentRound = nil
    if weapon:haveChamber() then
        currentRound = weaponMod.Guns93Chambered
    elseif weaponMod.Guns93AmmoList then
        local list = weaponMod.Guns93AmmoList
        local top = list[1]
        if top and top.type then
            currentRound = top.type
        end
    end
    if currentRound == nil then
        currentRound = weapon:getAmmoType():getItemKey()
    end
    local roundData = AmmoStatList[currentRound]
    if roundData and tostring(roundData.caliber) == tostring(weaponMod.modAlt_Ammo) then
        if weaponMod.modAlt_Hitcount ~= nil and weaponMod.modAlt_Hitcount ~= baseHitcount then
            baseHitcount = weaponMod.modAlt_Hitcount
        end
        if weaponMod.modAlt_AimingPerkCrit ~= nil and weaponMod.modAlt_AimingPerkCrit ~= baseAimingPerkCrit then
            baseAimingPerkCrit = weaponMod.modAlt_AimingPerkCrit
        end
        if weaponMod.modAlt_HitChance ~= nil and weaponMod.modAlt_HitChance ~= baseHitChance then
            baseHitChance = weaponMod.modAlt_HitChance
        end
        if weaponMod.modAlt_RecoilDelay ~= nil and weaponMod.modAlt_RecoilDelay ~= baseRecoil then
            baseRecoil = weaponMod.modAlt_RecoilDelay
        end
        if weaponMod.modAlt_DoorDamage ~= nil and weaponMod.modAlt_DoorDamage ~= baseDoorDamage then
            baseDoorDamage = weaponMod.modAlt_DoorDamage
        end
        if weaponMod.modAlt_MinDamage ~= nil and weaponMod.modAlt_MinDamage ~= baseMinDMG then
            baseMinDMG = weaponMod.modAlt_MinDamage
        end
        if weaponMod.modAlt_MaxDamage ~= nil and weaponMod.modAlt_MaxDamage ~= baseMaxDMG then
            baseMaxDMG = weaponMod.modAlt_MaxDamage
        end
        if weaponMod.modAlt_CriticalChance ~= nil and weaponMod.modAlt_CriticalChance ~= baseCritChance then
            baseCritChance = weaponMod.modAlt_CriticalChance
        end
        if weaponMod.modAlt_CritDmgMultiplier ~= nil and weaponMod.modAlt_CritDmgMultiplier ~= baseCritDmgMultiplier then
            baseCritDmgMultiplier = weaponMod.modAlt_CritDmgMultiplier
        end
        if weaponMod.modAlt_StopPower ~= nil and weaponMod.modAlt_StopPower ~= baseStopPower then
            baseStopPower = weaponMod.modAlt_StopPower
        end
        if weaponMod.modAlt_PushBackMod ~= nil and weaponMod.modAlt_PushBackMod ~= basePushBackMod then
            basePushBackMod = weaponMod.modAlt_PushBackMod
        end
        if weaponMod.modAlt_MaxRange ~= nil and weaponMod.modAlt_MaxRange ~= baseRange then
            baseRange = weaponMod.modAlt_MaxRange
        end
        if weaponMod.modAlt_KnockdownMod ~= nil and weaponMod.modAlt_KnockdownMod ~= baseKnockdownMod then
            baseKnockdownMod = weaponMod.modAlt_KnockdownMod
        end
        if weaponMod.modAlt_ProjectileCount ~= baseProjectileCount then
            baseProjectileCount = weaponMod.modAlt_ProjectileCount
        end
        if weaponMod.modAlt_ProjectileSpread ~= baseProjectileSpread then
            baseProjectileSpread = weaponMod.modAlt_ProjectileSpread
        end
        if weaponMod.modAlt_ProjectileWeightCenter ~= baseProjectileWeightCenter then
            baseProjectileWeightCenter = weaponMod.modAlt_ProjectileWeightCenter
        end
    end
    if roundData ~= nil then
        if roundData.jamchance ~= nil and baseJamChance ~= 0 then
            baseJamChance = baseJamChance + roundData.jamchance
        end
        if roundData.conchange ~= nil then
            baseConChance = baseConChance + roundData.conchange
        end
        if roundData.hitchance ~= nil then
            baseHitChance = baseHitChance + roundData.hitchance
        end
        if roundData.hitcount ~= nil then
            baseHitcount = baseHitcount + roundData.hitcount
            if baseHitcount < 1 then
                baseHitcount = 1
            end
        end
        if roundData.recoil ~= nil then
            baseRecoil = baseRecoil + roundData.recoil
        end
        if roundData.doordmg ~= nil then
            baseDoorDamage = baseDoorDamage + roundData.doordmg
        end
        if roundData.dmgmod ~= nil then
            baseMinDMG = baseMinDMG + roundData.dmgmod
            baseMaxDMG = baseMaxDMG + roundData.dmgmod
            if baseMinDMG < 0.1 then
                baseMinDMG = 0.1
            end
            if baseMaxDMG < 0.1 then
                baseMaxDMG = 0.1
            end
        end
        if roundData.critchance ~= nil then
            baseCritChance = baseCritChance + roundData.critchance
        end
        if roundData.critmultipler ~= nil then
            baseCritDmgMultiplier = baseCritDmgMultiplier + roundData.critmultipler
        end
        if roundData.pushback ~= nil then
            basePushBackMod = basePushBackMod + roundData.pushback
        end
        if roundData.range ~= nil then
            baseRange = baseRange + roundData.range
        end
        if roundData.knockdown ~= nil then
            baseKnockdownMod = baseKnockdownMod + roundData.knockdown
        end
        if roundData.projectileCount ~= nil then
            baseProjectileCount = baseProjectileCount + roundData.projectileCount
        end
        if roundData.spread ~= nil then
            baseProjectileSpread = baseProjectileSpread + roundData.spread
        end
        if roundData.projectilecenter ~= nil then
            baseProjectileWeightCenter = baseProjectileWeightCenter + roundData.projectilecenter
        end
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
                    if partMod["ProjectileSpreadModifier"] then
                        baseProjectileSpread = baseProjectileSpread + partMod["ProjectileSpreadModifier"]
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
    weapon:setJamGunChance(baseJamChance)
    weapon:setConditionLowerChance(baseConChance)
    weapon:setMaxHitCount(baseHitcount)
    weapon:setAimingPerkCritModifier(baseAimingPerkCrit)
    weapon:setRecoilDelay(recoilDelay)
    weapon:setDoorDamage(baseDoorDamage)
    weapon:setMinDamage(baseMinDMG)
    weapon:setMaxDamage(baseMaxDMG)
    weapon:setCriticalChance(baseCritChance)
    weapon:setCriticalDamageMultiplier(baseCritDmgMultiplier)
    weaponMod.StopPower = baseStopPower
    weapon:setPushBackMod(basePushBackMod)
    weapon:setMaxRange(baseRange)
    weapon:setKnockdownMod(baseKnockdownMod)
    weapon:setProjectileCount(baseProjectileCount)
    weaponMod.ProjectileSpread = baseProjectileSpread
    weaponMod.ProjectileWeightCenter = baseProjectileWeightCenter
    if not isClient() and not instanceof(player, "IsoZombie") then
        syncItemModData(player, weapon)
        syncHandWeaponFields(player, weapon)
    end
    SilencerEff(player, weapon)
end

---Events.OnWeaponSwing.Add(GunStatAdjust)
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