local function Guns93AddChambered(item, round)
    local modData = item:getModData()
    if modData then
        modData.Guns93Chambered = round
    end
end

function Guns93RemoveChambered(item)
    if not item then return nil end
    local modData = item:getModData()
    local round = modData.Guns93Chambered
    if round == nil or round == "Empty" then
        modData.Guns93Chambered = nil
        return nil
    end
    modData.Guns93Chambered = nil
    return round
end

function Guns93AddAmmoTypes(item, bullet)
    if not item or bullet == nil then return end
    local ammoType = type(bullet) == "string" and bullet or (bullet.getFullType and bullet:getFullType()) or tostring(bullet)
    ammoType = tostring(ammoType)
    local list = item:getModData().Guns93AmmoList
    if not list then
        list = {}
        item:getModData().Guns93AmmoList = list
    end
    local top = list[1]
    if top and tostring(top.type) == ammoType then
        top.count = (top.count or 0) + 1
    else
        table.insert(list, 1, {type = ammoType, count = 1})
    end
end

function Guns93RemoveAmmoType(item)
    if not item then return nil end
    local modData = item:getModData()
    modData.Guns93AmmoList = modData.Guns93AmmoList or {}
    local list = modData.Guns93AmmoList
    local top = list[1]
    if not top or not top.type then
        return nil
    end
    local bullet = top.type
    top.count = (top.count or 0) - 1
    if top.count <= 0 then
        table.remove(list, 1)
    end
    return bullet
end

function Guns93AddSpentAmmo(item, bullet)
    if bullet == nil then return end
    bullet = tostring(bullet)
    local modData = item:getModData()
    modData.Guns93SpentList = modData.Guns93SpentList or {}
    if modData.Guns93SpentList then
        local list = modData.Guns93SpentList
        local top = list[1]
        if top and tostring(top.type) == bullet then
            top.count = (top.count or 0) + 1
        else
            table.insert(list, {type = bullet, count = 1})
        end
    end
end

function Guns93RemoveSpentAmmo(item)
    if not item then return nil end
    local modData = item:getModData()
    modData.Guns93SpentList = modData.Guns93SpentList or {}
    local list = modData.Guns93SpentList
    local top = list[1]
    if not top or not top.type then
        return nil
    end
    local bullet = top.type
    top.count = (top.count or 0) - 1
    if top.count <= 0 then
        table.remove(list, 1)
    end
    return bullet
end

