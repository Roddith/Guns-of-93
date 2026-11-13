--------------My Recipes Start--------------
SawedOffSpriteSet = {
    "Rem870","SORem870",
    "Rem870Park","SORem870Park",
    "Rem870P","SORem870Park",
    "Rem870PBlue","SORem870",
    "Rem870Marine","SORem870Marine",
    "M870","SOM870",
    "M870Blue","SORem870",
    "Rem1100Blue","SORem1100Blue",
    "Rem1187PBlue","SORem1100Blue",
    "Rem1100Gold","SORem1100Gold",
    "Rem1187Park","SORem1100Park",
    "Rem1187PPark","SORem1100Park",
    "Moss500Blue","SOMoss500Blue",
    "Moss500Gray","SOMoss500Gray",
    "Moss500Camo","SOMoss500Camo",
    "Ithaca37Blued","SOIthaca37Blued",
    "Ithaca37Gold","SOIthaca37Gold",
    "Ithaca37Park","SOIthaca37Blued",
    "Ithaca37SS","SOIthaca37SS",
    "Ithaca37Scene","SOIthaca37Scene",
    "Ithaca37MPBlued","SOIthaca37Blued",
    "Ithaca37MPPark","SOIthaca37Blued",
    "Ithaca37MPSS","SOIthaca37SS",
    "StoegerUplander2Tone","SOStoegerUplander2Tone",
    "StoegerUplander","SOStoegerUplander",
    "SavageFox","SOSavageFox",
    "SavageFoxCase","SOSavageFoxCase",
    "SavageFox2Tone","SOSavageFox2Tone",
    "Mav88","SOMav88",
    "Rem700","SORem700",
    "Rem700Bolt","SORem700Bolt",
    "Rem700Park","SORem700Park",
    "Rem788","SORem788",
    "M24","SOM24",
    "M24Camo","SOM24Camo",
    "Colt9mm","M635",
    "HK94","SOHK94",
    "WinM70Bolt","SOWinM70Bolt",
    "WinM70Lever","SOWinM70Lever",
    "WinM70SS","SOWinM70SS"
}

SawedOffIconSet = {
    "Rem870","SORem870Blue",
    "Rem870Park","SORem870Park",
    "Rem870P","SORem870Park",
    "Rem870PBlue","SORem870Blue",
    "Rem870Marine","SORem870Marine",
    "M870","SOM870Park",
    "M870Blue","SORem870Blue",
    "Rem1100Blue","SORem1100",
    "Rem1187PBlue","SORem1100",
    "Rem1100Gold","SORem1100Gold",
    "Rem1187Park","SORem1187Park",
    "Rem1187PPark","SORem1187Park",
    "Moss500Blue","SOMoss500Blue",
    "Moss500Gray","SOMoss500Gray",
    "Moss500Camo","SOMoss500Camo",
    "Ithaca37Blued","SOIthaca37Blued",
    "Ithaca37Gold","SOIthaca37Gold",
    "Ithaca37Park","SOIthaca37Blued",
    "Ithaca37SS","SOIthaca37SS",
    "Ithaca37Scene","SOIthaca37Scene",
    "Ithaca37MPBlued","SOIthaca37Blued",
    "Ithaca37MPPark","SOIthaca37Blued",
    "M37Park","SOIthaca37Blued",
    "M37Blued","SOIthaca37Blued",
    "Ithaca37MPSS","SOIthaca37SS",
    "UplanderTwoTone","SOUplanderTwoTone",
    "StoegerUplander","SOStoegerUplander",
    "SavageFox","SOSavageFox",
    "SavageFoxCase","SOSavageFoxCase",
    "SavageFox2Tone","SOSavageFox2Tone",
    "Mav88","SOMav88",
    "M24Camo","SOM24Camo",
    "Colt9mm","M635",
    "HK94","MP5",
    "HK94Fold","MP5Fold",
    "WinM70Lever","SOWinM70Lever",
    "WinM70SS","SOWinM70SS"
}

function RecipeCodeOnCreate.shotgunSawnoff(craftRecipeData, character)
    local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
	for i=0,items:size()-1 do
		local item = items:get(i)
		if item:getCategory() == "Weapon" then
            if item:getWeaponPart("Bayonet") then
                local bayoPart = item:getWeaponPart("Bayonet")
                local detachedType = string.gsub(bayoPart:getFullType(), "Part$", "")
                local removedBayo = instanceItem(detachedType)
                if bayoPart:hasTag(Gun93Registries.guns93.Sharp) then 
                    removedBayo:setSharpness(bayoPart:getSharpness()) 
                end
                removedBayo:setBloodLevel(item:getBloodLevel())
                item:detachWeaponPart(bayoPart)
                character:getInventory():AddItem(removedBayo)
                sendAddItemToContainer(character:getInventory(), removedBayo)
            end
            local remParts = result:getAllWeaponParts()
            for i = remParts:size() - 1, 0, -1 do
                result:detachWeaponPart(remParts:get(i))
            end
            local name = getText("ContextMenu_Guns93Naming_SawOff") .. item:getDisplayName()
            name = string.gsub(name, " %(", "")
            name = string.gsub(name, "%)", "")
            name = string.gsub(name, "Bloody", "")
            result:setName(name)
            result:setCondition(item:getCondition())
            result:setHaveBeenRepaired(item:getHaveBeenRepaired())
            result:setBloodLevel(item:getBloodLevel())
            result:setFavorite(item:isFavorite())
            result:setActivated(item:isActivated())
            result:setAttachedSlot(item:getAttachedSlot())
            if item:getCurrentAmmoCount() > 0 then
                ammoCount = item:getCurrentAmmoCount()
                if result:haveChamber() and item:isRoundChambered() then
                    ammoCount = ammoCount + 1
                    item:setRoundChambered(false)
                end
                character:getInventory():AddItems(item:getAmmoType():getItemKey(), ammoCount)
                item:setCurrentAmmoCount(0)
                result:setCurrentAmmoCount(0)
            end
			local modData = result:getModData()
			for k,v in pairs(item:getModData()) do
				modData[k] = v
			end
            local weaponParts = item:getAllWeaponParts()
            for i = 0, weaponParts:size() - 1 do
                local part = weaponParts:get(i)
                local partType = part:getPartType()
                if partType == "Canon" or partType == "Irons" or partType == "BarrelItem" or partType == "Shield" then
                    if not part:hasTag(Gun93Registries.guns93.NoMount) then
                        character:getInventory():AddItem(part)
                        sendAddItemToContainer(character:getInventory(), part)
                    end
                elseif partType ~= "Threading" then
                    result:attachWeaponPart(part)
                end
            end
            for index, preset in ipairs(SawedOffIconSet) do
                if preset == item:getWeaponSprite() then     
                    newIcon = SawedOffIconSet[index + 1]
                    if newIcon then
                        result:setTexture(getTexture("media/textures/item_".. newIcon .. ".png"))
                    end
                end
            end
            for index, preset in ipairs(SawedOffSpriteSet) do
                if preset == item:getWeaponSprite() then     
                    result:setWeaponSprite(SawedOffSpriteSet[index + 1])
                end
            end
	        syncHandWeaponFields(character, result)
            character:getInventory():setDirty(true)
			return
		end
	end
