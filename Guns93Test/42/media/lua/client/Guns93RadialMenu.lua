local BaseCommand = ISBaseObject:derive("BaseCommand")

function BaseCommand:new(frm)
    local o = ISBaseObject.new(self)
    o.frm = frm
    o.character = frm.character
	o.index = 0
    return o
end

function BaseCommand:getWeapon()
	return self.frm:getWeapon()
end

function BaseCommand:fillMenu(menu, weapon, index)
	error "Error, did not derive fillMenu()"
end

---Adjust Gun Stock---

local CGuns93StockAdjust = BaseCommand:derive("CGuns93StockAdjust")

function CGuns93StockAdjust:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CGuns93StockAdjust:fillMenu(menu, weapon, index)
	for index, preset in ipairs(FoldingStockSet) do
		if weapon:getWeaponPart("Stock") then
			if preset == weapon:getWeaponPart("Stock"):getFullType() then
				if (index % 2 == 1) then
					self.index = index + 1
					local text = getText("IGUI_FirearmRadial_FoldStock")
					menu:addSlice(text, getTexture("media/ui/Radial_FoldStock.png"), self.invoke, self)
				else
					self.index = index - 1
					local text = getText("IGUI_FirearmRadial_UnfoldStock")
					menu:addSlice(text, getTexture("media/ui/Radial_UnfoldStock.png"), self.invoke, self)
				end
			end
		end
	end
end

function CGuns93StockAdjust:invoke()
	local weapon = self.character:getPrimaryHandItem()
	if not weapon then return end
		ISTimedActionQueue.add(Guns93StockAdjustAction:new(weapon, self.index, self.character, CharacterActionAnims.Craft, 15))
end

---Toggle Bayonet Use---

local CGuns93UseBayonet = BaseCommand:derive("CGuns93UseBayonet")

function CGuns93UseBayonet:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CGuns93UseBayonet:fillMenu(menu, weapon, index)
	if weapon:getWeaponPart("Bayonet") then
		if weapon:getSubCategory() == "Firearm" then
			local text = getText("IGUI_FirearmRadial_UseBayonet")
			menu:addSlice(text, getTexture("media/ui/Radial_UseBayonet.png"), self.invoke, self)
		else
			local text = getText("IGUI_FirearmRadial_UseFirearm")
			menu:addSlice(text, getTexture("media/ui/Radial_UseFirearm.png"), self.invoke, self)
		end
	end
end

function CGuns93UseBayonet:invoke()
	local weapon = self.character:getPrimaryHandItem()
	ISTimedActionQueue.add(Guns93UseBayonetAction:new(weapon, weapon:getWeaponPart("Bayonet"), self.character, CharacterActionAnims.Craft, 0))
end

---Add/Remove Bayonet From Firearm---

local CGuns93FixBayonet = BaseCommand:derive("CGuns93FixBayonet")

function CGuns93FixBayonet:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CGuns93FixBayonet:fillMenu(menu, weapon, index)
	self.index = index
	local bayo = nil
	if not weapon:getWeaponPart("Bayonet") then
		if MuzzleDeviceCheck(weapon) == true then
			for i=1, self.character:getInventory():getItems():size() do
				local findbayo = self.character:getInventory():getItems():get(i-1)
				local bayoTag = false							
				if findbayo:hasTag(Gun93Registries.guns93.Bayonet) and findbayo:hasTag(Gun93Registries.guns93.NoScrewdriver) then
					bayoTag = findbayo:getType()
				end
				if bayoTag then
					if weapon:hasTag(Gun93Registries.guns93[bayoTag]) then
						bayo = findbayo
					end
					if weapon:getWeaponPart("BarrelItem") then
						if weapon:getWeaponPart("BarrelItem"):hasTag(Gun93Registries.guns93[bayoTag]) then
							bayo = findbayo
						end
					end
					if weapon:getWeaponPart("BayoLug") then
						if weapon:getWeaponPart("BayoLug"):hasTag(Gun93Registries.guns93[bayoTag]) then
							bayo = findbayo
						end
					end
					if bayo ~= nil then
						local text = getText("IGUI_FirearmRadial_PreFix") .. bayo:getDisplayName() .. " (" .. (bayo:getCondition()/bayo:getConditionMax())*100 .. "%)"
						menu:addSlice(text, bayo:getTex(), self.invoke, self, bayo)
					end
				end
			end
		end
	elseif weapon:getWeaponPart("Bayonet") then
		if not weapon:getWeaponPart("Bayonet"):hasTag(Gun93Registries.guns93.FoldingBayo) and not weapon:getWeaponPart("Bayonet"):hasTag(Gun93Registries.guns93.BayoFolded) then
			local text = getText("IGUI_FirearmRadial_PreRemove").. weapon:getWeaponPart("Bayonet"):getDisplayName()
			menu:addSlice(text, getTexture("media/ui/Radial_RemoveBayonet.png"), self.invoke, self)
		elseif weapon:getWeaponPart("Bayonet"):hasTag(Gun93Registries.guns93.BayoFolded) then
			local text = getText("IGUI_FirearmRadial_PreUnfold") .. getText("IGUI_FirearmRadial_PostBayonet")
			menu:addSlice(text, getTexture("media/ui/Radial_UnfoldBayonet.png"), self.invoke, self)
		elseif weapon:getWeaponPart("Bayonet"):hasTag(Gun93Registries.guns93.FoldingBayo) then
			local text = getText("IGUI_FirearmRadial_PreFold") .. getText("IGUI_FirearmRadial_PostBayonet")
			menu:addSlice(text, getTexture("media/ui/Radial_FoldBayonet.png"), self.invoke, self)
		end
	end
