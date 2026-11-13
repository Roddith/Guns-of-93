local function Guns93reloadTypeisOpenBolt(weapon)
    if not weapon or not instanceof(weapon, "HandWeapon") then return false end
    return weapon:getModData()["isOpenBolt"] == "true"
end

local function Guns93reloadTypeisEnBloc(weapon)
    if not weapon or not instanceof(weapon, "HandWeapon") then return false end
    return weapon:getModData()["EnBloc"] == "true"
end


local MOD_MODULE = "Guns93"
local CMD_ENBLOC = "EnBlocEject"

local function TriggerEnBlocPing(player, weapon)
    if not player or not weapon then return end
    if not Guns93reloadTypeisEnBloc(weapon) then return end
    if weapon:getCurrentAmmoCount() ~= 0 or weapon:isRoundChambered() or not weapon:isContainsClip() then return end
    getSoundManager():PlayWorldSound("GarandPing", player:getCurrentSquare(), 0, 15, 2.0, false)
    if isClient() then
        sendClientCommand(MOD_MODULE, CMD_ENBLOC, {})
    else
        Guns93doEnBlocEject(player, weapon)
    end
end

function Guns93doEnBlocEject(player, weapon)
    if not player or not weapon then return end
    if not Guns93reloadTypeisEnBloc(weapon) then return end
    if weapon:getCurrentAmmoCount() ~= 0 or weapon:isRoundChambered() or not weapon:isContainsClip() then return end
    local magType = weapon:getMagazineType()
    if not magType then return end
    local clip = instanceItem(magType)
    clip:setCurrentAmmoCount(0)
    local square = player:getCurrentSquare()
    if square then
        square:AddWorldInventoryItem(clip, 0.5, 0.5, 0)
    end
    weapon:setContainsClip(false)
    weapon:setCurrentAmmoCount(0)
    syncHandWeaponFields(player, weapon)
end

local function OnEnBlocCheck()
    local player = getPlayer()
    if not player then return end
    local weapon = player:getPrimaryHandItem()
    if weapon and instanceof(weapon, "HandWeapon") and weapon:isRanged() then
        TriggerEnBlocPing(player, weapon)
    end
end

Events.OnPlayerAttackFinished.Add(OnEnBlocCheck)

local function OnRackKeyPressed(key)
    if key == getCore():getKey("Rack Firearm") then
        local player = getPlayer()
        if not player then return end
        local weapon = player:getPrimaryHandItem()
        if weapon and instanceof(weapon, "HandWeapon") and weapon:isRanged() then
            TriggerEnBlocPing(player, weapon)
        end
    end
end

Events.OnKeyPressed.Add(OnRackKeyPressed)

local function Guns93HammerCock(player, weapon)
    if not player or not weapon then return end
    if not weapon:isRanged() then return end
    if weapon:hasTag(Gun93Registries.guns93.HammerCock) then
        getSoundManager():PlayWorldSound("ColtHammerCock", player:getCurrentSquare(), 0, 15, 2.0, false)
    end
end

Events.OnPlayerAttackFinished.Add(Guns93HammerCock)

function DynamicMagClip(mag)
    if not mag or not mag:hasTag(Gun93Registries.guns93.DynamicMagClip) then return end
    local baseIcon = mag:getScriptItem():getIcon()
    local baseSprite = mag:getScriptItem():getWorldStaticModel()
    local suffix = ""
    if mag:getCurrentAmmoCount() < 1 then
        suffix = ""
    elseif mag:getCurrentAmmoCount() < mag:getMaxAmmo() then
        suffix = "_Half"
    elseif mag:getCurrentAmmoCount() >= mag:getMaxAmmo() then
        suffix = "_Full"
    end
    local newIcon = baseIcon .. suffix
    local newSprite = baseSprite .. suffix
    mag:setTexture(getTexture("media/textures/item_" .. newIcon .. ".png"))
    mag:setWorldStaticModel(newSprite)
end

local ISLoadBulletsInMagazine_animEvent_Old = ISLoadBulletsInMagazine.animEvent
function ISLoadBulletsInMagazine:animEvent(event, parameter)
    DynamicMagClip(self.magazine)
    self.character:getInventory():setDirty(true)
    if event == 'InsertBullet' then
		if self:isLoadFinished() then
			return
		end
        if self:isLocal() then
            if self.loadedThisLoop then
                return
            end
        end
        self.loadedThisLoop = true
		if not isClient() then
			local chance = 5;
			local xp = 1;
			if self.character:getPerkLevel(Perks.Reloading) < 5 then
				chance = 2;
				xp = 4;
			end
			if ZombRand(chance) == 0 then
				addXp(self.character, Perks.Reloading, xp)
			end
            local itemKey = self.magazine:getAmmoType():getItemKey();
			local removedBullet = self.character:getInventory():RemoveOneOf(itemKey, true)
            if removedBullet then
                self.magazine:setCurrentAmmoCount(self.magazine:getCurrentAmmoCount() + 1)
                sendRemoveItemFromContainer(self.character:getInventory(), removedBullet)
                syncItemFields(self.character, self.magazine)
                syncItemModData(self.character, self.magazine)
            end
        end
        DynamicMagClip(self.magazine)
        self.character:getInventory():setDirty(true)
    else
        DynamicMagClip(self.magazine)
        return ISLoadBulletsInMagazine_animEvent_Old(self, event, parameter)
    end
end

local ISUnloadBulletsFromMagazine_animEvent_Old = ISUnloadBulletsFromMagazine.animEvent
function ISUnloadBulletsFromMagazine:animEvent(event, parameter)
    DynamicMagClip(self.magazine)
    self.character:getInventory():setDirty(true)
    if event == 'RemoveBullet' then
		if self.magazine:getCurrentAmmoCount() <= 0 then
			return
		end
        if self:isLocal() then
            if self.unloadedThisLoop then
                return
            end
        end
        self.unloadedThisLoop = true
		if not isClient() then
		    local itemKey = self.magazine:getAmmoType():getItemKey();
			local newBullet = instanceItem(itemKey);
			self.character:getInventory():AddItem(newBullet)
			self.magazine:setCurrentAmmoCount(self.magazine:getCurrentAmmoCount() - 1)
			sendAddItemToContainer(self.character:getInventory(), newBullet)
			syncItemFields(self.character, self.magazine)
            syncItemModData(self.character, self.magazine)
		end
        DynamicMagClip(self.magazine)
        self.character:getInventory():setDirty(true)
		self.unloadFinished = false
    else
        return ISUnloadBulletsFromMagazine_animEvent_Old(self, event, parameter)
    end