end

function Guns93OnTestAlwaysFail(item)
    return false
end

function Guns93OnTestDovetailHandgun(item)
    local ready = false
    if item:hasTag(ItemTag.FILE) or item:hasTag(ItemTag.SMALLFILES) then
        ready = true
	elseif item:getCategory() == "Weapon" then
        if item:getWeaponPart("Irons") then
            if item:getWeaponPart("Irons"):hasTag(Gun93Registries.guns93.NoMount) then
                ready = true
            end
		end
    end
    return ready
end

function Guns93OnCreateDovetailHandgun(craftRecipeData, character)
    local item = craftRecipeData:getFirstInputItemWithFlag("Prop2")
	if item:getCategory() == "Weapon" then
        if item:getWeaponPart("Irons") then
            if item:getWeaponPart("Irons"):hasTag(Gun93Registries.guns93.NoMount) then
                local irons = item:getWeaponPart("Irons")
                item:detachWeaponPart(irons)
	            syncHandWeaponFields(character, item)
            end
        end
	end
end

function Guns93OnTestIsHKPaddle(item)
    local ready = false
    if item:getCategory() == "Weapon" then
        if item:getWeaponPart("MagWell") then
            ready = true
		end
    else
        ready = true
    end
    return ready
end

function Guns93OnCreateRemoveHKPaddle(craftRecipeData, character)
    local item = craftRecipeData:getFirstInputItemWithFlag("Prop2")
	if item:getCategory() == "Weapon" then
        if item:getWeaponPart("MagWell") then
            local paddle = item:getWeaponPart("MagWell")
            item:detachWeaponPart(paddle)
	        syncHandWeaponFields(character, item)
        end
	end
end

function Guns93OnTestNoHKPaddle(item)
    local ready = false
    if item:getCategory() == "Weapon" then
        if item:getWeaponPart("MagWell") then
            ready = false
		end
    else
        ready = true
    end
    return ready
end

function Guns93OnCreateInstallHKPaddle(craftRecipeData, character)
    local item = craftRecipeData:getFirstInputItemWithFlag("Prop2")
	if item:getCategory() == "Weapon" then
        local paddle = instanceItem("Base.HKMagRelease")
        item:attachWeaponPart(paddle)
	    syncHandWeaponFields(character, item)
	end
end

function Guns93OnTestPinWeldCanon(item)
    local ready = false
    if item:getCategory() == "Weapon" then
        if item:getWeaponPart("Canon") then
            if item:getWeaponPart("Canon"):hasTag(Gun93Registries.guns93.NoMount) then
                ready = true
            end
		end
    else
        ready = true
    end
    return ready
end

function Guns93OnCreatePinWeldCanon(craftRecipeData, character)
    local item = craftRecipeData:getFirstInputItemWithFlag("Prop2")
	if item:getCategory() == "Weapon" then
        if item:getWeaponPart("Canon") then
            if item:getWeaponPart("Canon"):hasTag(Gun93Registries.guns93.NoMount) then
                local canon = item:getWeaponPart("Canon")
                item:detachWeaponPart(canon)
	            syncHandWeaponFields(character, item)
            end
        end
	end
end

function Guns93OnTestInstallBayo(item)
    if item:hasTag(ItemTag.SCREWDRIVER) then
        return true
	elseif item:getCategory() == "Weapon" then
        if item:getWeaponPart("Bayonet") == nil then
            return true
        else
            return false
        end
	elseif item:hasTag(Gun93Registries.guns93.UseDriver) then
        return true
    else
        return false
	end
end

function Guns93OnTestCleanKitTest(item)
    local fill = true
    if not item:hasTag(Gun93Registries.guns93.EmptyGunCleanKit) and item:hasTag(Gun93Registries.guns93.GunCleaningKit) then
        if (1/(item:getUseDelta()))-item:getCurrentUses() < 1 then
            fill = false
        end
    end
    return fill
end

function Guns93OnCreateCleanKitCreate(craftRecipeData, character)
    local item = craftRecipeData:getFirstInputItemWithTag(Gun93Registries.guns93.GunOil);
	local result = craftRecipeData:getAllCreatedItems():get(0);
    if item:getCurrentUses() then
        if item:getCurrentUses() < (1/result:getUseDelta()) then
            result:setCurrentUses(item:getCurrentUses())
            item:setCurrentUses(0)
        else
            item:setCurrentUses(item:getCurrentUses()-(1/result:getUseDelta()))
            result:setCurrentUses((1/result:getUseDelta()))
        end
    end