end

function CGuns93FixBayonet:invoke(bayo)
	local weapon = self.character:getPrimaryHandItem()
	if not weapon then return end
	if weapon:getWeaponPart("Bayonet") and weapon:getWeaponPart("Bayonet"):hasTag(Gun93Registries.guns93.FoldingBayo) then
		ISTimedActionQueue.add(Guns93FoldBayoAction:new(weapon, self.index, self.character, bayo, CharacterActionAnims.Craft, 15));
	elseif bayo ~= nil or weapon:getWeaponPart("Bayonet") and not weapon:getWeaponPart("Bayonet"):hasTag(Gun93Registries.guns93.FoldingBayo) then
		ISTimedActionQueue.add(Guns93FixBayonetAction:new(weapon, self.index, self.character, bayo, CharacterActionAnims.Craft, 60));
	end
end

---Switch Ammo Type---

local CGuns93AmmoSwitch = BaseCommand:derive("CGuns93AmmoSwitch")

function CGuns93AmmoSwitch:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CGuns93AmmoSwitch:fillMenu(menu, weapon, index)
	if weapon:hasTag(Gun93Registries.guns93.AmmoSwitch) then
		local newAmmo = nil
		if weapon:hasTag(Gun93Registries.guns93.AltAmmo) then
			newAmmo = string.gsub(weapon:getFullType(), "_Alt", "")
		else
			newAmmo = weapon:getFullType() .. "_Alt"
		end
		if newAmmo ~= nil then
			local refAmmo = instanceItem(newAmmo):getScriptItem()
			if weapon:hasTag(Gun93Registries.guns93.AltAmmo) then
				self.index = index
				local text = getText("IGUI_FirearmRadial_SwitchTo") .. getItemNameFromFullType(refAmmo:getAmmoType():getItemKey())
				menu:addSlice(text, getTexture("media/ui/Radial_SwitchAmmo1.png"), self.invoke, self)
			else
				self.index = index
				local text = getText("IGUI_FirearmRadial_SwitchTo") .. getItemNameFromFullType(refAmmo:getAmmoType():getItemKey())
				menu:addSlice(text, getTexture("media/ui/Radial_SwitchAmmo2.png"), self.invoke, self)
			end
		end
	end
end

function CGuns93AmmoSwitch:invoke()
	local weapon = self.character:getPrimaryHandItem()
	if not weapon then return end
    if weapon:isContainsClip() then
        ISTimedActionQueue.add(ISEjectMagazine:new(self.character, weapon))
    elseif weapon:getCurrentAmmoCount() > 0 then
        ISTimedActionQueue.add(ISUnloadBulletsFromFirearm:new(self.character, weapon, false))
    end
    if weapon:isRoundChambered() then
        ISTimedActionQueue.add(ISRackFirearm:new(self.character, weapon))
    end
	ISTimedActionQueue.add(Guns93AmmoSwitchAction:new(weapon, self.index, self.character, CharacterActionAnims.Craft, 0))
end

---Switch Fire Mode---

local CGuns93ModeSingle = BaseCommand:derive("CGuns93ModeSingle")

function CGuns93ModeSingle:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CGuns93ModeSingle:fillMenu(menu, weapon, index)
    if weapon:getFireMode() ~= "Single" then
		local fireMode = "Single"
		if weapon:getFireMode() == "Safe" then
			fireMode = "Safe"
		end
		local text = getText("ContextMenu_FireMode_" .. fireMode)
		menu:addSlice(text, getTexture("media/ui/Radial_" .. fireMode ..".png"), self.invoke, self)
	end
end

function CGuns93ModeSingle:invoke()
	local weapon = self.character:getPrimaryHandItem()
	if not weapon then return end
	ISInventoryPaneContextMenu.onChangefiremode(self.character, weapon, "Single")
end

local CGuns93ModeBurst= BaseCommand:derive("CGuns93ModeBurst")

function CGuns93ModeBurst:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CGuns93ModeBurst:fillMenu(menu, weapon, index)
    if weapon:getFireMode() ~= "Burst" then
		if weapon:getFireMode() ~= "Safe" then
			local burstPart = weapon:getWeaponPart("AutoPart") or weapon:getWeaponPart("Trigger")
			local burst = ""
			if burstPart:hasTag(Gun93Registries.guns93.Burst) then
				if burstPart:getModData().modBurst_Num == 2 then
					burst = "2"
				elseif burstPart:getModData().modBurst_Num == 3 then
					burst = "3"
				elseif burstPart:getModData().modBurst_Num == 4 then
					burst = "4"
				end
			end
			local text = getText("ContextMenu_FireMode_Burst" .. burst)
			menu:addSlice(text, getTexture("media/ui/Radial_Burst" .. burst .. "Auto.png"), self.invoke, self)
		else
			local text = getText("ContextMenu_FireMode_Safe")
			menu:addSlice(text, getTexture("media/ui/Radial_Safe.png"), self.invoke, self)
		end
	end
end

function CGuns93ModeBurst:invoke()
	local weapon = self.character:getPrimaryHandItem()
	if not weapon then return end
		ISInventoryPaneContextMenu.onChangefiremode(self.character, weapon, "Burst")
end

local CGuns93ModeAuto= BaseCommand:derive("CGuns93ModeAuto")

