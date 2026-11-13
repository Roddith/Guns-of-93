AmmoBrassSet = AmmoBrassSet or {}

    AmmoBrassSet["Base.22Bullets"]      = {damageChance = 89, damaged = "Base.DamagedEmptyBrass"}
    AmmoBrassSet["Base.25Bullets"]      = {damageChance = 88, damaged = "Base.DamagedEmptyBrass"}
    AmmoBrassSet["Base.380Bullets"]     = {damageChance = 91, damaged = "Base.DamagedEmptyBrass"}
    AmmoBrassSet["Base.Bullets38"]      = {damageChance = 94, damaged = "Base.DamagedEmptyBrass"}
    AmmoBrassSet["Base.Bullets9mm"]     = {damageChance = 82, damaged = "Base.DamagedEmptyBrass"}
    AmmoBrassSet["Base.40Bullets"]      = {damageChance = 82, damaged = "Base.DamagedEmptyBrass"}
    AmmoBrassSet["Base.Bullets45"]      = {damageChance = 91, damaged = "Base.DamagedEmptyBrass"}
    AmmoBrassSet["Base.45LCBullets"]    = {damageChance = 95, damaged = "Base.DamagedEmptyBrass"}
    AmmoBrassSet["Base.10mmBullets"]    = {damageChance = 80, damaged = "Base.DamagedEmptyBrass"}
    AmmoBrassSet["Base.Bullets357"]     = {damageChance = 82, damaged = "Base.DamagedEmptyBrass"}
    AmmoBrassSet["Base.Bullets44"]      = {damageChance = 81, damaged = "Base.DamagedEmptyBrass"}
    AmmoBrassSet["Base.30CarBullets"]   = {damageChance = 78, damaged = "Base.DamagedEmptyBrass"}
    AmmoBrassSet["Base.556Bullets"]     = {damageChance = 68, damaged = "Base.DamagedEmptyBrass"}
    AmmoBrassSet["Base.76239Bullets"]   = {damageChance = 75, damaged = "Base.DamagedRifleCase"}
    AmmoBrassSet["Base.3030Bullets"]    = {damageChance = 77, damaged = "Base.DamagedEmptyBrass"}
    AmmoBrassSet["Base.308Bullets"]     = {damageChance = 64, damaged = "Base.DamagedEmptyBrass"}
    AmmoBrassSet["Base.3006Bullets"]    = {damageChance = 65, damaged = "Base.DamagedEmptyBrass"}
    AmmoBrassSet["Base.792Bullets"]     = {damageChance = 57, damaged = "Base.DamagedEmptyBrass"}
    AmmoBrassSet["Base.SlugBullets"]    = {damageChance = 95, damaged = "Base.DamagedSlugHull"}
    AmmoBrassSet["Base.ShotgunShells"]  = {damageChance = 95, damaged = "Base.DamagedShotHull"}

local function Guns93BrassPicker(player, weapon)
    if isClient() then return end
    local ammoKey = weapon:getAmmoType():getItemKey()
    local brassData = AmmoBrassSet[ammoKey]
    if not brassData then return end
    local willDmg = brassData.damageChance
    if weapon:haveChamber() then
        if not weapon:isRackAfterShoot() then
            willDmg = willDmg - 5
        end
    else
        willDmg = willDmg + 5
    end
    if weapon:hasTag(Gun93Registries.guns93.BadBrass) then
        willDmg = willDmg - 8
    end
    if weapon:hasTag(Gun93Registries.guns93.VeryBadBrass) then
        willDmg = willDmg - 15
    end
    if weapon:hasTag(Gun93Registries.guns93.goodBrass) then
        willDmg = willDmg + 5
    end
    if willDmg > 95 then willDmg = 95 end
    if willDmg < 0 then willDmg = 0 end
    local brassType = (ZombRand(100) > willDmg) and brassData.damaged or (ammoKey .. "Brass")
    local brassDrop = instanceItem(brassType)
    if weapon:getWeaponPart("Moonclip") or weapon:hasTag(Gun93Registries.guns93.SingleEject) then
        player:getInventory():AddItem(brassDrop)
        sendAddItemToContainer(player:getInventory(), brassDrop)
    else
        local square = player:getCurrentSquare()
        if square then
            local brass = square:AddWorldInventoryItem(brassDrop, 0.0, 0.0, 0.0)
        end
    end
end

function Guns93BrassEject(player, weapon)
    if not SandboxVars.Guns93.Guns93SpentBrass then return end
    if isClient() then return end
    local ejected = false
    if weapon:getSpentRoundCount() > 0 then
        if weapon:hasTag(Gun93Registries.guns93.SingleEject) then
            Guns93BrassPicker(player, weapon)
            weapon:setSpentRoundCount(weapon:getSpentRoundCount() - 1)
        else
            for i = 1, weapon:getSpentRoundCount() do
                Guns93BrassPicker(player, weapon)
            end
            weapon:setSpentRoundCount(0)
        end
        ejected = true
    elseif weapon:isSpentRoundChambered() then
        Guns93BrassPicker(player, weapon)
        weapon:setSpentRoundChambered(false)
        ejected = true
    end
    if ejected then
        syncHandWeaponFields(player, weapon)
    end