end

function Guns93OnCreateCleanKitFill(craftRecipeData, character)
    local item = craftRecipeData:getFirstInputItemWithTag(Gun93Registries.guns93.GunOil);
	local item2 = craftRecipeData:getFirstInputItemWithTag(Gun93Registries.guns93.GunCleaningKit);
    local getUses = item:getCurrentUses()
    local getUses2 = item2:getCurrentUses()
    if item2:hasTag(Gun93Registries.guns93.EmptyGunCleanKit) then
        local newKit = character:getInventory():addItem(instanceItem(string.gsub(item2:getFullType(), "Empty", "")))
        character:getInventory():Remove(item2)
        item2 = newKit
        item2:setCurrentUses(0)
        getUses2 = item2:getCurrentUses()
    end
    local fillAmount = (1/item2:getUseDelta())-getUses2
    if fillAmount > getUses then
        item:setCurrentUses(0)
        item2:setCurrentUses(getUses2+getUses)
    elseif fillAmount <= getUses then
        item:setCurrentUses(getUses-fillAmount)
        item2:setCurrentUses(getUses2+fillAmount)
    end
end

function Guns93OnCreateInstallBayo(craftRecipeData, character)
    local weapon = craftRecipeData:getFirstInputItemWithFlag("Prop2")
	for i=0,craftRecipeData:getAllConsumedItems():size()-1 do
        local fixbayo = craftRecipeData:getAllConsumedItems():get(i)
        if fixbayo:hasTag(Gun93Registries.guns93.UseDriver) then
            local bayopart = instanceItem(fixbayo:getType() .. "Part")
            if fixbayo:getSharpness() then
                bayopart:setSharpness(fixbayo:getSharpness())
            end
            bayopart:setCondition(fixbayo:getCondition())
            bayopart:setHaveBeenRepaired(fixbayo:getHaveBeenRepaired())
            if fixbayo:getBloodLevel() > weapon:getBloodLevel() then
                weapon:setBloodLevel(fixbayo:getBloodLevel())
            end
            weapon:attachWeaponPart(bayopart)
        end
    end
end

function Guns93OnTestRemoveBayo(item)
    if item:hasTag(ItemTag.SCREWDRIVER) then
        return true
	elseif item:getCategory() == "Weapon" then
        local bayo = item:getWeaponPart("Bayonet")
        if bayo and bayo:hasTag(Gun93Registries.guns93.FoldingBayo) then
            return true
        else
            return false
        end
    else
        return false
	end
end

function Guns93OnCreateRemoveBayo(craftRecipeData, character)
    local weapon = craftRecipeData:getFirstInputItemWithFlag("Prop2")
    local bayopart = weapon:getWeaponPart("Bayonet")
    local removebayo = character:getInventory():AddItem(instanceItem(string.gsub(string.gsub(weapon:getWeaponPart("Bayonet"):getFullType(),"Part",""),"Out","")))
    if bayopart:getSharpness() then
        removebayo:setSharpness(bayopart:getSharpness())
    end
    removebayo:setCondition(bayopart:getCondition())
    removebayo:setBloodLevel(weapon:getBloodLevel())
    removebayo:setHaveBeenRepaired(bayopart:getHaveBeenRepaired())
    weapon:detachWeaponPart("Bayonet")
	syncHandWeaponFields(character, weapon)
end

function Guns93OnCreateBeltLink556(craftRecipeData, character)
    local amount = craftRecipeData:getAllConsumedItems():size();
    character:getInventory():AddItems("Base.556BeltLink", amount);
end

function Guns93OnCreateBeltLink308(craftRecipeData, character)
    local amount = craftRecipeData:getAllConsumedItems():size();
    character:getInventory():AddItems("Base.308BeltLink", amount);
end

function Guns93OnTestAmmoCountZero(item)
    if item:getMaxAmmo() then
        if item:getCurrentAmmoCount() > 0 then
            return false
        elseif item:getCurrentAmmoCount() == 0 then
            return true
        end
    end
end

function Guns93OnCreateDisassembleOilFilterSilencer(craftRecipeData, character)
    character:getInventory():AddItem("Base.ThreadAdapter", 1)
end

function Guns93OnCreateDisassembleBoostedSilencer(craftRecipeData, character)
    character:getInventory():AddItem("Base.CanBooster", 1)
end

function Guns93OnCreateDisassembleTriLugSilencer(craftRecipeData, character)
    character:getInventory():AddItem("Base.SilencerTriLug", 1)
end

function Guns93OnTestGuns93NoAmmoCheck(item, result, player)
    if item:getMaxAmmo() then
        if item:getCurrentAmmoCount() > 0 then
            return false
        elseif item:getCurrentAmmoCount() == 0 then
            return true
        end
    end
end

function Guns93OnCreateThreadBarrel(craftRecipeData, character)
	local item = craftRecipeData:getAllKeepInputItems():get(0);
    if not item:getWeaponPart("Threading") then
        local threading = instanceItem("Base.BarrelThread")
        item:attachWeaponPart(threading)
	    syncHandWeaponFields(character, item)
    end
end

function Guns93OnCreateThreadBarrelCanon(craftRecipeData, character)
	local item = craftRecipeData:getAllKeepInputItems():get(0);
    local canon = item:getWeaponPart("Canon"):getType()
    character:getInventory():AddItem(instanceItem(canon .. "Thread"))
    item:detachWeaponPart("Canon")
    item:attachWeaponPart(instanceItem("Base.BarrelThread"))
	syncHandWeaponFields(character, item)
end

