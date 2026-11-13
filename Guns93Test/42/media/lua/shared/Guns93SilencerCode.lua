CaliberValue = CaliberValue or {}

    CaliberValue["Base.Bullets9mm"]     = {shock = 15,  subsonic = 1,   bore = 0.125,  action = "PistolSilencedAction",   rack = "PistolSilenced"}
    CaliberValue["Base.40Bullets"]      = {shock = 15,  subsonic = 1,   bore = 0.1875, action = "PistolSilencedAction",   rack = "PistolSilenced"}
    CaliberValue["Base.Bullets45"]      = {shock = 15,  subsonic = 0.8, bore = 0.25,   action = "SubPistolSilencedAction", rack = "SubPistolSilenced"}
    CaliberValue["Base.45LCBullets"]    = {shock = 15,  subsonic = 0.8, bore = 0.25,   action = "SubPistolSilencedAction", rack = "SubPistolSilenced"}
    CaliberValue["Base.10mmBullets"]    = {shock = 20,  subsonic = 1,   bore = 0.1875, action = "MagnumSilencedAction",   rack = "MagnumSilenced"}
    CaliberValue["Base.Bullets357"]     = {shock = 20,  subsonic = 1,   bore = 0.125,  action = "MagnumSilencedAction",   rack = "MagnumSilenced"}
    CaliberValue["Base.Bullets44"]      = {shock = 20,  subsonic = 1,   bore = 0.25,   action = "MagnumSilencedAction",   rack = "MagnumSilenced"}
    CaliberValue["Base.30CarBullets"]   = {shock = 20,  subsonic = 1,   bore = 0.0625, action = "MagnumSilencedAction",   rack = "MagnumSilenced"}
    CaliberValue["Base.76239Bullets"]   = {shock = 35,  subsonic = 1,   bore = 0.0625, action = "CarbineSilencedAction",  rack = "CarbineSilenced"}
    CaliberValue["Base.3030Bullets"]    = {shock = 35,  subsonic = 1,   bore = 0.0625, action = "CarbineSilencedAction",  rack = "CarbineSilenced"}
    CaliberValue["Base.556Bullets"]     = {shock = 35,  subsonic = 1,   bore = 0,      action = "CarbineSilencedAction",  rack = "CarbineSilenced"}
    CaliberValue["Base.308Bullets"]     = {shock = 40,  subsonic = 1,   bore = 0.0625, action = "RifleSilencedAction",    rack = "RifleSilenced"}
    CaliberValue["Base.3006Bullets"]    = {shock = 40,  subsonic = 1,   bore = 0.0625, action = "RifleSilencedAction",    rack = "RifleSilenced"}
    CaliberValue["Base.792Bullets"]     = {shock = 40,  subsonic = 1,   bore = 0.09375,action = "RifleSilencedAction",    rack = "RifleSilenced"}
    CaliberValue["Base.Bullets38"]      = {shock = 5,   subsonic = 0.8, bore = 0.125,  action = "SubPistolSilencedAction", rack = "SubPistolSilenced"}
    CaliberValue["Base.380Bullets"]     = {shock = 5,   subsonic = 0.8, bore = 0.125,  action = "SubPistolSilencedAction", rack = "SubPistolSilenced"}
    CaliberValue["Base.25Bullets"]      = {shock = -5,  subsonic = 1,   bore = 0.15,   action = "22SilencedAction",       rack = "22Silenced"}
    CaliberValue["Base.22Bullets"]      = {shock = -5,  subsonic = 1,   bore = 0.15,   action = "22SilencedAction",       rack = "22Silenced"}
    CaliberValue["Base.SlugBullets"]    = {shock = 35,  subsonic = 1,   bore = 0.33,   action = "ShotgunSilencedAction",  rack = "ShotgunSilenced"}
    CaliberValue["Base.ShotgunShells"]  = {shock = 35,  subsonic = 1,   bore = 0.25,   action = "ShotgunSilencedAction",  rack = "ShotgunSilenced"}

local function SilencerCondition(player, weapon)
    if not instanceof(player, "IsoPlayer") then return end
    if not weapon or not instanceof(weapon, "HandWeapon") or not weapon:isRanged() then return end
    local canon = weapon:getWeaponPart("Canon")
    if not canon or not canon:getModData()["isSilencerCon"] then return end
    if isClient() then return end
    local moditem = canon:getModData()
    local candur = moditem.modCan_Dur or 0
    local caliberData = CaliberValue[weapon:getAmmoType():getItemKey()]
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

local function SilencerEff(player, weapon)
    if not instanceof(player, "IsoPlayer") then return end
    if not weapon or not weapon:hasTag(Gun93Registries.guns93.Guns93) or weapon:hasTag(Gun93Registries.guns93.NoSilence) or not weapon:isRanged() then return end
    local canon = weapon:getWeaponPart("Canon")
    local scriptItem = weapon:getScriptItem()
    local baseSoundRadius = scriptItem:getSoundRadius()
    local baseSwingSound = scriptItem:getSwingSound()
    local muzzleFlash = scriptItem:getMuzzleFlashModelKey()
    local manualop = (weapon:getModData()['isMustRack'] or weapon:isRackAfterShoot()) and 0.8 or 1.0
    local swingSound = baseSwingSound
    local soundRadius = baseSoundRadius
    if canon and canon:hasTag(Gun93Registries.guns93.Guns93Can) and canon:getCondition() > 0 then
        local moditem = canon:getModData()
        local cansize = moditem.modBore_Eff
        local caneff = moditem.modSound_Eff
        local fouling = moditem.mod_fouling
        local caliberData = CaliberValue[weapon:getAmmoType():getItemKey()]
        if caliberData then
            local subsonic = caliberData.subsonic
            local boresize = caliberData.bore
            if weapon:getModData()['isMustRack'] or weapon:isRackAfterShoot() then
                swingSound = caliberData.rack
            else
                swingSound = caliberData.action
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

Events.OnPlayerAttackFinished.Add(SilencerEff)
Events.OnEquipPrimary.Add(SilencerEff)

Events.OnGameStart.Add(function()
    local player = getPlayer()
    if player then
        SilencerEff(player, player:getPrimaryHandItem())
    end
end)