function CGuns93ModeAuto:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CGuns93ModeAuto:fillMenu(menu, weapon, index)
    if weapon:getFireMode() ~= "Auto" then
		if weapon:getFireMode() ~= "Safe" then
			local text = getText("ContextMenu_FireMode_Auto")
			menu:addSlice(text, getTexture("media/ui/Radial_FullAuto.png"), self.invoke, self)
		else
			local text = getText("ContextMenu_FireMode_Safe")
			menu:addSlice(text, getTexture("media/ui/Radial_Safe.png"), self.invoke, self)
		end
	end
end

function CGuns93ModeAuto:invoke()
	local weapon = self.character:getPrimaryHandItem()
	if not weapon then return end
		ISInventoryPaneContextMenu.onChangefiremode(self.character, weapon, "Auto")
end

---Toggle Attachment---

local CGuns93ToggleParts = BaseCommand:derive("CGuns93ToggleParts")

function CGuns93ToggleParts:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CGuns93ToggleParts:fillMenu(menu, weapon, index)
	local togglePart = nil
	local toggleParts = weapon:getAllWeaponParts()
    for i=0, toggleParts:size()-1 do
        togglePart = toggleParts:get(i)
		if togglePart:hasTag(Gun93Registries.guns93.Light) then
			if togglePart:getCurrentUses() <= 0 then
				local text = getText("IGUI_ContextMenu_NoBatLight")
				menu:addSlice(text, getTexture("media/ui/Radial_WMLBat.png"), nil, self, nil)
			elseif weapon:isActivated() then
				local text = getText("IGUI_ContextMenu_ToggleOffLight")
				menu:addSlice(text, getTexture("media/ui/Radial_WMLOn.png"), self.invoke, self, togglePart)
			elseif togglePart:getCurrentUses() > 0 then
				local text = getText("IGUI_ContextMenu_ToggleOnLight")
				menu:addSlice(text, getTexture("media/ui/Radial_WMLOff.png"), self.invoke, self, togglePart)
			end
		elseif togglePart:hasTag(Gun93Registries.guns93.Laser) then
			if togglePart:getCurrentUses() <= 0 then
				local text = getText("IGUI_ContextMenu_NoBatLaser")
				menu:addSlice(text, getTexture("media/ui/Radial_LaserBat.png"), nil, self, nil)
			elseif togglePart:hasTag(Gun93Registries.guns93.ToggleItemOff) then
				local text = getText("IGUI_ContextMenu_ToggleOffLaser")
				menu:addSlice(text, getTexture("media/ui/Radial_LaserOn.png"), self.invoke, self, togglePart)
			elseif togglePart:hasTag(Gun93Registries.guns93.ToggleItemOn) then
				local text = getText("IGUI_ContextMenu_ToggleOnLaser")
				menu:addSlice(text, getTexture("media/ui/Radial_LaserOff.png"), self.invoke, self, togglePart)
			end
		elseif togglePart:hasTag(Gun93Registries.guns93.RedDot) then
			if togglePart:getCurrentUses() <= 0 then
				local text = getText("IGUI_ContextMenu_NoBatSight")
				menu:addSlice(text, getTexture("media/ui/Radial_RedDotBat.png"), nil, self, nil)
			elseif togglePart:hasTag(Gun93Registries.guns93.ToggleItemOff) then
				local text = getText("IGUI_ContextMenu_ToggleOffSight")
				menu:addSlice(text, getTexture("media/ui/Radial_RedDotOn.png"), self.invoke, self, togglePart)
			elseif togglePart:hasTag(Gun93Registries.guns93.ToggleItemOn) then
				local text = getText("IGUI_ContextMenu_ToggleOnSight")
				menu:addSlice(text, getTexture("media/ui/Radial_RedDotOff.png"), self.invoke, self, togglePart)
			end
		end
	end
end

function CGuns93ToggleParts:invoke(togglePart)
	local weapon = self.character:getPrimaryHandItem()
	ISTimedActionQueue.add(Guns93ActiveItemAction:new(weapon, togglePart:getFullType(), self.character, CharacterActionAnims.Craft, 1))
end

---Bipod Attachment---

local CGuns93Bipod = BaseCommand:derive("CGuns93Bipod")

function CGuns93Bipod:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CGuns93Bipod:fillMenu(menu, weapon, index)
	local bipod = nil
	local bipods = weapon:getAllWeaponParts()
    for i=0, bipods:size()-1 do
        bipod = bipods:get(i)
		if bipod:hasTag(Gun93Registries.guns93.Bipod) then
			if bipod:hasTag(Gun93Registries.guns93.ToggleItemOff) then
				local text = getText("IGUI_ContextMenu_FoldBipod")
				menu:addSlice(text, getTexture("media/ui/Radial_FoldBipod.png"), self.invoke, self, bipod)
			elseif bipod:hasTag(Gun93Registries.guns93.ToggleItemOn) then
				local text = getText("IGUI_ContextMenu_UnfoldBipod")
				menu:addSlice(text, getTexture("media/ui/Radial_UnfoldBipod.png"), self.invoke, self, bipod)
			end
		end
	end
end

function CGuns93Bipod:invoke(togglePart)
	local weapon = self.character:getPrimaryHandItem()
	ISTimedActionQueue.add(Guns93ActiveItemAction:new(weapon, togglePart:getFullType(), self.character, CharacterActionAnims.Craft, 50))
end

---Submenu---

ISFirearmRadialMenu.menu = {};

ISFirearmRadialMenu.menu["FixBayonet"] = {};
ISFirearmRadialMenu.menu["FixBayonet"].name = getText("Fix Bayonet");
ISFirearmRadialMenu.menu["FixBayonet"].subMenu = {};
ISFirearmRadialMenu.menu["FixBayonet"].subMenu["FixBayonet"] = "FixBayonet";
ISFirearmRadialMenu.menu["ToggleParts"] = {};
ISFirearmRadialMenu.menu["ToggleParts"].name = getText("Toggle Attachments");
ISFirearmRadialMenu.menu["ToggleParts"].subMenu = {};
ISFirearmRadialMenu.menu["ToggleParts"].subMenu["Off/On"] = "Off/On";