function Guns93TransferAmmoList(firstItem, secItem, amount)
    amount = amount or 0
    if not firstItem or not secItem or amount <= 0 then
        return 0
    end
    local firstData = firstItem:getModData()
    local secData = secItem:getModData()
    firstData.Guns93AmmoList = firstData.Guns93AmmoList or {}
    secData.Guns93AmmoList = secData.Guns93AmmoList or {}
    local first = firstData.Guns93AmmoList
    local second = secData.Guns93AmmoList
    while amount > 0 and #first > 0 do
        local last = first[#first]  -- last entry on first list
        if not last or not last.type or (last.count or 0) <= 0 then
            table.remove(first, #first)
        else
            local take = math.min(amount, last.count)
            local ammoType = tostring(last.type)
            local top = second[1]
            if top and tostring(top.type) == ammoType then
                top.count = (top.count or 0) + take
            else
                table.insert(second, 1, { type = ammoType, count = take })
            end
            last.count = last.count - take
            if last.count <= 0 then
                table.remove(first, #first)
            end
            amount = amount - take
        end
    end
end

local function Guns93TrimListRounds(list, total)
    if not list or total < 1 then return end
    local number = 0
    for _, entries in ipairs(list) do
        number = number + (entries.count or 0)
    end
    while number > total and #list > 0 do
        local last = list[#list]
        local overflow = number - total
        local take = math.min(last.count or 0, overflow)
        last.count = (last.count or 0) - take
        if (last.count or 0) <= 0 then
            table.remove(list)
        end
    end
end


function Guns93HasMultipleCalibers(item)
    if not item then
        return false
    end
    local list = item:getModData().Guns93AmmoList
    if not list or #list < 1 then
        return false
    end
    local calibers = {}
    local count = 0
    for _, entries in ipairs(list) do
        if entries and entries.type and (entries.count or 0) > 0 then
            local stat = AmmoStatList[entries.type]
            local round = stat and stat.caliber
            if round and not calibers[round] then
                calibers[round] = true
                count = count + 1
                if count >= 2 then
                    return true
                end
            end
        end
    end
    return false
end

local function Guns93reloadTypeisOpenBolt(weapon)
    if not weapon or not instanceof(weapon, "HandWeapon") then return false end
    return weapon:getModData()["isOpenBolt"] == "true"
end

local function Guns93reloadTypeisEnBloc(weapon)
    if not weapon or not instanceof(weapon, "HandWeapon") then return false end
    return weapon:getModData()["EnBloc"] == "true"
end

local function TriggerEnBlocPing(player, weapon)
    if not player or not weapon then return end
    if not Guns93reloadTypeisEnBloc(weapon) then return end
    if weapon:getCurrentAmmoCount() ~= 0 or weapon:isRoundChambered() or not weapon:isContainsClip() then return end
    getSoundManager():PlayWorldSound("GarandPing", player:getCurrentSquare(), 0, 15, 2.0, false)
    if isClient() then
        sendClientCommand("Guns93", "EnBlocEject", {})
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
    weapon:getModData().Guns93AmmoList = nil
    syncItemModData(player, weapon)
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
    local low = 1
    local high = mag:getMaxAmmo()
    if mag:hasTag(Gun93Registries.guns93.AmmoBelt) then
        low = high * 0.2
        high = high * 0.8
    end
    if mag:getCurrentAmmoCount() < low then
        suffix = ""
    elseif mag:getCurrentAmmoCount() < high then
        suffix = "_Half"
    elseif mag:getCurrentAmmoCount() >= high then
        suffix = "_Full"
    end
    local newIcon = baseIcon .. suffix
    local newSprite = baseSprite .. suffix
    mag:getModData().Guns93Icon = newIcon
    mag:setTexture(getTexture("media/textures/item_" .. newIcon .. ".png"))
    mag:setWorldStaticModel(newSprite)
end

Guns93PendingLoad = Guns93PendingLoad or {}

local function guns93ApplyPendingToAction(self, item)
    local pending = Guns93PendingLoad[self.character:getOnlineID()]
    if not pending then return false end
    self.round = pending.round
    self.round2 = pending.round2
    self.bycaliber = pending.bycaliber
    if pending.amount and (not self.ammoCount or self.ammoCount < 1) then
        self.ammoCount = pending.amount
    end
    return true
end

local function guns93ClearPending(player)
    if not player then return end
    Guns93PendingLoad[player:getOnlineID()] = nil
end

local ISLoadBulletsInMagazine_animEvent_Old = ISLoadBulletsInMagazine.animEvent
function ISLoadBulletsInMagazine:animEvent(event, parameter)
    if not self.magazine:hasTag(Gun93Registries.guns93.Guns93Mag) then
        ISLoadBulletsInMagazine_animEvent_Old(event, parameter)
    end
    if event == 'InsertBullet' then
        if self:isLoadFinished() then
            if isServer() then
                guns93ClearPending(self.character)
            end
            DynamicMagClip(self.magazine)
            return
        end
        if self:isLocal() and self.loadedThisLoop then
            return
        end
        self.loadedThisLoop = true
        if not isClient() then
            if isServer() then
                guns93ApplyPendingToAction(self, self.magazine)
            end
            local chance = 5
            local xp = 1
            if self.character:getPerkLevel(Perks.Reloading) < 5 then
                chance = 2
                xp = 4
            end
            if ZombRand(chance) == 0 then
                addXp(self.character, Perks.Reloading, xp)
            end
            local removedBullet = nil
            local ammolink = nil
            local linkNum = nil
            local doLoad = true
            if self.magazine:hasTag(Gun93Registries.guns93.AmmoBelt) then
                ammolink = self.character:getInventory():getItemFromType(self.magazine:getModData().needLink)
                linkNum = self.character:getInventory():getItemCountRecurse(self.magazine:getModData().needLink)
                if linkNum < 1 then
                    doLoad = false
                end
            end
            if doLoad then
                if self.bycaliber then
                    local bullets = ArrayList.new()
                    self.character:getInventory():getAllTagRecurse(Gun93Registries.guns93.Ammo, bullets)
                    local primRound = self.round and tostring(self.round) or nil
                    local secRound = self.round2 and tostring(self.round2) or nil
                    for i = 0, bullets:size() - 1 do
                        local bullet = bullets:get(i)
                        local round = bullet:getModData()
                        local caliber = tostring(round.isCaliber)
                        local ammoType = tostring(bullet:getFullType())
                        if (primRound and (caliber == primRound or ammoType == primRound)) or (secRound and (caliber == secRound or ammoType == secRound)) then
                            removedBullet = bullet
                            break
                        end
                    end
                    if removedBullet then
                        if not removedBullet:hasTag(Gun93Registries.guns93.AmmoBelt) then
                            self.character:getInventory():Remove(removedBullet)
                        end
                    end
                else
                    local itemKey = self.round
                    if not itemKey then
                        itemKey = self.magazine:getAmmoType():getItemKey()
                    end
                    removedBullet = self.character:getInventory():RemoveOneOf(itemKey, true)
                end
            end
            if removedBullet then
                if removedBullet:hasTag(Gun93Registries.guns93.AmmoBelt) then
                    local ammoCount = removedBullet:getCurrentAmmoCount()
                    local magCount = self.magazine:getMaxAmmo() - self.magazine:getCurrentAmmoCount()
                    if ammoCount > magCount then
                        ammoCount = magCount
                    end
                    while ammoCount > 0 do
                        removedBullet:setCurrentAmmoCount(removedBullet:getCurrentAmmoCount() - 1)
                        self.magazine:setCurrentAmmoCount(self.magazine:getCurrentAmmoCount() + 1)
                        local bullet = Guns93RemoveAmmoType(removedBullet)
                        Guns93AddAmmoTypes(self.magazine, bullet)
                        ammoCount = ammoCount - 1
                    end
                    syncItemFields(self.character, removedBullet)
                    syncItemModData(self.character, removedBullet)
                else
                    Guns93AddAmmoTypes(self.magazine, removedBullet:getFullType())
                    self.magazine:setCurrentAmmoCount(self.magazine:getCurrentAmmoCount() + 1)
                    sendRemoveItemFromContainer(self.character:getInventory(), removedBullet)
                    if ammolink ~= nil then
                        self.character:getInventory():Remove(ammolink)
                        sendRemoveItemFromContainer(self.character:getInventory(), ammolink)
                    end
                end
                if removedBullet:getCurrentAmmoCount() < 1 then
                    self.character:getInventory():Remove(removedBullet)
                    sendRemoveItemFromContainer(self.character:getInventory(), removedBullet)
                end
                syncItemFields(self.character, self.magazine)
                syncItemModData(self.character, self.magazine)
            end
        end
        DynamicMagClip(self.magazine)
    elseif event == 'loadFinished' then
        if self:isLoadFinished() then
            if isServer() then
                guns93ClearPending(self.character)
            end
            DynamicMagClip(self.magazine)
            local modData = self.magazine:getModData()
            Guns93TrimListRounds(modData.Guns93AmmoList, self.magazine:getMaxAmmo())
            self.loadFinished = true
            self.loadedThisLoop = false
            if isServer() then
                self.netAction:forceComplete()
            end
        end
    else
        return ISLoadBulletsInMagazine_animEvent_Old(self, event, parameter)
    end
end

local ISUnloadBulletsFromMagazine_animEvent_Old = ISUnloadBulletsFromMagazine.animEvent
function ISUnloadBulletsFromMagazine:animEvent(event, parameter)
    if not self.magazine:hasTag(Gun93Registries.guns93.Guns93Mag) then
        ISUnloadBulletsFromMagazine_animEvent_Old(event, parameter)
    end
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
            local ammolink = self.magazine:getModData().needLink
            local itemKey = nil
            if not self.magazine:hasTag(Gun93Registries.guns93.AmmoBox) then
                itemKey = Guns93RemoveAmmoType(self.magazine)
            end
            if itemKey == nil then
		        itemKey = self.magazine:getAmmoType():getItemKey();
            end
			local newBullet = instanceItem(itemKey);
            local newlink = nil
            if ammolink ~= nil then
			    newlink = instanceItem(ammolink);
            end
            if newlink ~= nil then
			    self.character:getInventory():AddItem(newlink)
            end
            if newBullet:hasTag(Gun93Registries.guns93.AmmoBelt) then
                local magCount = self.magazine:getCurrentAmmoCount()
                local beltCount = newBullet:getMaxAmmo()
                if magCount > beltCount then
                    magCount = beltCount
                end
                while magCount > 0 do
                    self.magazine:setCurrentAmmoCount(self.magazine:getCurrentAmmoCount() - 1)
                    newBullet:setCurrentAmmoCount(newBullet:getCurrentAmmoCount() + 1)
                    local bullet = Guns93RemoveAmmoType(self.magazine)
                    Guns93AddAmmoTypes(newBullet, bullet)
                    magCount = magCount - 1
                end
                DynamicMagClip(newBullet)
            else
			    self.magazine:setCurrentAmmoCount(self.magazine:getCurrentAmmoCount() - 1)
            end
			self.character:getInventory():AddItem(newBullet)
			sendAddItemToContainer(self.character:getInventory(), newBullet)
            if ammolink ~= nil then
			    sendAddItemToContainer(self.character:getInventory(), newlink)
            end
			syncItemFields(self.character, self.magazine)
            syncItemModData(self.character, self.magazine)
		end
        DynamicMagClip(self.magazine)
		self.unloadFinished = false
	elseif event == 'unloadFinished' then
		if self.magazine:getCurrentAmmoCount() <= 0 then
            DynamicMagClip(self.magazine)
            local modData = self.magazine:getModData()
            Guns93TrimListRounds(modData.Guns93AmmoList, 0)
			self.unloadFinished = true
		    if not isClient() then
                local ammolink = self.magazine:getModData().needLink
                if ammolink ~= nil then
                    self.character:getInventory():Remove(self.magazine)
                    sendRemoveItemFromContainer(self.character:getInventory(), self.magazine)
                end
            end
			if isServer() then
				self.netAction:forceComplete()
			end
		end
    end
    return ISUnloadBulletsFromMagazine_animEvent_Old(self, event, parameter)
end

local ISLoadBulletsInMagazine_start_Old = ISLoadBulletsInMagazine.start
function ISLoadBulletsInMagazine:start()
    if not self.magazine:hasTag(Gun93Registries.guns93.Guns93Mag) then
        ISLoadBulletsInMagazine_start_Old(event, parameter)
    end
    if isServer() then
        guns93ApplyPendingToAction(self, self.magazine)
    end
    if self.round == nil and self.magazine:getAmmoType() then
        self.round = tostring(self.magazine:getAmmoType():getItemKey())
    else
        self.round = self.round and tostring(self.round) or nil
    end
    if self.round2 == nil then
        local magData = self.magazine:getModData()
        if magData and magData.modAlt_Ammo then
            self.round2 = tostring(magData.modAlt_Ammo)
        end
    else
        self.round2 = tostring(self.round2)
    end
    self.startAmmoCount = self.magazine:getCurrentAmmoCount()
    self.ammoCountStart = self.startAmmoCount
	self.magazine:setJobDelta(0.0)
	self:setOverrideHandModels(nil, "GunMagazine");
	self:setActionAnim(CharacterActionAnims.InsertBullets);
	self:initVars()
	self.loadedThisLoop = false;
	self.updateLoadBulletsTime = 0.0
	self.character:setVariable("UpdateLoadBulletsTime", 0.0);
end

local function guns93AmmoLeft(character, magazine, round, round2, bycaliber)
    if not character or not magazine then
        return false
    end
    if bycaliber then
        local primRound = round and tostring(round) or nil
        local secRound = round2 and tostring(round2) or nil
        local bullets = ArrayList.new()
        character:getInventory():getAllTagRecurse(Gun93Registries.guns93.Ammo, bullets)
        for i = 0, bullets:size() - 1 do
            local bullet = bullets:get(i)
            local round = bullet:getModData()
            local caliber = tostring(round.isCaliber)
            local ammoType = tostring(bullet:getFullType())
            if (primRound and (caliber == primRound or ammoType == primRound)) or (secRound and (caliber == secRound or ammoType == secRound)) then
                return true
            end
        end
        return false
    end
    local itemKey = round
    if not itemKey and magazine.getAmmoType and magazine:getAmmoType() then
        itemKey = magazine:getAmmoType():getItemKey()
    end
    if not itemKey then
        return false
    end
    local number = character:getInventory():getItemCountRecurse(itemKey)
    if number and number > 0 then
        return true
    end
    return false
end

local ISLoadBulletsInMagazine_isLoadFinished_Old = ISLoadBulletsInMagazine.isLoadFinished
function ISLoadBulletsInMagazine:isLoadFinished()
    if not self.magazine or not self.magazine:hasTag(Gun93Registries.guns93.Guns93Mag) then
        return ISLoadBulletsInMagazine_isLoadFinished_Old(self)
    end
    if isServer() then
        guns93ApplyPendingToAction(self, self.magazine)
    end
    if self.magazine:hasTag(Gun93Registries.guns93.AmmoBelt) then
        local linkType = self.magazine:getModData().needLink
        local linkNum = self.character:getInventory():getItemCountRecurse(linkType)
        if linkNum and linkNum < 1 then
            return true
        end
    end
    if self.magazine:getCurrentAmmoCount() >= self.magazine:getMaxAmmo() then
        return true
    end
    if self.startAmmoCount ~= nil and self.ammoCount and self.ammoCount > 0 then
        local loaded = self.magazine:getCurrentAmmoCount() - self.startAmmoCount
        if loaded >= self.ammoCount then
            return true
        end
    end
    local hasAmmo = guns93AmmoLeft( self.character, self.magazine, self.round, self.round2, self.bycaliber)
    return not hasAmmo
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
                Guns93TransferAmmoList(self.magazine, self.gun, loaded)
                self.gun:setCurrentAmmoCount(self.gun:getCurrentAmmoCount() + loaded)
                self.magazine:setCurrentAmmoCount(self.magazine:getCurrentAmmoCount() - loaded)
            end
            syncItemFields(self.character, self.magazine)
            syncItemModData(self.character, self.magazine)
            syncItemModData(self.character, self.gun)
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
            Guns93TransferAmmoList(self.magazine, self.gun, self.magazine:getCurrentAmmoCount())
            self.gun:setCurrentAmmoCount(self.magazine:getCurrentAmmoCount())
            if self.magazine:getCategory() == "WeaponPart" then
                self.gun:attachWeaponPart(self.magazine)
            end
            sendRemoveItemFromContainer(self.character:getInventory(), self.magazine)
            syncItemModData(self.character, self.gun)
            syncHandWeaponFields(self.character, self.gun)
        end
    end
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
            local ammotype = Guns93RemoveChambered(self.gun)
            if ammotype == nil or ammotype == "Empty" then
                ammotype = self.gun:getAmmoType():getItemKey()
            end
            self.character:getInventory():AddItem(ammotype)
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
                local ammotype = Guns93RemoveChambered(self.gun)
                if ammotype == nil or ammotype == "Empty" then
                    ammotype = self.gun:getAmmoType():getItemKey():getFullType()
                end
                newMag:setCurrentAmmoCount(self.gun:getCurrentAmmoCount() + 1)
                Guns93AddAmmoTypes(self.gun, ammotype)
            else
                newMag:setCurrentAmmoCount(self.gun:getCurrentAmmoCount())
            end
        end
        newMag:setCurrentAmmoCount(self.gun:getCurrentAmmoCount())
        DynamicMagClip(newMag)
    end
    if newMag then
        if self.gun:getWeaponPart("Clip") then
            self.gun:detachWeaponPart(newMag) 
        end
        Guns93TransferAmmoList(self.gun, newMag, self.gun:getCurrentAmmoCount())
        self.character:getInventory():AddItem(newMag)
        sendAddItemToContainer(self.character:getInventory(), newMag)
    end
    self.gun:setContainsClip(false)
    self.gun:setCurrentAmmoCount(0)
    self.gun:getModData().Guns93AmmoList = nil
    syncItemModData(self.character, self.gun)
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

local ISRackFirearm_removeBullet_Old = ISRackFirearm.removeBullet
function ISRackFirearm:removeBullet()
    if not self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        return ISRackFirearm_removeBullet_Old(self)
    end
    local itemKey = Guns93RemoveChambered(self.gun)
    if itemKey == nil or itemKey == "Empty" then
        itemKey = self.gun:getAmmoType():getItemKey();
    end
	local newBullet = instanceItem(itemKey)
	self.character:getInventory():AddItem(newBullet)
	sendAddItemToContainer(self.character:getInventory(), newBullet)
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
            syncItemModData(self.character, self.gun)
            syncHandWeaponFields(self.character, self.gun)
            return
        end
        if self.gun:isRoundChambered() then
            if not self.gun:isJammed() then
                self:removeBullet()
            end
        end
        if self.gun:isSpentRoundChambered() then
            Guns93BrassEject(self.character, self.gun)
        end
        self.gun:setRoundChambered(false)
        if Guns93HasMultipleCalibers(self.gun) and self.gun:hasTag(Gun93Registries.guns93.MixJam) and ZombRand(0,50) > 30 then
            self.gun:setJammed(true)
        else
            self.gun:setJammed(false)
        end
        if self.gun:getCurrentAmmoCount() >= self.gun:getAmmoPerShoot() then
            self.gun:setRoundChambered(true)
            local bullet = Guns93RemoveAmmoType(self.gun)
            if bullet ~= nil then
                Guns93AddChambered(self.gun, bullet)
            end
            self.gun:setCurrentAmmoCount(self.gun:getCurrentAmmoCount() - self.gun:getAmmoPerShoot())
            if self.gun:getJamGunChance() > 0 then
                self.gun:checkJam(self.character, true)
            end
        end
    else
		self.gun:setJammed(false)
    end
    GunStatAdjust(self.character, self.gun)
    syncItemModData(self.character, self.gun)
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

local Guns93reloadMagazine = function(playerObj, magazine)
	if not magazine then
		return 0
	end
    local round = magazine:getAmmoType():getItemKey()
    local round2 = nil
    local magData = magazine:getModData()
    local ammoCount = 0
    if magData and magData.modAlt_Ammo then
        round2 = magData.modAlt_Ammo
    end
    local ammoNeeded = magazine:getMaxAmmo() - magazine:getCurrentAmmoCount()
    if ammoNeeded < 1 then
        return
    end
    local bullets = ArrayList.new()
    playerObj:getInventory():getAllTagRecurse(Gun93Registries.guns93.Ammo, bullets)
    local doneList = {}
    for i = 0, bullets:size() - 1 do
        local bullet = bullets:get(i)
        local roundData = bullet:getModData()
        if roundData and roundData.isCaliber then
            local caliber = roundData.isCaliber
            local fullType = bullet:getFullType()
            if caliber == round or caliber == round2 or fullType == round or fullType == round2 then
                if not doneList[fullType] then
                    doneList[fullType] = true
                    local ammoReturn = ISInventoryPaneContextMenu.transferBullets(playerObj, fullType, magazine:getCurrentAmmoCount(), magazine:getMaxAmmo())
                    ammoCount = ammoCount + ammoReturn
                    if ammoCount >= ammoNeeded then
                        break
                    end
                end
            end
        end
    end
    if ammoCount > 0 then
        guns93SendLoadIntent(playerObj, magazine, round, round2, true, ammoCount)
        local action = ISLoadBulletsInMagazine:new(playerObj, magazine, ammoCount)
        action.round = round
        action.round2 = round2
        action.bycaliber = true
        ISTimedActionQueue.add(action)
    end
	return ammoCount
end

local old_ReloadBestMagazine = ISReloadWeaponAction.ReloadBestMagazine
ISReloadWeaponAction.ReloadBestMagazine = function(playerObj, gun)
    if not gun or not gun:hasTag(Gun93Registries.guns93.Guns93) then
        return old_ReloadBestMagazine(playerObj, gun)
    end
	local magazine = gun:getBestMagazine(playerObj)
	local ammoCount = Guns93reloadMagazine(playerObj, magazine)
	if not magazine or ammoCount == 0 then
		return
	end
	ISTimedActionQueue.add(ISInsertMagazine:new(playerObj, gun, magazine))
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
    local round1 = gun:getAmmoType():getItemKey()
    local round2 = gun:getModData().modAlt_Ammo
    local magList = MagazineGunSet[gunType]
    if magList then
        for _, magType in ipairs(magList) do
            local items = playerObj:getInventory():getAllTypeRecurse(magType)
            for k = 0, items:size() - 1 do
                local mag = items:get(k)
                if mag and mag:getCurrentAmmoCount() >= highest then
                    if not (mag:hasTag(Gun93Registries.guns93.SpeedLoader) and gun:getCurrentAmmoCount() > mag:getCurrentAmmoCount()) then
                        local doLoad = true
                        if Guns93HasMultipleCalibers(mag) then
                            if not round2 then
                                doLoad = false
                            end
                        end
                        if doLoad then
                            local magData = mag:getModData()
                            local topRound = nil
                            if magData.Guns93AmmoList then
                                local list = magData.Guns93AmmoList
                                if #list ~= 0 then
                                    topRound = list[1].type
                                end
                            end
                            local ammoCheck = nil
                            if topRound ~= nil then
                                ammoCheck = AmmoStatList[topRound].caliber
                            else
                                ammoCheck = round1
                            end
                            if ammoCheck == round1 or ammoCheck == round2 then
                                highest = mag:getCurrentAmmoCount()
                                bestMag = mag
                            end
                        end
                    end
                end
            end
        end
    end
    if not bestMag and gun:getMagazineType() then
        local items = playerObj:getInventory():getAllTypeRecurse(gun:getMagazineType())
        for k = 0, items:size() - 1 do
            local mag = items:get(k)
            if mag and mag:getCurrentAmmoCount() >= highest then
                if not (mag:hasTag(Gun93Registries.guns93.SpeedLoader) and gun:getCurrentAmmoCount() > mag:getCurrentAmmoCount()) then
                    local doLoad = true
                    if Guns93HasMultipleCalibers(mag) then
                        if not round2 then
                            doLoad = false
                        end
                    end
                    if doLoad then
                        local magData = mag:getModData()
                        local topRound = nil
                        if magData.Guns93AmmoList then
                            local list = magData.Guns93AmmoList
                            if #list ~= 0 then
                                topRound = list[1].type
                            end
                        end
                        local ammoCheck = nil
                        if topRound ~= nil then
                            ammoCheck = AmmoStatList[topRound].caliber
                        else
                            ammoCheck = round1
                        end
                        if ammoCheck == round1 or ammoCheck == round2 then
                            highest = mag:getCurrentAmmoCount()
                            bestMag = mag
                        end
                    end
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
            local ammoCount = Guns93reloadMagazine(playerObj, bestMag)
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
        local round = gun:getAmmoType():getItemKey()
        local round2 = nil
        local gunData = gun:getModData()
        if gunData and gunData.modAlt_Ammo then
            round2 = gunData.modAlt_Ammo
        end
        local ammoNeeded = gun:getMaxAmmo() - gun:getCurrentAmmoCount()
        if ammoNeeded < 1 then
            return
        end
        local bullets = ArrayList.new()
        playerObj:getInventory():getAllTagRecurse(Gun93Registries.guns93.Ammo, bullets)
        local doneList = {}
        for i = 0, bullets:size() - 1 do
            local bullet = bullets:get(i)
            local roundData = bullet:getModData()
            if roundData and roundData.isCaliber then
                local caliber = roundData.isCaliber
                local fullType = bullet:getFullType()
                if caliber == round or caliber == round2 or fullType == round or fullType == round2 then
                    if not doneList[fullType] then
                        doneList[fullType] = true
                        local ammoReturn = ISInventoryPaneContextMenu.transferBullets(playerObj, fullType, gun:getCurrentAmmoCount(), gun:getMaxAmmo())
                        ammoNeeded = ammoNeeded - ammoReturn
                        if ammoNeeded < 1 then
                            break
                        end
                    end
                end
            end
        end
        ISInventoryPaneContextMenu.equipWeapon(gun, true, false, playerObj:getPlayerNum())
        guns93SendLoadIntent(playerObj, gun, round, round2, true, gun:getMaxAmmo() - gun:getCurrentAmmoCount())
        local action = ISReloadWeaponAction:new(playerObj, gun)
        action.round = round
        action.round2 = round2
        action.bycaliber = true
        ISTimedActionQueue.add(action)
    end
end

local function SetSpentCases(player, weapon)
    if not weapon or not weapon:hasTag(Gun93Registries.guns93.Guns93) then return end
    local modData = weapon:getModData()
    local list = modData.Guns93SpentList or {}
    if weapon:haveChamber() then
        Guns93TrimListRounds(list, 1)
    else
        Guns93TrimListRounds(list, weapon:getMaxAmmo())
    end
    local total = 0
    for _, brass in ipairs(list) do
        total = total + (brass.count or 0)
    end
    if weapon:haveChamber() then
        weapon:setSpentRoundChambered(true)
    else
        weapon:setSpentRoundCount(total)
    end
end

Events.OnEquipPrimary.Add(SetSpentCases)

Events.OnGameStart.Add(function()
    local player = getPlayer()
    if player then
        SetSpentCases(player, player:getPrimaryHandItem())
    end
end)

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
end

Events.OnEquipPrimary.Add(SetMagazineStats)

local function Guns93SetIcon(player, weapon)
    if not isClient() then return end
    if not weapon or not weapon:hasTag(Gun93Registries.guns93.Guns93) then return end
    local gunData = weapon:getModData()
    if gunData.Guns93Icon ~= nil then
        weapon:setTexture(getTexture(gunData.Guns93Icon))
        weapon:setTexture(getTexture("media/textures/item_" .. gunData.Guns93Icon .. ".png"))
    end
end

Events.OnEquipPrimary.Add(Guns93SetIcon)

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
        if part then
            if part:hasTag(Gun93Registries.guns93.BullpupStock) then
                Guns93BullpupStock(self.weapon, true)
            elseif part:hasTag(Gun93Registries.guns93.ToggleItemOff) then
                if part:isActivated() then
                    part:setActivated(false)
                end
                local newPart = instanceItem(string.gsub(part:getFullType(), "_On$", ""))
                newPart:setCurrentUses(part:getCurrentUses())
                self.weapon:detachWeaponPart(self.character, part)
                self.weapon:attachWeaponPart(self.character, newPart)
            elseif part:hasTag(Gun93Registries.guns93.Guns93Mag) or part:hasTag(Gun93Registries.guns93.MagExten) then
                local baseCount = self.weapon:getModData().isBaseAmmo
                if baseCount then
                    self.weapon:setMaxAmmo(baseCount)
                end
            end
            syncItemModData(self.character, self.weapon)
            syncHandWeaponFields(self.character, self.weapon)
        end
    end
    self.character:setSecondaryHandItem(nil)
    self.character:setPrimaryHandItem(nil)
    self.weapon:setJobDelta(0.0)
    self.weapon:setJobType(nil)
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
        if self.part:hasTag(Gun93Registries.guns93.BullpupStock) then
            Guns93BullpupStock(self.weapon, false)
        elseif self.part:hasTag(Gun93Registries.guns93.Guns93Mag) or self.part:hasTag(Gun93Registries.guns93.MagExten) then
            SetMagazineStats(self.character, self.weapon)
            sync = true
        end
        syncItemModData(self.character, self.weapon)
        syncHandWeaponFields(self.character, self.weapon)
    end
    self.character:setSecondaryHandItem(nil)
    self.character:setPrimaryHandItem(nil)
    self.weapon:setJobDelta(0.0)
    self.weapon:setJobType(nil)
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

ISReloadWeaponAction_initVars_Old = ISReloadWeaponAction.initVars
function ISReloadWeaponAction:initVars()
    if not self.gun or not self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        return ISReloadWeaponAction_initVars_Old(self)
    end
    ISReloadWeaponAction.setReloadSpeed(self.character, false)
    local ammoTotal = self.gun:getMaxAmmo() - self.gun:getCurrentAmmoCount()
    if ammoTotal < 1 then
        return
    end
    if isServer() then
        guns93ApplyPendingToAction(self, self.gun)
    end
    local primCaliber = self.round
    local secCaliber = self.round2
    local allBullets = ArrayList.new()
    self.character:getInventory():getAllTagRecurse(Gun93Registries.guns93.Ammo, allBullets)
    local getbullets = ArrayList.new()
    for i = 0, allBullets:size() - 1 do
        local bullet = allBullets:get(i)
        local bulletData = bullet:getModData()
        local caliber = bulletData and bulletData.isCaliber and tostring(bulletData.isCaliber) or nil
        local ammoType = tostring(bullet:getFullType())
        local match = (primCaliber and (caliber == primCaliber or ammoType == primCaliber)) or (secCaliber and (caliber == secCaliber or ammoType == secCaliber))
        if match then
            getbullets:add(bullet)
            if getbullets:size() >= ammoTotal then
                break
            end
        end
    end
    if getbullets:size() > 0 then
        self.bullets = getbullets
        self.ammoCount = getbullets:size()
    end
end

ISReloadWeaponAction_loadAmmo_Old = ISReloadWeaponAction.loadAmmo
function ISReloadWeaponAction.loadAmmo(self)
	if not self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        return ISReloadWeaponAction_loadAmmo_Old(self)
    end
    if isServer() then
        guns93ApplyPendingToAction(self, self.gun)
    end
	if self.bullets then
        if not self.bullets:isEmpty() and self.gun:getCurrentAmmoCount() < self.gun:getMaxAmmo() then
            local bullet = self.bullets:get(0);
            Guns93BrassEject(self.character, self.gun)
            self.bullets:remove(bullet);
            self.character:getInventory():Remove(bullet);
            self.gun:setCurrentAmmoCount(self.gun:getCurrentAmmoCount() + 1);
            Guns93AddAmmoTypes(self.gun, bullet:getFullType())
            sendRemoveItemFromContainer(self.character:getInventory(), bullet)
            syncItemModData(self.character, self.gun)
            syncHandWeaponFields(self.character, self.gun)
        end
        if self.bullets:isEmpty() or self.gun:getCurrentAmmoCount() >= self.gun:getMaxAmmo() then
            if isServer() then
                guns93ClearPending(self.character)
            end
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
    end
end

local function Guns93CycleChamber(player, weapon)
    if not player or not weapon or not weapon:isRanged() then return end
    if not weapon:hasTag(Gun93Registries.guns93.Guns93) then return end
    if getDebug() and player:isUnlimitedAmmo() and player:isUnlimitedAmmo() then return end
    if isClient() then return end
    local brass = nil
    if weapon:haveChamber() then
        brass = Guns93RemoveChambered(weapon)
        Guns93AddSpentAmmo(weapon, brass)
        if not weapon:isRackAfterShoot() then
            Guns93BrassEject(player, weapon)
            local bullet = Guns93RemoveAmmoType(weapon)
            if bullet then
                Guns93AddChambered(weapon, bullet)
            end
        end
    else
        brass = Guns93RemoveAmmoType(weapon)
        Guns93AddSpentAmmo(weapon, brass)
    end
    GunStatAdjust(player, weapon)
    syncItemModData(player, weapon)
    syncHandWeaponFields(player, weapon)
end

Events.OnPlayerAttackFinished.Add(Guns93CycleChamber)

local ISReloadWeaponAction_canShoot = ISReloadWeaponAction.canShoot
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
        GunStatAdjust(player, weapon)
    end
    return ISReloadWeaponAction_canShoot(player, weapon)
end

local ISReloadWeaponAction_animEvent_Old = ISReloadWeaponAction.animEvent
function ISReloadWeaponAction.animEvent(self, event, parameter)
    if tostring(event) == "changeWeaponSprite" and self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        Guns93BreakActionOpen(self.character, self.gun)
    else
        return ISReloadWeaponAction_animEvent_Old(self, event, parameter)
    end
end

local ISReloadWeaponAction_perform_Old = ISReloadWeaponAction.perform
function ISReloadWeaponAction.perform(self)
    if self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        Guns93BreakActionClosed(self.character, self.gun)
    end
    return ISReloadWeaponAction_perform_Old(self)
end


local ISReloadWeaponAction_complete_Old = ISReloadWeaponAction.complete
function ISReloadWeaponAction.complete(self)
    if self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        Guns93BreakActionClosed(self.character, self.gun)
    end
    return ISReloadWeaponAction_complete_Old(self)
end

local ISReloadWeaponAction_stop_Old = ISReloadWeaponAction.stop
function ISReloadWeaponAction.stop(self)
    if self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        Guns93BreakActionClosed(self.character, self.gun)
    end
	return ISReloadWeaponAction_stop_Old(self)
end

local ISUnloadBulletsFromFirearm_animEvent_Old = ISUnloadBulletsFromFirearm.animEvent
function ISUnloadBulletsFromFirearm.animEvent(self, event, parameter)
	if event == 'playReloadSound' then
		if parameter == 'ejectAmmoStart' then
			if not self.playedEjectAmmoStartSound and self.gun:getEjectAmmoStartSound() then
				self.playedEjectAmmoStartSound = true;
				self.character:playSound(self.gun:getEjectAmmoStartSound());
			end
			return
		end
		if self.gun:getCurrentAmmoCount() <= 0 then
			return
		end
		if self.gun:getEjectAmmoSound() then
			self.character:playSound(self.gun:getEjectAmmoSound())
		end
		local count = 1
		if self.gun:isInsertAllBulletsReload() then
			count = self.gun:getCurrentAmmoCount()
		end
		if not isClient() then
			while self.gun:getCurrentAmmoCount() > 0 do
                local itemKey = Guns93RemoveAmmoType(self.gun)
                if itemKey == nil then
			        itemKey = self.gun:getAmmoType():getItemKey();
                end
				local newBullet = instanceItem(itemKey)
				self.character:getInventory():AddItem(newBullet)
				self.gun:setCurrentAmmoCount(self.gun:getCurrentAmmoCount() - 1)
				sendAddItemToContainer(self.character:getInventory(), newBullet)
                syncItemModData(self.character, self.gun)
				syncHandWeaponFields(self.character, self.gun)
				count = count - 1
				if count == 0 then
					break
				end
			end
		end
		self.unloadFinished = false
    elseif tostring(event) == "changeWeaponSprite" and self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        Guns93BreakActionOpen(self.character, self.gun)
    else        
        return ISUnloadBulletsFromFirearm_animEvent_Old(self, event, parameter)
    end
end

local ISUnloadBulletsFromFirearm_complete_Old = ISUnloadBulletsFromFirearm.complete
function ISUnloadBulletsFromFirearm.complete(self)
    if self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        Guns93BreakActionClosed(self.character, self.gun)
    end
	return ISUnloadBulletsFromFirearm_complete_Old(self)
end

local ISUnloadBulletsFromFirearm_stop_Old =ISUnloadBulletsFromFirearm.stop
function ISUnloadBulletsFromFirearm.stop(self)
    if self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        Guns93BreakActionClosed(self.character, self.gun)
    end
	return ISUnloadBulletsFromFirearm_stop_Old(self)
end

local ISRackFirearm_animEvent_Old = ISRackFirearm.animEvent
function ISRackFirearm.animEvent(self, event, parameter)
    if tostring(event) == "changeWeaponSprite" and self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        Guns93BreakActionOpen(self.character, self.gun)
    else 
        return ISRackFirearm_animEvent_Old(self, event, parameter)
    end
end

local ISRackFirearm_complete_Old = ISRackFirearm.complete
function ISRackFirearm.complete(self)
    if self.gun:hasTag(Gun93Registries.guns93.Guns93) then
        Guns93BreakActionClosed(self.character, self.gun)
    end
	return ISRackFirearm_complete_Old(self)
end

local ISRackFirearm_stop_Old = ISRackFirearm.stop
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
    if self.gun:getWeaponPart("Moonclip") then
        ISTimedActionQueue.add(ISEjectMagazine:new(self.character, self.gun))
    end
    if self.gun:haveChamber() then
        if self.gun:isRoundChambered() then
            if not self.gun:isJammed() then
                self:removeBullet()
            end
        end
        if self.gun:isSpentRoundChambered() then
            Guns93BrassEject(self.character, self.gun)
        end
        self.gun:setRoundChambered(false)
        self.gun:setJammed(false)
    end
    GunStatAdjust(self.character, self.gun)
    syncItemModData(self.character, self.gun)
    syncHandWeaponFields(self.character, self.gun)
end

function ISUnloadRackFirearm:removeBullet()
    local itemKey = Guns93RemoveChambered(self.gun)
    if itemKey == nil or itemKey == "Empty" then
        itemKey = self.gun:getAmmoType():getItemKey();
    end
	local newBullet = instanceItem(itemKey)
	self.character:getInventory():AddItem(newBullet)
	sendAddItemToContainer(self.character:getInventory(), newBullet)
end

function ISUnloadRackFirearm:ejectSpentRounds()
	if self.gun:getSpentRoundCount() > 0 then
		self.gun:setSpentRoundCount(0)
        syncItemModData(self.character, self.gun)
		syncHandWeaponFields(self.character, self.gun)
	elseif self.gun:isSpentRoundChambered() then
		self.gun:setSpentRoundChambered(false)
        syncItemModData(self.character, self.gun)
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