end

local ISInsertMagazine_loadAmmo_Old = ISInsertMagazine.loadAmmo
function ISInsertMagazine:loadAmmo()
    if not self.magazine:hasTag(Gun93Registries.guns93.Guns93Mag) then
        return ISInsertMagazine_loadAmmo_Old(self)
    end
    if not isClient() then
        local isLoader = self.magazine:hasTag(Gun93Registries.guns93.SpeedLoader) or self.magazine:hasTag(Gun93Registries.guns93.StripperClip) or self.magazine:hasTag(Gun93Registries.guns93.SpeedStrip)
        if isLoader then
            local ammoNum = self.gun:getMaxAmmo() - self.gun:getCurrentAmmoCount()
            local loaded = 0
            if ammoNum >= self.magazine:getCurrentAmmoCount() then
                if self.magazine:hasTag(Gun93Registries.guns93.SpeedStrip) and self.magazine:getCurrentAmmoCount() > 1 then
                    loaded = 2
                else
                    loaded = self.magazine:getCurrentAmmoCount()
                end
            elseif not self.magazine:hasTag(Gun93Registries.guns93.SpeedLoader) then
                loaded = ammoNum
            end
            if loaded > 0 then
                self.gun:setCurrentAmmoCount(self.gun:getCurrentAmmoCount() + loaded)
                self.magazine:setCurrentAmmoCount(self.magazine:getCurrentAmmoCount() - loaded)
            end
            self.character:getInventory():setDirty(true)
            syncItemFields(self.character, self.magazine)
            syncItemModData(self.character, self.magazine)
            syncHandWeaponFields(self.character, self.gun)
            DynamicMagClip(self.magazine)
        else
            self.character:getInventory():Remove(self.magazine)
            self.character:removeFromHands(self.magazine)
            if not self.magazine:hasTag(Gun93Registries.guns93.MoonClip) then
                self.gun:setMagazineType(self.magazine:getFullType())
                self.gun:setMaxAmmo(self.magazine:getMaxAmmo())
                self.gun:setContainsClip(true)
            end
            self.gun:setCurrentAmmoCount(self.magazine:getCurrentAmmoCount())
            if self.magazine:getCategory() == "WeaponPart" then
                self.gun:attachWeaponPart(self.magazine)
            end
            sendRemoveItemFromContainer(self.character:getInventory(), self.magazine)
        end
    end
    syncHandWeaponFields(self.character, self.gun)
    DynamicMagClip(self.magazine)
    self.character:getInventory():setDirty(true)
	if not isServer() and not isClient() then
        if self.magazine:hasTag(Gun93Registries.guns93.SpeedStrip) and self.gun:getCurrentAmmoCount() < self.gun:getMaxAmmo() and self.magazine:getCurrentAmmoCount() > 0 then
            ISTimedActionQueue.addAfter(self, ISInsertMagazine:new(self.character, self.gun, self.magazine))
        end
       if self.gun:haveChamber() and not self.gun:isRoundChambered() and not self.gun:hasTag(Gun93Registries.guns93.MoonClip) and self.gun:getCurrentAmmoCount() >= self.gun:getAmmoPerShoot() then
           ISTimedActionQueue.addAfter(self, ISRackFirearm:new(self.character, self.gun))
        end
    end
end

local ISInsertMagazine_perform_Old = ISInsertMagazine.perform
function ISInsertMagazine:perform()
    if not self.magazine:hasTag(Gun93Registries.guns93.Guns93Mag) then
        return ISInsertMagazine_perform_Old(self)
    end
	if self.gun:getInsertAmmoStopSound() then
		self.character:playSound(self.gun:getInsertAmmoStopSound());
	end
	self.gun:setJobDelta(0.0)
	self.magazine:setJobDelta(0.0)
	self.character:clearVariable("isLoading")
	self.character:clearVariable("WeaponReloadType")

	if isClient() then
        if self.magazine:hasTag(Gun93Registries.guns93.SpeedStrip) and self.gun:getCurrentAmmoCount() < self.gun:getMaxAmmo() and self.magazine:getCurrentAmmoCount() > 0 then
            ISTimedActionQueue.addAfter(self, ISInsertMagazine:new(self.character, self.gun, self.magazine))
        end
        if self.gun:haveChamber() and not self.gun:isRoundChambered() and not self.gun:hasTag(Gun93Registries.guns93.MoonClip) and self.gun:getCurrentAmmoCount() >= self.gun:getAmmoPerShoot() then
			ISTimedActionQueue.addAfter(self, ISRackFirearm:new(self.character, self.gun))
		end
	end
	ISBaseTimedAction.perform(self)
end

local ISEjectMagazine_start_Old = ISEjectMagazine.start
function ISEjectMagazine:start()
    if not self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        return ISEjectMagazine_start_Old(self)
    end
	if not self.gun:isContainsClip() and not self.gun:getWeaponPart("Moonclip") then
		self:forceStop()
		return
	end
	self:setAnimVariable("WeaponReloadType", tostring(self.gun:getWeaponReloadType()))
	self:setAnimVariable("isUnloading", true)
	self:setOverrideHandModels(self.gun, nil)
	self:setActionAnim(CharacterActionAnims.Reload)
	self.character:reportEvent("EventReloading");
	self:initVars()
end