ISFirearmRadialMenu.icons = {};
ISFirearmRadialMenu.icons["FixBayonet"] = getTexture("media/ui/Radial_FixBayonet.png");
ISFirearmRadialMenu.icons["ToggleParts"] = getTexture("media/ui/Radial_Toggle.png");
ISFirearmRadialMenu.icons["Back"] = getTexture("media/ui/emotes/back.png");

---Vanilla Commands---

local CInsertMagazine = BaseCommand:derive("CInsertMagazine")

function CInsertMagazine:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CInsertMagazine:fillMenu(menu, weapon, index)
    if (weapon:getMagazineType() and not weapon:isContainsClip()) or (weapon:hasTag(Gun93Registries.guns93.MoonClip) and not weapon:getWeaponPart(MoonClip)) or weapon:hasTag(Gun93Registries.guns93.SpeedLoader) or weapon:hasTag(Gun93Registries.guns93.StripperClip) and weapon:getCurrentAmmoCount() < 1 then
		local magazine = weapon:getBestMagazine(self.character)
		local highest = -1
        local weaponType = weapon:getFullType()
        local magList = MagazineGunSet[weaponType]
        if magList then
            for _, magType in ipairs(magList) do
                local items = self.character:getInventory():getAllTypeRecurse(magType)
                for k = 0, items:size() - 1 do
                    local mag = items:get(k)
                    if mag and mag:getCurrentAmmoCount() > highest then
                        if not (mag:hasTag(Gun93Registries.guns93.SpeedLoader) and weapon:getCurrentAmmoCount() > 0) or not (mag:hasTag(Gun93Registries.guns93.MoonClip) and weapon:getCurrentAmmoCount() > 0 or weapon:getSpentRoundCount() > 0) or not (weapon:getMaxAmmo() <= weapon:getCurrentAmmoCount()) then
                            highest = mag:getCurrentAmmoCount()
                            magazine = mag
                        end
                    end
                end
            end
        end
		if not magazine then return end
		local text = nil
		if weapon:hasTag(Gun93Registries.guns93.MoonClip) or weapon:hasTag(Gun93Registries.guns93.SpeedLoader) or weapon:hasTag(Gun93Registries.guns93.StripperClip) then
			text = getText("IGUI_ContextMenu_LoadDevice")
		else
			text = getText("IGUI_FirearmRadial_InsertMagazine")
		end
		local xln = "IGUI_FirearmRadial_AmmoCount"
		local textCount = getText(xln, magazine:getCurrentAmmoCount(), magazine:getMaxAmmo())
		text = text .. "\n" .. textCount
		menu:addSlice(text, getTexture("media/ui/FirearmRadial_InsertMagazine.png"), self.invoke, self)
	else
		return
	end
end

function CInsertMagazine:invoke()
	local weapon = self:getWeapon()
	if not weapon then return end
	if weapon:isContainsClip() or weapon:getWeaponPart("Moonclip") then return end
	local magazine = weapon:getBestMagazine(self.character)
	local highest = -1
    local weaponType = weapon:getFullType()
    local magList = MagazineGunSet[weaponType]
    if magList then
        for _, magType in ipairs(magList) do
            local items = self.character:getInventory():getAllTypeRecurse(magType)
            for k = 0, items:size() - 1 do
                local mag = items:get(k)
                if mag and mag:getCurrentAmmoCount() > highest then
                    if not (mag:hasTag(Gun93Registries.guns93.SpeedLoader) and weapon:getCurrentAmmoCount() > 0) or not (mag:hasTag(Gun93Registries.guns93.MoonClip) and weapon:getCurrentAmmoCount() > 0 or weapon:getSpentRoundCount() > 0) and not (weapon:getMaxAmmo() <= weapon:getCurrentAmmoCount()) then
                        highest = mag:getCurrentAmmoCount()
                        magazine = mag
                    end
                end
            end
        end
    end
	if not magazine then return end
	ISInventoryPaneContextMenu.transferIfNeeded(self.character, magazine)
    if magazine:hasTag(Gun93Registries.guns93.StripperClip) then
        ISTimedActionQueue.add(ISUnloadRackFirearm:new(self.character, weapon))
    end
	ISTimedActionQueue.add(ISInsertMagazine:new(self.character, weapon, magazine))
end

local CEjectMagazine = BaseCommand:derive("CEjectMagazine")

function CEjectMagazine:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CEjectMagazine:fillMenu(menu, weapon, index)
	if weapon:isContainsClip() or weapon:getWeaponPart("Moonclip") then
		local text = nil
		if weapon:getWeaponPart("Moonclip") then
			text = getText("IGUI_ContextMenu_EjectMoon")
		else
			text = getText("IGUI_FirearmRadial_EjectMagazine")
		end
		local xln = weapon:isRoundChambered() and "IGUI_FirearmRadial_AmmoCountChambered" or "IGUI_FirearmRadial_AmmoCount"
		local textCount = getText(xln, weapon:getCurrentAmmoCount(), weapon:getMaxAmmo())
		text = text, '\n', textCount
		text = text:gsub("\\n", "\n")
		menu:addSlice(text, getTexture("media/ui/FirearmRadial_EjectMagazine.png"), self.invoke, self)
	else
		return
	end
end