end

local function AutoEjectCase(player, weapon)
    if not SandboxVars.Guns93.Guns93SpentBrass or not weapon:hasTag(Gun93Registries.guns93.Guns93) or not weapon:isRanged() then return end
    if weapon:haveChamber() and not weapon:isRackAfterShoot() then       
        local canon = weapon:getWeaponPart("Canon")
        if canon and canon:hasTag(Gun93Registries.guns93.Guns93Can) and weapon:hasTag(Gun93Registries.guns93.ReqBooster) then
            if not canon:hasTag(Gun93Registries.guns93.Booster) then
                return
            end
        end
        Guns93BrassPicker(player, weapon)
    end
    if weapon:isContainsClip() then
        local clip = weapon:getWeaponPart("Clip")
        if clip then
            local clipAmmoKey = clip:getAmmoType():getItemKey()
            if clipAmmoKey == "Base.556Belt" or clipAmmoKey == "Base.308Belt" then
                if isClient() then return end
                local linkType = (ZombRand(4) < 3) and (clipAmmoKey .. "Link") or "Base.DamagedBeltLink"
                local link = instanceItem(linkType)
                local square = player:getCurrentSquare()
                if square then
                    local worldLink = square:AddWorldInventoryItem(link, 0.0, 0.0, 0.0)
                end
            end
        end
    end
end

Events.OnPlayerAttackFinished.Add(AutoEjectCase)

local ISReloadWeaponAction_ejectSpentRounds_Old = ISReloadWeaponAction.ejectSpentRounds
function ISReloadWeaponAction:ejectSpentRounds()
    if not SandboxVars.Guns93.Guns93SpentBrass or not self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        return ISReloadWeaponAction_ejectSpentRounds_Old(self)
    end
    Guns93BrassEject(self.character, self.gun)
    if self.gun:getShellFallSound() then
        self.character:getEmitter():playSound(self.gun:getShellFallSound())
    end
end

local ISRackFirearm_ejectSpentRounds_Old = ISRackFirearm.ejectSpentRounds
function ISRackFirearm:ejectSpentRounds()
    if not SandboxVars.Guns93.Guns93SpentBrass or not self.gun:hasTag(Gun93Registries.guns93.Guns93) or self.gun:getWeaponPart("Moonclip") then
        return ISRackFirearm_ejectSpentRounds_Old(self)
    end
    Guns93BrassEject(self.character, self.gun)
    if self.gun:getShellFallSound() then
        self.character:getEmitter():playSound(self.gun:getShellFallSound())
    end
end

-- Add brass/casings to world removal list
local Guns93RemovalListItems = {
    "Base.3006BulletsBrass", "Base.792BulletsBrass", "Base.30CarBulletsBrass",
    "Base.76239BulletsBrass", "Base.3030BulletsBrass", "Base.22BulletsBrass",
    "Base.25BulletsBrass", "Base.380BulletsBrass", "Base.45LCBulletsBrass",
    "Base.357BulletsBrass", "Base.10mmBulletsBrass", "Base.ShotgunShellsBrass",
    "Base.SlugBulletsBrass", "Base.Bullets9mmBrass", "Base.40BulletsBrass",
    "Base.Bullets45Brass", "Base.Bullets44Brass", "Base.Bullets38Brass",
    "Base.223BulletsBrass", "Base.308BulletsBrass", "Base.556BulletsBrass",
    "Base.DamagedEmptyBrass", "Base.DamagedRifleCase", "Base.DamagedShotHull",
    "Base.DamagedSlugHull", "Base.DamagedBeltLink"
}

local function Guns93AddToRemovalList()
    if isClient() and not isAdmin() then return end
    if not SandboxVars.Guns93.Guns93CleanBrass then return end
    local sandbox = getSandboxOptions()
    local option = sandbox:getOptionByName("WorldItemRemovalList")
    if not option then return end
    local current = option:getValue() or ""
    local newList = current
    for _, item in ipairs(Guns93RemovalListItems) do
        if not string.find("," .. current .. ",", "," .. item .. ",") then
            newList = newList .. (newList == "" and "" or ",") .. item
        end
    end
    if newList ~= current then
        option:setValue(newList)
        sandbox:toLua()
        sandbox:updateFromLua()
        if isClient() then
            sandbox:sendToServer()
        end
    end
end

Events.OnGameStart.Add(Guns93AddToRemovalList)