local ISEjectMagazine_unloadAmmo_Old = ISEjectMagazine.unloadAmmo
function ISEjectMagazine:unloadAmmo()
    if isClient() then return end
    if not self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        return ISEjectMagazine_unloadAmmo_Old(self)
    end
    local newMag = nil
    if Guns93reloadTypeisEnBloc(self.gun) and self.gun:isContainsClip() then
        newMag = instanceItem(self.gun:getMagazineType())
        if self.gun:isRoundChambered() then
            self.gun:setRoundChambered(false)
            self.character:getInventory():AddItem(self.gun:getAmmoType():getItemKey())
        end
        newMag:setCurrentAmmoCount(self.gun:getCurrentAmmoCount())
    elseif self.gun:getWeaponPart("Moonclip") then
        local moonClip = self.gun:getWeaponPart("Moonclip")
        newMag = instanceItem(moonClip:getFullType())
        newMag:setCurrentAmmoCount(self.gun:getCurrentAmmoCount())
        Guns93BrassEject(self.character, self.gun)
        DynamicMagClip(newMag)
        self.gun:detachWeaponPart(moonClip)
    elseif self.gun:isContainsClip() then
        if self.gun:getWeaponPart("Clip") then
            newMag = self.gun:getWeaponPart("Clip")
        else
            newMag = instanceItem(self.gun:getMagazineType())
        end
        if Guns93reloadTypeisOpenBolt(self.gun) then
            if self.gun:isRoundChambered() then
                self.gun:setRoundChambered(false)
                newMag:setCurrentAmmoCount(self.gun:getCurrentAmmoCount() + 1)
            else
                newMag:setCurrentAmmoCount(self.gun:getCurrentAmmoCount())
            end
        end
        newMag:setCurrentAmmoCount(self.gun:getCurrentAmmoCount())
        DynamicMagClip(newMag)
        if newMag == self.gun:getWeaponPart("Clip") then 
            self.gun:detachWeaponPart(newMag) 
        end
    end
    if newMag then
        self.character:getInventory():AddItem(newMag)
        sendAddItemToContainer(self.character:getInventory(), newMag)
    end
    self.gun:setContainsClip(false)
    self.gun:setCurrentAmmoCount(0)
    syncHandWeaponFields(self.character, self.gun)
    self.character:getInventory():setDirty(true)
end

local ISInsertMagazine_initVars_Old = ISInsertMagazine.initVars
function ISInsertMagazine:initVars()
    if not self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        return ISInsertMagazine_initVars_Old(self)
    end
    ISReloadWeaponAction.setReloadSpeed(self.character, false, self.magazine)
--    if self.magazine:hasTag(Gun93Registries.guns93.StripperClip) and self.gun:haveChamber() then
--        local currentCapacity = self.gun:getCurrentAmmoCount()
--        ISTimedActionQueue.add(ISRackFirearm:new(self.character, self.gun))
--        self.gun:setRoundChambered(false)
--        self.gun:setCurrentAmmoCount(currentCapacity)
--        syncHandWeaponFields(self.character, self.gun)
--    end
end

local ISRackFirearm_rackBullet_Old = ISRackFirearm.rackBullet
function ISRackFirearm:rackBullet()
    if not self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        return ISRackFirearm_rackBullet_Old(self)
    end
    if self.gun:getWeaponPart("Moonclip") then
        ISTimedActionQueue.add(ISEjectMagazine:new(self.character, self.gun))
    end
    if self.gun:haveChamber() then
        if self.gun:isJammed() and self.gun:checkUnJam(self.character) then
            syncHandWeaponFields(self.character, self.gun)
            return
        end
        if self.gun:isRoundChambered() then
            if not self.gun:isJammed() then
                self:removeBullet()
            elseif self.gun:isSpentRoundChambered() then
                Guns93BrassPicker(self.character, self.gun)
            end
        end
        self.gun:setRoundChambered(false)
        self.gun:setJammed(false)
        if self.gun:getCurrentAmmoCount() >= self.gun:getAmmoPerShoot() then
            self.gun:setRoundChambered(true)
            self.gun:setCurrentAmmoCount(self.gun:getCurrentAmmoCount() - self.gun:getAmmoPerShoot())
            if self.gun:getJamGunChance() > 0 then
                self.gun:checkJam(self.character, true)
            end
        end
    else
		self.gun:setJammed(false)
    end
    syncHandWeaponFields(self.character, self.gun)
end