function CEjectMagazine:invoke()
	local weapon = self:getWeapon()
	if not weapon then return end
	if weapon:isContainsClip() or weapon:getWeaponPart("Moonclip") then
		ISTimedActionQueue.add(ISEjectMagazine:new(self.character, weapon))
	else
		return
	end
end

local CLoadBulletsInMagazine = BaseCommand:derive("CLoadBulletsInMagazine")

function CLoadBulletsInMagazine:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

local function predicateNotFullMagazine(item, magazineType)
	return (item:getType() == magazineType or item:getFullType() == magazineType) and item:getCurrentAmmoCount() < item:getMaxAmmo()
end

local function predicateFullestMagazine(item1, item2)
	return item1:getCurrentAmmoCount() - item2:getCurrentAmmoCount()
end

function CLoadBulletsInMagazine:getMagazine(weapon)
	if not weapon:getMagazineType() then return nil end
	local inventory = self.character:getInventory()
	return inventory:getBestEvalArgRecurse(predicateNotFullMagazine, predicateFullestMagazine, weapon:getMagazineType())
end

function CLoadBulletsInMagazine:hasBulletsForMagazine(magazine)
	local inventory = self.character:getInventory()
	return inventory:getCountTypeRecurse(magazine:getAmmoType():getItemKey()) > 0
end

function CLoadBulletsInMagazine:fillMenu(menu, weapon, index)
    local weapon = self:getWeapon()
    if not weapon then return end
    local allow = false
    if weapon:getMagazineType() then
        allow = true
    elseif weapon:hasTag(Gun93Registries.guns93.MoonClip) and not weapon:getWeaponPart("Moonclip") then
        allow = true
    elseif (weapon:hasTag(Gun93Registries.guns93.SpeedLoader) or weapon:hasTag(Gun93Registries.guns93.StripperClip))
        and weapon:getCurrentAmmoCount() < 1 then
        allow = true
    end
    if not allow then return end
    local magazine = nil
    local highest = 200
    local magList = MagazineGunSet and MagazineGunSet[weapon:getFullType()]
    if magList then
        for _, magType in ipairs(magList) do
            local items = self.character:getInventory():getAllTypeRecurse(magType)
            for k = 0, items:size() - 1 do
                local mag = items:get(k)
                if mag and mag:getCurrentAmmoCount() < mag:getMaxAmmo() then
                    local ammoDelta = mag:getMaxAmmo() - mag:getCurrentAmmoCount()
                    if ammoDelta <= highest then
                        highest = ammoDelta
                        magazine = mag
                    end
                end
            end
        end
    end
    if not magazine then return end
    local prim = magazine:getAmmoType() and tostring(magazine:getAmmoType():getItemKey()) or nil
    local sec = nil
    local magData = magazine:getModData()
    if magData and magData.modAlt_Ammo then
        sec = tostring(magData.modAlt_Ammo)
    end
    local bullets = ArrayList.new()
    self.character:getInventory():getAllTagRecurse(Gun93Registries.guns93.Ammo, bullets)
    local hasAmmo = false
    for i = 0, bullets:size() - 1 do
        local round = bullets:get(i)
        local roundData = round:getModData()
        local caliber = roundData and roundData.isCaliber and tostring(roundData.isCaliber) or nil
        local fullType = tostring(round:getFullType())
        if caliber and ((prim and (caliber == prim or fullType == prim)) or (sec and (caliber == sec or fullType == sec))) then
            hasAmmo = true
            break
        end
    end
    if not hasAmmo then return end
    local text = getText("IGUI_FirearmRadial_LoadBulletsIntoMagazine")
    local textCount = getText("IGUI_FirearmRadial_AmmoCount", magazine:getCurrentAmmoCount(), magazine:getMaxAmmo())
    text = text .. " " .. textCount
    menu:addSlice(text, getTexture("media/ui/FirearmRadial_BulletsIntoMagazine.png"), self.invoke, self)
end

function CLoadBulletsInMagazine:invoke()
    local weapon = self:getWeapon()
    if not weapon then return end
    local allow = false
    if weapon:getMagazineType() then
        allow = true
    elseif weapon:hasTag(Gun93Registries.guns93.MoonClip) and not weapon:getWeaponPart("Moonclip") then
        allow = true
    elseif (weapon:hasTag(Gun93Registries.guns93.SpeedLoader) or weapon:hasTag(Gun93Registries.guns93.StripperClip))
        and weapon:getCurrentAmmoCount() < 1 then
        allow = true
    end
    if not allow then return end
    local magazine = nil
    local highest = 200
    local magList = MagazineGunSet and MagazineGunSet[weapon:getFullType()]
    if magList then
        for _, magType in ipairs(magList) do
            local items = self.character:getInventory():getAllTypeRecurse(magType)
            for k = 0, items:size() - 1 do
                local mag = items:get(k)
                if mag and mag:getCurrentAmmoCount() < mag:getMaxAmmo() then
                    local ammoDelta = mag:getMaxAmmo() - mag:getCurrentAmmoCount()
                    if ammoDelta <= highest then
                        highest = ammoDelta
                        magazine = mag
                    end
                end
            end
        end
    end
    if not magazine then return end
    local bulletNeeded = magazine:getMaxAmmo() - magazine:getCurrentAmmoCount()
    if bulletNeeded < 1 then return end
    local prim = magazine:getAmmoType() and tostring(magazine:getAmmoType():getItemKey()) or nil
    local sec = nil
    local magData = magazine:getModData()
    if magData and magData.modAlt_Ammo then
        sec = tostring(magData.modAlt_Ammo)
    end
    local bullets = ArrayList.new()
    self.character:getInventory():getAllTagRecurse(Gun93Registries.guns93.Ammo, bullets)
    local byType = {}
    local anyAvail = 0
    for i = 0, bullets:size() - 1 do
        local round = bullets:get(i)
        local roundData = round:getModData()
        local caliber = roundData and roundData.isCaliber and tostring(roundData.isCaliber) or nil
        local getType = tostring(round:getFullType())
        if caliber and ((prim and (caliber == prim or getType == prim)) or (sec and (caliber == sec or getType == sec))) then
            anyAvail = anyAvail + 1
            local entry = byType[getType]
            if not entry then
                entry = { count = 0 }
                byType[getType] = entry
            end
            entry.count = entry.count + 1
        end
    end
    if anyAvail < 1 then return end
    ISInventoryPaneContextMenu.transferIfNeeded(self.character, magazine)
    local transferred = 0
    local done = {}
    for fullType, info in pairs(byType) do
        if info.count > 0 and not done[fullType] then
            done[fullType] = true
            local n = ISInventoryPaneContextMenu.transferBullets( self.character, fullType, magazine:getCurrentAmmoCount(), magazine:getMaxAmmo() )
            transferred = transferred + (n or 0)
            if transferred >= bulletNeeded then
                break
            end
        end
    end
    if transferred < 1 then return end
    local loadCount = transferred
    if loadCount > bulletNeeded then
        loadCount = bulletNeeded
    end
    local action = ISLoadBulletsInMagazine:new(self.character, magazine, loadCount)
    action.round = prim
    action.round2 = sec
    action.bycaliber = true
    if guns93SendLoadIntent then
        guns93SendLoadIntent(self.character, magazine, prim, sec, true, loadCount)
    end
    ISTimedActionQueue.add(action)