function Guns93OnCreateBarrelThreadExtension(craftRecipeData, character)
	local item = craftRecipeData:getAllKeepInputItems():get(0);
    if not item:getWeaponPart("Threading") then
        local threading = instanceItem("Base.BarrelThreadExtension")
        item:attachWeaponPart(threading)
	    syncHandWeaponFields(character, item)
    end
end

function Guns93OnCreateBoreThread(craftRecipeData, character)
	local item = craftRecipeData:getAllKeepInputItems():get(0);
    if not item:getWeaponPart("Threading") then
        local threading = instanceItem("Base.BoreThread")
        item:attachWeaponPart(threading)
	    syncHandWeaponFields(character, item)
    end
end


local function predicateNotBroken(item)
	return not item:isBroken()
end

function Guns93WeaponPartsNoRemove(character, weapon, weaponPart)
    return character == nil or false
end

function Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    local toolCheck = false
    if weaponPart:hasTag(Gun93Registries.guns93.UseDriver) then
        if character:getInventory():getFirstTagEvalRecurse(ItemTag.SCREWDRIVER, predicateNotBroken) then
            toolCheck = true
        end
    elseif weaponPart:hasTag(Gun93Registries.guns93.UseWrench) then
        if character:getInventory():getFirstTagEvalRecurse(ItemTag.WRENCH, predicateNotBroken) then
            toolCheck = true
        end
    elseif weaponPart:hasTag(Gun93Registries.guns93.NoScrewdriver) then
        toolCheck = true
    end
    if weapon:getWeaponPart("Stock") then
        if weapon:getWeaponPart("Stock"):hasTag(Gun93Registries.guns93.BullpupStock) then
            if weaponPart:getPartType() == "BarrelItem" or weaponPart:getPartType() == "UpHandguard" or weaponPart:getPartType() == "Receiver" then
                toolCheck = false
            end
        end
    end
    if weapon:getWeaponPart("BarrelItem") or weapon:getWeaponPart("BayoLug") then
        local bayoLug = false
        if weapon:getWeaponPart("BarrelItem") and weapon:getWeaponPart("BarrelItem"):hasTag(Gun93Registries.guns93.Bayonet) then
            bayoLug = weapon:getWeaponPart("BarrelItem")
        end
        if weapon:getWeaponPart("BayoLug") and weapon:getWeaponPart("BayoLug"):hasTag(Gun93Registries.guns93.Bayonet) then
            bayoLug = weapon:getWeaponPart("BayoLug")
        end
        if bayoLug then
            if bayoLug:hasTag(Gun93Registries.guns93.ShieldBlock) and weaponPart:getPartType() == "Shield" or weaponPart:getPartType() == "UpHandguard" then
                toolCheck = false
            end
            if bayoLug:hasTag(Gun93Registries.guns93.IronsBlock) and weaponPart:getPartType() == "Irons" then
                toolCheck = false
            end
        end
    end
    if weapon:getWeaponPart("Canon") and weaponPart:hasTag(Gun93Registries.guns93.CanonBlock) then
        toolCheck = false
    end
    return character == nil or toolCheck
end