local ISReloadWeaponAction_setReloadSpeed_old = ISReloadWeaponAction.setReloadSpeed
function ISReloadWeaponAction.setReloadSpeed(character, rack, mag)
    local gun = character:getPrimaryHandItem()
    if gun and instanceof(gun, "HandWeapon") and not gun:hasTag(Gun93Registries.guns93.Guns93) then
        return ISReloadWeaponAction_setReloadSpeed_old(character, rack)
    end
    local baseReloadSpeed = 0.7
    if rack then
        baseReloadSpeed = 0.8
		baseReloadSpeed = baseReloadSpeed + (character:getPerkLevel(Perks.Reloading) * 0.04);
        baseReloadSpeed = baseReloadSpeed - (character:getMoodles():getMoodleLevel(MoodleType.PANIC) * 0.04)
        if gun:hasTag(Gun93Registries.guns93.FastRack) then 
            baseReloadSpeed = baseReloadSpeed * 1.1
        elseif gun:hasTag(Gun93Registries.guns93.SlowRack) then 
            baseReloadSpeed = baseReloadSpeed * 0.7
        end
        local handguard = gun:getWeaponPart("Handguard")
        if handguard then
            if handguard:hasTag(Gun93Registries.guns93.FastRack) then 
                baseReloadSpeed = baseReloadSpeed * 1.1
            elseif handguard:hasTag(Gun93Registries.guns93.SlowRack) then 
                baseReloadSpeed = baseReloadSpeed * 0.7
            end
        end
        local chargeHandle = gun:getWeaponPart("ChargeHandle")
        if chargeHandle then
            if chargeHandle:hasTag(Gun93Registries.guns93.FastRack) then 
                baseReloadSpeed = baseReloadSpeed * 1.1
            elseif chargeHandle:hasTag(Gun93Registries.guns93.SlowRack) then 
                baseReloadSpeed = baseReloadSpeed * 0.7
            end
        end
    else
		baseReloadSpeed = baseReloadSpeed + (character:getPerkLevel(Perks.Reloading) * 0.10);
		baseReloadSpeed = baseReloadSpeed - (character:getMoodles():getMoodleLevel(MoodleType.PANIC) * 0.05);
        local strap = character:getWornItem(ItemBodyLocation.AMMO_STRAP)
        local reloadFast = character:hasEquippedTag(ItemTag.RELOAD_FAST_SHELLS) or character:hasEquippedTag(ItemTag.RELOAD_FAST_BULLETS)
        local shellStrap = strap and strap:getClothingItemName() == "AmmoStrap_Shells"
        local bulletStrap = strap and strap:getClothingItemName() == "AmmoStrap_Bullets"
        local strapFound = false
        if gun then
            local isShell = gun:getAmmoType():getItemKey() == "Base.ShotgunShells" or gun:getAmmoType():getItemKey() == "Base.SlugBullets"
            local isMagazine = gun:getMagazineType() or mag
            if gun:hasTag(Gun93Registries.guns93.FastReload) then 
                baseReloadSpeed = baseReloadSpeed * 1.1
            elseif gun:hasTag(Gun93Registries.guns93.SlowReload) then 
                baseReloadSpeed = baseReloadSpeed * 0.7
            end
            if isMagazine and (character:hasEquippedTag(ItemTag.RELOAD_FAST_MAGAZINES) or character:hasWornTag(ItemTag.RELOAD_FAST_MAGAZINES)) then
                strapFound = true
            elseif isShell and (character:hasEquippedTag(ItemTag.RELOAD_FAST_SHELLS) or character:hasWornTag(ItemTag.RELOAD_FAST_SHELLS) or shellStrap) then
                strapFound = true
            elseif not isShell and not isMagazine and (character:hasEquippedTag(ItemTag.RELOAD_FAST_BULLETS) or character:hasWornTag(ItemTag.RELOAD_FAST_BULLETS) or bulletStrap) then
                strapFound = true
            end
            local mgwell = gun:getWeaponPart("Magwell")
            if mgwell then
                if mgwell:hasTag(Gun93Registries.guns93.FastMag1) then 
                    baseReloadSpeed = baseReloadSpeed * 1.4
                elseif mgwell:hasTag(Gun93Registries.guns93.FastMag2) then 
                    baseReloadSpeed = baseReloadSpeed * 2
                end
            end
            if mag then
                if mag:hasTag(Gun93Registries.guns93.SlowMag1) then
                    baseReloadSpeed = baseReloadSpeed * 0.7
                elseif mag:hasTag(Gun93Registries.guns93.SlowMag2) then
                    baseReloadSpeed = baseReloadSpeed * 0.5
                elseif mag:hasTag(Gun93Registries.guns93.SlowMag3) then
                    baseReloadSpeed = baseReloadSpeed * 0.2
                elseif mag:hasTag(Gun93Registries.guns93.FastMag1) then
                    baseReloadSpeed = baseReloadSpeed * 1.1
                elseif mag:hasTag(Gun93Registries.guns93.FastMag2) then
                    baseReloadSpeed = baseReloadSpeed * 1.3
                end
            end
        end
        if strapFound then 
            baseReloadSpeed = baseReloadSpeed * 1.15 
        end
    end
    if character:getVehicle() and character:getVehicle():getDriver() == character then
        baseReloadSpeed = baseReloadSpeed * 0.8
    end
    character:setVariable("ReloadSpeed", baseReloadSpeed)
end

local reloadMagazine = function(playerObj, magazine)
	if not magazine then
		return 0
	end
	local itemKey = magazine:getAmmoType():getItemKey();
	local ammoCount = magazine:getCurrentAmmoCount() + ISInventoryPaneContextMenu.transferBullets(playerObj, itemKey, magazine:getCurrentAmmoCount(), magazine:getMaxAmmo())
	if ammoCount > 0 then
		ISTimedActionQueue.add(ISLoadBulletsInMagazine:new(playerObj, magazine, ammoCount))
	end
	return ammoCount
end

local old_BeginAutomaticReload = ISReloadWeaponAction.BeginAutomaticReload
function ISReloadWeaponAction.BeginAutomaticReload(playerObj, gun)
    if not gun or not gun:hasTag(Gun93Registries.guns93.Guns93) then
        return old_BeginAutomaticReload(playerObj, gun)
    end
    if gun:isContainsClip() or gun:getWeaponPart("Moonclip") then
        ISTimedActionQueue.add(ISEjectMagazine:new(playerObj, gun))
    end
    local bestMag = nil
    local highest = -1
    local gunType = gun:getFullType()
    local magList = MagazineGunSet[gunType]
    if magList then
        for _, magType in ipairs(magList) do
            local items = playerObj:getInventory():getAllTypeRecurse(magType)
            for k = 0, items:size() - 1 do
                local mag = items:get(k)
                if mag and mag:getCurrentAmmoCount() > highest then
                    if not (mag:hasTag(Gun93Registries.guns93.SpeedLoader) and gun:getCurrentAmmoCount() > mag:getCurrentAmmoCount()) then
                        highest = mag:getCurrentAmmoCount()
                        bestMag = mag
                    end
                end
            end
        end
    end
    if not bestMag and gun:getMagazineType() then
        local items = playerObj:getInventory():getAllTypeRecurse(gun:getMagazineType())
        for k = 0, items:size() - 1 do
            local mag = items:get(k)
            if mag and mag:getCurrentAmmoCount() > highest then
                if not (mag:hasTag(Gun93Registries.guns93.SpeedLoader) and gun:getCurrentAmmoCount() > mag:getCurrentAmmoCount()) then
                    highest = mag:getCurrentAmmoCount()
                    bestMag = mag
                end
            end
        end
    end
    if bestMag then
        if (bestMag:hasTag(Gun93Registries.guns93.MoonClip) or bestMag:hasTag(Gun93Registries.guns93.SpeedLoader) or bestMag:hasTag(Gun93Registries.guns93.SpeedStrip)) and gun:getSpentRoundCount() > 0 then
            ISTimedActionQueue.add(ISRackFirearm:new(playerObj, gun))
        end
        if bestMag:hasTag(Gun93Registries.guns93.MoonClip) and gun:getCurrentAmmoCount() > 0 then
            ISTimedActionQueue.add(ISUnloadBulletsFromFirearm:new(playerObj, gun))
        end
        if bestMag:getCurrentAmmoCount() > 0 then
            ISInventoryPaneContextMenu.transferIfNeeded(playerObj, bestMag)
            if bestMag:hasTag(Gun93Registries.guns93.StripperClip) then
                ISTimedActionQueue.add(ISUnloadRackFirearm:new(playerObj, gun))
            end
            local readyLoad = true
            if bestMag:hasTag(Gun93Registries.guns93.MoonClip) or bestMag:hasTag(Gun93Registries.guns93.SpeedLoader) then
                if gun:getCurrentAmmoCount() > 0 then
                    readyLoad = false
                end
            end
            if readyLoad then
                ISTimedActionQueue.add(ISInsertMagazine:new(playerObj, gun, bestMag))
            end
            if readyLoad then return end
        end
        if not (bestMag:hasTag(Gun93Registries.guns93.MoonClip) or bestMag:hasTag(Gun93Registries.guns93.SpeedLoader) or bestMag:hasTag(Gun93Registries.guns93.SpeedStrip) or bestMag:hasTag(Gun93Registries.guns93.StripperClip)) then
            local ammoCount = reloadMagazine(playerObj, bestMag)
            if ammoCount > 0 or not gun:isContainsClip() then
                ISInventoryPaneContextMenu.transferIfNeeded(playerObj, bestMag)
                ISTimedActionQueue.add(ISInsertMagazine:new(playerObj, gun, bestMag))
                return
            end
        end
    elseif gun:getMagazineType() then
	    ISTimedActionQueue.queueActions(playerObj, ISReloadWeaponAction.ReloadBestMagazine, gun)
    end
    if not gun:getMagazineType() or (gun:getCurrentAmmoCount() >= gun:getMaxAmmo() and not gun:isJammed()) then
        local ammoCount = ISInventoryPaneContextMenu.transferBullets(playerObj, gun:getAmmoType():getItemKey(), gun:getCurrentAmmoCount(), gun:getMaxAmmo())
        if ammoCount > 0 then
            ISTimedActionQueue.add(ISReloadWeaponAction:new(playerObj, gun))
        end
    end