end

local CLoadRounds = BaseCommand:derive("CLoadRounds")

function CLoadRounds:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CLoadRounds:hasBullets(weapon)
	local inventory = self.character:getInventory()
	return inventory:getCountTypeRecurse(weapon:getAmmoType():getItemKey()) > 0
end

function CLoadRounds:fillMenu(menu, weapon)
	if weapon:getMagazineType() then return end
	if weapon:getCurrentAmmoCount() >= weapon:getMaxAmmo() then return end
	if weapon:getWeaponPart("Moonclip") then return end
	if not self:hasBullets(weapon) then return end
	local text = getText("IGUI_FirearmRadial_LoadRounds")
	local xln = weapon:isRoundChambered() and "IGUI_FirearmRadial_AmmoCountChambered" or "IGUI_FirearmRadial_AmmoCount"
	local textCount = getText(xln, weapon:getCurrentAmmoCount(), weapon:getMaxAmmo())
	text = text, '\\n', textCount
	text = text:gsub('\\n', '\n')
	menu:addSlice(text, getTexture("media/ui/FirearmRadial_BulletsIntoFirearm.png"), self.invoke, self)
end

function CLoadRounds:invoke()
	local weapon = self:getWeapon()
	if not weapon then return end
	if weapon:getMagazineType() then return end
	if weapon:getCurrentAmmoCount() >= weapon:getMaxAmmo() then return end
	if not self:hasBullets(weapon) then return end
	ISInventoryPaneContextMenu.transferBullets(self.character, weapon:getAmmoType():getItemKey(), weapon:getCurrentAmmoCount(), weapon:getMaxAmmo())
	ISTimedActionQueue.add(ISReloadWeaponAction:new(self.character, weapon))
end


local CUnloadRounds = BaseCommand:derive("CUnloadRounds")

function CUnloadRounds:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CUnloadRounds:fillMenu(menu, weapon)
	if weapon:getMagazineType() then return end
	if weapon:getCurrentAmmoCount() == 0 then return end
	if weapon:getWeaponPart("Moonclip") then return end
	local text = getText("IGUI_FirearmRadial_UnloadRounds")
	local xln = weapon:isRoundChambered() and "IGUI_FirearmRadial_AmmoCountChambered" or "IGUI_FirearmRadial_AmmoCount"
	local textCount = getText(xln, weapon:getCurrentAmmoCount(), weapon:getMaxAmmo())
	text = text, '\\n', textCount
	text = text:gsub('\\n', '\n')
	menu:addSlice(text, getTexture("media/ui/FirearmRadial_BulletsFromFirearm.png"), self.invoke, self)
end

function CUnloadRounds:invoke()
	local weapon = self:getWeapon()
	if not weapon then return end
	if weapon:getMagazineType() then return end
	if weapon:getCurrentAmmoCount() == 0 then return end
	ISTimedActionQueue.add(ISUnloadBulletsFromFirearm:new(self.character, weapon, false))
end

local CRack = BaseCommand:derive("CRack")

function CRack:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CRack:fillMenu(menu, weapon, index)
	if not ISReloadWeaponAction.canRack(weapon) then return end
	if weapon:getWeaponPart("Moonclip") then return end
	local xln = weapon:isRoundChambered() and "IGUI_FirearmRadial_AmmoCountChambered" or "IGUI_FirearmRadial_AmmoCount"
	local textCount = getText(xln, weapon:getCurrentAmmoCount(), weapon:getMaxAmmo())
	if weapon:isJammed() then
		local text = getText("IGUI_FirearmRadial_Unjam")
		text = text, '\n', textCount
		menu:addSlice(text, getTexture("media/ui/FirearmRadial_Unjam.png"), self.invoke, self)
	elseif not weapon:haveChamber() or weapon:isRoundChambered() then
		local xln = weapon:haveChamber() and "IGUI_FirearmRadial_Rack" or "IGUI_FirearmRadial_UnloadRound"
		local text = getText(xln)
		text = text, '\n', textCount
		menu:addSlice(text, getTexture("media/ui/FirearmRadial_Rack.png"), self.invoke, self)
	elseif weapon:haveChamber() then
		local text = getText("IGUI_FirearmRadial_ChamberRound")
		text = text, '\n', textCount
		menu:addSlice(text, getTexture("media/ui/FirearmRadial_ChamberRound.png"), self.invoke, self)
	end