function Guns93WeaponPartsBayoLug(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    if toolCheck then
        if weaponPart:hasTag(Gun93Registries.guns93.ShieldBlock) and weapon:getWeaponPart("Shield") then
            toolCheck = false
        end
        if weaponPart:hasTag(Gun93Registries.guns93.IronsBlock) and weapon:getWeaponPart("Irons") then
            toolCheck = false
        end
    end
    return character == nil or toolCheck
end

function Guns93WeaponPartsBullpupStock(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    if toolCheck then
        if weapon:getWeaponPart("BarrelItem") or weapon:getWeaponPart("UpHandguard") or weapon:getWeaponPart("Receiver") then
            toolCheck = false
        end
    end
    return character == nil or toolCheck
end

function Guns93WeaponPartsReflexCan(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    if character == nil then
        return true
    elseif toolCheck then
        if weapon:getWeaponPart("ReflexCollar") then
            return true
        end
    else
        return false
    end
end

function Guns93WeaponPartsReflexCollar(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    if character == nil then
        return true
    elseif toolCheck then
        if weapon:getWeaponPart("Canon") then
            return false
        else
            return true
        end
    else
        return false
    end
end

function Guns93WeaponPartsRailInstall(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    if weapon:getWeaponPart("Stock") then
        if weapon:getWeaponPart("Stock"):hasTag(Gun93Registries.guns93.TopBlock) then
            return false
        end
    end
    return character == nil or toolCheck
end

function Guns93WeaponPartsRecoilPad(character, weapon, weaponPart)
    local toolCheck = false
    if weaponPart:hasTag(Gun93Registries.guns93.UseDriver) then
        if character:getInventory():containsTagEval(ItemTag.SCREWDRIVER, predicateNotBroken) then
            toolCheck = true
        end
    elseif weaponPart:hasTag(Gun93Registries.guns93.UseWrench) then
        if character:getInventory():getFirstTagEvalRecurse(ItemTag.WRENCH, predicateNotBroken) then
            toolCheck = true
        end
    elseif weaponPart:hasTag(Gun93Registries.guns93.NoScrewdriver) then
        toolCheck = true
    end
    if character == nil then
        return true
    elseif toolCheck then
        if weapon:getWeaponPart("Stock") then
            if weapon:getWeaponPart("Stock"):hasTag(Gun93Registries.guns93.RecoilPad) then
                return true
            end
        elseif weapon:hasTag(Gun93Registries.guns93.RecoilPad) then
            return true
        end
    else
        return false
    end
end

function Guns93WeaponPartsMountSling(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    local rearSwivel = false
    local frontSwivel = false
    if toolCheck then
        if weapon:getWeaponPart("Stock") then
            if weapon:getWeaponPart("Stock"):hasTag(Gun93Registries.guns93.RearSwivel) then
                rearSwivel = true
            end
        end
        if weapon:hasTag(Gun93Registries.guns93.RearSwivel) then
            rearSwivel = true
        end
        if weapon:getWeaponPart("Stock") then
            if weapon:getWeaponPart("Stock"):hasTag(Gun93Registries.guns93.FrontSwivel) then
                frontSwivel = true
            end
        end
        if weapon:getWeaponPart("Handguard") then
            if weapon:getWeaponPart("Handguard"):hasTag(Gun93Registries.guns93.FrontSwivel) then
                frontSwivel = true
            end
        end
        if weapon:hasTag(Gun93Registries.guns93.FrontSwivel) then
            frontSwivel = true
        end
    end
    if character == nil or (rearSwivel and frontSwivel) then
        return true
    else
        return false
    end
end

function Guns93WeaponPartsHeatShield(character, weapon, weaponPart)
    local isCompatible = true
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    if weaponPart:hasTag(Gun93Registries.guns93.NoShield) then
        if weapon:getWeaponPart("Shield") then
            if weapon:getWeaponPart("Shield"):hasTag(Gun93Registries.guns93.NoShield) then
                isCompatible = false
            end
        elseif weapon:getWeaponPart("Irons") then
            if weapon:getWeaponPart("Irons"):hasTag(Gun93Registries.guns93.NoShield) then
                isCompatible = false
            end
        end
    end
    if character == nil then
        return true
    elseif isCompatible and toolCheck then
        return true
    else
        return false
    end
end

function Guns93WeaponPartsMountScope(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    local canMount = false
    if toolCheck then
        if weaponPart:hasTag(Gun93Registries.guns93.ScopeRail) then
            if weapon:getWeaponPart("Receiver") then
                if weapon:getWeaponPart("Receiver"):hasTag(Gun93Registries.guns93.ScopeRail) then
                    canMount = true
                end
            elseif weapon:hasTag(Gun93Registries.guns93.ScopeRail) then
                canMount = true
            end
        end
        if weaponPart:hasTag(Gun93Registries.guns93.PistolRail) then
            if weapon:getWeaponPart("Receiver") then
                if weapon:getWeaponPart("Receiver"):hasTag(Gun93Registries.guns93.PistolRail) then
                    canMount = true
                end
            elseif weapon:getWeaponPart("Grip") then
                if weapon:getWeaponPart("Grip"):hasTag(Gun93Registries.guns93.PistolRail) then
                    canMount = true
                end
            elseif weapon:hasTag(Gun93Registries.guns93.PistolRail) then
                canMount = true
            end
        end
    end
    if weapon:getWeaponPart("Scope") or weapon:getWeaponPart("RedDot") or weapon:getWeaponPart("Scope2") then
        canMount = false
    end
    return character == nil or canMount
end

function Guns93WeaponPartsMountRail(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    local canMount = false
    if toolCheck then
        if weapon:getWeaponPart("Scope") or weapon:getWeaponPart("RedDot") or weapon:getWeaponPart("Scope2") then
            canMount = false
        else
            canMount = true
        end
    end
    return character == nil or canMount
end

function Guns93WeaponPartsMountReceiver(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    local canMount = false
    if toolCheck then
        if weapon:getWeaponPart("Scope") or weapon:getWeaponPart("RedDot") or weapon:getWeaponPart("Scope2") or weapon:getWeaponPart("Receiver") then
            canMount = false
        else
            canMount = true
        end
    end
    return character == nil or canMount
end

function Guns93WeaponPartsMountACOG(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    local canMount = false
    local railBlock = false
    if toolCheck then
        if weaponPart:hasTag(Gun93Registries.guns93.ScopeRail) then
            if weapon:getWeaponPart("Receiver") then
                if weapon:getWeaponPart("Receiver"):hasTag(Gun93Registries.guns93.ScopeRail) then
                    canMount = true
                    railBlock = true
                end
            elseif weapon:hasTag(Gun93Registries.guns93.ScopeRail) then
                canMount = true
                railBlock = true
            end
        end
        if weapon:hasTag(Gun93Registries.guns93.ARHandle) then
            canMount = true
            if railBlock == true then
                canMount = false
            end
        end
    end
    if weapon:getWeaponPart("Scope") or weapon:getWeaponPart("RedDot") or weapon:getWeaponPart("Scope2") then
        return false
    end
	if character == nil or canMount then
        return true
    end
end

function Guns93WeaponPartsDirectMount(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    local railBlock = false
    if toolCheck then
        if weapon:getWeaponPart("Receiver") then
            if weapon:getWeaponPart("Receiver"):hasTag(Gun93Registries.guns93.ScopeRail) then
                railBlock = true
            end
        elseif weapon:hasTag(Gun93Registries.guns93.ScopeRail) then
                railBlock = true
        end
        if weapon:hasTag(Gun93Registries.guns93.ARHandle) then
            if railBlock == true then
                return false
            else
                return true
            end
        end
    end
    if weapon:getWeaponPart("Scope") or weapon:getWeaponPart("RedDot") or weapon:getWeaponPart("Scope2") then
        return false
    end
	if character == nil or canMount then
        return true
    end
end

function Guns93WeaponPartsSidesaddle(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    if character == nil then
        return true
    elseif toolCheck then
        if weaponPart:hasTag(Gun93Registries.guns93.Sidesaddle) and weapon:hasTag(Gun93Registries.guns93.Sidesaddle) then
            return true
        end
    else
        return false
    end
end

function Guns93WeaponPartsStockitem(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    if character == nil then
        return true
    elseif weapon:hasTag(Gun93Registries.guns93.Stockitem) and toolCheck then
        return true
    elseif weapon:getWeaponPart("Stock") and toolCheck then
        if weapon:getWeaponPart("Stock"):hasTag(Gun93Registries.guns93.Stockitem) then
            return true
        end
    else
        return false
    end
end

function Guns93WeaponPartsHandguardItem(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    if character == nil then
        return true
    elseif toolCheck then
        if weapon:hasTag(Gun93Registries.guns93.HandguardItem) then
            return true
        elseif weapon:getWeaponPart("Handguard") then
            if weapon:getWeaponPart("Handguard"):hasTag(Gun93Registries.guns93.HandguardItem) then
                return true
            end
        elseif weapon:getWeaponPart("Stock") then
            if weapon:getWeaponPart("Stock"):hasTag(Gun93Registries.guns93.HandguardItem) then
                return true
            end
        end
    else
        return false
    end
end

function Guns93WeaponPartsSpecialHandguard(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    if character == nil then
        return true
    elseif weapon:hasTag(Gun93Registries.guns93.SpecialHandguard) and toolCheck then
        return true
    elseif weapon:getWeaponPart("Handguard") and toolCheck then
        if weapon:getWeaponPart("Handguard"):hasTag(Gun93Registries.guns93.SpecialHandguard) then
            return true
        end
    elseif weapon:getWeaponPart("Stock") and toolCheck then
        if weapon:getWeaponPart("Stock"):hasTag(Gun93Registries.guns93.SpecialHandguard) then
            return true
        end
    else
        return false
    end
end

function Guns93WeaponPartsBothStockitem(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    if character == nil then
        return true
    elseif weapon:getWeaponPart("Stock") and toolCheck then
        if weapon:getWeaponPart("Stock"):hasTag(Gun93Registries.guns93.Stockitem) or weapon:getWeaponPart("Stock"):hasTag(Gun93Registries.guns93.StockitemMag) or weapon:hasTag(Gun93Registries.guns93.Stockitem) or weapon:hasTag(Gun93Registries.guns93.StockitemMag) then
            return true
        end
    else
        return false
    end
end

function Guns93WeaponPartsTGrip(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    if character == nil then
        return true
    elseif weapon:getWeaponPart("Grip") and toolCheck then
        if weapon:getWeaponPart("Grip"):hasTag(Gun93Registries.guns93.TGrip) then
            return true
        end
    else
        return false
    end
end

function Guns93WeaponPartsRifleGrip(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    if character == nil then
        return true
    elseif weapon:getWeaponPart("Stock") and toolCheck then
        if weapon:getWeaponPart("Stock"):hasTag(Gun93Registries.guns93.Sport) then
            return false
        else
            return true
        end
    else
        return true
    end
end

function Guns93WeaponPartsSportStock(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    if character == nil then
        return true
    elseif weapon:getWeaponPart("Grip") then
        return false
    elseif toolCheck then
        return true
    end
end

function Guns93WeaponPartsStockitemMag(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    if character == nil then
        return true
    elseif weapon:getWeaponPart("Stock") and toolCheck then
        if weapon:getWeaponPart("Stock"):hasTag(Gun93Registries.guns93.StockitemMag) or weapon:hasTag(Gun93Registries.guns93.StockitemMag) then
            return true
        end
    else
        return false
    end
end

function Guns93WeaponPartsWML(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    if character == nil then
        return true
    elseif toolCheck then
        local start = true
        if weapon:getWeaponPart("BarrelItem") then
            if weapon:getWeaponPart("BarrelItem"):hasTag(Gun93Registries.guns93.Light) then
                start = false
                return false
            end
        end
        if weapon:getWeaponPart("Handguard") then
            if weapon:getWeaponPart("Handguard"):hasTag(Gun93Registries.guns93.Light) then
                start = false
                return false
            end
            if weapon:hasTag(Gun93Registries.guns93.BiBarrelBlock) then
                if weapon:getWeaponPart("Handguard"):hasTag(Gun93Registries.guns93.Bipod) then
                    start = false
                    return false
                end
            end
        end
        if weapon:getWeaponPart("HandguardItem") then
            if weapon:getWeaponPart("HandguardItem"):hasTag(Gun93Registries.guns93.Light) then
                start = false
                return false
            end
            if weapon:hasTag(Gun93Registries.guns93.BiBarrelBlock) then
                if weapon:getWeaponPart("HandguardItem"):hasTag(Gun93Registries.guns93.Bipod) then
                    start = false
                    return false
                end
            end
        end
        if weapon:getWeaponPart("Scope") then
            if weapon:getWeaponPart("Scope"):hasTag(Gun93Registries.guns93.Light) then
                start = false
                return false
            end
        end
        if weapon:getWeaponPart("Scope2") then
            if weapon:getWeaponPart("Scope2"):hasTag(Gun93Registries.guns93.Light) then
                start = false
                return false
            end
        end
        if weapon:getWeaponPart("Light") then
            if weapon:getWeaponPart("Light"):hasTag(Gun93Registries.guns93.Light) then
                start = false
                return false
            end
        end
        if weaponPart:getPartType() == "BarrelItem" and (not weapon:hasTag(Gun93Registries.guns93.BarrelItem) or weapon:getWeaponPart("Bayonet")) then
            start = false
            return false
        end
        if weaponPart:getPartType() == "Handguard" then
            if weapon:hasTag(Gun93Registries.guns93.WMLBarrelBlock) and weapon:getWeaponPart("BarrelItem") and not weapon:getWeaponPart("BarrelItem"):hasTag(Gun93Registries.guns93.MagExten)  then
                start = false
                return false
            end
        end
        if weaponPart:getPartType() == "BarrelItem" then
            if weapon:hasTag(Gun93Registries.guns93.BiBayoBlock) and weapon:getWeaponPart("Bayonet") then
                start = false
                return false
            elseif weapon:hasTag(Gun93Registries.guns93.WMLBarrelBlock) and weapon:getWeaponPart("Handguard") then
                if weapon:getWeaponPart("Handguard"):hasTag(Gun93Registries.guns93.Light) then
                    start = false
                    return false
                end
            end
        end
        if start then
            return true
        end
    else
        return false
    end
end

function Guns93WeaponPartsLaser(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    if character == nil then
        return true
    elseif toolCheck then
        local start = true
        if weapon:getWeaponPart("BarrelItem") then
            if weapon:getWeaponPart("BarrelItem"):hasTag(Gun93Registries.guns93.Laser) then
                start = false
                return false
            end
        end
        if weapon:getWeaponPart("Handguard") then
            if weapon:getWeaponPart("Handguard"):hasTag(Gun93Registries.guns93.Laser) then
                start = false
                return false
            end
            if weapon:hasTag(Gun93Registries.guns93.BiBarrelBlock) then
                if weapon:getWeaponPart("Handguard"):hasTag(Gun93Registries.guns93.Bipod) then
                    start = false
                    return false
                end
            end
        end
        if weapon:getWeaponPart("HandguardItem") then
            if weapon:getWeaponPart("HandguardItem"):hasTag(Gun93Registries.guns93.Laser) then
                start = false
                return false
            end
            if weapon:hasTag(Gun93Registries.guns93.BiBarrelBlock) then
                if weapon:getWeaponPart("HandguardItem"):hasTag(Gun93Registries.guns93.Bipod) then
                    start = false
                    return false
                end
            end
        end
        if weapon:getWeaponPart("Scope") then
            if weapon:getWeaponPart("Scope"):hasTag(Gun93Registries.guns93.Laser) then
                start = false
                return false
            end
        end
        if weapon:getWeaponPart("Scope2") then
            if weapon:getWeaponPart("Scope2"):hasTag(Gun93Registries.guns93.Laser) then
                start = false
                return false
            end
        end
        if weapon:getWeaponPart("Light") then
            if weapon:getWeaponPart("Light"):hasTag(Gun93Registries.guns93.Laser) then
                start = false
                return false
            end
        end
        if weaponPart:getPartType() == "BarrelItem" and (not weapon:hasTag(Gun93Registries.guns93.BarrelItem) or weapon:getWeaponPart("Bayonet")) then
            start = false
            return false
        end
        if weaponPart:getPartType() == "Handguard" then
            if weapon:hasTag(Gun93Registries.guns93.WMLBarrelBlock) and weapon:getWeaponPart("BarrelItem") then
                start = false
                return false
            end
        end
        if weaponPart:getPartType() == "BarrelItem" then
            if weapon:hasTag(Gun93Registries.guns93.BiBayoBlock) and weapon:getWeaponPart("Bayonet") then
                start = false
                return false
            elseif weapon:hasTag(Gun93Registries.guns93.WMLBarrelBlock) and weapon:getWeaponPart("Handguard") then
                if weapon:getWeaponPart("Handguard"):hasTag(Gun93Registries.guns93.Light) then
                    start = false
                    return false
                end
            end
        end
        if start then
            return true
        end
    else
        return false
    end
end

function Guns93WeaponPartsLaserScope(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    local canMount = false
    if toolCheck then
        if weaponPart:hasTag(Gun93Registries.guns93.ScopeRail) then
            if weapon:getWeaponPart("Receiver") then
                if weapon:getWeaponPart("Receiver"):hasTag(Gun93Registries.guns93.ScopeRail) then
                    canMount = true
                end
            elseif weapon:hasTag(Gun93Registries.guns93.ScopeRail) then
                canMount = true
            end
        end
        if weaponPart:hasTag(Gun93Registries.guns93.PistolRail) then
            if weapon:getWeaponPart("Receiver") then
                if weapon:getWeaponPart("Receiver"):hasTag(Gun93Registries.guns93.PistolRail) then
                    canMount = true
                end
            elseif weapon:getWeaponPart("Grip") then
                if weapon:getWeaponPart("Grip"):hasTag(Gun93Registries.guns93.PistolRail) then
                    canMount = true
                end
            elseif weapon:hasTag(Gun93Registries.guns93.PistolRail) then
                canMount = true
            end
        end
    end
    if character == nil then
        return true
    end
    if canMount then
        local start = true
        if weapon:getWeaponPart("BarrelItem") then
            if weapon:getWeaponPart("BarrelItem"):hasTag(Gun93Registries.guns93.Laser) then
                start = false
                return false
            end
        end
        if weapon:getWeaponPart("Handguard") then
            if weapon:getWeaponPart("Handguard"):hasTag(Gun93Registries.guns93.Laser) then
                start = false
                return false
            end
        end
        if weapon:getWeaponPart("HandguardItem") then
            if weapon:getWeaponPart("HandguardItem"):hasTag(Gun93Registries.guns93.Laser) then
                start = false
                return false
            end
        end
        if weapon:getWeaponPart("Scope") then
            if weapon:getWeaponPart("Scope"):hasTag(Gun93Registries.guns93.Laser) then
                start = false
                return false
            end
        end
        if weapon:getWeaponPart("Scope2") then
            if weapon:getWeaponPart("Scope2"):hasTag(Gun93Registries.guns93.Laser) then
                start = false
                return false
            end
        end
        if weapon:getWeaponPart("Light") then
            if weapon:getWeaponPart("Light"):hasTag(Gun93Registries.guns93.Laser) then
                start = false
                return false
            end
        end
        if start and canMount then
            return true
        end
    else
        return false
    end
end

function Guns93WeaponPartsMountSights(character, weapon, weaponPart)
    local isCompatible = false
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    local shield = true
    if weapon:getWeaponPart("Shield") then
        if weapon:getWeaponPart("Shield"):hasTag(Gun93Registries.guns93.NoShield) then
            shield = false
        end
    elseif weapon:getWeaponPart("Irons") then
        if weapon:getWeaponPart("Irons"):hasTag(Gun93Registries.guns93.NoShield) then
            shield = false
        end
    end
    if weaponPart:hasTag(Gun93Registries.guns93.PistolSights) and weapon:hasTag(Gun93Registries.guns93.PistolSights) then
        isCompatible = true
    elseif weaponPart:hasTag(Gun93Registries.guns93.RevolverSights) and weapon:hasTag(Gun93Registries.guns93.RevolverSights) then
        isCompatible = true
    elseif weaponPart:hasTag(Gun93Registries.guns93.SportRifleSights) and weapon:hasTag(Gun93Registries.guns93.SportRifleSights) then
        isCompatible = true
    elseif weaponPart:hasTag(Gun93Registries.guns93.ShotgunSights) and weapon:hasTag(Gun93Registries.guns93.ShotgunSights) then
        if weaponPart:hasTag(Gun93Registries.guns93.NoShield) and not shield then
            isCompatible = false
        else
            isCompatible = true
        end
    elseif weaponPart:hasTag(Gun93Registries.guns93.BeadSight) and weapon:hasTag(Gun93Registries.guns93.BeadSight) then
        if weaponPart:hasTag(Gun93Registries.guns93.NoShield) and not shield then
            isCompatible = false
        else
            isCompatible = true
        end
    end
    if character == nil then
        return true
    elseif isCompatible and toolCheck then
        return true
    else
        return false
    end
end

function Guns93WeaponPartsRifleBipod(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    if weapon:hasTag(Gun93Registries.guns93.BiBarrelBlock) then
        if weapon:getWeaponPart("BarrelItem") then
            return false
        end
    elseif weapon:hasTag(Gun93Registries.guns93.BiBayoBlock) then
        if weapon:getWeaponPart("Bayonet") then
            return false
        end
    end
    if character == nil then
        return true
    elseif toolCheck then
        if weapon:hasTag(Gun93Registries.guns93.HandguardItem) then
            return true
        elseif weapon:getWeaponPart("Handguard") then
            if weapon:getWeaponPart("Handguard"):hasTag(Gun93Registries.guns93.HandguardItem) then
                return true
            end
        elseif weapon:getWeaponPart("Stock") then
            if weapon:getWeaponPart("Stock"):hasTag(Gun93Registries.guns93.HandguardItem) then
                return true
            end
        else
            return false
        end
    else
        return false
    end
end

function Guns93WeaponPartsThreadedCanonPart(character, weapon, weaponPart)
    local isThreaded = false
    local isCompatible = false
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    if weapon:getWeaponPart("Threading") then
        isThreaded = true
    end
    if weapon:getWeaponPart("MP5TriLug") and weaponPart:hasTag(Gun93Registries.guns93.QDMount) then
        isThreaded = true
    end
    if weaponPart:hasTag(Gun93Registries.guns93.C22cal) and weapon:hasTag(Gun93Registries.guns93.C22cal) then
        isCompatible = true
    elseif weaponPart:hasTag(Gun93Registries.guns93.C9mm) and weapon:hasTag(Gun93Registries.guns93.C9mm) then
        isCompatible = true
    elseif weaponPart:hasTag(Gun93Registries.guns93.C40cal) and weapon:hasTag(Gun93Registries.guns93.C40cal) then
        isCompatible = true
    elseif weaponPart:hasTag(Gun93Registries.guns93.C45cal) and weapon:hasTag(Gun93Registries.guns93.C45cal) then
        isCompatible = true
    elseif weaponPart:hasTag(Gun93Registries.guns93.C30cal) and weapon:hasTag(Gun93Registries.guns93.C30cal) then
        isCompatible = true
    elseif weaponPart:hasTag(Gun93Registries.guns93.Mauser) and weapon:hasTag(Gun93Registries.guns93.Mauser) then
        isCompatible = true
    elseif weaponPart:hasTag(Gun93Registries.guns93.C12ga) and weapon:hasTag(Gun93Registries.guns93.BoreThread) then
        isCompatible = true
    end
    if weapon:getWeaponPart("Handguard") and weapon:getWeaponPart("Handguard"):hasTag(Gun93Registries.guns93.CanonBlock) then
        isCompatible = false
    end
    if weapon:getWeaponPart("BarrelItem") and weapon:getWeaponPart("Handguard"):hasTag(Gun93Registries.guns93.CanonBlock) then
        isCompatible = false
    end
    if weapon:getWeaponPart("Bayonet") and not weaponPart:hasTag(Gun93Registries.guns93.Choke) then
        isCompatible = false
    end
    if character == nil then
        return true
    elseif isThreaded and isCompatible and toolCheck then
        return true
    else
        return false
    end
end

function Guns93WeaponPartsTriLugAdapter(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    if weapon:getWeaponPart("QDMount") and Guns93WeaponPartsThreadedCanonPart(character, weapon, weaponPart) then
        return true
    else
        return false
    end
end

function Guns93WeaponPartsAutoTriggers(character, weapon, weaponPart)
    local toolCheck = Guns93WeaponPartsToolCheck(character, weapon, weaponPart)
    local autoInstall = false
    local autoPart = false
    local installpart = weapon:getWeaponPart("AutoPart") or weapon:getWeaponPart("Trigger")
    if installpart then
        if installpart:hasTag(Gun93Registries.guns93.Fullauto) or installpart:hasTag(Gun93Registries.guns93.Burst) then
            autoInstall = true
        end
    end
    if weaponPart:hasTag(Gun93Registries.guns93.Fullauto) or weaponPart:hasTag(Gun93Registries.guns93.Burst) then
        autoPart = true
    end
    if character == nil then
        return true
    elseif autoInstall and autoPart then
        return false
    else
        return true
    end
end