end

local function SetMagazineStats(player, weapon)
    if not weapon or not weapon:hasTag(Gun93Registries.guns93.Guns93) then return end
    local clip = weapon:getWeaponPart("Clip") or false
    local magExten1 = weapon:getWeaponPart("BarrelItem") or false
    local magExten2 = weapon:getWeaponPart("MagExten") or false
    local hasPart = false
    if clip then
        if clip:hasTag(Gun93Registries.guns93.Guns93Mag) or clip:hasTag(Gun93Registries.guns93.MagExten) then
            hasPart = true
        end
    end
    if magExten1 then
        if magExten1:hasTag(Gun93Registries.guns93.Guns93Mag) or magExten1:hasTag(Gun93Registries.guns93.MagExten) then
            hasPart = true
        end
    end
    if magExten2 then
        if magExten2:hasTag(Gun93Registries.guns93.Guns93Mag) or magExten2:hasTag(Gun93Registries.guns93.MagExten) then
            hasPart = true
        end
    end
    if hasPart then
        if clip and clip:hasTag(Gun93Registries.guns93.Guns93Mag) then
            weapon:setMagazineType(clip:getFullType())
            weapon:setMaxAmmo(clip:getMaxAmmo())
        elseif magExten1 or magExten2 then
            weapon:setMaxAmmo(magExten1:getMaxAmmo())
        end
    elseif not clip and not magExten1 or not magExten2 then
        local baseCount = weapon:getModData().isBaseAmmo
        if baseCount then
            weapon:setMaxAmmo(baseCount)
        end
    end
    player:getInventory():setDirty(true)
end

Events.OnEquipPrimary.Add(SetMagazineStats)

Events.OnGameStart.Add(function()
    local player = getPlayer()
    if player then
        SetMagazineStats(player, player:getPrimaryHandItem())
    end
end)

local old_ISUnequipAction_complete = ISUnequipAction.complete
function ISUnequipAction:complete()
    if instanceof(self.item, "HandWeapon") and self.item:hasTag(Gun93Registries.guns93.Guns93) then
        local parts = self.item:getAllWeaponParts()
        if parts and not parts:isEmpty() then
            local toToggle = {}
            for i = 0, parts:size() - 1 do
                local part = parts:get(i)
                if part and (part:hasTag(Gun93Registries.guns93.Light) or part:hasTag(Gun93Registries.guns93.Laser)) then
                    if part:hasTag(Gun93Registries.guns93.ToggleItemOff) then
                        local newType = string.gsub(part:getFullType(), "_On$", "")
                        if newType and newType ~= part:getFullType() then
                            table.insert(toToggle, {old = part, newType = newType})
                        end
                    end
                end
            end
            for _, data in ipairs(toToggle) do
                local part = data.old
                local newPart = instanceItem(data.newType)
                if newPart then
                    newPart:setCurrentUses(part:getCurrentUses())
                    self.item:detachWeaponPart(part)
                    self.item:attachWeaponPart(newPart)
                end
            end
        end
        syncItemModData(self.character, self.item)
        syncHandWeaponFields(self.character, self.item)
    end
    return old_ISUnequipAction_complete(self)
end

local function Guns93BullpupStock(weapon, isRemove)
    if isRemove then
        weapon:setWeaponSprite((string.gsub(weapon:getWeaponSprite(), "Bullpup$", "")))
    else
        weapon:setWeaponSprite((string.gsub(weapon:getWeaponSprite(), "Bullpup$", "")))
        weapon:setWeaponSprite(weapon:getWeaponSprite() .. "Bullpup")
    end
end