end

function CRack:invoke()
	local weapon = self:getWeapon()
	if not weapon then return end
	if not ISReloadWeaponAction.canRack(weapon) then return end
	ISTimedActionQueue.add(ISRackFirearm:new(self.character, weapon))
end

---Fill Radial Menu---

local ISFirearmRadialMenu_fillMenu_old = ISFirearmRadialMenu.fillMenu
function ISFirearmRadialMenu:fillMenu(submenu, subNum)
	local weapon = self.character:getPrimaryHandItem()
	local topBlock = false
	local bayo = nil
	local bayoFix = false
	if not weapon then return nil end
	if not instanceof(weapon, "HandWeapon") then 
		return nil
	else
		local menu = getPlayerRadialMenu(self.playerNum)
		menu:clear()
		local commands = {}
		local toggleParts = weapon:getAllWeaponParts()
		if not submenu then
			for i=1, self.character:getInventory():getItems():size() do
				local findbayo = self.character:getInventory():getItems():get(i-1)
				local bayoTag = false							
				if findbayo:hasTag(Gun93Registries.guns93.Bayonet) then
					bayoTag = findbayo:getType()
				end
				if bayoTag then
					if weapon:hasTag(Gun93Registries.guns93[bayoTag]) then
						bayo = findbayo
					end
					if weapon:getWeaponPart("BarrelItem") then
						if weapon:getWeaponPart("BarrelItem"):hasTag(Gun93Registries.guns93[bayoTag]) then
							bayo = findbayo
						end
					end
					if weapon:getWeaponPart("BayoLug") then
						if weapon:getWeaponPart("BayoLug"):hasTag(Gun93Registries.guns93[bayoTag]) then
							bayo = findbayo
						end
					end
				end
			end
			if weapon:getWeaponPart("Bayonet") then
				bayoFix = true
			elseif bayo ~= nil then
				if not bayo:isBroken() then
					bayoFix = true
				end
			end
			for index, preset in ipairs(FoldingStockSet) do
				if weapon:getWeaponPart("Stock") then
					if weapon:getWeaponPart("Stock"):hasTag(Gun93Registries.guns93.TopFold) then
						if weapon:getWeaponPart("Scope") then
							if weapon:getWeaponPart("Scope"):hasTag(Gun93Registries.guns93.TopBlock) then
								topBlock = true
							end
						end
						if weapon:getWeaponPart("Receiver") then
							if weapon:getWeaponPart("Receiver"):hasTag(Gun93Registries.guns93.TopBlock) then
								topBlock = true
							end
						end
					end
					if preset == weapon:getWeaponPart("Stock"):getFullType() and topBlock == false then
						foldStock = true
					end
				end
			end
			local auto = false
			local burst = false
			local autoOnly = false
			if not weapon:hasTag(Gun93Registries.guns93.ReqTrigger) then
				burst = true
				auto = true
			end
			if weapon:getWeaponPart("Trigger") then
				if weapon:getWeaponPart("Trigger"):hasTag(Gun93Registries.guns93.AutoOnly) then
					autoOnly = true
				end
			end
			if weapon:getWeaponPart("AutoPart") then
				if weapon:getWeaponPart("AutoPart"):hasTag(Gun93Registries.guns93.AutoOnly) then
					autoOnly = true
				end
			end
			if weapon:getWeaponPart("Trigger") then
				if weapon:getWeaponPart("Trigger"):hasTag(Gun93Registries.guns93.Fullauto) then
					auto = true
				end
			end
			if weapon:getWeaponPart("AutoPart") then
				if weapon:getWeaponPart("AutoPart"):hasTag(Gun93Registries.guns93.Fullauto) then
					auto = true
				end
			end
			if weapon:getWeaponPart("Trigger") then
				if weapon:getWeaponPart("Trigger"):hasTag(Gun93Registries.guns93.Burst) then
					burst = true
				end
			end
			if weapon:getWeaponPart("AutoPart") then
				if weapon:getWeaponPart("AutoPart"):hasTag(Gun93Registries.guns93.Burst) then
					burst = true
				end
			end
			if weapon:getMagazineType() or weapon:hasTag(Gun93Registries.guns93.MoonClip) or weapon:hasTag(Gun93Registries.guns93.SpeedLoader) or weapon:hasTag(Gun93Registries.guns93.StripperClip)then
				if weapon:isContainsClip() or weapon:getWeaponPart("Moonclip") then
					table.insert(commands, CEjectMagazine:new(self))
				elseif weapon:getMaxAmmo() > weapon:getCurrentAmmoCount() and not weapon:isContainsClip() then
					table.insert(commands, CInsertMagazine:new(self))
				end
				table.insert(commands, CLoadBulletsInMagazine:new(self))
			end
			if not weapon:isContainsClip() and not weapon:getWeaponPart("Moonclip") then
				table.insert(commands, CLoadRounds:new(self))
				table.insert(commands, CUnloadRounds:new(self))
			end
			table.insert(commands, CRack:new(self))
			if foldStock then
				table.insert(commands, CGuns93StockAdjust:new(self))
			end
			if bayoFix and not weapon:getWeaponPart("Bayonet") then
				if MuzzleDeviceCheck(weapon) then
					for i, v in pairs(ISFirearmRadialMenu.menu) do
						if v.subMenu and i == "FixBayonet" then
							menu:addSlice(v.name, ISFirearmRadialMenu.icons[i], self.fillMenu, self, i)
						end
					end
				end
			end
			if weapon:getWeaponPart("Bayonet") then
				if bayoFix then
					table.insert(commands, CGuns93FixBayonet:new(self))
				end
				if not weapon:getWeaponPart("Bayonet"):hasTag(Gun93Registries.guns93.BayoFolded) then
					table.insert(commands, CGuns93UseBayonet:new(self))
				end
			end
			local toggleParts = weapon:getAllWeaponParts()
			local addSlice = true
			for i=0, toggleParts:size()-1 do
				togglePart = toggleParts:get(i)
				if togglePart:hasTag(Gun93Registries.guns93.Bipod) then
					table.insert(commands, CGuns93Bipod:new(self))
				elseif togglePart:hasTag(Gun93Registries.guns93.ToggleItemOff) or togglePart:hasTag(Gun93Registries.guns93.ToggleItemOn) then
					for i, v in pairs(ISFirearmRadialMenu.menu) do
						if v.subMenu and i == "ToggleParts" then
							if addSlice then
								menu:addSlice(v.name, ISFirearmRadialMenu.icons[i], self.fillMenu, self, i)
								addSlice = false
							end
						end
					end
				end
			end
			if weapon:hasTag(Gun93Registries.guns93.AmmoSwitch) then
				table.insert(commands, CGuns93AmmoSwitch:new(self))
			end
			if weapon:getFireModePossibilities() then  
				for i=0, weapon:getFireModePossibilities():size() - 1 do
					local firemode = weapon:getFireModePossibilities():get(i);
					if firemode ~= weapon:getFireMode() then
						if firemode == "Auto" and auto and not autoOnly then
							table.insert(commands, CGuns93ModeAuto:new(self))
						end
						if firemode == "Burst" and burst and not autoOnly then
							table.insert(commands, CGuns93ModeBurst:new(self))
						end
						if firemode == "Single" and not autoOnly then
							table.insert(commands, CGuns93ModeSingle:new(self))
						end
					end
				end
			end
			for _,command in ipairs(commands) do
				local count = #menu.slices
				command:fillMenu(menu, weapon, index)
				if count == #menu.slices then
					menu:addSlice(nil, nil, nil)
				end
			end
		else
			if submenu == "FixBayonet" then
				table.insert(commands, CGuns93FixBayonet:new(self))
			elseif submenu == "ToggleParts" then
				table.insert(commands, CGuns93ToggleParts:new(self))
			end
			menu:addSlice(getText("IGUI_Emote_Back"), ISFirearmRadialMenu.icons["Back"], self.fillMenu, self)
			for _,command in ipairs(commands) do
				local count = #menu.slices
				command:fillMenu(menu, weapon, index)
				if count == #menu.slices then
					menu:addSlice(nil, nil, nil)
				end
			end
		end
		self:display()
		return
	end
	ISFirearmRadialMenu_fillMenu_old(self, submenu)
