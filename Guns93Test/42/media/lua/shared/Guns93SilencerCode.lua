local function SilencerCondition(player, weapon)
    if not instanceof(player, "IsoPlayer") then return end
    if not weapon or not instanceof(weapon, "HandWeapon") or not weapon:isRanged() then return end
    local canon = weapon:getWeaponPart("Canon")
    if not canon or not canon:getModData()["isSilencerCon"] then return end
    if isClient() then return end
    local moditem = canon:getModData()
    local candur = moditem.modCan_Dur or 0
    local modData = weapon:getModData()
    local bullet = nil
    if modData.Guns93AmmoList then
        local list = modData.Guns93AmmoList
        local top = list[1]
        if not top or not top.type then
            return nil
        end
        bullet = top.type
    else
        bullet = weapon:getAmmoType():getItemKey()
    end
    local caliberData = AmmoStatList[bullet]
    local shock = caliberData and caliberData.shock or 0
    local fouling = moditem.mod_fouling or 0
    local durability = 100 - (shock - candur) + (5 - (fouling / 10))
    if durability < 1 then durability = 1 end
    if ZombRand(durability) == 0 and canon:getCondition() > 0 then
        canon:setCondition(canon:getCondition() - 1)
    end
    if not SandboxVars.Guns93.Guns93Fouling then
        if ZombRand(41) == 0 then
            fouling = fouling + ZombRand(1, 10)
            if fouling > 100 then fouling = 100 end
            moditem.mod_fouling = fouling
        end
    end
    syncItemModData(player, canon)
    syncHandWeaponFields(player, weapon)
end

Events.OnPlayerAttackFinished.Add(SilencerCondition)

local function CanBooster(wielder, weapon)
    if not instanceof(wielder, "IsoPlayer") then return end
    if not weapon or not weapon:hasTag(Gun93Registries.guns93.ReqBooster) or wielder:isDoShove() or not weapon:isRanged() then return end
    local canon = weapon:getWeaponPart("Canon")
    if not canon or not canon:hasTag(Gun93Registries.guns93.Guns93Can) then return end
    if isClient() then return end
    if not canon:hasTag(Gun93Registries.guns93.Booster) then
        if weapon:isRoundChambered() then
            weapon:setRoundChambered(false)
            weapon:setSpentRoundChambered(true)
            if weapon:getCurrentAmmoCount() > 0 then
                weapon:setCurrentAmmoCount(weapon:getCurrentAmmoCount() + 1)
            end
        end
    end
    syncHandWeaponFields(wielder, weapon)
end

Events.OnPlayerAttackFinished.Add(CanBooster)

function SilencerEff(player, weapon)
    if not instanceof(player, "IsoPlayer") then return end
    if not weapon or not weapon:hasTag(Gun93Registries.guns93.Guns93) or not weapon:isRanged() then return end
    local canon = weapon:getWeaponPart("Canon")
    local weaponMod = weapon:getModData()
    local baseSoundRadius = weaponMod.g93_soundRadius
    local baseSwingSound = weaponMod.g93_shootSound
    local muzzleFlash = weaponMod.g93_muzzleFlash
    if not baseSoundRadius or not baseSwingSound or not muzzleFlash then
        local baseGunRef = instanceItem(weapon:getFullType())
        local remparts = baseGunRef:getAllWeaponParts()
        for i = remparts:size() - 1, 0, -1 do
            local part = remparts:get(i)
            if part then baseGunRef:detachWeaponPart(part) end
        end
        baseSoundRadius = baseGunRef:getSoundRadius()
        baseSwingSound = baseGunRef:getSwingSound()
        muzzleFlash = baseGunRef:getMuzzleFlashModelKey()
        weaponMod.g93_soundRadius = baseSoundRadius
        weaponMod.g93_shootSound = baseSwingSound
        weaponMod.g93_muzzleFlash = muzzleFlash
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
    if roundData.caliber == weaponMod.modAlt_Ammo then
        baseSoundRadius = weaponMod.modAlt_SoundRadius
        baseSwingSound = weaponMod.modAlt_SwingSound
---        muzzleFlash = weaponMod.modAlt_MuzzleFlash
    end
    if roundData ~= nil then
        if roundData.soundmod then
            baseSoundRadius = baseSoundRadius + roundData.soundmod
        end
    end
    local manualop = (weapon:getModData()['isMustRack'] or weapon:isRackAfterShoot()) and 0.8 or 1.0
    local swingSound = baseSwingSound
    local soundRadius = baseSoundRadius
    if canon and canon:hasTag(Gun93Registries.guns93.Guns93Can) and canon:getCondition() > 0 and not weapon:hasTag(Gun93Registries.guns93.NoSilence) then
        local moditem = canon:getModData()
        local cansize = moditem.modBore_Eff
        local caneff = moditem.modSound_Eff
        local fouling = moditem.mod_fouling
        if roundData then
            local subsonic = roundData.subsonic
            local boresize = roundData.bore
            if weapon:getModData()['isMustRack'] or weapon:isRackAfterShoot() then
                swingSound = roundData.rack
            else
                swingSound = roundData.action
            end
            local bore = moditem['isOilFilter'] and 1 or (cansize - boresize)
            if bore < 0.1 then bore = 0.1 end
            local efficiency = caneff * subsonic * manualop * bore
            soundRadius = ((baseSoundRadius * efficiency) + (fouling / 10)) * (SandboxVars.Guns93.Guns93SilencerEff or 1)
        end
        muzzleFlash = nil
    end
    soundRadius = soundRadius * (SandboxVars.Guns93.Guns93SoundAdjust or 1)
    if soundRadius < 0 then soundRadius = 0 end
    weapon:setSoundVolume(soundRadius)
    weapon:setSoundRadius(soundRadius)
    weapon:setSwingSound(swingSound)
    weapon:setMuzzleFlashModelKey(muzzleFlash)
    if not isClient() then
        syncHandWeaponFields(player, weapon)
    end
end

--Events.OnWeaponSwing.Add(SilencerEff)
--Events.OnEquipPrimary.Add(SilencerEff)

Events.OnGameStart.Add(function()
    local player = getPlayer()
    if player then
        SilencerEff(player, player:getPrimaryHandItem())
    end
end)