local old_ISRemoveWeaponUpgrade_complete = ISRemoveWeaponUpgrade.complete
function ISRemoveWeaponUpgrade:complete()
    if self.weapon:hasTag(Gun93Registries.guns93.Guns93) then
        local part = self.weapon:getWeaponPart(self.partType)
        local sync = false
        if part then
            if part:hasTag(Gun93Registries.guns93.BullpupStock) then
                Guns93BullpupStock(self.weapon, true)
                sync = true
            elseif part:hasTag(Gun93Registries.guns93.ToggleItemOff) then
                if part:isActivated() then
                    part:setActivated(false)
                end
                local newPart = instanceItem(string.gsub(part:getFullType(), "_On$", ""))
                newPart:setCurrentUses(part:getCurrentUses())
                self.weapon:detachWeaponPart(self.character, part)
                self.weapon:attachWeaponPart(self.character, newPart)
                sync = true
            elseif part:hasTag(Gun93Registries.guns93.Guns93Mag) or part:hasTag(Gun93Registries.guns93.MagExten) then
                local baseCount = self.weapon:getModData().isBaseAmmo
                if baseCount then
                    self.weapon:setMaxAmmo(baseCount)
                end
            end
            if sync then
                syncHandWeaponFields(self.character, self.weapon)
            end
        end
    end
    return old_ISRemoveWeaponUpgrade_complete(self)
end

local old_ISRemoveWeaponUpgrade_getDuration = ISRemoveWeaponUpgrade.getDuration
function ISRemoveWeaponUpgrade:getDuration()
    if self.weapon:hasTag(Gun93Registries.guns93.Guns93) then
        local part = self.weapon:getWeaponPart(self.partType)
        if part:hasTag(Gun93Registries.guns93.QDMount) then
            return 15;
        end
    end
    return old_ISRemoveWeaponUpgrade_getDuration(self)
end

local old_ISUpgradeWeapon_complete = ISUpgradeWeapon.complete
function ISUpgradeWeapon:complete()
    if self.weapon:hasTag(Gun93Registries.guns93.Guns93) then
        local sync = false
        if self.part:hasTag(Gun93Registries.guns93.BullpupStock) then
            Guns93BullpupStock(self.weapon, false)
            sync = true
        elseif self.part:hasTag(Gun93Registries.guns93.Guns93Mag) or self.part:hasTag(Gun93Registries.guns93.MagExten) then
            SetMagazineStats(self.character, self.weapon)
            sync = true
        end
        if sync then
            syncHandWeaponFields(self.character, self.weapon)
        end
    end
    return old_ISUpgradeWeapon_complete(self)
end

local old_ISUpgradeWeapon_getDuration = ISUpgradeWeapon.getDuration
function ISUpgradeWeapon:getDuration()
    if self.weapon:hasTag(Gun93Registries.guns93.Guns93) then
        if self.part:hasTag(Gun93Registries.guns93.QDMount) then
            return 15;
        end
    end
    return old_ISUpgradeWeapon_getDuration(self)
end

local function Guns93BreakActionClosed(player, weapon)
    if weapon and tostring(weapon:getWeaponReloadType()) == "doublebarrelshotgun" then
        local sprite = weapon:getWeaponSprite()
        sprite = string.gsub(sprite, "_OPEN", "")
        weapon:setWeaponSprite(sprite)
        player:resetEquippedHandsModels()
    end
end

local function Guns93BreakActionOpen(player, weapon)
    if weapon and tostring(weapon:getWeaponReloadType()) == "doublebarrelshotgun" then
        local sprite = weapon:getWeaponSprite()
        sprite = string.gsub(sprite, "_OPEN", "")
        sprite = sprite .. "_OPEN"
        weapon:setWeaponSprite(sprite)
        player:resetEquippedHandsModels()
    end
end

ISReloadWeaponAction_loadAmmo_Old = ISReloadWeaponAction.loadAmmo
function ISReloadWeaponAction.loadAmmo(self)
	if self.bullets and self.gun:hasTag(Gun93Registries.guns93.SingleEject) then
		if not self.bullets:isEmpty() and self.gun:getCurrentAmmoCount() < self.gun:getMaxAmmo() then
			local bullet = self.bullets:get(0);
            Guns93BrassEject(self.character, self.gun)
			self.bullets:remove(bullet);
			self.character:getInventory():Remove(bullet);
			self.gun:setCurrentAmmoCount(self.gun:getCurrentAmmoCount() + 1);
			sendRemoveItemFromContainer(self.character:getInventory(), bullet)
			syncHandWeaponFields(self.character, self.gun)
		end
		if self.bullets:isEmpty() or self.gun:getCurrentAmmoCount() >= self.gun:getMaxAmmo() then
			self.character:clearVariable("isLoading");
			if not isServer() then
				if self.gun:haveChamber() and not self.gun:isRoundChambered() then
					ISTimedActionQueue.addAfter(self, ISRackFirearm:new(self.character, self.gun))
				end
                if self.gun:needToBeClosedOnceReload() then
                    self:setAnimVariable("isLoading", false);
                    self:setAnimVariable("isRacking", true);
                    return;
                end
			end
			if isServer() then
				self.netAction:forceComplete()
			else
				self:forceComplete()
			end
		elseif self.gun:isInsertAllBulletsReload() then
			self:loadAmmo()
		end
	else
        return ISReloadWeaponAction_loadAmmo_Old(self)
    end
end

ISReloadWeaponAction_canShoot = ISReloadWeaponAction.canShoot
ISReloadWeaponAction.canShoot = function(player, weapon)
    if weapon:hasTag(Gun93Registries.guns93.Guns93) then
        if weapon:hasTag(Gun93Registries.guns93.ReqTrigger) and not weapon:getWeaponPart("Trigger") then
            return false
        elseif weapon:hasTag(Gun93Registries.guns93.ReqGrip) and not weapon:getWeaponPart("Grip") then
            local stock = weapon:getWeaponPart("Stock")
            if not (stock and stock:hasTag(Gun93Registries.guns93.Sport)) then
                return false
            end
        elseif weapon:hasTag(Gun93Registries.guns93.ReqStock) and not weapon:getWeaponPart("Stock") then
            return false
        end
    end
    return ISReloadWeaponAction_canShoot(player, weapon)
end

ISReloadWeaponAction_animEvent_Old = ISReloadWeaponAction.animEvent
function ISReloadWeaponAction.animEvent(self, event, parameter)
    if tostring(event) == "changeWeaponSprite" and self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        Guns93BreakActionOpen(self.character, self.gun)
    else
        return ISReloadWeaponAction_animEvent_Old(self, event, parameter)
    end