end

local ISFirearmRadialMenu_checkWeapon_old = ISFirearmRadialMenu.checkWeapon
function ISFirearmRadialMenu.checkWeapon(playerObj)
	local weapon = playerObj:getPrimaryHandItem()
	if not weapon then return false end
	if not instanceof(weapon, "HandWeapon") then return false end
	if weapon:hasTag(Gun93Registries.guns93.BayoUsed) then
		return true
	end
	return ISFirearmRadialMenu_checkWeapon_old(playerObj)
end

local ISLightSourceRadialMenu_onToggle_Old = ISLightSourceRadialMenu.onToggle
function ISLightSourceRadialMenu:onToggle(item)
    if not self or not self.character then
        return
    end
    if not item then
        return ISLightSourceRadialMenu_onToggle_Old(self, item)
    end
    local player = self.character
    if item:hasTag(Gun93Registries.guns93.Guns93) then
        local lightPart = nil
        local slots = { "BarrelItem", "Handguard", "HandguardItem", "Scope", "Light" }
        for _, slot in ipairs(slots) do
            local part = item:getWeaponPart(slot)
            if part and part:hasTag(Gun93Registries.guns93.Guns93Light) then
                lightPart = part
                break
            end
        end
        if lightPart then
            local canToggle = true
            if lightPart:hasTag(ItemTag.UsesBattery) then
                local uses = lightPart:getCurrentUses()
                if not uses or uses <= 1 then
                    canToggle = false
                end
            end
            local newPart = nil
            if lightPart:hasTag(Gun93Registries.guns93.ToggleItemOn) and canToggle then
                newPart = instanceItem(lightPart:getFullType() .. "_On")
            elseif lightPart:hasTag(Gun93Registries.guns93.ToggleItemOff) then
                newPart = instanceItem(lightPart:getFullType():gsub("_On$", ""))
            end
            if newPart then
                newPart:setCurrentUses(lightPart:getCurrentUses() or 0)
                item:detachWeaponPart(lightPart)
                item:attachWeaponPart(newPart)
                if item:isActivated() and lightPart:hasTag(Gun93Registries.guns93.ToggleItemOff) then
                    item:setActivated(false)
                else
                    item:setActivated(true)
                end
                if item.playActivateDeactivateSound then
                    item:playActivateDeactivateSound()
                end
                player:resetEquippedHandsModels()
                return
            end
        end
    end
    return ISLightSourceRadialMenu_onToggle_Old(self, item)
end