end

ISReloadWeaponAction_perform_Old = ISReloadWeaponAction.perform
function ISReloadWeaponAction.perform(self)
    if self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        Guns93BreakActionClosed(self.character, self.gun)
    end
    return ISReloadWeaponAction_perform_Old(self)
end


ISReloadWeaponAction_complete_Old = ISReloadWeaponAction.complete
function ISReloadWeaponAction.complete(self)
    if self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        Guns93BreakActionClosed(self.character, self.gun)
    end
    return ISReloadWeaponAction_complete_Old(self)
end

ISReloadWeaponAction_stop_Old = ISReloadWeaponAction.stop
function ISReloadWeaponAction.stop(self)
    if self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        Guns93BreakActionClosed(self.character, self.gun)
    end
	return ISReloadWeaponAction_stop_Old(self)
end

ISUnloadBulletsFromFirearm_animEvent_Old = ISUnloadBulletsFromFirearm.animEvent
function ISUnloadBulletsFromFirearm.animEvent(self, event, parameter)
    if tostring(event) == "changeWeaponSprite" and self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        Guns93BreakActionOpen(self.character, self.gun)
    else        
        return ISUnloadBulletsFromFirearm_animEvent_Old(self, event, parameter)
    end
end

ISUnloadBulletsFromFirearm_complete_Old = ISUnloadBulletsFromFirearm.complete
function ISUnloadBulletsFromFirearm.complete(self)
    if self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        Guns93BreakActionClosed(self.character, self.gun)
    end
	return ISUnloadBulletsFromFirearm_complete_Old(self)
end

ISUnloadBulletsFromFirearm_stop_Old =ISUnloadBulletsFromFirearm.stop
function ISUnloadBulletsFromFirearm.stop(self)
    if self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        Guns93BreakActionClosed(self.character, self.gun)
    end
	return ISUnloadBulletsFromFirearm_stop_Old(self)
end

ISRackFirearm_animEvent_Old = ISRackFirearm.animEvent
function ISRackFirearm.animEvent(self, event, parameter)
    if tostring(event) == "changeWeaponSprite" and self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        Guns93BreakActionOpen(self.character, self.gun)
    else 
        return ISRackFirearm_animEvent_Old(self, event, parameter)
    end
end

ISRackFirearm_complete_Old = ISRackFirearm.complete
function ISRackFirearm.complete(self)
    if self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        Guns93BreakActionClosed(self.character, self.gun)
    end
	return ISRackFirearm_complete_Old(self)
end

ISRackFirearm_stop_Old = ISRackFirearm.stop
function ISRackFirearm.stop(self)
    if self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        Guns93BreakActionClosed(self.character, self.gun)
    end
	return ISRackFirearm_stop_Old(self)
end

ISUnloadRackFirearm = ISBaseTimedAction:derive("ISUnloadRackFirearm")

function ISUnloadRackFirearm:isValid()
	return true
end

function ISUnloadRackFirearm:start()
	if isClient() then
		self.gun = self.character:getInventory():getItemById(self.gun:getID())
	end
	if not ISReloadWeaponAction.canRack(self.gun) then
		self:forceComplete()
		return
	end
	self:setAnimVariable("WeaponReloadType", tostring(self.gun:getWeaponReloadType()))
	if self.gun:haveChamber() then
		self:setAnimVariable("isRacking", true)
	else
		self:setAnimVariable("isUnloading", true)
	end

	self:setAnimVariable("RackAiming", self.character:isAiming())
	if self.character:isAiming() then
		self.character:setAimingDelay(self.character:getAimingDelay() + self.gun:getAimingTime() * (0.15 - self.character:getPerkLevel(Perks.Reloading)*0.01))
	end
	self:setOverrideHandModels(self.gun, nil)
	self:setActionAnim(CharacterActionAnims.Reload)
	self.character:reportEvent("EventReloading");

	self:ejectSpentRounds()

	self:initVars()
end

function ISUnloadRackFirearm:update()
end

function ISUnloadRackFirearm:rackBullet()
	if self.gun:haveChamber() then
		if self.gun:isJammed() and self.gun:checkUnJam(self.character) then
			syncHandWeaponFields(self.character, self.gun)
			return
		end
		if not self.gun:isJammed() and self.gun:isRoundChambered() then
			self:removeBullet()
		end
		self.gun:setRoundChambered(false)
		self.gun:setJammed(false)
	else
		if not self.gun:isJammed() and self.gun:getCurrentAmmoCount() > 0 then
			self:removeBullet()
			self.gun:setCurrentAmmoCount(self.gun:getCurrentAmmoCount() - self.gun:getAmmoPerShoot())
		end
		self.gun:setJammed(false)
	end
	syncHandWeaponFields(self.character, self.gun)
end

function ISUnloadRackFirearm:removeBullet()
    local itemKey = self.gun:getAmmoType():getItemKey();
	local newBullet = instanceItem(itemKey)
	self.character:getInventory():AddItem(newBullet)
	sendAddItemToContainer(self.character:getInventory(), newBullet)
end

function ISUnloadRackFirearm:ejectSpentRounds()
	if self.gun:getSpentRoundCount() > 0 then
		self.gun:setSpentRoundCount(0)
		syncHandWeaponFields(self.character, self.gun)
	elseif self.gun:isSpentRoundChambered() then
		self.gun:setSpentRoundChambered(false)
		syncHandWeaponFields(self.character, self.gun)
	else
		return
	end
	if self.gun:getShellFallSound() then
		self.character:getEmitter():playSound(self.gun:getShellFallSound())
	end
end

function ISUnloadRackFirearm:initVars()
    ISReloadWeaponAction.setReloadSpeed(self.character, rack, self.magazine)
end

function ISUnloadRackFirearm:stop()
	if self.playedEjectAmmoStartSound and self.gun:getEjectAmmoStopSound() then
		self.character:playSound(self.gun:getEjectAmmoStopSound());
	end
	self.character:clearVariable("isLoading")
	self.character:clearVariable("isRacking")
	self.character:clearVariable("isUnloading")
	self.character:clearVariable("WeaponReloadType")
	self.character:clearVariable("RackAiming")
	ISBaseTimedAction.stop(self)
end

function ISUnloadRackFirearm:perform()
	if self.playedEjectAmmoStartSound and self.gun:getEjectAmmoStopSound() then
		self.character:playSound(self.gun:getEjectAmmoStopSound());
	end
	self.character:clearVariable("isLoading")
	self.character:clearVariable("isRacking")
	self.character:clearVariable("isUnloading")
	self.character:clearVariable("WeaponReloadType")
	self.character:clearVariable("RackAiming")
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISUnloadRackFirearm:serverStart()
	self:ejectSpentRounds()
	self:initVars()
	emulateAnimEventOnce(self.netAction, ISReloadWeaponAction.getReloadTime(self.character, 100), "rackBullet", nil)
	emulateAnimEventOnce(self.netAction, ISReloadWeaponAction.getReloadTime(self.character, 1200), "rackingFinished", nil)
end

function ISUnloadRackFirearm:getDuration()
	return -1
end

function ISUnloadRackFirearm:complete()
	return true
end

function ISUnloadRackFirearm:animEvent(event, parameter)
	if event == 'unloadFinished' then
		if not isClient() then
			self:rackBullet()
		end
		if isServer() then
			self.netAction:forceComplete()
		else
			self:forceComplete()
		end
	end
	if event == 'rackBullet' then
		if not isClient() then
			self:rackBullet()
		end
	end
	if event == 'rackingFinished' then
		if isServer() then
			self.netAction:forceComplete()
		else
			self:forceComplete()
		end
	end
	if event == 'playReloadSound' then
		if parameter == 'rack' then
			if self.gun:getRackSound() then
				self.character:playSound(self.gun:getRackSound())
			end
		end
		if parameter == 'ejectAmmoStart' then
			if not self.playedEjectAmmoStartSound and self.gun:getEjectAmmoStartSound() then
				self.playedEjectAmmoStartSound = true;
				self.character:playSound(self.gun:getEjectAmmoStartSound());
			end
			return
		end
		if parameter == 'unload' then
			if self.gun:getEjectAmmoSound() then
				self.character:playSound(self.gun:getEjectAmmoSound())
			end
		end
	end
	if event == "changeWeaponSprite" then
		if parameter and parameter ~= '' then
			if parameter ~= 'original' then
				self:setOverrideHandModels(parameter, nil)
			else
				self:setOverrideHandModels(self.gun:getWeaponSprite(), nil)
			end
		end
	end
end

function ISUnloadRackFirearm:new(character, gun)
	local o = ISBaseTimedAction.new(self, character)
	o.stopOnAim = false
	o.stopOnWalk = false
	o.stopOnRun = true
	o.maxTime = o:getDuration()
	o.useProgressBar = false
	o.gun = gun
	return o
end

-- FireModeHotKey.lua
local FireModeHotKey = {}

local FIRE_MODE_ORDER = { "Single", "Burst", "Auto" }

local function getAvailableFireModes(weapon)
    local available = {}
    local possibilities = weapon:getFireModePossibilities()
    for i = 0, possibilities:size() - 1 do
        local mode = possibilities:get(i)
        available[mode] = true
    end
    if weapon:hasTag(Gun93Registries.guns93.ReqTrigger) then
        local hasFullAuto = false
        local hasBurst = false
        local trigger = weapon:getWeaponPart("Trigger")
        local autoPart = weapon:getWeaponPart("AutoPart")
        if trigger then
            if trigger:hasTag(Gun93Registries.guns93.Fullauto) then 
                hasFullAuto = true 
            end
            if trigger:hasTag(Gun93Registries.guns93.Burst) then
                hasBurst = true
            end
        end
        if autoPart then
            if autoPart:hasTag(Gun93Registries.guns93.Fullauto) then
                hasFullAuto = true
            end
            if autoPart:hasTag(Gun93Registries.guns93.Burst) then
                hasBurst = true
            end
        end
        if not hasFullAuto then
            available["Auto"] = nil
        end
        if not hasBurst then
            available["Burst"] = nil
        end
    end
    return available
end

function FireModeHotKey.FireModeToggle()
    local player = getPlayer()
    if not player then return end
    local weapon = player:getPrimaryHandItem()
    if not weapon or not instanceof(weapon, "HandWeapon") then return end
    if not weapon:hasTag(Gun93Registries.guns93.Guns93) then return end
    local possibilities = weapon:getFireModePossibilities()
    if not possibilities or possibilities:size() <= 1 then return end
    local available = getAvailableFireModes(weapon)
    local current = weapon:getFireMode()
    local startIndex = 1
    for i, mode in ipairs(FIRE_MODE_ORDER) do
        if mode == current then
            startIndex = i
            break
        end
    end
    for offset = 1, #FIRE_MODE_ORDER do
        local index = ((startIndex - 1 + offset) % #FIRE_MODE_ORDER) + 1
        local nextMode = FIRE_MODE_ORDER[index]
        if available[nextMode] then
            weapon:setFireMode(nextMode)
            player:setHaloNote(nextMode)
            GunStatAdjust(player, weapon)
            return
        end
    end
end

function FireModeHotKey.addHotkey()
    table.insert(keyBinding, { value = "FireMode_Toggle", key = Keyboard.KEY_TAB })
end

function FireModeHotKey.onKeyPressed(key)
    if key ~= getCore():getKey("FireMode_Toggle") then return end
    local player = getPlayer()
    if not player then return end
    local weapon = player:getPrimaryHandItem()
    if not weapon or not instanceof(weapon, "HandWeapon") then return end
    if not weapon:hasTag(Gun93Registries.guns93.Guns93) then return end
    local possibilities = weapon:getFireModePossibilities()
    if not possibilities or possibilities:size() <= 1 then return end
    local available = getAvailableFireModes(weapon)
    local count = 0
    for _ in pairs(available) do count = count + 1 end
    if count > 1 then
        FireModeHotKey.FireModeToggle()
    end
end

FireModeHotKey.addHotkey()
Events.OnKeyPressed.Add(FireModeHotKey.onKeyPressed)

return FireModeHotKey