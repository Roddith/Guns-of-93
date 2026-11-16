local function AddMagAttachment(weapon, magType)
    if magType == nil then
        magType = weapon:getMagazineType()
    end
    weapon:setContainsClip(true)
    if magType then
        local mag = instanceItem(magType)
        weapon:setContainsClip(true)
        weapon:setMaxAmmo(mag:getMaxAmmo())
        if mag and mag:getCategory() == "WeaponPart" then
            weapon:attachWeaponPart(mag)
        end
    end
end

local function GetAmmoName(weapon)
    if SandboxVars.Guns93.Guns93AmmoName then
        local ammoNam = " - " .. getItemNameFromFullType(weapon:getAmmoType():getItemKey())
        return string.gsub(ammoNam, " Round", "")
    else
        return ""
    end
end

Guns93GunConfig = Guns93GunConfig or {}

Guns93GunConfig.AmmoBeltBox = function(AmmoBox)
    if not AmmoBox then return end
    local beltCount = 0
    local beltType = nil
    local bulletType = nil
    local container = AmmoBox:getInventory()
    if AmmoBox:getFullType() == "Base.556AmmoBeltBox" then
        beltCount = ZombRand(1,7)
        beltType = "Base.556Belt"
        bulletType = "Base.556BulletsM855"
    else
        beltCount = ZombRand(2,4)
        beltType = "Base.308Belt"
        bulletType = "Base.76251M80"
    end
    for i = 0, beltCount - 1 do
        local newBelt = instanceItem(beltType)
        container:AddItem(newBelt)
        sendAddItemToContainer(container, newBelt)
        newBelt:setCurrentAmmoCount(50)
        local ammoCount = 50
        while ammoCount > 0 do
            Guns93AddAmmoTypes(newBelt, bulletType)
            ammoCount = ammoCount - 1
        end
        DynamicMagClip(newBelt)
    end
end


Guns93GunConfig.Guns93FirearmSpawns = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    AddMagAttachment(weapon, nil)
    if weapon:getFullType() == "Base.SKS" then
        if not weapon:getWeaponPart("Bayonet") then
            local bayo = instanceItem("Base.SKSBayonetPart")
            weapon:attachWeaponPart(bayo)
        end
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93FirearmScopes = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    AddMagAttachment(weapon, nil)
    local rail = instanceItem("Base.NonremoveScopeRail")
    weapon:attachWeaponPart(rail)
    local scope = nil
    local d15 = ZombRand(0,15)
    if d15 > 13 then
        scope = instanceItem("Base.x3Scope")
    elseif d15 > 11 then
        scope = instanceItem("Base.x4Scope")
    elseif d15 > 9 then
        scope = instanceItem("Base.x6Scope")
    elseif d15 > 7 then
        scope = instanceItem("Base.x8Scope")
    elseif d15 > 5 then
        scope = instanceItem("Base.x10Scope")
    elseif d15 > 4 then
        scope = instanceItem("Base.x3ScopeSilver")
    elseif d15 > 3 then
        scope = instanceItem("Base.x4ScopeSilver")
    elseif d15 > 2 then
        scope = instanceItem("Base.x6ScopeSilver")
    elseif d15 > 1 then
        scope = instanceItem("Base.x8ScopeSilver")
    else
        scope = instanceItem("Base.x10ScopeSilver")
    end
    weapon:attachWeaponPart(scope)
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end



Guns93GunConfig.Guns93FirearmRail = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    AddMagAttachment(weapon, nil)
    local rail = instanceItem("Base.NonremoveScopeRail")
    weapon:attachWeaponPart(rail)
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93PistolScopes = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    AddMagAttachment(weapon, nil)
    local rail = instanceItem("Base.NonremovePistolRail")
    weapon:attachWeaponPart(rail)
    local Irons = nil
    local d4 = ZombRand(1,4)
    if d4 == 1 then
        Irons = instanceItem("Base.IronPistolBasic")
    elseif d4 == 2 then
        Irons = instanceItem("Base.IronPistolTarget")
    elseif d4 == 3 then
        Irons = instanceItem("Base.IronPistolCombat")
    elseif d4 == 4 then
        Irons = instanceItem("Base.TritiumSights")
    end
    if Irons then
        weapon:attachWeaponPart(Irons)
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93PistolSights = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    AddMagAttachment(weapon, nil)
    local Irons = nil
    local d4 = ZombRand(1,4)
    if d4 == 1 then
        Irons = instanceItem("Base.IronPistolBasic")
    elseif d4 == 2 then
        Irons = instanceItem("Base.IronPistolTarget")
    elseif d4 == 3 then
        Irons = instanceItem("Base.IronPistolCombat")
    elseif d4 == 4 then
        Irons = instanceItem("Base.TritiumSights")
    end
    if Irons then
            weapon:attachWeaponPart(Irons)
        end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93RevolverSights = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    AddMagAttachment(weapon, nil)
    local Irons = nil
    local d4 = ZombRand(1,4)
    if d4 == 1 then
        Irons = instanceItem("Base.IronRevolverBasic")
    elseif d4 == 2 then
        Irons = instanceItem("Base.IronRevolverTarget")
    elseif d4 == 3 then
        Irons = instanceItem("Base.IronRevolverCombat")
    elseif d4 == 4 then
        Irons = instanceItem("Base.RevolverTritiumSights")
    end
    if Irons then
        weapon:attachWeaponPart(Irons)
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93ThreadedFirearmSpawns = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    weapon:attachWeaponPart(instanceItem("Base.BarrelThread"))
    AddMagAttachment(weapon, nil)
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93ShotgunSpawns = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    if not weapon:hasTag(Gun93Registries.guns93.SawedOff) then
        weapon:attachWeaponPart(instanceItem("Base.BoreThread"))
    end
    AddMagAttachment(weapon, nil)
    if not weapon:getWeaponPart("Irons") then
        local Irons = nil
        local d2 = ZombRand(1,2)
        if d2 == 1 then
            Irons = instanceItem("Base.BeadSight")
        elseif d2 == 1 then
            Irons = instanceItem("Base.IronSightNotch")
        end
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93TacShotgunSpawns = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    if not weapon:getWeaponPart("Irons") then
        local Irons = nil
        local d6 = ZombRand(0,6)
        if d3 == 1 then
            Irons = instanceItem("Base.BeadSight")
        elseif d3 == 2 then
            Irons = instanceItem("Base.IronSightGhost")
        elseif d3 == 3 then
            Irons = instanceItem("Base.IronSightNotch")
        end
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93Rug1022 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    if weapon:getMagazineType() then
        local magD10 = ZombRand(0,10)
        local gunMag = nil
        if magD10 > 2 then
            gunMag = "Base.1022Mag"
        else
            gunMag = "Base.25Rug1022Mag"
        end
        if gunMag then
            weapon:setMagazineType(gunMag)
            AddMagAttachment(weapon, gunMag)
        end
    end
    local rail = instanceItem("Base.NonremoveScopeRail")
    weapon:attachWeaponPart(rail)
    local scope = nil
    local d5 = ZombRand(0,5)
    if d5 > 2 then
        scope = instanceItem("Base.x3Scope")
    else
        scope = instanceItem("Base.x4Scope")
    end
        weapon:attachWeaponPart(scope)
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    weapon:attachWeaponPart(instanceItem("Base.R1022Trigger"))
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93Rem700 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local isSO = false
    local namSO = ""
    if weapon:hasTag(Gun93Registries.guns93.SawedOff) then
        isSO = true
        namSO = getText("Sawed-Off ")
    end
    weapon:setName(namSO .. weapon:getName() .. ammoNam)
    local ReceiverD5 = ZombRand(0,5)
    if isSO == false then
        if ReceiverD5 > 3 then
            weapon:setWeaponSprite("Rem700")
        elseif ReceiverD5 > 1 then
            weapon:setWeaponSprite("Rem700Bolt")
        else
            weapon:setWeaponSprite("Rem700Park")
        end
    end
    local rail = instanceItem("Base.NonremoveScopeRail")
    weapon:attachWeaponPart(rail)
    local irons = nil
    local noIrons = true
    local ironD6 = ZombRand(0,6)
    if ironD6 > 4 then
        irons = instanceItem("Base.IronSightRifle")
        noIrons = false
    end
    if Irons then
        weapon:attachWeaponPart(Irons)
    end
    local StockD100 = ZombRand(0,100)
    local cutStockD10 = ZombRand(1,10)
    local stock = nil
    local synthetic = false
    local noRecoil = false
    if StockD100 > 88 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SO700WalnutStock")
            noRecoil = true
        else
            stock = instanceItem("Base.700WalnutStock")
        end
    elseif StockD100 > 78 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SO700WalnutStockCheck")
            noRecoil = true
        else
            stock = instanceItem("Base.700WalnutStockCheck")
        end
    elseif StockD100 > 68 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SO700WalnutStockCap")
            noRecoil = true
        else
            stock = instanceItem("Base.700WalnutStockCap")
        end
    elseif StockD100 > 58 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SO700DarkWalnutStock")
            noRecoil = true
        else
            stock = instanceItem("Base.700DarkWalnutStock")
        end
    elseif StockD100 > 48 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SO700DarkWalnutStockCheck")
            noRecoil = true
        else
            stock = instanceItem("Base.700DarkWalnutStockCheck")
        end
    elseif StockD100 > 38 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SO700DarkWalnutStockCap")
            noRecoil = true
        else
            stock = instanceItem("Base.700DarkWalnutStockCap")
        end
    elseif StockD100 > 31 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SO700LaminateStock")
            noRecoil = true
        else
            stock = instanceItem("Base.700LaminateStock")
        end
    elseif StockD100 > 26 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SO700LaminateStockCheck")
            noRecoil = true
        else
            stock = instanceItem("Base.700LaminateStockCheck")
        end
    elseif StockD100 > 18 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SO700LaminateStockCap")
            noRecoil = true
        else
            stock = instanceItem("Base.700LaminateStockCap")
        end
    elseif StockD100 > 10 then
        stock = instanceItem("Base.700PolymerStock")
        synthetic = true
    elseif StockD100 > 5 then
        stock = instanceItem("Base.700PolymerStockCheck")
        synthetic = true
    elseif StockD100 > 4 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SO700MapleStock")
        else
            stock = instanceItem("Base.700MapleStock")
        end
    elseif StockD100 > 2 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SO700MapleStockCheck")
        else
            stock = instanceItem("Base.700MapleStockCheck")
        end
    elseif StockD100 > 1 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SO700MapleStockCap")
        else
            stock = instanceItem("Base.700MapleStockCap")
        end
    else
        stock = instanceItem("Base.700SmearStock")
        synthetic = true
    end
    weapon:attachWeaponPart(stock)
    if noRecoil == false then
        local recoilD10 = ZombRand(0,10)
        local recoil = nil
        if recoilD10 > 4 then
            recoil = nil
        elseif recoilD10 > 2 or synthetic == true then
            recoil = instanceItem("Base.RecoilPad")
        elseif recoilD10 > 1 then
            recoil = instanceItem("Base.RedRecoilPad")
        else 
            recoil = instanceItem("Base.BrownRecoilPad")
        end
        weapon:attachWeaponPart(recoil)
        local sleeve = nil
        local sleeveD24 = ZombRand(0,24)
        if sleeveD24 < 2 then
            sleeve = instanceItem("Base.LeatherAmmoCarrier")
        elseif sleeveD24 < 4 then
            sleeve = instanceItem("Base.ODAmmoCarrier")
        elseif sleeveD24 < 6 then
            sleeve = instanceItem("Base.NylonAmmoCarrier")
        elseif sleeveD24 < 8 then
            sleeve = instanceItem("Base.LeatherCheekPad")
        elseif sleeveD24 < 10 then
            sleeve = instanceItem("Base.ODCheekPad")
        elseif sleeveD24 < 12 then
            sleeve = instanceItem("Base.NylonCheekPad")
        end
        weapon:attachWeaponPart(sleeve)
    end
    local scope = nil
    local d29 = ZombRand(0,29)
    if ZombRand(0,2) > 1 or noIrons then
        if d29 > 24 then
            scope = instanceItem("Base.x3Scope")
        elseif d29 > 19 then
            scope = instanceItem("Base.x4Scope")
        elseif d29 > 15 then
            scope = instanceItem("Base.x6Scope")
        elseif d29 > 11 then
            scope = instanceItem("Base.x8Scope")
        elseif d29 > 7 then
            scope = instanceItem("Base.x10Scope")
        elseif d29 > 4 then
            scope = instanceItem("Base.x3ScopeSilver")
        elseif d29 > 3 then
            scope = instanceItem("Base.x4ScopeSilver")
        elseif d29 > 2 then
            scope = instanceItem("Base.x6ScopeSilver")
        elseif d29 > 1 then
            scope = instanceItem("Base.x8ScopeSilver")
        else
            scope = instanceItem("Base.x10ScopeSilver")
        end
    end
    weapon:attachWeaponPart(scope)
    if not weapon:getWeaponPart("Trigger") then
        local d100 = ZombRand(0,100)
        local trigger = nil
        if d100 > 70 then
            trigger = instanceItem("Base.700MatchTrigger")
        else
            trigger = instanceItem("Base.700Trigger")
        end
        if trigger then
            weapon:attachWeaponPart(trigger)
        end
    end
    if not isSO then
        if ZombRand(1,10) < 3 then
            weapon:attachWeaponPart(instanceItem("Base.RifleBipod"))
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93M24 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local isSO = false
    local namSO = ""
    if weapon:hasTag(Gun93Registries.guns93.SawedOff) then
        isSO = true
        namSO = getText("Sawed-Off ")
    end
    weapon:setName(namSO .. weapon:getName() .. ammoNam)
    local ReceiverD10 = ZombRand(0,10)
    local camo = false
    if isSO == false then
        if ReceiverD10 > 8 then
            weapon:setWeaponSprite("M24Camo")
            weapon:setTexture(getTexture("media/textures/item_M24Camo.png"))
            weapon:getModData().Guns93Icon = "M24Camo"
            camo = true
        else
            weapon:setWeaponSprite("M24")
            weapon:setTexture(getTexture("media/textures/item_M24.png"))
            weapon:getModData().Guns93Icon = "M24"
        end
    end
    weapon:attachWeaponPart(instanceItem("Base.NonremoveScopeRail"))
    local stock = nil
    if camo then
        stock = instanceItem("Base.M24CamoStock")
    else
        stock = instanceItem("Base.M24Stock")
    end
    if stock ~= nil then
        weapon:attachWeaponPart(stock)
        weapon:attachWeaponPart(instanceItem("Base.RecoilPad"))
    end
    local sleeve = nil
    local sleeveD20 = ZombRand(0,20)
    if sleeveD20 < 3 then
        sleeve = instanceItem("Base.ODAmmoCarrier")
    elseif sleeveD20 < 6 then
        sleeve = instanceItem("Base.NylonAmmoCarrier")
    elseif sleeveD20 < 9 then
        sleeve = instanceItem("Base.ODCheekPad")
    elseif sleeveD20 < 12 then
        sleeve = instanceItem("Base.NylonCheekPad")
    end
    if sleeve ~= nil then
        weapon:attachWeaponPart(sleeve)
    end
    local scope = nil
    local scopeD4 = ZombRand(0,4)
    if scopeD4 > 2 then
        scope = instanceItem("Base.ARTScope")
    elseif scopeD4 > 1 then
        scope = instanceItem("Base.x8Scope")
    else
        scope = instanceItem("Base.x10Scope")
    end
    if scope ~= nil then
        weapon:attachWeaponPart(scope)
    end
    if not weapon:getWeaponPart("Trigger") then
        weapon:attachWeaponPart(instanceItem("Base.700MatchTrigger"))
    end
    if not isSO then
        if ZombRand(1,10) < 4 then
            weapon:attachWeaponPart(instanceItem("Base.RifleBipod"))
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93Rem788 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local isSO = false
    local namSO = ""
    if weapon:hasTag(Gun93Registries.guns93.SawedOff) then
        isSO = true
        namSO = getText("Sawed-Off ")
    end
    weapon:setName(namSO .. weapon:getName() .. ammoNam)
    weapon:attachWeaponPart(instanceItem("Base.NonremoveScopeRail"))
    local irons = nil
    local noIrons = true
    local ironD6 = ZombRand(0,6)
    if ironD6 > 4 then
        irons = instanceItem("Base.IronSightRifle")
        noIrons = false
    end
    if weapon:getMagazineType() then
        local mag = instanceItem(weapon:getMagazineType())
        weapon:setContainsClip(true)
        weapon:attachWeaponPart(mag)
    end
    if Irons then
        weapon:attachWeaponPart(Irons)
    end
    local StockD100 = ZombRand(0,100)
    local cutStockD10 = ZombRand(1,10)
    local stock = nil
    local synthetic = false
    local noRecoil = false
    if StockD100 > 94 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SO788WalnutStock")
            noRecoil = true
        else
            stock = instanceItem("Base.788WalnutStock")
        end
    elseif StockD100 > 85 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SO788WalnutStockCheck")
            noRecoil = true
        else
            stock = instanceItem("Base.788WalnutStockCheck")
        end
    elseif StockD100 > 67 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SO788DarkWalnutStock")
            noRecoil = true
        else
            stock = instanceItem("Base.788DarkWalnutStock")
        end
    elseif StockD100 > 58 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SO788DarkWalnutStockCheck")
            noRecoil = true
        else
            stock = instanceItem("Base.788DarkWalnutStockCheck")
        end
    elseif StockD100 > 16 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SO788BeechStock")
            noRecoil = true
        else
            stock = instanceItem("Base.788BeechStock")
        end
    elseif StockD100 > 7 then
        stock = instanceItem("Base.788PolymerStock")
        synthetic = true
    elseif StockD100 > 2 then
        stock = instanceItem("Base.788PolymerStockCheck")
        synthetic = true
    else
        stock = instanceItem("Base.788SmearStock")
        synthetic = true
    end
    weapon:attachWeaponPart(stock)
    if noRecoil == false then
        local recoilD10 = ZombRand(0,10)
        local recoil = nil
        if recoilD10 > 4 then
            recoil = nil
        elseif recoilD10 > 2 or synthetic == true then
            recoil = instanceItem("Base.RecoilPad")
        elseif recoilD10 > 1 then
            recoil = instanceItem("Base.RedRecoilPad")
        else 
            recoil = instanceItem("Base.BrownRecoilPad")
        end
        weapon:attachWeaponPart(recoil)
        local sleeve = nil
        local sleeveD24 = ZombRand(0,24)
        if sleeveD24 < 2 then
            sleeve = instanceItem("Base.LeatherAmmoCarrier")
        elseif sleeveD24 < 4 then
            sleeve = instanceItem("Base.ODAmmoCarrier")
        elseif sleeveD24 < 6 then
            sleeve = instanceItem("Base.NylonAmmoCarrier")
        elseif sleeveD24 < 8 then
            sleeve = instanceItem("Base.LeatherCheekPad")
        elseif sleeveD24 < 10 then
            sleeve = instanceItem("Base.ODCheekPad")
        elseif sleeveD24 < 12 then
            sleeve = instanceItem("Base.NylonCheekPad")
        end
        weapon:attachWeaponPart(sleeve)
    end
    local scope = nil
    local d29 = ZombRand(0,29)
    if ZombRand(0,2) > 1 or noIrons then
        if d29 > 24 then
            scope = instanceItem("Base.x3Scope")
        elseif d29 > 19 then
            scope = instanceItem("Base.x4Scope")
        elseif d29 > 15 then
            scope = instanceItem("Base.x6Scope")
        elseif d29 > 11 then
            scope = instanceItem("Base.x8Scope")
        elseif d29 > 7 then
            scope = instanceItem("Base.x10Scope")
        elseif d29 > 4 then
            scope = instanceItem("Base.x3ScopeSilver")
        elseif d29 > 3 then
            scope = instanceItem("Base.x4ScopeSilver")
        elseif d29 > 2 then
            scope = instanceItem("Base.x6ScopeSilver")
        elseif d29 > 1 then
            scope = instanceItem("Base.x8ScopeSilver")
        else
            scope = instanceItem("Base.x10ScopeSilver")
        end
    end
    weapon:attachWeaponPart(scope)
    if not weapon:getWeaponPart("Trigger") then
        local d100 = ZombRand(0,100)
        local trigger = nil
        if d100 > 70 then
            trigger = instanceItem("Base.788MatchTrigger")
        else
            trigger = instanceItem("Base.788Trigger")
        end
        if trigger then
            weapon:attachWeaponPart(trigger)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93WinM70 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local isSO = false
    local namSO = ""
    if weapon:hasTag(Gun93Registries.guns93.SawedOff) then
        isSO = true
        namSO = getText("Sawed-Off ")
    end
    weapon:setName(namSO .. weapon:getName() .. ammoNam)
    local ReceiverD10 = ZombRand(0,10)
    if isSO == false then
        if ReceiverD10 > 7 then
            weapon:setWeaponSprite("WinM70")
        elseif ReceiverD10 > 4 then
            weapon:setWeaponSprite("WinM70Bolt")
        elseif ReceiverD10 > 1 then
            weapon:setWeaponSprite("WinM70Lever")
            weapon:setTexture(getTexture("media/textures/item_WinM70Lever.png"))
            weapon:getModData().Guns93Icon = "WinM70Lever"
        else
            weapon:setWeaponSprite("WinM70SS")
            weapon:setTexture(getTexture("media/textures/item_WinM70SS.png"))
            weapon:getModData().Guns93Icon = "WinM70SS"
        end
    end
    local rail = instanceItem("Base.NonremoveScopeRail")
    weapon:attachWeaponPart(rail)
    local irons = nil
    local noIrons = true
    local ironD6 = ZombRand(0,6)
    if ironD6 > 4 then
        irons = instanceItem("Base.IronSightRifle")
        noIrons = false
    end
    if Irons then
        weapon:attachWeaponPart(Irons)
    end
    local StockD100 = ZombRand(0,100)
    local cutStockD10 = ZombRand(1,10)
    local stock = nil
    local synthetic = false
    local noRecoil = false
    if StockD100 > 88 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SOWinM70WalnutStock")
            noRecoil = true
        else
            stock = instanceItem("Base.WinM70WalnutStock")
        end
    elseif StockD100 > 78 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SOWinM70DarkWalnutStock")
            noRecoil = true
        else
            stock = instanceItem("Base.WinM70DarkWalnutStock")
        end
    elseif StockD100 > 68 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SOWinM70MapleStock")
            noRecoil = true
        else
            stock = instanceItem("Base.WinM70MapleStock")
        end
    elseif StockD100 > 58 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SOWinM70WalnutStockCap")
            noRecoil = true
        else
            stock = instanceItem("Base.WinM70WalnutStockCap")
        end
    elseif StockD100 > 48 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SOWinM70DarkWalnutStockCap")
            noRecoil = true
        else
            stock = instanceItem("Base.WinM70DarkWalnutStockCap")
        end
    elseif StockD100 > 38 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SOWinM70MapleStockCap")
            noRecoil = true
        else
            stock = instanceItem("Base.WinM70MapleStockCap")
        end
    elseif StockD100 > 31 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SOWinM70WalnutSchnabel")
            noRecoil = true
        else
            stock = instanceItem("Base.WinM70WalnutSchnabel")
        end
    elseif StockD100 > 26 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SOWinM70DarkWalnutSchnabel")
            noRecoil = true
        else
            stock = instanceItem("Base.WinM70DarkWalnutSchnabel")
        end
    elseif StockD100 > 18 then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.SOWinM70MapleSchnabel")
            noRecoil = true
        else
            stock = instanceItem("Base.WinM70MapleSchnabel")
        end
    elseif StockD100 > 10 then
        stock = instanceItem("Base.WinM70PolymerStockCheck")
        synthetic = true
    elseif StockD100 > 5 then
        stock = instanceItem("Base.WinM70TreeStock")
        synthetic = true
    elseif StockD100 > 4 then
        stock = instanceItem("Base.WinM70PolymerStockTex")
        synthetic = true
    elseif StockD100 > 2 then
        stock = instanceItem("Base.WinM70GreenStock")
        synthetic = true
    else
        stock = instanceItem("Base.WinM70TanStockTex")
        synthetic = true
    end
    weapon:attachWeaponPart(stock)
    if noRecoil == false then
        local recoilD10 = ZombRand(0,10)
        local recoil = nil
        if recoilD10 > 4 then
            recoil = nil
        elseif recoilD10 > 2 or synthetic == true then
            recoil = instanceItem("Base.RecoilPad")
        elseif recoilD10 > 1 then
            recoil = instanceItem("Base.RedRecoilPad")
        else 
            recoil = instanceItem("Base.BrownRecoilPad")
        end
        weapon:attachWeaponPart(recoil)
        local sleeve = nil
        local sleeveD24 = ZombRand(0,24)
        if sleeveD24 < 2 then
            sleeve = instanceItem("Base.LeatherAmmoCarrier")
        elseif sleeveD24 < 4 then
            sleeve = instanceItem("Base.ODAmmoCarrier")
        elseif sleeveD24 < 6 then
            sleeve = instanceItem("Base.NylonAmmoCarrier")
        elseif sleeveD24 < 8 then
            sleeve = instanceItem("Base.LeatherCheekPad")
        elseif sleeveD24 < 10 then
            sleeve = instanceItem("Base.ODCheekPad")
        elseif sleeveD24 < 12 then
            sleeve = instanceItem("Base.NylonCheekPad")
        end
        weapon:attachWeaponPart(sleeve)
    end
    local scope = nil
    local d29 = ZombRand(0,29)
    if ZombRand(0,2) > 1 or noIrons then
        if d29 > 24 then
            scope = instanceItem("Base.x3Scope")
        elseif d29 > 19 then
            scope = instanceItem("Base.x4Scope")
        elseif d29 > 15 then
            scope = instanceItem("Base.x6Scope")
        elseif d29 > 11 then
            scope = instanceItem("Base.x8Scope")
        elseif d29 > 7 then
            scope = instanceItem("Base.x10Scope")
        elseif d29 > 4 then
            scope = instanceItem("Base.x3ScopeSilver")
        elseif d29 > 3 then
            scope = instanceItem("Base.x4ScopeSilver")
        elseif d29 > 2 then
            scope = instanceItem("Base.x6ScopeSilver")
        elseif d29 > 1 then
            scope = instanceItem("Base.x8ScopeSilver")
        else
            scope = instanceItem("Base.x10ScopeSilver")
        end
    end
    weapon:attachWeaponPart(scope)
    if not weapon:getWeaponPart("Trigger") then
        local d100 = ZombRand(0,100)
        local trigger = nil
        if d100 > 70 then
            trigger = instanceItem("Base.WinM70MatchTrigger")
        else
            trigger = instanceItem("Base.WinM70Trigger")
        end
        if trigger then
            weapon:attachWeaponPart(trigger)
        end
    end
    if not isSO then
        if ZombRand(1,10) < 3 then
            weapon:attachWeaponPart(instanceItem("Base.RifleBipod"))
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93Mini14 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local isSS = false
    local isNut = false
    local isFold = false
    local isATeam = false
    if ZombRand(1,10) < 6 then
        if weapon:getFullType() == "Base.Mini14" or weapon:getFullType() == "Base.Mini30" then
            weapon:setWeaponSprite("Mini14")
        elseif weapon:getFullType() == "Base.Mini14GB" then
            weapon:setWeaponSprite("Mini14GB")
        elseif weapon:getFullType() == "Base.AC556K" then
            weapon:setWeaponSprite("AC556K")
        end
    else
        if weapon:getFullType() == "Base.Mini14" or weapon:getFullType() == "Base.Mini30" then
            weapon:setWeaponSprite("Mini14SS")
        elseif weapon:getFullType() == "Base.Mini14GB" then
            weapon:setWeaponSprite("Mini14GBSS")
        elseif weapon:getFullType() == "Base.AC556K" then
            weapon:setWeaponSprite("AC556KSS")
        end
        isSS = true
    end
    if ZombRand(1,10) < 6 then
        local d10 = ZombRand(1,10)
        if d10 < 6 then
            weapon:attachWeaponPart(instanceItem("Base.Mini14WalnutStock"))
            isNut = true
        elseif d10 < 9 then
            weapon:attachWeaponPart(instanceItem("Base.Mini14PolymerStock"))
        else
            weapon:attachWeaponPart(instanceItem("Base.Mini14GreenStock"))
        end
    elseif isSS then
        weapon:attachWeaponPart(instanceItem("Base.Mini14FoldStockInSS"))
        isFold = true
        if ZombRand(1,30) == 1 and weapon:getFullType() == "Base.Mini14" then
            isATeam = true
            weapon:setName(weapon:getName() .. " Z-Squad Carbine")
        end
    else
        weapon:attachWeaponPart(instanceItem("Base.Mini14FoldStockIn"))
        isFold = true
    end
    weapon:setName(weapon:getName() .. ammoNam)
    if ZombRand(1,10) < 8 and not isATeam then
        weapon:attachWeaponPart(instanceItem("Base.Mini14HeatShield"))
    elseif isNut and ZombRand(1,10) > 7 and not isATeam then
        weapon:attachWeaponPart(instanceItem("Base.Mini14WalnutUpHandguard"))
    elseif isSS and ZombRand(1,10) < 7 or isATeam then
        weapon:attachWeaponPart(instanceItem("Base.Mini14GrateSS"))
    else
        weapon:attachWeaponPart(instanceItem("Base.Mini14Grate"))
    end
    if weapon:getFullType() == "Base.Mini14" or weapon:getFullType() == "Base.Mini30" or isATeam then
        if ZombRand(1,10) > 7 or isATeam then
            if isSS or isATeam then
                weapon:attachWeaponPart(instanceItem("Base.Mini14FlashHiderPinSS"))
            else
                weapon:attachWeaponPart(instanceItem("Base.Mini14FlashHiderPin"))
            end
        end
    elseif weapon:getFullType() == "Base.Mini14GB" or weapon:getFullType() == "Base.AC556K" then
        if isSS then
            weapon:attachWeaponPart(instanceItem("Base.Mini14FlashHiderSS"))
            weapon:attachWeaponPart(instanceItem("Base.Mini14AutoBurstPartSS"))
        else
            weapon:attachWeaponPart(instanceItem("Base.Mini14FlashHider"))
            weapon:attachWeaponPart(instanceItem("Base.Mini14AutoBurstPart"))
        end
        weapon:attachWeaponPart(instanceItem("Base.BarrelThread"))
    end
    if weapon:getFullType() == "Base.Mini14" or weapon:getFullType() == "Base.Mini30" then
        if isATeam then
            weapon:setTexture(getTexture("media/textures/item_Mini14ATeam.png"))
            weapon:getModData().Guns93Icon = "Mini14ATeam"
        elseif isSS and isFold then
            weapon:setTexture(getTexture("media/textures/item_Mini14FoldSS.png"))
            weapon:getModData().Guns93Icon = "Mini14FoldSS"
        elseif isSS then
            weapon:setTexture(getTexture("media/textures/item_Mini14SS.png"))
            weapon:getModData().Guns93Icon = "Mini14SS"
        elseif isFold then
            weapon:setTexture(getTexture("media/textures/item_Mini14Fold.png"))
            weapon:getModData().Guns93Icon = "Mini14Fold"
        else
            weapon:setTexture(getTexture("media/textures/item_Mini14.png"))
            weapon:getModData().Guns93Icon = "Mini14"
        end
    elseif weapon:getFullType() == "Base.Mini14GB" then
        if isSS and isFold then
            weapon:setTexture(getTexture("media/textures/item_Mini14GBFoldSS.png"))
            weapon:getModData().Guns93Icon = "Mini14GBFoldSS"
        elseif isSS then
            weapon:setTexture(getTexture("media/textures/item_Mini14GBSS.png"))
            weapon:getModData().Guns93Icon = "Mini14GBSS"
        elseif isFold then
            weapon:setTexture(getTexture("media/textures/item_Mini14GBFold.png"))
            weapon:getModData().Guns93Icon = "Mini14GBFold"
        else
            weapon:setTexture(getTexture("media/textures/item_Mini14GB.png"))
            weapon:getModData().Guns93Icon = "Mini14GB"
        end
    elseif weapon:getFullType() == "Base.AC556K" then
        if isSS and isFold then
            weapon:setTexture(getTexture("media/textures/item_AC556KFoldSS.png"))
            weapon:getModData().Guns93Icon = "AC556KFoldSS"
        elseif isSS then
            weapon:setTexture(getTexture("media/textures/item_AC556KSS.png"))
            weapon:getModData().Guns93Icon = "AC556KSS"
        elseif isFold then
            weapon:setTexture(getTexture("media/textures/item_AC556KFold.png"))
            weapon:getModData().Guns93Icon = "AC556KFold"
        else
            weapon:setTexture(getTexture("media/textures/item_AC556K.png"))
            weapon:getModData().Guns93Icon = "AC556K"
        end
    end
    if weapon:getMagazineType() then
        local magD10 = ZombRand(0,10)
        local gunMag = nil
        if weapon:getFullType() == "Base.Mini14" or weapon:getFullType() == "Base.Mini14GB" or weapon:getFullType() == "Base.AC556K" then
            if magD10 > 5 and weapon:getFullType() == "Base.Mini14" and not isATeam then
                if isSS then
                    gunMag = "Base.Mini14MagSS"
                else
                    gunMag = "Base.Mini14Mag"
                end
            elseif magD10 > 3 and not isATeam then
                if isSS then
                    gunMag = "Base.30Mini14MagSS"
                else
                    gunMag = "Base.30Mini14Mag"
                end
            elseif magD10 > 1 and not isATeam then
                gunMag = "Base.TherMini14Mag"
            else
                if isSS or isATeam then
                    gunMag = "Base.40Mini14MagSS"
                else
                    gunMag = "Base.40Mini14Mag"
                end
            end
        elseif weapon:getFullType() == "Base.Mini30" then
            if magD10 > 2 then
                if isSS then
                    gunMag = "Base.Mini30MagSS"
                else
                    gunMag = "Base.Mini30Mag"
                end
            else
                gunMag = "Base.30Mini30Mag"
            end
        end
        if gunMag then
            weapon:setMagazineType(gunMag)
            AddMagAttachment(weapon, gunMag)
        end
    end
    local raild25 = ZombRand(0,25)
    if raild25 < 8 then
        local rail = "Base.Mini14Mount"
        if isSS then
            rail = "Base.Mini14MountSS"
        end
        weapon:attachWeaponPart(instanceItem(rail))
        local scope = nil
        if raild25 > 10 then
            scope = instanceItem("Base.x3Scope")
        elseif raild25 > 9 then
            scope = instanceItem("Base.x3ScopeSilver")
        elseif raild25 > 8 then
            scope = instanceItem("Base.x4Scope")
        elseif raild25 > 7 then
            scope = instanceItem("Base.x4ScopeSilver")
        elseif raild25 > 6 then
            scope = instanceItem("Base.x6Scope")
        elseif raild25 > 5 then
            scope = instanceItem("Base.x6ScopeSilver")
        elseif raild25 > 4 then
            scope = instanceItem("Base.x8Scope")
        elseif raild25 > 3 then
            scope = instanceItem("Base.x8ScopeSilver")
        elseif raild25 > 2 then
            scope = instanceItem("Base.x10Scope")
        elseif raild25 > 1 then
            scope = instanceItem("Base.x10ScopeSilver")
        elseif raild25 > 0 then
            scope = instanceItem("Base.AccuDot")
        else
            scope = instanceItem("Base.AccuDotSilver")
        end
        weapon:attachWeaponPart(scope)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    local trigger = nil
    if isSS then
        trigger = "Base.Mini14TriggerSS"
    else
        trigger = "Base.Mini14Trigger"
    end
    if trigger then
        weapon:attachWeaponPart(instanceItem(trigger))
    end
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        weapon:getModData().Guns93Icon = "Mini14"
    end
end

Guns93GunConfig.Guns93Auto5 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local NameD100 = ZombRand(0,100)
    if NameD100 > 75 then
        weapon:setName(getText("Browning ") .. getText("Auto-5 ") .. ammoNam)
    elseif NameD100 > 50 then
        weapon:setName(getText("FN ") .. getText("Auto-5 ") .. ammoNam)
    elseif NameD100 > 25 then
        weapon:setName(getText("Remington ") .. getText("Model 11 ") .. ammoNam)
    else
        weapon:setName(getText("Savage ") .. getText("Model 720 ") .. ammoNam)
    end
    weapon:attachWeaponPart(instanceItem("Base.BeadSight"))
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93Rem1100 = function(weapon)
    if not weapon then return end
    local slugGun = false
    if ZombRand(1,40) > 30 then
        local bullet = weapon:getModData().modAlt_Ammo
        Guns93AddAmmoTypes(weapon, bullet)
        slugGun = true 
    end
    local ammoNam = GetAmmoName(weapon)
    local isSO = false
    local namSO = ""
    if weapon:getFullType() == "Base.SORem1100" then
        isSO = true
        namSO = getText("Sawed-Off ")
    end
    local NameD100 = ZombRand(0,100)
    local spriteD100 = ZombRand(0,100)
    local noSyth = false
    local park = false
    local blue = false
    local synthetic = false
    local magTube = false
    if not weapon:getWeaponPart("Trigger") then
        weapon:attachWeaponPart(instanceItem("Base.Rem870Trigger"))
    end
    if NameD100 > 50 then
        if weapon:getFullType() == "Base.Rem1187P" then
            weapon:setName(getText("Remington ") .. getText("Model 1100") .. ammoNam)
            weapon:setWeaponSprite("Rem1187PBlue")
            weapon:setTexture(getTexture("media/textures/item_Rem1187PBlue.png"))
            weapon:getModData().Guns93Icon = "Rem1187PBlue"
            blue = true
            magTube = true
        else
            weapon:setName(namSO .. getText("Remington ") .. getText("Model 1100") .. getText(" Field") .. ammoNam) --- add Field to tranlation file
            if spriteD100 > 50 then
                if isSO then
                    weapon:setWeaponSprite("SORem1100Blue")
                    weapon:setTexture(getTexture("media/textures/item_SORem1100.png"))
                    weapon:getModData().Guns93Icon = "SORem1100"
                else
                    weapon:setWeaponSprite("Rem1100Blue")
                    weapon:setTexture(getTexture("media/textures/item_Rem1100.png"))
                    weapon:getModData().Guns93Icon = "Rem1100"
                end
            else
                if isSO then
                    weapon:setWeaponSprite("SORem1100Gold")
                    weapon:setTexture(getTexture("media/textures/item_SORem1100Gold.png"))
                    weapon:getModData().Guns93Icon = "SORem1100Gold"
                else
                    weapon:setWeaponSprite("Rem1100Gold")
                    weapon:setTexture(getTexture("media/textures/item_Rem1100Gold.png"))
                    weapon:getModData().Guns93Icon = "Rem1100Gold"
                end
            end
        end
        noSyth = true
    else
        if weapon:getFullType() == "Base.Rem1187P" then
            weapon:setName(getText("Remington ") .. getText("Model 11-87") .. getText(" Police") .. ammoNam)
            weapon:setWeaponSprite("Rem1187PPark")
            weapon:setTexture(getTexture("media/textures/item_Rem1187PPark.png"))
            weapon:getModData().Guns93Icon = "Rem1187PPark"
            park = true
            synthetic = true
            magTube = true
        else
            weapon:setName(namSO .. getText("Remington ") .. getText("Model 11-87") .. ammoNam)
            if spriteD100 > 50 then
                if isSO then
                    weapon:setWeaponSprite("SORem1100Blue")
                    weapon:setTexture(getTexture("media/textures/item_SORem1100.png"))
                    weapon:getModData().Guns93Icon = "SORem1100"
                else
                    weapon:setWeaponSprite("Rem1100Blue")
                    weapon:setTexture(getTexture("media/textures/item_Rem1100.png"))
                    weapon:getModData().Guns93Icon = "Rem1100"
                end
            else
                if isSO then
                    weapon:setWeaponSprite("SORem1100Park")
                    weapon:setTexture(getTexture("media/textures/item_SORem1187Park.png"))
                    weapon:getModData().Guns93Icon = "SORem1187Park"
                else
                    weapon:setWeaponSprite("Rem1187Park")
                    weapon:setTexture(getTexture("media/textures/item_Rem1187Park.png"))
                    weapon:getModData().Guns93Icon = "Rem1187Park"
                end
            end
        end
    end
    if magTube then
        local magExten = nil
        if ZombRand(10) < 4 then
            if park then
                magExten = instanceItem("Base.870MagExtenPark")
            elseif blue then
                magExten = instanceItem("Base.870MagExtenBlue")
            end
            weapon:attachWeaponPart(magExten)
        end
        if magExten ~= nil then
            weapon:attachWeaponPart(magExten)
            weapon:setMaxAmmo(magExten:getMaxAmmo())
        end
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = nil
        local irond10 = ZombRand(0,10)
        if irond10 > 5 then
            Irons = instanceItem("Base.BeadSight")
        else
            Irons = instanceItem("Base.IronSightNotch")
        end
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    local stock = nil
    local forend = nil
    local recoil = nil
    local forendD20 = ZombRand(0,20)
    local darkWood = false
    local lightWood = false
    if (forendD20 > 10 and not noSyth) or synthetic then
        forend = instanceItem("Base.Rem1100ForendSynthetic")
        synthetic = true
    elseif forendD20 > 5 then
        forend = instanceItem("Base.Rem1100ForendWoodLight")
        lightWood = true
    else
        forend = instanceItem("Base.Rem1100ForendWoodDark")
        darkWood = true
    end
    if darkWood then
        stock = instanceItem("Base.870StockWoodDark")
    end
    if lightWood then
        stock = instanceItem("Base.870StockWoodLight")
    end
    if synthetic then
        stock = instanceItem("Base.870StockSynthetic")
    end
    local recoilD10 = ZombRand(0,10)
    if recoilD10 > 7 then
        recoil = nil
    elseif recoilD10 > 5 or synthetic == true then
        recoil = instanceItem("Base.RecoilPad")
    elseif recoilD10 > 3 then
        recoil = instanceItem("Base.RedRecoilPad")
    else 
        recoil = instanceItem("Base.BrownRecoilPad")
    end
    weapon:attachWeaponPart(stock)
    if recoil ~= nil then
        weapon:attachWeaponPart(recoil)
    end
    weapon:attachWeaponPart(forend)
    weapon:attachWeaponPart(instanceItem("Base.BarrelThread"))
    local choke = nil
    local chokeD6 = ZombRand(0,6)
    if isSO == false then
        if chokeD6 > 4 and not slugGun then
            choke = instanceItem("Base.ChokeTubeFull")
        elseif chokeD6 > 2 and not slugGun then
            choke = instanceItem("Base.ChokeTubeImproved")
        elseif chokeD6 > 1 or slugGun then
            choke = instanceItem("Base.ChokeTubeRifled")
        end
    end
    if choke then
        weapon:attachWeaponPart(choke)
    end
    local slugD10 = ZombRand(0,10)
    if slugD10 > 6 and slugGun then
        weapon:attachWeaponPart(instanceItem("Base.870ScopeRail"))
        local scope = nil
        local scopeD12 = ZombRand(0,12)
        if scopeD12 > 10 then
            scope = instanceItem("Base.x3Scope")
        elseif scopeD12 > 8 then
            scope = instanceItem("Base.x4Scope")
        elseif scopeD12 > 6 then
            scope = instanceItem("Base.x6Scope")
        elseif scopeD12 > 4 then
            scope = instanceItem("Base.x8Scope")
        elseif scopeD12 > 2 then
            scope = instanceItem("Base.AccuDot")
        elseif scopeD12 > 1 then
            scope = instanceItem("Base.AccuDotSilver")
        else
            scope = nil
        end
        if scope ~= nil then
            weapon:attachWeaponPart(scope)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93Rem870 = function(weapon)
    if not weapon then return end
    local slugGun = false
    if ZombRand(1,40) > 30 then
        local bullet = weapon:getModData().modAlt_Ammo
        Guns93AddAmmoTypes(weapon, bullet)
        slugGun = true 
    end
    local ammoNam = GetAmmoName(weapon)
    local isSO = false
    local namSO = ""
    if weapon:getFullType() == "Base.SORem870" then
        isSO = true
        namSO = getText("Sawed-Off ")
    end
    local spriteD100 = ZombRand(0,100)
    if not weapon:getWeaponPart("Trigger") then
        weapon:attachWeaponPart(instanceItem("Base.Rem870Trigger"))
    end
    if spriteD100 > 50 then
        weapon:setName(namSO .. getText("Remington ") .. getText("870") .. getText(" Wingmaster") .. ammoNam)
        if isSO then
            weapon:setWeaponSprite("SORem870")
            weapon:setTexture(getTexture("media/textures/item_SORem870Blue.png"))
            weapon:getModData().Guns93Icon = "SORem870Blue"
        else
            weapon:setWeaponSprite("Rem870")
            weapon:setTexture(getTexture("media/textures/item_Rem870.png"))
            weapon:getModData().Guns93Icon = "Rem870"
        end
    else
        weapon:setName(namSO .. getText("Remington ") .. getText("870") .. getText(" Express") .. ammoNam)
        if isSO then
            weapon:setWeaponSprite("SORem870Park")
            weapon:setTexture(getTexture("media/textures/item_SORem870Park.png"))
            weapon:getModData().Guns93Icon = "SORem870Park"
        else
            weapon:setWeaponSprite("Rem870Park")
            weapon:setTexture(getTexture("media/textures/item_Rem870Park.png"))
            weapon:getModData().Guns93Icon = "Rem870Park"
        end
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = nil
        local irond10 = ZombRand(0,10)
        if irond10 > 5 then
            Irons = instanceItem("Base.BeadSight")
        else
            Irons = instanceItem("Base.IronSightNotch")
        end
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    local stock = nil
    local forend = nil
    local recoil = nil
    local foldD10 = ZombRand(0,10)
    local forendD20 = ZombRand(0,20)
    local darkWood = false
    local lightWood = false
    local synthetic = false
    if forendD20 > 16 then
        forend = instanceItem("Base.870ForendWoodDark")
        darkWood = true
    elseif forendD20 > 12 then
        forend = instanceItem("Base.870CorncobWoodDark")
        darkWood = true
    elseif forendD20 > 6 then
        forend = instanceItem("Base.870ForendWoodLight")
        lightWood = true
    elseif forendD20 > 3 then
        forend = instanceItem("Base.870CorncobWoodLight")
        lightWood = true
    else
        forend = instanceItem("Base.870ForendSynthetic")
        synthetic = true
    end
    local cutStockD10 = ZombRand(1,10)
    local noRecoil = false
    if darkWood then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.870CutStockDark")
            noRecoil = true
        else
            stock = instanceItem("Base.870StockWoodDark")
        end
    end
    if lightWood then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.870CutStockLight")
            noRecoil = true
        else
            stock = instanceItem("Base.870StockWoodLight")
        end
    end
    if synthetic then
        local synthD10 = ZombRand(0,10)
        if synthD10 > 5 then
            stock = instanceItem("Base.870StockSynthetic")
        else
            stock = instanceItem("Base.870PistolStock")
        end
    end
    if noRecoil == false then
        local recoilD10 = ZombRand(0,10)
        if recoilD10 > 7 then
            recoil = nil
        elseif recoilD10 > 5 or synthetic == true then
            recoil = instanceItem("Base.RecoilPad")
        elseif recoilD10 > 3 then
            recoil = instanceItem("Base.RedRecoilPad")
        else 
            recoil = instanceItem("Base.BrownRecoilPad")
        end
    end
    weapon:attachWeaponPart(stock)
    if recoil ~= nil then
        weapon:attachWeaponPart(recoil)
    end
    weapon:attachWeaponPart(forend)
    if isSO == false then
        weapon:attachWeaponPart(instanceItem("Base.BoreThread"))
        local choke = nil
        local chokeD6 = ZombRand(0,6)
        if isSO == false then
            if chokeD6 > 4 and not slugGun then
                choke = instanceItem("Base.ChokeTubeFull")
            elseif chokeD6 > 2 and not slugun then
                choke = instanceItem("Base.ChokeTubeImproved")
            elseif chokeD6 > 1 or slugGun then
                choke = instanceItem("Base.ChokeTubeRifled")
            end
        end
        weapon:attachWeaponPart(choke)
        local slugD10 = ZombRand(0,10)
        if slugD10 > 6 and slugGun then
            weapon:attachWeaponPart(instanceItem("Base.870ScopeRail"))
            local scope = nil
            local scopeD12 = ZombRand(0,12)
            if scopeD12 > 10 then
                scope = instanceItem("Base.x3Scope")
            elseif scopeD12 > 8 then
                scope = instanceItem("Base.x4Scope")
            elseif scopeD12 > 6 then
                scope = instanceItem("Base.x6Scope")
            elseif scopeD12 > 4 then
                scope = instanceItem("Base.x8Scope")
            elseif scopeD12 > 2 then
                scope = instanceItem("Base.AccuDot")
            elseif scopeD12 > 1 then
                scope = instanceItem("Base.AccuDotSilver")
            else
                scope = nil
            end
            if scope ~= nil then
                weapon:attachWeaponPart(scope)
            end
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93870P = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local spriteD100 = ZombRand(0,100)
    local blue = false
    local park = false
    local marine = false
    local carrier = false
    if not weapon:getWeaponPart("Trigger") then
        weapon:attachWeaponPart(instanceItem("Base.Rem870Trigger"))
    end
    if spriteD100 > 60 then
        weapon:setName(getText("Remington ") .. getText("870") .. getText(" Police") .. ammoNam)
        weapon:setWeaponSprite("Rem870P")
        weapon:setTexture(getTexture("media/textures/item_Rem870P.png"))
        weapon:getModData().Guns93Icon = "Rem870P"
        park = true
    elseif spriteD100 > 10 then
        weapon:setName(getText("Remington ") .. getText("870") .. getText(" Police") .. ammoNam)
        weapon:setWeaponSprite("Rem870PBlue")
        weapon:setTexture(getTexture("media/textures/item_Rem870PBlue.png"))
        weapon:getModData().Guns93Icon = "Rem870PBlue"
        blue = true
    else
        weapon:setName(getText("Remington ") .. getText("870") .. getText(" Marine Magnum") .. ammoNam)
        weapon:setWeaponSprite("Rem870Marine")
        weapon:setTexture(getTexture("media/textures/item_Rem870Marine.png"))
        weapon:getModData().Guns93Icon = "Rem870Marine"
        marine = true
    end
    local magExten = nil
    if marine then
        magExten = instanceItem("Base.870MagExtenMarine")
    elseif not marine then
        if ZombRand(10) < 4 then
            if park then
                magExten = instanceItem("Base.870MagExtenPark")
            elseif blue then
                magExten = instanceItem("Base.870MagExtenBlue")
            end
        end
    end
    if magExten ~= nil then
        weapon:attachWeaponPart(magExten)
        weapon:setMaxAmmo(magExten:getMaxAmmo())
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = nil
        local noShield = false
        local irond10 = ZombRand(0,10)
        if irond10 > 6 then
            Irons = instanceItem("Base.BeadSight")
            noShield = true
        elseif irond10 > 4 then
            Irons = instanceItem("Base.IronSightGhost")
            noShield = true
        else
            Irons = instanceItem("Base.IronSightNotch")
        end
        local sheildd5 = ZombRand(0,5)
        if sheildd5 > 3 and noShield then
            if marine then
                weapon:attachWeaponPart(instanceItem("Base.870HeatShieldSS"))
            else
                weapon:attachWeaponPart(instanceItem("Base.870HeatShield"))
            end
        end
        local carrierD5 = ZombRand(0,5)
        if carrierD5 > 3 then
            weapon:attachWeaponPart(instanceItem("Base.ShellCarrier"))
            carrier = true
        end
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    local foldstock = false
    local stock = nil
    local forend = nil
    local recoil = nil
    local foldD10 = ZombRand(0,10)
    local forendD20 = ZombRand(0,20)
    if foldD10 > 7 then
        foldstock = true
    end
    local darkWood = false
    local lightWood = false
    local synthetic = false
    local pistolGrip = false
    if not marine then
        if forendD20 > 16 then
            forend = instanceItem("Base.870ForendWoodDark")
            darkWood = true
        elseif forendD20 > 14 then
            forend = instanceItem("Base.870CorncobWoodDark")
            darkWood = true
        elseif forendD20 > 12 then
            forend = instanceItem("Base.870ForendWoodLight")
            lightWood = true
        elseif forendD20 > 10 then
            forend = instanceItem("Base.870CorncobWoodLight")
            lightWood = true
        end
    end
    if not forend then
        if forendD20 > 8 then
            forend = instanceItem("Base.870CorncobSynthetic")
            synthetic = true
        elseif forendD20 > 6 then
            forend = instanceItem("Base.870ForendSynthetic")
            synthetic = true
        elseif forendD20 > 4 then
            forend = instanceItem("Base.870StrapSynthetic")
            synthetic = true
        elseif forendD20 > 2 then
            forend = instanceItem("Base.870PistolPump")
            synthetic = true
            pistolGrip = true
        else
            forend = instanceItem("Base.870ForendLight")
            forend:setCurrentUsesFloat(ZombRand(0, 10)/10);
            synthetic = true
        end
    end
    if foldstock == false then
        if darkWood then
            stock = instanceItem("Base.870StockWoodDark")
        end
        if lightWood then
            stock = instanceItem("Base.870StockWoodLight")
        end
        if synthetic then
            local synthD10 = ZombRand(0,10)
            if synthD10 > 5 and pistolGrip == false then
                stock = instanceItem("Base.870StockSynthetic")
            else
                stock = instanceItem("Base.870PistolStock")
            end
        end
        local recoilD10 = ZombRand(0,10)
        if recoilD10 > 7 then
            recoil = nil
        elseif recoilD10 > 5 or synthetic == true then
            recoil = instanceItem("Base.RecoilPad")
        elseif recoilD10 > 3 then
            recoil = instanceItem("Base.RedRecoilPad")
        else 
            recoil = instanceItem("Base.BrownRecoilPad")
        end
        if carrier == false then
            local sleeve = nil
            local sleeveD15 = ZombRand(0,15)
            if sleeveD15 < 3 then
                sleeve = instanceItem("Base.NylonAmmoCarrier")
            elseif sleeveD15 < 7 then
                sleeve = instanceItem("Base.ODAmmoCarrier")
            elseif sleeveD15 < 11 then
                sleeve = instanceItem("Base.LeatherAmmoCarrier")
            end
            if sleeve ~= nil then
                weapon:attachWeaponPart(sleeve)
            end
        end
    else
        local d6 = ZombRand(0,6)
        if d6 > 4 then
            stock = instanceItem("Base.870SideFoldIn")
        elseif d6 > 2 then
            stock = instanceItem("Base.870TopFoldIn")
        else
            stock = instanceItem("Base.870PistolGrip")
        end
    end
    weapon:attachWeaponPart(stock)
    if foldstock == false or recoil ~= nil then
        weapon:attachWeaponPart(recoil)
    end
    weapon:attachWeaponPart(forend)
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93M870 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local spriteD100 = ZombRand(0,100)
    if not weapon:getWeaponPart("Trigger") then
        weapon:attachWeaponPart(instanceItem("Base.Rem870Trigger"))
    end
    if spriteD100 > 50 then
        weapon:setName(getText("Remington ") .. weapon:getDisplayName() .. ammoNam)
        weapon:setWeaponSprite("M870")
        weapon:setTexture(getTexture("media/textures/item_M870Park.png"))
        weapon:getModData().Guns93Icon = "M870Park"
    else
        weapon:setName(getText("Remington ") .. weapon:getDisplayName() .. ammoNam)
        weapon:setWeaponSprite("M870Blue")
        weapon:setTexture(getTexture("media/textures/item_M870Blue.png"))
        weapon:getModData().Guns93Icon = "M870Blue"
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = nil
        local noShield = false
        local irond10 = ZombRand(0,10)
        if irond10 > 5 then
            Irons = instanceItem("Base.BeadSight")
            noShield = true
        else
            Irons = instanceItem("Base.IronSightNotch")
        end
        local sheildd5 = ZombRand(0,5)
        if sheildd5 > 3 and noShield then
            weapon:attachWeaponPart(instanceItem("Base.870HeatShield"))
        end
        if ZombRand(0,6) > 3 then
            local bayoD5 = ZombRand(0,6)
            if bayoD5 > 3 then
                weapon:attachWeaponPart(instanceItem("Base.M9BayonetPart"))
            else
                weapon:attachWeaponPart(instanceItem("Base.M7BayonetPart"))
            end
        end
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    local foldstock = false
    local stock = nil
    local forend = nil
    local recoil = nil
    local foldD10 = ZombRand(0,10)
    local forendD20 = ZombRand(0,20)
    if foldD10 > 7 then
        foldstock = true
    end
    local darkWood = false
    local lightWood = false
    if forendD20 > 15 then
        forend = instanceItem("Base.870ForendWoodDark")
        darkWood = true
    elseif forendD20 > 10 then
        forend = instanceItem("Base.870CorncobWoodDark")
        darkWood = true
    elseif forendD20 > 5 then
        forend = instanceItem("Base.870ForendWoodLight")
        lightWood = true
    else
        forend = instanceItem("Base.870CorncobWoodLight")
        lightWood = true
    end
    if foldstock == false then
        if darkWood then
            stock = instanceItem("Base.870StockWoodDark")
        end
        if lightWood then
            stock = instanceItem("Base.870StockWoodLight")
        end
        local recoilD10 = ZombRand(0,10)
        if recoilD10 > 5 then
            recoil = nil
        else
            recoil = instanceItem("Base.RecoilPad")
        end
        local sleeve = nil
        local sleeveD15 = ZombRand(0,15)
        if sleeveD15 < 5 then
            sleeve = instanceItem("Base.NylonAmmoCarrier")
        elseif sleeveD15 < 10 then
            sleeve = instanceItem("Base.ODAmmoCarrier")
        end
        if sleeve ~= nil then
            weapon:attachWeaponPart(sleeve)
        end
    else
        stock = instanceItem("Base.870TopFoldIn")
    end
    weapon:attachWeaponPart(stock)
    if foldstock == false or recoil ~= nil then
        weapon:attachWeaponPart(recoil)
    end
    weapon:attachWeaponPart(forend)
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        weapon:getModData().Guns93Icon = "M870Blue"
    end
end

Guns93GunConfig.Guns93Moss500 = function(weapon)
    if not weapon then return end
    local slugGun = false
    if ZombRand(1,40) > 30 then
        local bullet = weapon:getModData().modAlt_Ammo
        Guns93AddAmmoTypes(weapon, bullet)
        slugGun = true 
    end
    local ammoNam = GetAmmoName(weapon)
    local isSO = false
    local namSO = ""
    if weapon:getFullType() == "Base.SOMoss500" then
        isSO = true
        namSO = getText("Sawed-Off ")
    end
    local spriteD100 = ZombRand(0,100)
    local camo = false
    local synthetic = false
    if not weapon:getWeaponPart("Trigger") then
        weapon:attachWeaponPart(instanceItem("Base.Moss500Trigger"))
    end
    if spriteD100 > 40 then
        weapon:setName(namSO .. getText("Mossberg ") .. getText("500A") .. ammoNam)
        if spriteD100 > 75 then
            if isSO then
                weapon:setWeaponSprite("SOMoss500Blue")
                weapon:setTexture(getTexture("media/textures/item_SOMoss500Blue.png"))
                weapon:getModData().Guns93Icon = "SOMoss500Blue"
            else
                weapon:setWeaponSprite("Moss500Blue")
                weapon:setTexture(getTexture("media/textures/item_Moss500Blue.png"))
                weapon:getModData().Guns93Icon = "Moss500Blue"
            end
        elseif spriteD100 > 50 then
            if isSO then
                weapon:setWeaponSprite("SOMoss500Gray")
                weapon:setTexture(getTexture("media/textures/item_SOMoss500Gray.png"))
                weapon:getModData().Guns93Icon = "SOMoss500Gray"
            else
                weapon:setWeaponSprite("Moss500Gray")
                weapon:setTexture(getTexture("media/textures/item_Moss500Gray.png"))
                weapon:getModData().Guns93Icon = "Moss500Gray"
            end
        elseif spriteD100 > 40 then
            if isSO then
                weapon:setWeaponSprite("SOMoss500Camo")
                weapon:setTexture(getTexture("media/textures/item_SOMoss500Camo.png"))
                weapon:getModData().Guns93Icon = "SOMoss500Camo"
            else
                weapon:setWeaponSprite("Moss500Camo")
                weapon:setTexture(getTexture("media/textures/item_Moss500Camo.png"))
                weapon:getModData().Guns93Icon = "Moss500Camo"
            end
            camo = true
        end
    else
        weapon:setName(namSO .. getText("Mossberg ") .. getText("Maverick 88") .. ammoNam)
        if isSO then
            weapon:setWeaponSprite("SOMav88")
            weapon:setTexture(getTexture("media/textures/item_SOMav88.png"))
            weapon:getModData().Guns93Icon = "SOMav88"
        else
            weapon:setWeaponSprite("Mav88")
            weapon:setTexture(getTexture("media/textures/item_Mav88.png"))
            weapon:getModData().Guns93Icon = "Mav88"
        end
        synthetic = true
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = nil
        local irond10 = ZombRand(0,10)
        if irond10 > 5 then
            Irons = instanceItem("Base.BeadSight")
        else
            Irons = instanceItem("Base.IronSightNotch")
        end
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    local stock = nil
    local forend = nil
    local recoil = nil
    local forendD20 = ZombRand(0,20)
    local darkWood = false
    local lightWood = false
    if forendD20 > 18 and not (camo or synthetic) then
        forend = instanceItem("Base.500ForendWoodDark")
        darkWood = true
    elseif forendD20 > 16 and not (camo or synthetic) then
        forend = instanceItem("Base.500RoundWoodDark")
        darkWood = true
    elseif forendD20 > 14 and not (camo or synthetic) then
        forend = instanceItem("Base.500ForendWoodLight")
        lightWood = true
    elseif forendD20 > 12 and not (camo or synthetic) then
        forend = instanceItem("Base.500RoundWoodLight")
        lightWood = true
    elseif forendD20 > 4 and not camo then
        forend = instanceItem("Base.500ForendSynthetic")
        synthetic = true
    elseif not camo or synthetic then
        forend = instanceItem("Base.500RoundSynthetic")
        synthetic = true
    elseif camo then
        forend = instanceItem("Base.500ForendCamo")
    end
    local cutStockD10 = ZombRand(1,10)
    if darkWood then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.500CutStockDark")
        else
            stock = instanceItem("Base.500StockWoodDark")
        end
    end
    if lightWood then
        if isSO and cutStockD10 > 5 then
            stock = instanceItem("Base.500CutStockLight")
        else
            stock = instanceItem("Base.500StockWoodLight")
        end
    end
    if synthetic then
        stock = instanceItem("Base.500StockSynthetic")
    end
    if camo then
        stock = instanceItem("Base.500StockCamo")
    end
    weapon:attachWeaponPart(stock)
    if isSO == false then
        local recoilD10 = ZombRand(0,10)
        if recoilD10 > 7 then
            recoil = nil
        elseif recoilD10 > 4 or (synthetic or camo) == true then
            recoil = instanceItem("Base.RecoilPad")
        elseif recoilD10 > 2 then
            recoil = instanceItem("Base.RedRecoilPad")
        else 
            recoil = instanceItem("Base.BrownRecoilPad")
        end
        if recoil ~= nil then
            weapon:attachWeaponPart(recoil)
        end
    end
    weapon:attachWeaponPart(forend)
    local choke = nil
    local chokeD6 = ZombRand(0,6)
    if isSO == false then
        weapon:attachWeaponPart(instanceItem("Base.BoreThread"))
        if chokeD6 > 4 and not slugGun then
            choke = instanceItem("Base.ChokeTubeFull")
        elseif chokeD6 > 2 and not slugGun then
            choke = instanceItem("Base.ChokeTubeImproved")
        elseif chokeD6 > 1 or slugGun then
            choke = instanceItem("Base.ChokeTubeRifled")
        end
        weapon:attachWeaponPart(choke)
        local slugD10 = ZombRand(0,10)
        if slugD10 > 6 and slugGun then
            weapon:attachWeaponPart(instanceItem("Base.500ScopeRail"))
            local scope = nil
            local scopeD12 = ZombRand(0,12)
            if scopeD12 > 10 then
                scope = instanceItem("Base.x3Scope")
            elseif scopeD12 > 8 then
                scope = instanceItem("Base.x4Scope")
            elseif scopeD12 > 6 then
                scope = instanceItem("Base.x6Scope")
            elseif scopeD12 > 4 then
                scope = instanceItem("Base.x8Scope")
            elseif scopeD12 > 2 then
                scope = instanceItem("Base.AccuDot")
            elseif scopeD12 > 1 then
                scope = instanceItem("Base.AccuDotSilver")
            else
                scope = nil
            end
            if scope ~= nil then
                weapon:attachWeaponPart(scope)
            end
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93Moss590 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local spriteD100 = ZombRand(0,100)
    local carrier = false
    if not weapon:getWeaponPart("Trigger") then
        weapon:attachWeaponPart(instanceItem("Base.Moss500Trigger"))
    end
    local mariner = ""
    local marinerPart = false
    if spriteD100 > 52 then
        weapon:setWeaponSprite("Moss590Blue")
        weapon:setTexture(getTexture("media/textures/item_Moss590Blue.png"))
        weapon:getModData().Guns93Icon = "Moss590Blue"
    elseif spriteD100 > 2 then
        weapon:setWeaponSprite("Moss590Gray")
        weapon:setTexture(getTexture("media/textures/item_Moss590Gray.png"))
        weapon:getModData().Guns93Icon = "Moss590Gray"
    else
        weapon:setWeaponSprite("Moss590Mariner")
        weapon:setTexture(getTexture("media/textures/item_Moss590Mariner.png"))
        weapon:getModData().Guns93Icon = "Moss590Mariner"
        mariner = getText(" Mariner")
        marinerPart = true
    end
    weapon:setName(getText("Mossberg ") .. getText("590") .. mariner .. ammoNam)
    if not weapon:getWeaponPart("Irons") then
        local Irons = nil
        local noShield = false
        local irond10 = ZombRand(0,10)
        if irond10 > 6 then
            Irons = instanceItem("Base.BeadSight")
            noShield = true
        elseif irond10 > 4 then
            Irons = instanceItem("Base.IronSightGhost")
            noShield = true
        else
            Irons = instanceItem("Base.IronSightNotch")
        end
        local sheildd5 = ZombRand(0,5)
        if sheildd5 > 3 and noShield then
            if marinerPart then
                weapon:attachWeaponPart(instanceItem("Base.870HeatShieldSS"))
            else
                weapon:attachWeaponPart(instanceItem("Base.870HeatShield"))
            end
        end
        local carrierD5 = ZombRand(0,5)
        if carrierD5 > 3 then
            weapon:attachWeaponPart(instanceItem("Base.ShellCarrier"))
            carrier = true
        end
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    local foldstock = false
    local stock = nil
    local forend = nil
    local recoil = nil
    local foldD10 = ZombRand(0,10)
    local forendD20 = ZombRand(0,20)
    if foldD10 > 7 then
        foldstock = true
    end
    local pistolGrip = false
    if forendD20 > 12 then
        forend = instanceItem("Base.500RoundSynthetic")
    elseif forendD20 > 6 then
        forend = instanceItem("Base.500ForendSynthetic")
    elseif forendD20 > 3 then
        forend = instanceItem("Base.500PistolPump")
        pistolGrip = true
    else
        forend = instanceItem("Base.500ForendLight")
        forend:setCurrentUsesFloat(ZombRand(0, 10)/10);
    end
    if foldstock == false then
        local synthD10 = ZombRand(0,10)
        if synthD10 > 5 and pistolGrip == false then
            stock = instanceItem("Base.500StockSynthetic")
        else
            stock = instanceItem("Base.500PistolStock")
        end
        local recoilD10 = ZombRand(0,10)
        if recoilD10 > 7 then
            recoil = nil
        else
            recoil = instanceItem("Base.RecoilPad")
        end
        if carrier == false then
            local sleeve = nil
            local sleeveD15 = ZombRand(0,15)
            if sleeveD15 < 3 then
                sleeve = instanceItem("Base.NylonAmmoCarrier")
            elseif sleeveD15 < 7 then
                sleeve = instanceItem("Base.ODAmmoCarrier")
            elseif sleeveD15 < 11 then
                sleeve = instanceItem("Base.LeatherAmmoCarrier")
            end
            if sleeve ~= nil then
                weapon:attachWeaponPart(sleeve)
            end
        end
    else
        local d6 = ZombRand(0,6)
        if d6 > 4 then
            stock = instanceItem("Base.500SideFoldIn")
        elseif d6 > 2 then
            stock = instanceItem("Base.500TopFoldIn")
        else
            stock = instanceItem("Base.500PistolGrip")
        end
    end
    weapon:attachWeaponPart(stock)
    if foldstock == false or recoil ~= nil then
        weapon:attachWeaponPart(recoil)
    end
    weapon:attachWeaponPart(forend)
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93Ithaca37 = function(weapon)
    if not weapon then return end
    local slugGun = false
    if ZombRand(1,40) > 30 then
        local bullet = weapon:getModData().modAlt_Ammo
        Guns93AddAmmoTypes(weapon, bullet)
        slugGun = true 
    end
    local ammoNam = GetAmmoName(weapon)
    local isSO = false
    local isTrench = false
    local isRiot = false
    local isMP = false
    local namSO = ""
    local nameType = ""
    local hicks = false
    local stakeout = false
    if weapon:getFullType() == "Base.SOIthaca37" then
        isSO = true
    elseif weapon:getFullType() == "Base.Ithaca37Riot" then
        isRiot = true
    elseif weapon:getFullType() == "Base.Ithaca37MP" then
        isMP = true
    elseif weapon:getFullType() == "Base.M37" then
        isTrench = true
        weapon:attachWeaponPart(instanceItem("Base.Ithaca37BayoLug"))
        if ZombRand(1,9) > 6 then
            weapon:attachWeaponPart(instanceItem("Base.M1917BayonetPart"))
        end
    end
    local model = ""
    if ZombRand(1,10) > 3 then
        model = getText("Model 37")
    else
        model = getText("Model 87")
    end
    local spriteD100 = ZombRand(0,100)
    if not weapon:getWeaponPart("Trigger") then
        weapon:attachWeaponPart(instanceItem("Base.Ithaca37Trigger"))
    end
    if isSO then
        if spriteD100 > 49 then
            weapon:setWeaponSprite("SOIthaca37Park")
            weapon:setTexture(getTexture("media/textures/item_Ithaca37Stakeout.png"))
            weapon:getModData().Guns93Icon = "Ithaca37Stakeout"
            nameType = getText(" Stakeout")
            stakeout = true
        elseif spriteD100 > 3 then
            weapon:setWeaponSprite("SOIthaca37Blued")
            weapon:setTexture(getTexture("media/textures/item_SOIthaca37Blued.png"))
            weapon:getModData().Guns93Icon = "SOIthaca37Blued"
            namSO = getText("Sawed-Off ")
        else
            weapon:setWeaponSprite("HicksIthaca37")
            weapon:setTexture(getTexture("media/textures/item_HicksIthaca37.png"))
            weapon:getModData().Guns93Icon = "HicksIthaca37"
            weapon:setName(getText("Hick's Ithaca 37") .. ammoNam)
            hicks = true
        end
    elseif isRiot then
        if spriteD100 > 65 then
            weapon:setWeaponSprite("Ithaca37RiotBlued")
            weapon:setTexture(getTexture("media/textures/item_Ithaca37RiotBlued.png"))
            weapon:getModData().Guns93Icon = "Ithaca37RiotBlued"
        elseif spriteD100 > 5 then
            weapon:setWeaponSprite("Ithaca37RiotPark")
            weapon:setTexture(getTexture("media/textures/item_Ithaca37RiotPark.png"))
            weapon:getModData().Guns93Icon = "Ithaca37RiotPark"
        else
            weapon:setWeaponSprite("Ithaca37RiotSS")
            weapon:setTexture(getTexture("media/textures/item_Ithaca37RiotSS.png"))
            weapon:getModData().Guns93Icon = "Ithaca37RiotSS"
        end
        nameType = getText(" Riot Gun")
    elseif isMP or isTrench then
        if spriteD100 > 65 then
            weapon:setWeaponSprite("Ithaca37MPBlued")
            if isTrench then
                weapon:setTexture(getTexture("media/textures/item_M37Blued.png"))
                weapon:getModData().Guns93Icon = "M37Blued"
            else
                weapon:setTexture(getTexture("media/textures/item_Ithaca37MPBlued.png"))
                weapon:getModData().Guns93Icon = "Ithaca37MPBlued"
            end
        elseif spriteD100 > 5 or isTrench then
            weapon:setWeaponSprite("Ithaca37MPPark")
            if isTrench then
                weapon:setTexture(getTexture("media/textures/item_M37Park.png"))
                weapon:getModData().Guns93Icon = "M37Park"
            else
                weapon:setTexture(getTexture("media/textures/item_Ithaca37MPPark.png"))
                weapon:getModData().Guns93Icon = "Ithaca37MPPark"
            end
        else
            weapon:setWeaponSprite("Ithaca37MPSS")
            weapon:setTexture(getTexture("media/textures/item_Ithaca37MPSS.png"))
                weapon:getModData().Guns93Icon = "Ithaca37MPSS"
        end
        if not isTrench then
            if slugGun then
                nameType = getText(" Deerslayer Police Special")
                weapon:attachWeaponPart(instanceItem("Base.SlugBarrel"))
            else
                nameType = getText(" Military & Police")
            end
        end
    else
        if spriteD100 > 65 then
            weapon:setWeaponSprite("Ithaca37Blued")
            weapon:setTexture(getTexture("media/textures/item_Ithaca37Blued.png"))
            weapon:getModData().Guns93Icon = "Ithaca37Blued"
        elseif spriteD100 > 50 then
            weapon:setWeaponSprite("Ithaca37Gold")
            weapon:setTexture(getTexture("media/textures/item_Ithaca37Gold.png"))
            weapon:getModData().Guns93Icon = "Ithaca37Gold"
        elseif spriteD100 > 10 then
            weapon:setWeaponSprite("Ithaca37Park")
            weapon:setTexture(getTexture("media/textures/item_Ithaca37Park.png"))
            weapon:getModData().Guns93Icon = "Ithaca37Park"
        elseif spriteD100 > 5 then
            weapon:setWeaponSprite("Ithaca37SS")
            weapon:setTexture(getTexture("media/textures/item_Ithaca37SS.png"))
            weapon:getModData().Guns93Icon = "Ithaca37SS"
        else
            weapon:setWeaponSprite("Ithaca37Scene")
            weapon:setTexture(getTexture("media/textures/item_Ithaca37Scene.png"))
            weapon:getModData().Guns93Icon = "Ithaca37Scene"
        end
        if slugGun then
            nameType = getText(" Deerslayer")
            weapon:attachWeaponPart(instanceItem("Base.SlugBarrel"))
        else
            nameType = getText(" Featherlight")
        end
    end
    if not hicks and not isTrench then
        weapon:setName(namSO .. getText("Ithaca ") .. model .. nameType .. ammoNam)
    end
    if not hicks and not isTrench then
        local Irons = nil
        local irond10 = ZombRand(0,10)
        if irond10 > 5 then
            Irons = instanceItem("Base.BeadSight")
        else
            Irons = instanceItem("Base.IronSightNotch")
        end
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    local stock = nil
    local forend = nil
    local recoil = nil
    local forendD20 = ZombRand(0,20)
    local darkWood = false
    local lightWood = false
    local synthStock = false
    if hicks then
        forend = instanceItem("Base.Ithaca37CheckForendWoodDark")
        stock = instanceItem("Base.HicksGrip")
        weapon:attachWeaponPart(instanceItem("Base.NonremoveIrons"))
    elseif forendD20 > 18 and (isSO or isRiot or isMP or stakeout) then
        forend = instanceItem("Base.Ithaca37ForendSynthetic")
        synthStock = true
    elseif forendD20 > 16 and (isSO or isRiot or isMP or stakeout) then
        forend = instanceItem("Base.Ithaca37PistolPump")
        synthStock = true
    elseif (forendD20 > 14 and (isSO or isRiot or isMP)) or stakeout then
        forend = instanceItem("Base.Ithaca37StrapSynthetic")
        synthStock = true
    elseif forendD20 > 12 and not isTrench then
        forend = instanceItem("Base.Ithaca37WideWoodDark")
        darkWood = true
    elseif forendD20 > 8 then
        forend = instanceItem("Base.Ithaca37ForendWoodDark")
        darkWood = true
    elseif forendD20 > 5 or isTrench then
        forend = instanceItem("Base.Ithaca37ForendWoodLight")
        lightWood = true
    elseif forendD20 > 3 then
        forend = instanceItem("Base.Ithaca37WideWoodLight")
        lightWood = true
    else
        forend = instanceItem("Base.Ithaca37WideSynthetic")
        synthStock = true
    end
    local folder = false
    if (ZombRand(1,10) > 7 and (isRiot or isMP)) and not hicks and not isTrench then
        stock = instanceItem("Base.Ithaca37SideFoldIn")
        folder = true
    end
    local cutStockD10 = ZombRand(1,10)
    if not folder and not hicks then
        if synthStock or stakeout then
            if (cutStockD10 > 7 and (isSO or isRiot or isMP)) or stakeout then
                stock = instanceItem("Base.Ithaca37PistolGrip")
                folder = true
            elseif cutStockD10 > 3 then
                stock = instanceItem("Base.Ithaca37StockSynthetic")
            else
                stock = instanceItem("Base.Ithaca37PistolStock")
            end
        end
        if darkWood then
            if isSO and cutStockD10 > 5 then
                stock = instanceItem("Base.Ithaca37CutStockDark")
                folder = true
            else
                stock = instanceItem("Base.Ithaca37StockWoodDark")
            end
        end
        if lightWood then
            if isSO and cutStockD10 > 5 then
                stock = instanceItem("Base.Ithaca37CutStockLight")
                folder = true
            else
                stock = instanceItem("Base.Ithaca37StockWoodLight")
            end
        end
    end
    weapon:attachWeaponPart(stock)
    if not (isSO or folder or isTrench) then
        local recoilD10 = ZombRand(0,10)
        if recoilD10 > 7 then
            recoil = nil
        elseif recoilD10 > 4 or synthStock then
            recoil = instanceItem("Base.RecoilPad")
        elseif recoilD10 > 2 then
            recoil = instanceItem("Base.RedRecoilPad")
        else 
            recoil = instanceItem("Base.BrownRecoilPad")
        end
        if recoil ~= nil then
            weapon:attachWeaponPart(recoil)
        end
    end
    weapon:attachWeaponPart(forend)
    local choke = nil
    local chokeD6 = ZombRand(0,6)
    if not (isSO or slugGun or isRiot or isMP or isTrench) then
        weapon:attachWeaponPart(instanceItem("Base.BoreThread"))
        if chokeD6 > 3 then
            choke = instanceItem("Base.ChokeTubeFull")
        else
            choke = instanceItem("Base.ChokeTubeImproved")
        end
        weapon:attachWeaponPart(choke)
    end
    local slugD10 = ZombRand(0,10)
    if slugD10 > 6 and not (isSO or isRiot or isMP or isTrench) then
        weapon:attachWeaponPart(instanceItem("Base.Ithaca37ScopeRail"))
        local scope = nil
        local scopeD12 = ZombRand(0,12)
        if scopeD12 > 10 then
            scope = instanceItem("Base.x3Scope")
        elseif scopeD12 > 8 then
            scope = instanceItem("Base.x4Scope")
        elseif scopeD12 > 6 then
            scope = instanceItem("Base.x6Scope")
        elseif scopeD12 > 4 then
            scope = instanceItem("Base.x8Scope")
        elseif scopeD12 > 2 then
            scope = instanceItem("Base.AccuDot")
        elseif scopeD12 > 1 then
            scope = instanceItem("Base.AccuDotSilver")
        else
            scope = nil
        end
        if scope ~= nil then
            weapon:attachWeaponPart(scope)
        end
    end
    local carrier = false
    local carrierD5 = ZombRand(0,5)
    if (isRiot or isMP) and not isSO and not folder and not isTrench then
        if carrierD5 < 1 then
            weapon:attachWeaponPart(instanceItem("Base.ShellCarrier"))
            carrier = true
        elseif carrierD5 < 2 then
            local sleeve = nil
            local sleeveD15 = ZombRand(0,15)
            if sleeveD15 < 3 then
                sleeve = instanceItem("Base.NylonAmmoCarrier")
            elseif sleeveD15 < 7 then
                sleeve = instanceItem("Base.ODAmmoCarrier")
            elseif sleeveD15 < 11 then
                sleeve = instanceItem("Base.LeatherAmmoCarrier")
            end
            if sleeve ~= nil then
                weapon:attachWeaponPart(sleeve)
            end
        end
    end
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        weapon:getModData().Guns93Icon = "Ithaca37Blued"
    end
end

Guns93GunConfig.Guns93M590 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local spriteD100 = ZombRand(0,100)
    if not weapon:getWeaponPart("Trigger") then
        weapon:attachWeaponPart(instanceItem("Base.Moss500Trigger"))
    end
    weapon:setName(getText("Mossberg ") .. getText("M590") .. ammoNam)
    if not weapon:getWeaponPart("Irons") then
        local Irons = nil
        local noShield = false
        local irond10 = ZombRand(0,10)
        if irond10 > 6 then
            Irons = instanceItem("Base.BeadSight")
            noShield = true
        elseif irond10 > 4 then
            Irons = instanceItem("Base.IronSightGhost")
            noShield = true
        else
            Irons = instanceItem("Base.IronSightNotch")
        end
        local sheildd5 = ZombRand(0,5)
        if sheildd5 > 3 and noShield then
            weapon:attachWeaponPart(instanceItem("Base.870HeatShield"))
        end
        if ZombRand(0,6) > 3 then
            local bayoD5 = ZombRand(0,6)
            if bayoD5 > 3 then
                weapon:attachWeaponPart(instanceItem("Base.M9BayonetPart"))
            else
                weapon:attachWeaponPart(instanceItem("Base.M7BayonetPart"))
            end
        end
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    local stock = nil
    local forend = nil
    local recoil = nil
    local forendD20 = ZombRand(0,20)
    forend = instanceItem("Base.500RoundSynthetic")
    stock = instanceItem("Base.500StockSynthetic")
    local recoilD10 = ZombRand(0,10)
    if recoilD10 > 7 then
        recoil = nil
    else
        recoil = instanceItem("Base.RecoilPad")
    end
    local sleeve = nil
    local sleeveD15 = ZombRand(0,15)
    if sleeveD15 < 5 then
        sleeve = instanceItem("Base.NylonAmmoCarrier")
    elseif sleeveD15 < 10 then
        sleeve = instanceItem("Base.ODAmmoCarrier")
    end
    if sleeve ~= nil then
        weapon:attachWeaponPart(sleeve)
    end
    weapon:attachWeaponPart(stock)
    if recoil ~= nil then
        weapon:attachWeaponPart(recoil)
    end
    weapon:attachWeaponPart(forend)
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        weapon:getModData().Guns93Icon = "M590"
    end
end

Guns93GunConfig.Guns93StoegerUplander = function(weapon)
    if not weapon then return end
    local isSO = false
    if weapon:getFullType() == "Base.SOStoegerUplander" then
        isSO = true
    end
    local ammoNam = GetAmmoName(weapon)
    if ZombRand(1,6) > 4 then
        if isSO then   
            weapon:setWeaponSprite("SOStoegerUplander2Tone")
            weapon:setTexture(getTexture("media/textures/item_SOUplanderTwoTone.png"))
            weapon:getModData().Guns93Icon = "SOUplanderTwoTone"
        else
            weapon:setWeaponSprite("StoegerUplander2Tone")
            weapon:setTexture(getTexture("media/textures/item_UplanderTwoTone.png"))
            weapon:getModData().Guns93Icon = "UplanderTwoTone"
        end
    end
    weapon:setName(weapon:getName() .. ammoNam)
    weapon:attachWeaponPart(instanceItem("Base.BeadSight"))
    weapon:attachWeaponPart(instanceItem("Base.UplanderTrigger"))
    local isThread = false
    if isSO == false then
        weapon:attachWeaponPart(instanceItem("Base.BoreThread"))
        isThread = true
    end
    local forendD12 = ZombRand(0,12)
    local cutGripD10 = ZombRand(1,10)
    local walnut = false
    local dark = false
    local walnutCheck = false
    local darkCheck = false
    local forend = nil
    local NoRecoil = false
    if forendD12 > 10 then
        if isSO and cutGripD10 > 5 then
            forend = instanceItem("Base.UplanderCutStock")
            NoRecoil = true
        else
            forend = instanceItem("Base.UplanderStock")
        end
        walnut = true
    elseif forendD12 > 8 then
        if isSO and cutGripD10 > 5 then
            forend = instanceItem("Base.UplanderCutStraightStock")
            NoRecoil = true
        else
            forend = instanceItem("Base.UplanderStraightStock")
        end
        walnut = true
    elseif forendD12 > 6 then
        if isSO and cutGripD10 > 5 then
            forend = instanceItem("Base.UplanderCutStockDark")
            NoRecoil = true
        else
            forend = instanceItem("Base.UplanderStockDark")
        end
        dark = true
    elseif forendD12 > 4 then
        if isSO and cutGripD10 > 5 then
            forend = instanceItem("Base.UplanderCutStraightStockDark")
            NoRecoil = true
        else
            forend = instanceItem("Base.UplanderStraightStockDark")
        end
        dark = true
    elseif forendD12 > 2 then
        if isSO and cutGripD10 > 5 then
            forend = instanceItem("Base.UplanderCutStockCheck")
            NoRecoil = true
        else
            forend = instanceItem("Base.UplanderStockCheck")
        end
        walnutCheck = true
    else
        if isSO and cutGripD10 > 5 then
            forend = instanceItem("Base.UplanderCutStockDarkCheck")
            NoRecoil = true
        else
            forend = instanceItem("Base.UplanderStockDarkCheck")
        end
        darkCheck = true
    end
    weapon:attachWeaponPart(forend)
    handguard = nil
    if walnut then
        handguard = instanceItem("Base.UplanderHandguard")
    elseif dark then
        handguard = instanceItem("Base.UplanderHandguardDark")
    elseif walnutCheck then
        handguard = instanceItem("Base.UplanderHandguardCheck")
    elseif darkCheck then
        handguard = instanceItem("Base.UplanderHandguardDarkCheck")
    end
    weapon:attachWeaponPart(handguard)
    local recoilD20 = ZombRand(0,20)
    local recoil = nil
    if NoRecoil == false then
        if recoilD20 > 10 then
            recoil = nil
        elseif recoilD20 > 6 or UpBlack == true then
            recoil = instanceItem("Base.RecoilPad")
        elseif recoilD20 > 4 then
            recoil = instanceItem("Base.RedRecoilPad")
        elseif recoilD20 > 2 then
            recoil = instanceItem("Base.BrownRecoilPad")
        else
            recoil = instanceItem("Base.LeatherRecoilPad")
        end
        if recoil ~= nil then
            weapon:attachWeaponPart(recoil)
        end
    end
    local choke = nil
    local chokeD10 = ZombRand(0,10)
    if isSO == false and chokeD10 < 7 then
        if chokeD10 > 4 then
            choke = instanceItem("Base.ChokeTubeFull")
        elseif chokeD10 > 2 then
            choke = instanceItem("Base.ChokeTubeImproved")
        end
    end
end

Guns93GunConfig.Guns93SavageFox = function(weapon)
    if not weapon then return end
    local isSO = false
    if weapon:getFullType() == "Base.SOSavageFox" then
        isSO = true
    end
    local ammoNam = GetAmmoName(weapon)
    local finishType = ZombRand(0,6)
    if finishType > 4 then
        if isSO then   
            weapon:setWeaponSprite("SOSavageFox2Tone")
            weapon:setTexture(getTexture("media/textures/item_SOSavageFox2Tone.png"))
            weapon:getModData().Guns93Icon = "SOSavageFox2Tone"
        else
           weapon:setWeaponSprite("SavageFox2Tone")
            weapon:setTexture(getTexture("media/textures/item_SavageFox2Tone.png"))
            weapon:getModData().Guns93Icon = "SavageFox2Tone"
        end
    elseif finishType > 2 then
        if isSO then   
            weapon:setWeaponSprite("SOSavageFoxCase")
            weapon:setTexture(getTexture("media/textures/item_SOSavageFoxCase.png"))
            weapon:getModData().Guns93Icon = "SOSavageFoxCase"
        else
           weapon:setWeaponSprite("SavageFoxCase")
            weapon:setTexture(getTexture("media/textures/item_SavageFoxCase.png"))
            weapon:getModData().Guns93Icon = "SavageFoxCase"
        end
    end
    weapon:setName(weapon:getName() .. ammoNam)
    weapon:attachWeaponPart(instanceItem("Base.BeadSight"))
    weapon:attachWeaponPart(instanceItem("Base.SavageFoxTrigger"))
    local isThread = false
    if isSO == false then
        weapon:attachWeaponPart(instanceItem("Base.BoreThread"))
        isThread = true
    end
    local forendD10 = ZombRand(1,10)
    local coinToss = ZombRand(1,10)
    local walnut = false
    local dark = false
    local beech = false
    local forend = nil
    local NoRecoil = false
    if forendD10 > 8 then
        if isSO and coinToss > 5 then
            forend = instanceItem("Base.SavageFoxCutStock")
            NoRecoil = true
        else
            forend = instanceItem("Base.SavageFoxStock")
        end
        walnut = true
    elseif forendD10 > 6 then
        if isSO and coinToss > 5 then
            forend = instanceItem("Base.SavageFoxCutCapStock")
            NoRecoil = true
        else
            forend = instanceItem("Base.SavageFoxCapStock")
        end
        walnut = true
    elseif forendD10 > 4 then
        if isSO and coinToss > 5 then
            forend = instanceItem("Base.SavageFoxCutStockDark")
            NoRecoil = true
        else
            forend = instanceItem("Base.SavageFoxStockDark")
        end
        dark = true
    elseif forendD10 > 2 then
        if isSO and coinToss > 5 then
            forend = instanceItem("Base.SavageFoxCutCapStockDark")
            NoRecoil = true
        else
            forend = instanceItem("Base.SavageFoxCapStockDark")
        end
        dark = true
    else
        if isSO and coinToss > 5 then
            forend = instanceItem("Base.SavageFoxCutStockBeech")
            NoRecoil = true
        else
            forend = instanceItem("Base.SavageFoxStockBeech")
        end
        beech = true
    end
    weapon:attachWeaponPart(forend)
    handguard = nil
    if walnut then
        if coinToss > 5 then
        	handguard = instanceItem("Base.SavageFoxSlimHandguard")
		else
        	handguard = instanceItem("Base.SavageFoxHandguard")
		end
    elseif dark then
        if coinToss > 5 then
        	handguard = instanceItem("Base.SavageFoxSlimHandguardDark")
		else
        	handguard = instanceItem("Base.SavageFoxHandguardDark")
		end
    elseif beech then
        if coinToss > 5 then
        	handguard = instanceItem("Base.SavageFoxSlimHandguardBeech")
		else
        	handguard = instanceItem("Base.SavageFoxHandguardBeech")
		end
    end
    weapon:attachWeaponPart(handguard)
    local recoilD20 = ZombRand(0,20)
    local recoil = nil
    if NoRecoil == false then
        if recoilD20 > 10 then
            recoil = nil
        elseif recoilD20 > 6 or UpBlack == true then
            recoil = instanceItem("Base.RecoilPad")
        elseif recoilD20 > 4 then
            recoil = instanceItem("Base.RedRecoilPad")
        elseif recoilD20 > 2 then
            recoil = instanceItem("Base.BrownRecoilPad")
        else
            recoil = instanceItem("Base.LeatherRecoilPad")
        end
        if recoil ~= nil then
            weapon:attachWeaponPart(recoil)
        end
    end
    local choke = nil
    local chokeD10 = ZombRand(0,10)
    if isSO == false and chokeD10 < 7 then
        if chokeD10 > 4 then
            choke = instanceItem("Base.ChokeTubeFull")
        elseif chokeD10 > 2 then
            choke = instanceItem("Base.ChokeTubeImproved")
        end
    end
end

Guns93GunConfig.Guns93BreakShotgunSpawns = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local threading = instanceItem("Base.BoreThread")
    weapon:attachWeaponPart(threading)
    if not weapon:getWeaponPart("Irons") then
        local Irons  instanceItem("Base.BeadSight")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
        weapon:setName(weapon:getName() .. ammoNam)
    end
end

Guns93GunConfig.Guns93M1911A1 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local manNam = getText("Colt ")
    local manNamD10 = ZombRand(0,10)
    if manNamD10 > 6 then
        manNam = getText("Colt ")
    elseif manNamD10 > 4 then
        manNam = getText("Ithaca ")
    else
        manNam = getText("Remington Rand ")
    end
    weapon:setName(manNam .. getText("M1911A1") .. ammoNam)
    if not weapon:getWeaponPart("Trigger") then
        weapon:attachWeaponPart(instanceItem("Base.1911Trigger"))
    end
    AddMagAttachment(weapon, nil)
    if not weapon:getWeaponPart("Grip") then
        local stock = instanceItem("Base.1911GripsGI")
        weapon:attachWeaponPart(stock)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.1911FixSightsPark")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93Gov1911 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local Mand100 = ZombRand(0,100)
    local Namd100 = ZombRand(0,100)
    local modelNam = "1911"
    local noPark = false
    local noBlack = false
    local noBlue = false
    local noSS = false
    local onlySS = false
    local noBT = false
    local noFix = false
    local onlyFix = false
    local onlyTar = false
    local sightPark = false
    local sightBlue = false
    local sightSS = false
    if Mand100 > 60 then
        if Namd100 > 60 then
            modelNam = getText("1991A1")
            noBlue = true
            noBT = true
            onlyFix = true
        elseif Namd100 > 30 then
            modelNam = getText("MKIV Gov. Enhanced")
            noBT = true
            noFix = true
        else
            modelNam = getText("MKIV Gold Cup Nat. Match")
            noPark = true
            onlyTar = true
        end
        weapon:setName(getText("Colt ") .. modelNam .. ammoNam)
    elseif Mand100 > 30 then
        if Namd100 > 50 then
            modelNam = getText("1911-A1")
        else
            modelNam = getText("1911-A1") .. getText(" Custom Carry")
            noSS = true
            noBT = true
            noFix = true
        end
        weapon:setName(getText("Springfield ") .. modelNam .. ammoNam)
    elseif Mand100 > 20 then
        noBT = true
        onlyFix = true
        weapon:setName(getText("Auto Ordnance ") .. getText("M1911A1") .. ammoNam)
    elseif Mand100 > 10 then
        onlySS = true
        onlyTar = true
        weapon:setName(getText("AMT ") .. getText("Hardballer") .. ammoNam)
    else
        weapon:setName(getText("Norinco ") .. getText("1911A1") .. ammoNam)
    end
    local finishD24 = ZombRand(0,24)
    if onlySS then
        weapon:setWeaponSprite("Gov1911SS")
        weapon:setTexture(getTexture("media/textures/item_1911SS.png"))
        weapon:getModData().Guns93Icon = "1911SS"
        sightSS = true
    elseif finishD24 > 16 and not noPark then
        weapon:setWeaponSprite("Gov1911Park")
        weapon:setTexture(getTexture("media/textures/item_1911.png"))
        weapon:getModData().Guns93Icon = "1911"
        sightPark = true
    elseif finishD24 > 12 and not noBlack then
        weapon:setWeaponSprite("Gov1911Black")
        weapon:setTexture(getTexture("media/textures/item_1911Black.png"))
        weapon:getModData().Guns93Icon = "1911Black"
        sightBlue = true
    elseif finishD24 > 8 and not noBlue then
        weapon:setWeaponSprite("Gov1911Blue")
        weapon:setTexture(getTexture("media/textures/item_1911Gov.png"))
        weapon:getModData().Guns93Icon = "1911Gov"
        sightBlue = true
    elseif finishD24 > 5 and not noSS then
        weapon:setWeaponSprite("Gov1911SS")
        weapon:setTexture(getTexture("media/textures/item_1911SS.png"))
        weapon:getModData().Guns93Icon = "1911SS"
        sightSS = true
    elseif finishD24 > 2 and not noBT then
        weapon:setWeaponSprite("Gov1911BiToneBlue")
        weapon:setTexture(getTexture("media/textures/item_1911TwoTone.png"))
        weapon:getModData().Guns93Icon = "1911TwoTone"
        sightBlue = true
    elseif not noBT then
        weapon:setWeaponSprite("Gov1911BiToneSS")
        weapon:setTexture(getTexture("media/textures/item_1911TwoTone2.png"))
        weapon:getModData().Guns93Icon = "1911TwoTone2"
        sightSS = true
    end
    if not weapon:getWeaponPart("Trigger") then
        local d100 = ZombRand(0,100)
        local trigger = nil
        if d100 > 70 then
            trigger = "Base.1911TriggerMatch"
        else
            trigger = "Base.1911Trigger"
        end
        if trigger then
            weapon:attachWeaponPart(instanceItem(trigger))
        end
    end
    if not weapon:getWeaponPart("Irons") then
        local sightd20 = ZombRand(0,20)
        local sights = nil
        if sightd20 > 19 and not (onlyFix or onlyTar) then
            sights = "Base.TritiumSights"
        elseif sightd20 > 13 or onlyFix and not onlyTar then
            if sightPark then
                sights = "Base.1911FixSightsPark"
            elseif sightBlue then
                sights = "Base.1911FixSightsBlue"
            elseif sightSS then
                sights = "Base.1911FixSightsSS"
            end
        elseif sightd20 > 13 and not onlyFix or onlyTar then
            sights = "Base.IronPistolTarget"
        elseif sightd20 > 10 and not onlyFix then
            sights = "Base.IronPistolBasic"
        else
            sights = "Base.IronPistolCombat"
        end
        if sights then
            weapon:attachWeaponPart(instanceItem(sights))
        end
    end
    if weapon:getMagazineType() then
        local magD20 = ZombRand(0,20)
        local gunMag = nil
        if magD20 > 12 then
            gunMag = "Base.1911Mag"
        elseif magD20 > 4 then
            gunMag = "Base.1911MagSS"
        elseif magD20 > 2 then
            gunMag = "Base.1911MagExtend"
        else
            gunMag = "Base.1911MagExtendSS"
        end
        if gunMag then
            weapon:setMagazineType(gunMag)
            AddMagAttachment(weapon, gunMag)
        end
    end
    local lightD20 = ZombRand(0,20)
    local gunLight = nil
    if lightD20 > 18 then
        gunLight = instanceItem("Base.1911WML")
        gunLight:setCurrentUsesFloat(ZombRand(0, 10)/10);
        weapon:attachWeaponPart(gunLight)
    end
    if not weapon:getWeaponPart("Grip") then
        local d100 = ZombRand(1,100)
        local stock = nil
        if d100 > 88 then
            stock = "Base.1911GripsGI"
        elseif d100 > 76 then
            stock = "Base.1911GripsRubber"
        elseif d100 > 64 then
            stock = "Base.1911GripsElk"
        elseif d100 > 52 then
            stock = "Base.1911GripsPearl"
        elseif d100 > 40 then
            stock = "Base.1911GripsWrap"
        elseif d100 > 28 then
            stock = "Base.1911GripsMedal"
        elseif d100 > 16 then
            stock = "Base.1911GripsMedal2"
        elseif d100 > 7 then
            stock = "Base.1911GripsWood2"
        else
            stock = "Base.1911GripsWood"
        end
        if stock then
            weapon:attachWeaponPart(instanceItem(stock))
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93Com1911 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local Mand100 = ZombRand(0,100)
    local Namd100 = ZombRand(0,100)
    local modelNam = "1911"
    local noPark = false
    local noBlack = false
    local noBlue = false
    local noSS = false
    local onlySS = false
    local noBT = false
    local noFix = false
    local onlyFix = false
    local onlyTar = false
    local sightPark = false
    local sightBlue = false
    local sightSS = false
    if Mand100 > 55 then
        if Namd100 > 50 then
            modelNam = getText("1991A1") .. getText(" Commander")
            noBlue = true
            noBT = true
            onlyFix = true
        else
            modelNam = getText("Combat") .. getText(" Commander")
            noPark = true
        end
        weapon:setName(getText("Colt ") .. modelNam .. ammoNam)
    elseif Mand100 > 12 then
        modelNam = getText("1911-A1") .. getText(" Champion")
        noSS = true
        noBT = true
        noFix = true
        weapon:setName(getText("Springfield ") .. modelNam .. ammoNam)
    else
        noBT = true
        noSS = true
        onlyFix = true
        weapon:setName(getText("Auto Ordnance ") .. getText("M1911A1") .. getText(" Commander") .. ammoNam)
    end
    local finishD24 = ZombRand(0,24)
    if onlySS then
        weapon:setWeaponSprite("Com1911SS")
        weapon:setTexture(getTexture("media/textures/item_1911ComSS.png"))
        weapon:getModData().Guns93Icon = "1911ComSS"
        sightSS = true
    elseif finishD24 > 16 and not noPark then
        weapon:setWeaponSprite("Com1911Park")
        weapon:setTexture(getTexture("media/textures/item_1911ComPark.png"))
        weapon:getModData().Guns93Icon = "1911ComPark"
        sightPark = true
    elseif finishD24 > 12 and not noBlack then
        weapon:setWeaponSprite("Com1911Black")
        weapon:setTexture(getTexture("media/textures/item_1911ComBlack.png"))
        weapon:getModData().Guns93Icon = "1911ComBlack"
        sightBlue = true
    elseif finishD24 > 8 and not noBlue then
        weapon:setWeaponSprite("Com1911Blue")
        weapon:setTexture(getTexture("media/textures/item_1911Command.png"))
        weapon:getModData().Guns93Icon = "1911Command"
        sightBlue = true
    elseif finishD24 > 5 and not noSS then
        weapon:setWeaponSprite("Com1911SS")
        weapon:setTexture(getTexture("media/textures/item_1911ComSS.png"))
        weapon:getModData().Guns93Icon = "1911ComSS"
        sightSS = true
    elseif finishD24 > 2 and not noBT then
        weapon:setWeaponSprite("Com1911BiToneBlue")
        weapon:setTexture(getTexture("media/textures/item_1911ComTwoTone.png"))
        weapon:getModData().Guns93Icon = "1911ComTwoTone"
        sightBlue = true
    elseif not noBT then
        weapon:setWeaponSprite("Com1911BiToneSS")
        weapon:setTexture(getTexture("media/textures/item_1911ComTwoTone2.png"))
        weapon:getModData().Guns93Icon = "1911ComTwoTone2"
        sightSS = true
    end
    if not weapon:getWeaponPart("Trigger") then
        local d100 = ZombRand(0,100)
        local trigger = nil
        if d100 > 80 then
            trigger = "Base.1911TriggerMatch"
        else
            trigger = "Base.1911Trigger"
        end
        if trigger then
            weapon:attachWeaponPart(instanceItem(trigger))
        end
    end
    if not weapon:getWeaponPart("Irons") then
        local sightd20 = ZombRand(0,20)
        local sights = nil
        if sightd20 > 19 and not (onlyFix or onlyTar) then
            sights = "Base.TritiumSights"
        elseif sightd20 > 13 or onlyFix and not onlyTar then
            if sightPark then
                sights = "Base.1911FixSightsPark"
            elseif sightBlue then
                sights = "Base.1911FixSightsBlue"
            elseif sightSS then
                sights = "Base.1911FixSightsSS"
            end
        elseif sightd20 > 13 and not onlyFix or onlyTar then
            sights = "Base.IronPistolTarget"
        elseif sightd20 > 10 and not onlyFix then
            sights = "Base.IronPistolBasic"
        else
            sights = "Base.IronPistolCombat"
        end
        if sights then
            weapon:attachWeaponPart(instanceItem(sights))
        end
    end
    if weapon:getMagazineType() then
        local magD20 = ZombRand(0,20)
        local gunMag = nil
        if magD20 > 12 then
            gunMag = "Base.1911Mag"
        elseif magD20 > 4 then
            gunMag = "Base.1911MagSS"
        elseif magD20 > 2 then
            gunMag = "Base.1911MagExtend"
        else
            gunMag = "Base.1911MagExtendSS"
        end
        if gunMag then
            weapon:setMagazineType(gunMag)
            AddMagAttachment(weapon, gunMag)
        end
    end
    if not weapon:getWeaponPart("Grip") then
        local d100 = ZombRand(1,100)
        if d100 > 88 then
            stock = "Base.1911GripsGI"
        elseif d100 > 76 then
            stock = "Base.1911GripsRubber"
        elseif d100 > 64 then
            stock = "Base.1911GripsElk"
        elseif d100 > 52 then
            stock = "Base.1911GripsPearl"
        elseif d100 > 40 then
            stock = "Base.1911GripsWrap"
        elseif d100 > 28 then
            stock = "Base.1911GripsMedal"
        elseif d100 > 16 then
            stock = "Base.1911GripsMedal2"
        else
            stock = "Base.1911GripsWood2"
        end
        if stock then
            weapon:attachWeaponPart(instanceItem(stock))
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93Officer = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local Mand100 = ZombRand(0,100)
    local Namd100 = ZombRand(0,100)
    local modelNam = "1911"
    local noPark = false
    local noBlack = false
    local noBlue = false
    local noSS = false
    local onlySS = false
    local noBT = false
    local noFix = false
    local onlyFix = false
    local onlyTar = false
    local onlyNit = false
    local sightPark = false
    local sightBlue = false
    local sightSS = false
    if Mand100 > 55 then
        if Namd100 > 60 then
            modelNam = getText("1991A1") .. getText(" Compact")
            noBlue = true
            noBT = true
            onlyFix = true
        elseif Namd100 > 20 then
            modelNam = getText("Officer ACP")
            noPark = true
        else
            modelNam = getText("Night Officer")
            noPark = true
            onlyNit = true
        end
        weapon:setName(getText("Colt ") .. modelNam .. ammoNam)
    elseif Mand100 > 12 then
        noBT = true
        onlyFix = true
        weapon:setName(getText("Springfield ") .. getText("1911-A1") .. getText(" Compact") .. ammoNam)
    else
        noBT = true
        noSS = true
        onlyFix = true
        weapon:setName(getText("Auto Ordnance ") .. getText("M1911A1") .. getText(" Officer") .. ammoNam)
    end
    local finishD24 = ZombRand(0,24)
    if onlySS then
        weapon:setWeaponSprite("Officer1911SS")
        weapon:setTexture(getTexture("media/textures/item_1911OfficerSS.png"))
        weapon:getModData().Guns93Icon = "1911OfficerSS"
        sightSS = true
    elseif finishD24 > 16 and not noPark then
        weapon:setWeaponSprite("Officer1911Park")
        weapon:setTexture(getTexture("media/textures/item_1911OfficerPark.png"))
        weapon:getModData().Guns93Icon = "1911OfficerPark"
        sightPark = true
    elseif finishD24 > 12 and not noBlack then
        weapon:setWeaponSprite("Officer1911Black")
        weapon:setTexture(getTexture("media/textures/item_1911OfficerBlack.png"))
        weapon:getModData().Guns93Icon = "1911OfficerBlack"
        sightBlue = true
    elseif finishD24 > 8 and not noBlue then
        weapon:setWeaponSprite("Officer1911Blue")
        weapon:setTexture(getTexture("media/textures/item_1911Officer.png"))
        weapon:getModData().Guns93Icon = "1911Officer"
        sightBlue = true
    elseif finishD24 > 5 and not noSS then
        weapon:setWeaponSprite("Officer1911SS")
        weapon:setTexture(getTexture("media/textures/item_1911OfficerSS.png"))
        weapon:getModData().Guns93Icon = "1911OfficerSS"
        sightSS = true
    elseif finishD24 > 2 and not noBT then
        weapon:setWeaponSprite("Officer1911BiToneBlue")
        weapon:setTexture(getTexture("media/textures/item_1911OfficerTwoTone.png"))
        weapon:getModData().Guns93Icon = "1911OfficerTwoTone"
        sightBlue = true
    elseif not noBT then
        weapon:setWeaponSprite("Officer1911BiToneSS")
        weapon:setTexture(getTexture("media/textures/item_1911OfficerTwoTone2.png"))
        weapon:getModData().Guns93Icon = "1911OfficerTwoTone2"
        sightSS = true
    end
    if not weapon:getWeaponPart("Trigger") then
        local d100 = ZombRand(0,100)
        local trigger = nil
        if d100 > 80 then
            trigger = "Base.1911TriggerMatch"
        else
            trigger = "Base.1911Trigger"
        end
        if trigger then
            weapon:attachWeaponPart(instanceItem(trigger))
        end
    end
    if not weapon:getWeaponPart("Irons") then
        local sightd20 = ZombRand(0,20)
        local sights = nil
        if sightd20 > 19 and not (onlyFix or onlyTar) or onlyNit then
            sights = "Base.TritiumSights"
        elseif sightd20 > 13 or onlyFix and not onlyTar then
            if sightPark then
                sights = "Base.1911FixSightsPark"
            elseif sightBlue then
                sights = "Base.1911FixSightsBlue"
            elseif sightSS then
                sights = "Base.1911FixSightsSS"
            end
        elseif sightd20 > 13 and not onlyFix or onlyTar then
            sights = "Base.IronPistolTarget"
        elseif sightd20 > 10 and not onlyFix then
            sights = "Base.IronPistolCombat"
        else
            sights = "Base.IronPistolBasic"
        end
        if sights then
            weapon:attachWeaponPart(instanceItem(sights))
        end
    end
    AddMagAttachment(weapon, nil)
    if not weapon:getWeaponPart("Grip") then
        local d100 = ZombRand(1,100)
        local stock = nil
        if d100 > 86 then
            stock = "Base.OfficerGripsGI"
        elseif d100 > 72 then
            stock = "Base.OfficerGripsRubber"
        elseif d100 > 58 then
            stock = "Base.OfficerGripsElk"
        elseif d100 > 44 then
            stock = "Base.OfficerGripsPearl"
        elseif d100 > 30 then
            stock = "Base.OfficerGripsMedal"
        elseif d100 > 16 then
            stock = "Base.OfficerGripsMedal2"
        elseif d100 > 7 then
            stock = "Base.OfficerGripsWood2"
        else
            stock = "Base.OfficerGripsWood"
        end
        if stock then
            weapon:attachWeaponPart(instanceItem(stock))
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93DeltaElite = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    if not weapon:getWeaponPart("Trigger") then
        local d100 = ZombRand(1,100)
        local trigger = nil
        if d100 == 100 then
            trigger = "Base.1911TriggerMatch"
        else
            trigger = "Base.1911Trigger"
        end
        if trigger then
            weapon:attachWeaponPart(instanceItem(trigger))
        end
    end
    if not weapon:getWeaponPart("Irons") then
        weapon:attachWeaponPart(instanceItem("Base.IronPistolBasic"))
    end
    AddMagAttachment(weapon, nil)
    if not weapon:getWeaponPart("Grip") then
        local gripD10 = ZombRand(1,10)
        local stock = nil
        if gripD10 > 5 then
            stock = "Base.1911GripsDelta"
        else
            stock = "Base.1911GripsWrapDelta"
        end
        if stock then
            weapon:attachWeaponPart(instanceItem(stock))
        end
    end
end

Guns93GunConfig.Guns931911Longslide = function(weapon)
    if not weapon then return end
    if not weapon:getWeaponPart("Trigger") then
        local d100 = ZombRand(0,100)
        local trigger = nil
        if d100 > 70 then
            trigger = "Base.1911TriggerMatch"
        else
            trigger = "Base.1911Trigger"
        end
        if trigger then
            weapon:attachWeaponPart(instanceItem(trigger))
        end
    end
    if not weapon:getWeaponPart("Irons") then
        local sightd20 = ZombRand(0,20)
        local sights = nil
        if sightd20 > 10 then
            sights = "Base.1911FixSightsSS"
        else
            sights = "Base.IronPistolTarget"
        end
        if sights then
            weapon:attachWeaponPart(instanceItem(sights))
        end
    end
    AddMagAttachment(weapon, nil)
    if not weapon:getWeaponPart("Grip") then
        local d100 = ZombRand(0,100)
        local stock = nil
        if d100 > 88 then
            stock = "Base.1911GripsGI"
        elseif d100 > 76 then
            stock = "Base.1911GripsRubber"
        elseif d100 > 64 then
            stock = "Base.1911GripsElk"
        elseif d100 > 52 then
            stock = "Base.1911GripsPearl"
        elseif d100 > 40 then
            stock = "Base.1911GripsWrap"
        elseif d100 > 28 then
            stock = "Base.1911GripsMedal"
        elseif d100 > 16 then
            stock = "Base.1911GripsMedal2"
        elseif d100 > 7 then
            stock = "Base.1911GripsWood2"
        else
            stock = "Base.1911GripsWood"
        end
        if stock then
            weapon:attachWeaponPart(instanceItem(stock))
        end
    end
    local railD20 = ZombRand(0,20)
    local terminator = false
    if railD20 > 14 then
        local rail = nil
        if railD20 > 18 then
            rail = "Base.1911Rail"
        elseif railD20 > 14 then
            rail = "Base.1911RailSS"
            terminator = true
        end
        if rail then
            weapon:attachWeaponPart(instanceItem(rail))
            local scopeD20 = ZombRand(0,20)
            local scope = nil
            if ZombRand(1,5) > 3 and terminator then
                scope = "Base.LaserProd"
            elseif scopeD20 > 28 then
                scope = "Base.CMore"
            elseif scopeD20 > 24 then
                scope = "Base.AccuDot"
            elseif scopeD20 > 19 then
                scope = "Base.x2ScopePistol"
            elseif scopeD20 > 14 then
                scope = "Base.x3ScopePistol"
            elseif scopeD20 > 10 then
                scope = "Base.x4ScopePistol"
            elseif scopeD20 > 6 then
                scope = "Base.AccuDotSilver"
            elseif scopeD20 > 2 then
                scope = "Base.x2ScopePistolSilver"
            elseif scopeD20 > 1 then
                scope = "Base.x3ScopePistolSilver"
            else
                scope = "Base.x4ScopePistolSilver"
            end
            if scope then
                weapon:attachWeaponPart(instanceItem(scope))
            end
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93SW17 = function(weapon)
    if not weapon then return end
    local manNam = getText("S&W ")
    local ammoNam = GetAmmoName(weapon)
    local manNamD10 = ZombRand(0,10)
    if manNamD10 > 5 then
        weapon:setName(manNam .. getText("Model 17 K-22 Masterpiece") .. ammoNam)
        weapon:setWeaponSprite("SW17")
        weapon:setTexture(getTexture("media/textures/item_SW17.png"))
        weapon:getModData().Guns93Icon = "SW17"
    else
        weapon:setName(manNam .. getText("Model 617") .. ammoNam)
        weapon:setWeaponSprite("SW617")
        weapon:setTexture(getTexture("media/textures/item_SW617.png"))
        weapon:getModData().Guns93Icon = "SW617"
    end
    if not weapon:getWeaponPart("Trigger") then
        local d100 = ZombRand(0,100)
        local trigger = nil
        if d100 > 70 then
            trigger = instanceItem("Base.KFrameTriggerMatch")
        else
            trigger = instanceItem("Base.KFrameTrigger")
        end
        if trigger then
            weapon:attachWeaponPart(trigger)
        end
    end
    if not weapon:getWeaponPart("Grip") then
        local gripD25 = ZombRand(0,25)
        local grip = nil
        if gripD25 > 22 then
            grip = instanceItem("Base.KFrameTargetGrip")
        elseif gripD25 > 19 then
            grip = instanceItem("Base.KFrameDarkTargetGrip")
        elseif gripD25 > 16 then
            grip = instanceItem("Base.KFrameRedTargetGrip")
        elseif gripD25 > 14 then
            grip = instanceItem("Base.KFrameServiceGrip")
        elseif gripD25 > 12 then
            grip = instanceItem("Base.KFrameDarkServiceGrip")
        elseif gripD25 > 10 then
            grip = instanceItem("Base.KFrameIvoryServiceGrip")
        elseif gripD25 > 8 then
            grip = instanceItem("Base.KFrameStagServiceGrip")
        elseif gripD25 > 6 then
            grip = instanceItem("Base.KFrameRubberFingerGrip")
        elseif gripD25 > 2 then
            grip = instanceItem("Base.KFrameFingerGrip")
        elseif gripD25 > 0 then
            grip = instanceItem("Base.KFrameDarkFingerGrip")
        else
            grip = instanceItem("Base.KFrameStagTargetGrip")
        end
        weapon:attachWeaponPart(grip)
    end
    if not weapon:getWeaponPart("Irons") then
        local sightD10 = ZombRand(0,10)
        local Irons = nil
        if sightD10 > 6 then
            Irons = instanceItem("Base.IronRevolverBasic")
        elseif sightD10 > 2 then
            Irons = instanceItem("Base.IronRevolverCombat")
        else
            Irons = instanceItem("Base.IronRevolverTarget")
        end
        if irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93JFrame = function(weapon)
    if not weapon then return end
    local manNam = getText("S&W ")
    local gunNam = nil
    local ammoNam = GetAmmoName(weapon)
    local manNamD10 = ZombRand(0,10)
    if manNamD10 > 5 then
        weapon:setName(manNam .. getText("Model 36") .. ammoNam)
        weapon:setWeaponSprite("SW36")
        weapon:setTexture(getTexture("media/textures/item_SW36.png"))
        weapon:getModData().Guns93Icon = "SW36"
    else
        weapon:setName(manNam .. getText("Model 60") .. ammoNam)
        weapon:setWeaponSprite("SW60")
        weapon:setTexture(getTexture("media/textures/item_SW60.png"))
        weapon:getModData().Guns93Icon = "SW60"
    end
    if not weapon:getWeaponPart("Trigger") then
        local d100 = ZombRand(0,100)
        local trigger = nil
        if d100 > 70 then
            trigger = instanceItem("Base.JFrameTriggerMatch")
        else
            trigger = instanceItem("Base.JFrameTrigger")
        end
        if trigger then
            weapon:attachWeaponPart(trigger)
        end
    end
    if not weapon:getWeaponPart("Grip") then
        local gripD25 = ZombRand(0,25)
        local grip = nil
        local service = false
        if gripD25 > 22 then
            grip = instanceItem("Base.JFrameServiceGrip")
            service = true
        elseif gripD25 > 20 then
            grip = instanceItem("Base.JFrameDarkServiceGrip")
            service = true
        elseif gripD25 > 18 then
            grip = instanceItem("Base.JFrameIvoryServiceGrip")
            service = true
        elseif gripD25 > 16 then
            grip = instanceItem("Base.JFrameStagServiceGrip")
            service = true
        elseif gripD25 > 14 then
            grip = instanceItem("Base.JFrameBootGrip")
        elseif gripD25 > 12 then
            grip = instanceItem("Base.JFrameDarkBootGrip")
        elseif gripD25 > 10 then
            grip = instanceItem("Base.JFrameIvoryBootGrip")
        elseif gripD25 > 8 then
            grip = instanceItem("Base.JFrameRubberBootGrip")
        elseif gripD25 > 6 then
            grip = instanceItem("Base.JFrameRubberFingerGrip")
        elseif gripD25 > 2 then
            grip = instanceItem("Base.JFrameFingerGrip")
        else
            grip = instanceItem("Base.JFrameDarkFingerGrip")
        end
        weapon:attachWeaponPart(grip)
        local TgripD10 = ZombRand(0,10)
        local Tgrip = nil
        if service then
            if TgripD10 < 5 then
                if TgripD10 > 3 then
                    Tgrip = instanceItem("Base.TGripBlue")
                elseif TgripD10 > 1 then
                    Tgrip = instanceItem("Base.TGripSS")
                else
                    Tgrip = instanceItem("Base.TGripGold")
                end
            end
        end
        if Tgrip ~= nil then
            weapon:attachWeaponPart(Tgrip)
        end
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93KFrame = function(weapon)
    if not weapon then return end
    local manNam = getText("S&W ")
    local gunNam = nil
    local ammoNam = GetAmmoName(weapon)
    local manNamD10 = ZombRand(0,10)
    if manNamD10 > 5 then
        if weapon:getFullType() == "Base.SW10" then
            gunNam = getText("Model 10")
        elseif weapon:getFullType() == "Base.SW65" then
            gunNam = getText("Model 13")
        end
        weapon:setName(manNam .. gunNam .. ammoNam)
        weapon:setWeaponSprite("SW10")
        weapon:setTexture(getTexture("media/textures/item_SW10.png"))
        weapon:getModData().Guns93Icon = "SW10"
    else
        if weapon:getFullType() == "Base.SW10" then
            gunNam = getText("Model 64")
        elseif weapon:getFullType() == "Base.SW65" then
            gunNam = getText("Model 65")
        end
        weapon:setName(manNam .. gunNam .. ammoNam)
        weapon:setWeaponSprite("SW64")
        weapon:setTexture(getTexture("media/textures/item_SW65.png"))
        weapon:getModData().Guns93Icon = "SW65"
    end
    if not weapon:getWeaponPart("Trigger") then
        local d100 = ZombRand(0,100)
        local trigger = nil
        if d100 > 70 then
            trigger = instanceItem("Base.KFrameTriggerMatch")
        else
            trigger = instanceItem("Base.KFrameTrigger")
        end
        if trigger then
            weapon:attachWeaponPart(trigger)
        end
    end
    if not weapon:getWeaponPart("Grip") then
        local gripD25 = ZombRand(0,25)
        local grip = nil
        local service = false
        if gripD25 > 22 then
            grip = instanceItem("Base.KFrameServiceGrip")
            service = true
        elseif gripD25 > 20 then
            grip = instanceItem("Base.KFrameDarkServiceGrip")
            service = true
        elseif gripD25 > 18 then
            grip = instanceItem("Base.KFrameIvoryServiceGrip")
            service = true
        elseif gripD25 > 16 then
            grip = instanceItem("Base.KFrameStagServiceGrip")
            service = true
        elseif gripD25 > 14 then
            grip = instanceItem("Base.KFrameBootGrip")
        elseif gripD25 > 12 then
            grip = instanceItem("Base.KFrameDarkBootGrip")
        elseif gripD25 > 10 then
            grip = instanceItem("Base.KFrameIvoryBootGrip")
        elseif gripD25 > 8 then
            grip = instanceItem("Base.KFrameRubberBootGrip")
        elseif gripD25 > 6 then
            grip = instanceItem("Base.KFrameRubberFingerGrip")
        elseif gripD25 > 2 then
            grip = instanceItem("Base.KFrameFingerGrip")
        else
            grip = instanceItem("Base.KFrameDarkFingerGrip")
        end
        weapon:attachWeaponPart(grip)
        local TgripD10 = ZombRand(0,10)
        local Tgrip = nil
        if service then
            if TgripD10 < 5 then
                if TgripD10 > 3 then
                    Tgrip = instanceItem("Base.TGripBlue")
                elseif TgripD10 > 1 then
                    Tgrip = instanceItem("Base.TGripSS")
                else
                    Tgrip = instanceItem("Base.TGripGold")
                end
            end
        end
        if Tgrip ~= nil then
            weapon:attachWeaponPart(Tgrip)
        end
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93SW586 = function(weapon)
    if not weapon then return end
    local manNam = getText("S&W ")
    local ammoNam = GetAmmoName(weapon)
    local manNamD10 = ZombRand(0,10)
    if manNamD10 > 5 then
        weapon:setName(manNam .. getText("Model 586") .. ammoNam)
        weapon:setWeaponSprite("SW586")
        weapon:setTexture(getTexture("media/textures/item_SW586.png"))
        weapon:getModData().Guns93Icon = "SW586"
    else
        weapon:setName(manNam .. getText("Model 686") .. ammoNam)
        weapon:setWeaponSprite("SW686")
        weapon:setTexture(getTexture("media/textures/item_SW686.png"))
        weapon:getModData().Guns93Icon = "SW686"
    end
    if not weapon:getWeaponPart("Trigger") then
        local d100 = ZombRand(0,100)
        local trigger = nil
        if d100 > 70 then
            trigger = instanceItem("Base.KFrameTriggerMatch")
        else
            trigger = instanceItem("Base.KFrameTrigger")
        end
        if trigger then
            weapon:attachWeaponPart(trigger)
        end
    end
    if not weapon:getWeaponPart("Grip") then
        local gripD25 = ZombRand(0,25)
        local grip = nil
        if gripD25 > 22 then
            grip = instanceItem("Base.KFrameTargetGrip")
        elseif gripD25 > 19 then
            grip = instanceItem("Base.KFrameDarkTargetGrip")
        elseif gripD25 > 16 then
            grip = instanceItem("Base.KFrameRedTargetGrip")
        elseif gripD25 > 14 then
            grip = instanceItem("Base.KFrameBootGrip")
        elseif gripD25 > 12 then
            grip = instanceItem("Base.KFrameDarkBootGrip")
        elseif gripD25 > 10 then
            grip = instanceItem("Base.KFrameIvoryBootGrip")
        elseif gripD25 > 8 then
            grip = instanceItem("Base.KFrameRubberBootGrip")
        elseif gripD25 > 6 then
            grip = instanceItem("Base.KFrameRubberFingerGrip")
        elseif gripD25 > 2 then
            grip = instanceItem("Base.KFrameFingerGrip")
        elseif gripD25 > 0 then
            grip = instanceItem("Base.KFrameDarkFingerGrip")
        else
            grip = instanceItem("Base.KFrameStagTargetGrip")
        end
        weapon:attachWeaponPart(grip)
    end
    if not weapon:getWeaponPart("Irons") then
        local sightD10 = ZombRand(0,10)
        local Irons = nil
        if sightD10 > 6 then
            Irons = instanceItem("Base.IronRevolverBasic")
        elseif sightD10 > 2 then
            Irons = instanceItem("Base.IronRevolverCombat")
        else
            Irons = instanceItem("Base.RevolverTritiumSights")
        end
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93SW29 = function(weapon)
    if not weapon then return end
    local manNam = getText("S&W ")
    local ammoNam = GetAmmoName(weapon)
    local manNamD10 = ZombRand(0,10)
    if manNamD10 > 5 then
        weapon:setName(manNam .. getText("Model 29") .. ammoNam)
        weapon:setWeaponSprite("SW29")
        weapon:setTexture(getTexture("media/textures/item_SW29.png"))
        weapon:getModData().Guns93Icon = "SW29"
    else
        weapon:setName(manNam .. getText("Model 629") .. ammoNam)
        weapon:setWeaponSprite("SW629")
        weapon:setTexture(getTexture("media/textures/item_SW629.png"))
        weapon:getModData().Guns93Icon = "SW629"
    end
    if not weapon:getWeaponPart("Trigger") then
        local d100 = ZombRand(0,100)
        local trigger = nil
        if d100 > 70 then
            trigger = instanceItem("Base.NFrameTriggerMatch")
        else
            trigger = instanceItem("Base.NFrameTrigger")
        end
        if trigger then
            weapon:attachWeaponPart(trigger)
        end
    end
    if not weapon:getWeaponPart("Grip") then
        local gripD25 = ZombRand(0,25)
        local grip = nil
        if gripD25 > 21 then
            grip = instanceItem("Base.NFrameTargetGrip")
        elseif gripD25 > 17 then
            grip = instanceItem("Base.NFrameDarkTargetGrip")
        elseif gripD25 > 14 then
            grip = instanceItem("Base.NFrameRedTargetGrip")
        elseif gripD25 > 10 then
            grip = instanceItem("Base.NFrameRubberFingerGrip")
        elseif gripD25 > 6 then
            grip = instanceItem("Base.NFrameFingerGrip")
        elseif gripD25 > 2 then
            grip = instanceItem("Base.NFrameDarkFingerGrip")
        else
            grip = instanceItem("Base.NFrameStagTargetGrip")
        end
        weapon:attachWeaponPart(grip)
    end
    if not weapon:getWeaponPart("Irons") then
        local sightD10 = ZombRand(0,10)
        local Irons = nil
        if sightD10 > 7 then
            Irons = instanceItem("Base.IronRevolverBasic")
        elseif sightD10 > 3 then
            Irons = instanceItem("Base.IronRevolverCombat")
        else
            Irons = instanceItem("Base.IronRevolverTarget")
        end
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93SW625 = function(weapon)
    if not weapon then return end
    local manNam = getText("S&W ")
    local ammoNam = GetAmmoName(weapon)
    local manNamD10 = ZombRand(0,10)
    if manNamD10 > 5 then
        weapon:setName(manNam .. getText("Model 25") .. ammoNam)
        weapon:setWeaponSprite("SW25")
        weapon:setTexture(getTexture("media/textures/item_SW25.png"))
        weapon:getModData().Guns93Icon = "SW25"
    else
        weapon:setName(manNam .. getText("Model 625") .. ammoNam)
        weapon:setWeaponSprite("SW625")
        weapon:setTexture(getTexture("media/textures/item_SW625.png"))
        weapon:getModData().Guns93Icon = "SW625"
    end
    if not weapon:getWeaponPart("Trigger") then
        local d100 = ZombRand(0,100)
        local trigger = instanceItem("Base.NFrameTrigger")
        if d100 > 70 then
            trigger = instanceItem("Base.NFrameTriggerMatch")
        else
            trigger = instanceItem("Base.NFrameTrigger")
        end
        if trigger then
            weapon:attachWeaponPart(trigger)
        end
    end
    if not weapon:getWeaponPart("Grip") then
        local gripD25 = ZombRand(0,25)
        local grip = nil
        if gripD25 > 21 then
            grip = instanceItem("Base.NFrameRubberFingerGrip")
        elseif gripD25 > 17 then
            grip = instanceItem("Base.NFrameFingerGrip")
        elseif gripD25 > 14 then
            grip = instanceItem("Base.NFrameDarkFingerGrip")
        elseif gripD25 > 10 then
            grip = instanceItem("Base.NFrameTargetGrip")
        elseif gripD25 > 6 then
            grip = instanceItem("Base.NFrameRedTargetGrip")
        elseif gripD25 > 2 then
            grip = instanceItem("Base.NFrameDarkTargetGrip")
        else
            grip = instanceItem("Base.NFrameStagTargetGrip")
        end
        weapon:attachWeaponPart(grip)
    end
    if not weapon:getWeaponPart("Irons") then
        local sightD10 = ZombRand(0,10)
        local Irons = nil
        if sightD10 > 6 then
            Irons = instanceItem("Base.IronRevolverBasic")
        elseif sightD10 > 2 then
            Irons = instanceItem("Base.IronRevolverCombat")
        else
            Irons = instanceItem("Base.RevolverTritiumSights")
        end
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93Python = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local manNamD10 = ZombRand(0,10)
    if manNamD10 > 5 then
        weapon:setWeaponSprite("Python")
        weapon:setTexture(getTexture("media/textures/item_Python.png"))
        weapon:getModData().Guns93Icon = "Python"
    else
        weapon:setWeaponSprite("PythonSS")
        weapon:setTexture(getTexture("media/textures/item_PythonSS.png"))
        weapon:getModData().Guns93Icon = "PythonSS"
    end
    if not weapon:getWeaponPart("Trigger") then
        local trigger = instanceItem("Base.IFrameTrigger")
        if trigger then
            weapon:attachWeaponPart(trigger)
        end
    end
    if not weapon:getWeaponPart("Grip") then
        local gripD25 = ZombRand(0,25)
        local grip = nil
        if gripD25 > 18 then
            grip = instanceItem("Base.IFrameRubberFingerGrip")
        elseif gripD25 > 14 then
            grip = instanceItem("Base.IFrameRubberGrip")
        elseif gripD25 > 12 then
            grip = instanceItem("Base.IFrameFingerGrip")
        elseif gripD25 > 3 then
            grip = instanceItem("Base.IFramePresGrip")
--        elseif gripD25 > 3 then
--            grip = instanceItem("Base.IFrameDarkPresGrip")
        elseif gripD25 > 2 then
            grip = instanceItem("Base.IFrameStarGrip")
        elseif gripD25 > 1 then
            grip = instanceItem("Base.IFrameIvoryServiceGrip")
        else
            grip = instanceItem("Base.IFrameStagServiceGrip")
        end
        weapon:attachWeaponPart(grip)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.IronRevolverCombat")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93ColtVFrame = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    if not weapon:getWeaponPart("Trigger") then
        local trigger = nil
        if weapon:getFullType() == "Base.Anaconda" then
            trigger = instanceItem("Base.MMFrameTrigger")
        else
            trigger = instanceItem("Base.VFrameTrigger")
        end
        if trigger then
            weapon:attachWeaponPart(trigger)
        end
    end
    if not weapon:getWeaponPart("Grip") then
        local gripD25 = ZombRand(0,25)
        local grip = nil
        if gripD25 > 10 then
            grip = instanceItem("Base.VFrameRubberFingerGrip")
        elseif gripD25 > 7 then
            grip = instanceItem("Base.VFrameFingerGrip")
        elseif gripD25 > 2 then
            grip = instanceItem("Base.VFrameTargetGrip")
--        elseif gripD25 > 3 then
--            grip = instanceItem("Base.VFrameDarkPresGrip")
--        elseif gripD25 > 2 then
--            grip = instanceItem("Base.VFrameStarGrip")
        elseif gripD25 > 1 then
            grip = instanceItem("Base.VFrameIvoryServiceGrip")
        else
            grip = instanceItem("Base.VFrameStagServiceGrip")
        end
        weapon:attachWeaponPart(grip)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.IronRevolverCombat")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93ColtDFrame = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local manNamD10 = ZombRand(0,10)
    if weapon:getFullType() == "Base.ColtDet" then
        if manNamD10 > 2 then
            weapon:setWeaponSprite("ColtDet")
            weapon:setTexture(getTexture("media/textures/item_ColtDet.png"))
            weapon:getModData().Guns93Icon = "ColtDet"
        else
            weapon:setWeaponSprite("ColtDetNickle")
            weapon:setTexture(getTexture("media/textures/item_ColtDetNickel.png"))
            weapon:getModData().Guns93Icon = "ColtDetNickel"
        end
    else
        if manNamD10 > 3 then
            weapon:setWeaponSprite("Diamondback")
            weapon:setTexture(getTexture("media/textures/item_Diamondback.png"))
        weapon:getModData().Guns93Icon = "Diamondback"
        else
            weapon:setWeaponSprite("DiamondbackSS")
            weapon:setTexture(getTexture("media/textures/item_DiamondbackSS.png"))
            weapon:getModData().Guns93Icon = "DiamondbackSS"
        end
    end
    if not weapon:getWeaponPart("Trigger") then
        local trigger = instanceItem("Base.DFrameTrigger")
        if trigger then
            weapon:attachWeaponPart(trigger)
        end
    end
    if not weapon:getWeaponPart("Grip") then
        local gripD25 = ZombRand(0,25)
        local grip = nil
        if gripD25 > 17 then
            grip = instanceItem("Base.DFrameRubberFingerGrip")
        elseif gripD25 > 15 then
            grip = instanceItem("Base.DFrameFingerGrip")
        elseif gripD25 > 6 then
            if weapon:getFullType() == "Base.ColtDet" then
                grip = instanceItem("Base.DFrameCombatGrip")
            else
                grip = instanceItem("Base.DFrameTargetGrip")
            end
        elseif gripD25 > 3 and weapon:getFullType() == "Base.ColtDet" then
            grip = instanceItem("Base.DFrameCompactGrip")
        elseif gripD25 > 2 then
            grip = instanceItem("Base.DFrameStarGrip")
        elseif gripD25 > 1 then
            grip = instanceItem("Base.DFrameIvoryServiceGrip")
        else
            grip = instanceItem("Base.DFrameStagServiceGrip")
        end
        weapon:attachWeaponPart(grip)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = nil
        if weapon:getFullType() == "Base.ColtDet" then
            Irons = instanceItem("Base.NonremoveIrons")
        else
            Irons = instanceItem("Base.IronRevolverBasic")
        end
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93ColtJFrame = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local manNamD10 = ZombRand(0,10)
    if weapon:getFullType() == "Base.ColtTrooper" then
        if manNamD10 > 3 then
            weapon:setWeaponSprite("ColtTrooper")
            weapon:setTexture(getTexture("media/textures/item_ColtTrooper.png"))
            weapon:getModData().Guns93Icon = "ColtTrooper"
        else
            weapon:setWeaponSprite("ColtTrooperNickel")
            weapon:setTexture(getTexture("media/textures/item_ColtTrooperNickel.png"))
            weapon:getModData().Guns93Icon = "ColtTrooperNickel"
        end
    else
        if manNamD10 > 3 then
            weapon:setWeaponSprite("ColtLawman")
            weapon:setTexture(getTexture("media/textures/item_ColtLawman.png"))
            weapon:getModData().Guns93Icon = "ColtLawman"
        else
            weapon:setWeaponSprite("ColtLawmanNickel")
            weapon:setTexture(getTexture("media/textures/item_ColtLawmanNickel.png"))
            weapon:getModData().Guns93Icon = "ColtLawmanNickel"
        end
    end
    if not weapon:getWeaponPart("Trigger") then
        local trigger = instanceItem("Base.ColtJFrameTrigger")
        if trigger then
            weapon:attachWeaponPart(trigger)
        end
    end
    if not weapon:getWeaponPart("Grip") then
        local gripD25 = ZombRand(0,25)
        local grip = nil
--        if gripD25 > 21 then
--            grip = instanceItem("Base.ColtJFrameDarkPresGrip")
        if gripD25 > 17 then
            grip = instanceItem("Base.ColtJFrameRubberGrip")
        elseif gripD25 > 15 then
            grip = instanceItem("Base.ColtJFrameFingerGrip")
        elseif gripD25 > 6 then
            grip = instanceItem("Base.ColtJFramePresGrip")
        elseif gripD25 > 3 then
            grip = instanceItem("Base.ColtJFrameRubberFingerGrip")
        elseif gripD25 > 2 then
            grip = instanceItem("Base.ColtJFrameStarGrip")
        elseif gripD25 > 1 then
            grip = instanceItem("Base.ColtJFrameIvoryServiceGrip")
        else
            grip = instanceItem("Base.ColtJFrameStagServiceGrip")
        end
        weapon:attachWeaponPart(grip)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = nil
        if weapon:getFullType() == "Base.ColtLawman" then
            Irons = instanceItem("Base.NonremoveIrons")
        else
            Irons = instanceItem("Base.IronRevolverBasic")
        end
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93ColtArmy = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local manNamD100 = ZombRand(0,165)
    if manNamD100 > 160 then
        weapon:setWeaponSprite("ColtArmyGold")
        weapon:setTexture(getTexture("media/textures/item_ColtArmyGold.png"))
        weapon:getModData().Guns93Icon = "ColtArmyGold"
    elseif manNamD100 > 140 then
        weapon:setWeaponSprite("ColtArmy")
        weapon:setTexture(getTexture("media/textures/item_ColtArmy.png"))
        weapon:getModData().Guns93Icon = "ColtArmy"
    elseif manNamD100 > 120 then
        weapon:setWeaponSprite("ColtArmyBlue")
        weapon:setTexture(getTexture("media/textures/item_ColtArmyBlue.png"))
        weapon:getModData().Guns93Icon = "ColtArmyBlue"
    elseif manNamD100 > 100 then
        weapon:setWeaponSprite("ColtArmyBlue2")
        weapon:setTexture(getTexture("media/textures/item_ColtArmyBlue.png"))
        weapon:getModData().Guns93Icon = "ColtArmyBlue"
    elseif manNamD100 > 80 then
        weapon:setWeaponSprite("ColtArmyGrey")
        weapon:setTexture(getTexture("media/textures/item_ColtArmyGrey.png"))
        weapon:getModData().Guns93Icon = "ColtArmyGrey"
    elseif manNamD100 > 60 then
        weapon:setWeaponSprite("ColtArmyBiTone")
        weapon:setTexture(getTexture("media/textures/item_ColtArmyBiTone.png"))
        weapon:getModData().Guns93Icon = "ColtArmyBiTone"
    elseif manNamD100 > 45 then
        weapon:setWeaponSprite("ColtArmyCase")
        weapon:setTexture(getTexture("media/textures/item_ColtArmyCase.png"))
        weapon:getModData().Guns93Icon = "ColtArmyCase"
    elseif manNamD100 > 30 then
        weapon:setWeaponSprite("ColtArmyRust")
        weapon:setTexture(getTexture("media/textures/item_ColtArmyRust.png"))
        weapon:getModData().Guns93Icon = "ColtArmyRust"
    elseif manNamD100 > 15 then
        weapon:setWeaponSprite("ColtArmyPit")
        weapon:setTexture(getTexture("media/textures/item_ColtArmyPit.png"))
        weapon:getModData().Guns93Icon = "ColtArmyPit"
    end
    if not weapon:getWeaponPart("Trigger") then
        local trigger = instanceItem("Base.ColtArmyTrigger")
        if trigger then
            weapon:attachWeaponPart(trigger)
        end
    end
    if not weapon:getWeaponPart("Grip") then
        local gripD25 = ZombRand(0,25)
        local grip = nil
        if gripD25 > 20 then
            grip = instanceItem("Base.ColtWalnutGrip")
        elseif gripD25 > 15 then
            grip = instanceItem("Base.ColtDarkWalnutGrip")
        elseif gripD25 > 10 then
            grip = instanceItem("Base.ColtHardRubberGrip")
        elseif gripD25 > 6 then
            grip = instanceItem("Base.ColtStagGrip")
        elseif gripD25 > 3 then
            grip = instanceItem("Base.ColtPearlGrip")
        else
            grip = instanceItem("Base.ColtIvoryGrip")
        end
        weapon:attachWeaponPart(grip)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = nil
        Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93GP100Spawns = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    if not weapon:getWeaponPart("Trigger") then
        local trigger = instanceItem("Base.GP100Trigger")
        if trigger then
            weapon:attachWeaponPart(trigger)
        end
    end
    if not weapon:getWeaponPart("Grip") then
        local gripD100 = ZombRand(0,100)
        local grip = nil
        if gripD100 > 50 then
            grip = instanceItem("Base.GP100GripWood")
        elseif gripD100 > 40 then
            grip = instanceItem("Base.GP100GripBlack")
        elseif gripD100 > 35 then
            grip = instanceItem("Base.GP100CompGripWood")
        elseif gripD100 > 30 then
            grip = instanceItem("Base.GP100CompGripBlack")
        elseif gripD100 > 25 then
            grip = instanceItem("Base.GP100HogueCheck")
        elseif gripD100 > 20 then
            grip = instanceItem("Base.GP100HogueSmooth")
        elseif gripD100 > 15 then
            grip = instanceItem("Base.GP100FingerCheck")
        elseif gripD100 > 10 then
            grip = instanceItem("Base.GP100FingerSmooth")
        elseif gripD100 > 7 then
            grip = instanceItem("Base.GP100HogueRubber")
        elseif gripD100 > 4 then
            grip = instanceItem("Base.GP100FingerRubber")
        elseif gripD100 > 2 then
            grip = instanceItem("Base.GP100WoodGrip")
        else
            grip = instanceItem("Base.GP100RubberGrip")
        end
        weapon:attachWeaponPart(grip)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = nil
        Irons = instanceItem("Base.IronRevolverBasic")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93SP101Spawns = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    if not weapon:getWeaponPart("Trigger") then
        local trigger = instanceItem("Base.SP101Trigger")
        if trigger then
            weapon:attachWeaponPart(trigger)
        end
    end
    if not weapon:getWeaponPart("Grip") then
        local gripD100 = ZombRand(0,100)
        local grip = nil
        if gripD100 > 60 then
            grip = instanceItem("Base.SP101GripBlack")
        elseif gripD100 > 40 then
            grip = instanceItem("Base.SP101GripWood")
        elseif gripD100 > 25 then
            grip = instanceItem("Base.SP101MonogripWood")
        elseif gripD100 > 15 then
            grip = instanceItem("Base.SP101MonogripRubber")
        else
            grip = instanceItem("Base.SP101RubberGrip")
        end
        weapon:attachWeaponPart(grip)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = nil
        Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93SecuritySixSpawns = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local finishD100 = ZombRand(0,100)
    if finishD100 > 30 then
        weapon:setWeaponSprite("SecuritySix")
        weapon:getModData().Guns93Icon = "SecuritySix"
    else
        weapon:setWeaponSprite("SecuritySixSS")
        weapon:setTexture(getTexture("media/textures/item_SecuritySixSS.png"))
        weapon:getModData().Guns93Icon = "SecuritySixSS"
    end
    if not weapon:getWeaponPart("Trigger") then
        local trigger = instanceItem("Base.S6Trigger")
        if trigger then
            weapon:attachWeaponPart(trigger)
        end
    end
    if not weapon:getWeaponPart("Grip") then
        local gripD100 = ZombRand(0,100)
        local grip = nil
        if gripD100 > 70 then
            grip = instanceItem("Base.S6TargetGrips")
        elseif gripD100 > 40 then
            grip = instanceItem("Base.S6ServiceGrips")
        elseif gripD100 > 10 then
            grip = instanceItem("Base.S6RubberGrips")
        elseif gripD100 > 5 then
            grip = instanceItem("Base.S6IvoryGrips")
        else
            grip = instanceItem("Base.S6StagGrips")
        end
        weapon:attachWeaponPart(grip)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = nil
        Irons = instanceItem("Base.IronRevolverCombat")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93BHP = function(weapon)
    if not weapon then return end
    local gunNam = weapon:getDisplayName()
    local ammoNam = GetAmmoName(weapon)
    local nameD100 = ZombRand(0,100)
    local gripD10 = ZombRand(1,10)
    local grip2D10 = ZombRand(1,10)
    local old1 = false
    local old2 = false
    local newGrip = false
    local magSS = false
    local fixSights = false
    if nameD100 > 98 then
        weapon:setName(getText("Browning ") .. getText("Maria ") .. getText("Hi-Power ") .. ammoNam)
        weapon:setWeaponSprite("BHPMaria")
        weapon:setTexture(getTexture("media/textures/Item_BHPMaria.png"))
        weapon:getModData().Guns93Icon = "BHPMaria"
        weapon:attachWeaponPart(instanceItem("Base.BHPFixSightsMaria"))
        fixSights = true
        weapon:attachWeaponPart(instanceItem("Base.BHPGripsMaria"))
    elseif nameD100 > 88 then
        weapon:setName(getText("Inglis ") .. getText("MkI ") .. getText("Hi-Power ") .. ammoNam)
        weapon:setWeaponSprite("BHPOld")
        weapon:setTexture(getTexture("media/textures/Item_BHPInglis.png"))
        weapon:getModData().Guns93Icon = "BHPInglis"
        weapon:attachWeaponPart(instanceItem("Base.BHPFixSightsInglis"))
        fixSights = true
        old2 = true
    elseif nameD100 > 80 then
        weapon:setName(getText("Browning ") .. getText("Hi-Power ") .. getText("Captain ") .. ammoNam)
        weapon:setWeaponSprite("BHPCapt")
        weapon:setTexture(getTexture("media/textures/Item_BHPCapt.png"))
        weapon:getModData().Guns93Icon = "BHPCapt"
        weapon:attachWeaponPart(instanceItem("Base.BHPTagentCapt"))
        fixSights = true
        if grip2D10 > 7 then
            old1 = true
        else
            newGrip = true
        end
    elseif nameD100 > 70 then
        weapon:setName(getText("FN ") .. getText("P35 ") .. getText("Hi-Power ") .. ammoNam)
        weapon:setWeaponSprite("BHPOld")
        weapon:setTexture(getTexture("media/textures/Item_BHPOld.png"))
        weapon:getModData().Guns93Icon = "BHPOld"
        if ZombRand(1,10) > 5 then
            weapon:attachWeaponPart(instanceItem("Base.BHPFixSightsPark"))
        else
            weapon:attachWeaponPart(instanceItem("Base.BHPTagentSights"))
        end
        fixSights = true
        old1 = true
    elseif nameD100 > 60 then
        weapon:setName(getText("FN ") .. getText("MkII ") .. getText("Hi-Power ") .. ammoNam)
        weapon:setWeaponSprite("BHPMk2")
        weapon:setTexture(getTexture("media/textures/Item_BHPMk2.png"))
        weapon:getModData().Guns93Icon = "BHPMk2"
        weapon:attachWeaponPart(instanceItem("Base.BHPFixSightsMk2"))
        fixSights = true
        if gripD10 > 5 then
            weapon:attachWeaponPart(instanceItem("Base.BHPGripsThumb"))
        else
            weapon:attachWeaponPart(instanceItem("Base.BHPGripsPlastic"))
        end
    elseif nameD100 > 48 then
        weapon:setName(getText("FN ") .. getText("MkIII ") .. getText("Hi-Power ") .. ammoNam)
        weapon:setWeaponSprite("BHPMk3")
        weapon:setTexture(getTexture("media/textures/Item_BHPMk3.png"))
        weapon:getModData().Guns93Icon = "BHPMk3"
        if grip2D10 > 7 then
            weapon:attachWeaponPart(instanceItem("Base.BHPGripsThumb"))
        else
            newGrip = true
        end
    elseif nameD100 > 39 then
        weapon:setName(getText("Browning ") .. getText("Hi-Power ") .. ammoNam)
        weapon:setWeaponSprite("BHPChrome")
        weapon:setTexture(getTexture("media/textures/Item_BHPChrome.png"))
        weapon:getModData().Guns93Icon = "BHPChrome"
        magSS = true
        if grip2D10 > 7 then
            old2 = true
        else
            newGrip = true
        end
    elseif nameD100 > 26 then
        weapon:setName(getText("Browning ") .. getText("Hi-Power ") .. ammoNam)
        weapon:setWeaponSprite("BHPBlue")
        weapon:setTexture(getTexture("media/textures/Item_BHPBlue.png"))
        weapon:getModData().Guns93Icon = "BHPBlue"
        fixSights = true
        if grip2D10 > 7 then
            old1 = true
        else
            newGrip = true
        end
    elseif nameD100 > 12 then
        weapon:setName(getText("Browning ") .. getText("Hi-Power ") .. getText("Practical") .. ammoNam)
        weapon:setWeaponSprite("BHPPract")
        weapon:setTexture(getTexture("media/textures/item_BHPPract.png"))
        weapon:getModData().Guns93Icon = "BHPPract"
        magSS = true
        if gripD10 > 6 then
            weapon:attachWeaponPart(instanceItem("Base.BHPGripsThumb"))
        elseif gripD10 > 3 then
            weapon:attachWeaponPart(instanceItem("Base.BHPGripsRubber"))
        else
            weapon:attachWeaponPart(instanceItem("Base.BHPGripsWrap"))
        end
    else
        weapon:setName(getText("Browning ") .. getText("Hi-Power ") .. getText("Standard") .. ammoNam)
        weapon:setWeaponSprite("BHPMk3")
        weapon:setTexture(getTexture("media/textures/Item_BHPStd.png"))
        weapon:getModData().Guns93Icon = "BHPStd"
        if grip2D10 > 7 then
            old1 = true
        else
            newGrip = true
        end
    end
    if old1 then
        if gripD10 > 5 then
            weapon:attachWeaponPart(instanceItem("Base.BHPGripsWood"))
        else
            weapon:attachWeaponPart(instanceItem("Base.BHPGripsLight"))
        end
    elseif old2 then
        if gripD10 > 6 then
            weapon:attachWeaponPart(instanceItem("Base.BHPGripsWood"))
        elseif gripD10 > 3 then
            weapon:attachWeaponPart(instanceItem("Base.BHPGripsLight"))
        else
            weapon:attachWeaponPart(instanceItem("Base.BHPGripsPlastic"))
        end
    elseif newGrip then
        if gripD10 > 6 then
            weapon:attachWeaponPart(instanceItem("Base.BHPGripsCoco"))
        elseif gripD10 > 2 then
            weapon:attachWeaponPart(instanceItem("Base.BHPGripsWalnut"))
        else
            weapon:attachWeaponPart(instanceItem("Base.BHPGripsElk"))
        end
    end
    if not weapon:getWeaponPart("Trigger") then
        local trigger = instanceItem("Base.BHPTrigger")
        weapon:attachWeaponPart(trigger)
    end
    if weapon:getMagazineType() then
        local magD20 = ZombRand(1,20)
        if magD20 > 6 then
            if magSS then
                gunMag = "Base.BHPMagSS"
            else
                gunMag = "Base.BHPMag"
            end
        elseif magD20 > 2 then
            gunMag = "Base.15BHPMag"
        else
            gunMag = "Base.17BHPMag"
        end
        if gunMag then
            weapon:setMagazineType(gunMag)
        end
        AddMagAttachment(weapon, gunMag)
    end
    if not fixSights then
        local Irons = nil
        local ironsD20 = ZombRand(1,20)
        if ironsD20 > 12 then
            Irons = instanceItem("Base.IronPistolTarget")
        elseif ironsD20 > 2 then
            Irons = instanceItem("Base.IronPistolCombat")
        else
            Irons = instanceItem("Base.TritiumSights")
        end
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93M9 = function(weapon)
    if not weapon then return end
    local gunNam = weapon:getDisplayName()
    local ammoNam = GetAmmoName(weapon)
    local manNamD12 = ZombRand(0,12)
    local stainless = false
    if manNamD12 > 4 or weapon:getFullType() == "Base.M9" then
        if weapon:getFullType() == "Base.M9" then
            weapon:setName("Beretta M9" .. ammoNam)
            weapon:getModData().Guns93Icon = "Beretta92Black"
        else
            weapon:setName(gunNam .. ammoNam)
        end
        weapon:setWeaponSprite("M9")
        weapon:setTexture(getTexture("media/textures/Item_Beretta92Black.png"))
        weapon:getModData().Guns93Icon = "Beretta92Black"
    elseif manNamD12 > 1 then
        weapon:setName(gunNam .. getText(" Inox") .. ammoNam)
        weapon:setWeaponSprite("Beretta92Inox")
        weapon:setTexture(getTexture("media/textures/Item_Beretta92Inox.png"))
        weapon:getModData().Guns93Icon = "Beretta92Inox"
        stainless = true
    else
        weapon:setName(gunNam .. getText(" Inox") .. ammoNam)
        weapon:setWeaponSprite("Beretta92Ghost")        
        weapon:setTexture(getTexture("media/textures/Item_Beretta92Ghost.png"))
        weapon:getModData().Guns93Icon = "Beretta92Ghost"
        stainless = true
    end
    if not weapon:getWeaponPart("Trigger") then
        local d100 = ZombRand(0,100)
        local trigger = nil
        if d100 > 70 then
            trigger = instanceItem("Base.M9TriggerMatch")
        else
            trigger = instanceItem("Base.M9Trigger")
        end
        if trigger then
            weapon:attachWeaponPart(trigger)
        end
    end
    if weapon:getMagazineType() then
        local magD20 = ZombRand(0,20)
        local gunMag = nil
        if magD20 > 2 or weapon:getFullType() == "Base.M9" then
            gunMag = "Base.Beretta92Mag"
        else
            gunMag = "Base.20M9Mag"
        end
        if gunMag then
            weapon:setMagazineType(gunMag)
            AddMagAttachment(weapon, gunMag)
        end
    end
    local lightD20 = ZombRand(0,20)
    local gunLight = nil
    if lightD20 > 18 and weapon:getFullType() ~= "Base.M9" then
        gunLight = instanceItem("Base.M9WML")
        gunLight:setCurrentUsesFloat(ZombRand(0, 10)/10);
        weapon:attachWeaponPart(gunLight)
    end
    if not weapon:getWeaponPart("Grip") then
        local gripD25 = ZombRand(0,25)
        local grip = nil
        local service = false
        if gripD25 > 10 or weapon:getFullType() == "Base.M9" and not stainless then
            grip = instanceItem("Base.M9StockGrips")
            service = true
        elseif gripD25 > 8 then
            grip = instanceItem("Base.M9RubberGrips")
            service = true
        elseif gripD25 > 6 then
            grip = instanceItem("Base.M9WrapGrips")
            service = true
        elseif gripD25 > 4 then
            grip = instanceItem("Base.M9WoodGrips")
            service = true
        elseif gripD25 > 2 then
            grip = instanceItem("Base.M9Wood2Grips")
        else
            if ZombRand(0,12) > 9 then
            grip = instanceItem("Base.M9SamEdgeGrips")
            else
            grip = instanceItem("Base.M9PearlGrips")
            end
        end
        weapon:attachWeaponPart(grip)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = nil
        if stainless then
            Irons = instanceItem("Base.M9FixSightsSS")
        else
            local ironsD20 = ZombRand(0,20)
            if ironsD20 > 19 and weapon:getFullType() ~= "Base.M9" then
                Irons = instanceItem("Base.IronPistolTarget")
            elseif ironsD20 > 18 and weapon:getFullType() ~= "Base.M9" then
                Irons = instanceItem("Base.IronPistolCombat")
            else
                Irons = instanceItem("Base.M9FixSights")
            end
        end
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93DE44 = function(weapon)
    if not weapon then return end
    local gunNam = "IMI Desert Eagle"
    local ammoNam = GetAmmoName(weapon)
    local manNamD10 = ZombRand(0,10)
    if manNamD10 > 4 then
        weapon:setName(gunNam .. ammoNam)
        weapon:setWeaponSprite("DE44")
        weapon:setTexture(getTexture("media/textures/Item_DE44.png"))
        weapon:getModData().Guns93Icon = "DE44"
    elseif manNamD10 > 1 then
        weapon:setName(gunNam .. ammoNam)
        weapon:setWeaponSprite("DE44Black")
        weapon:setTexture(getTexture("media/textures/Item_DE44Black.png"))
        weapon:getModData().Guns93Icon = "DE44Black"
    else
        weapon:setName(gunNam .. ammoNam)
        weapon:setWeaponSprite("DE44Gold")        
        weapon:setTexture(getTexture("media/textures/Item_DE44Gold.png"))
        weapon:getModData().Guns93Icon = "DE44Gold"
    end
    if not weapon:getWeaponPart("Trigger") then
        local trigger = instanceItem("Base.DE44Trigger")
        weapon:attachWeaponPart(trigger)
    end
    AddMagAttachment(weapon, nil)
    if not weapon:getWeaponPart("Grip") then
        local gripD25 = ZombRand(0,25)
        local grip = nil
        local service = false
        if gripD25 > 10 then
            grip = instanceItem("Base.DE44RubberGrips")
        elseif gripD25 > 5 then
            grip = instanceItem("Base.DE44WrapGrips")
        elseif gripD25 > 1 then
            grip = instanceItem("Base.DE44WoodGrips")
        else
            grip = instanceItem("Base.DE44PearlGrips")
        end
        weapon:attachWeaponPart(grip)
    end
    if not weapon:getWeaponPart("Reciever") then
        local rail = instanceItem("Base.NonremovePistolRail")
        weapon:attachWeaponPart(rail)
    end
    if not weapon:getWeaponPart("Irons") then
        Irons = instanceItem("Base.IronPistolBasic")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93M16Military = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local d12 = ZombRand(0,12)
    local M16A1 = false
    if d12 > 4 then
        weapon:setName(getText("Colt ") .. getText("M16A2") .. ammoNam)
        weapon:setWeaponSprite("AR15A2Gray")
        weapon:setTexture(getTexture("media/textures/item_AR15A2Gray.png"))
        weapon:getModData().Guns93Icon = "AR15A2Gray"
    elseif d12 > 2 then
        weapon:setName(getText("FN ") .. getText("M16A2") .. ammoNam)
        weapon:setWeaponSprite("AR15A2Black")
        weapon:setTexture(getTexture("media/textures/item_AR15A2Black.png"))
        weapon:getModData().Guns93Icon = "AR15A2Black"
    else
        weapon:setName(getText("Colt ") .. getText("M16A1") .. ammoNam)
        weapon:setWeaponSprite("AR15A1Gray")
        weapon:setTexture(getTexture("media/textures/item_AR15A1Gray.png"))
        weapon:getModData().Guns93Icon = "AR15A1Gray"
        M16A1 = true
    end
    if not weapon:getWeaponPart("Trigger") then
        if M16A1 then
            weapon:attachWeaponPart(instanceItem("Base.M16Trigger"))
        else
            weapon:attachWeaponPart(instanceItem("Base.M16A2Trigger"))
        end
    end
    AddMagAttachment(weapon, nil)
    weapon:attachWeaponPart(instanceItem("Base.BarrelThread"))
    if not weapon:getWeaponPart("Buttstock") then
        local stock = instanceItem("Base.A2Stock")
        weapon:attachWeaponPart(stock)
    end
    if M16A1 then
        if not weapon:getWeaponPart("Handguard") then
            local Handguard = instanceItem("Base.A1Handguard")
            weapon:attachWeaponPart(Handguard)
        end
        if not weapon:getWeaponPart("Grip") then
            local Grip = instanceItem("Base.A1PistolGrip")
            weapon:attachWeaponPart(Grip)
        end
        if not weapon:getWeaponPart("Canon") then
            local Canon = instanceItem("Base.A1FlashHider")
            weapon:attachWeaponPart(Canon)
        end
    else
        if not weapon:getWeaponPart("Handguard") then
            local Handguard = instanceItem("Base.A2Handguard")
            weapon:attachWeaponPart(Handguard)
        end
        if not weapon:getWeaponPart("Grip") then
            local Grip = instanceItem("Base.A2PistolGrip")
            weapon:attachWeaponPart(Grip)
        end
        if not weapon:getWeaponPart("Canon") then
            local Canon = instanceItem("Base.A2FlashHider")
            weapon:attachWeaponPart(Canon)
        end
    end
    if ZombRand(0,10) > 8 then
        local scope = nil
        local d5 = ZombRand(0,5)
        if d5 > 3 then
            scope = instanceItem("Base.x3Handle")
        elseif d5 > 2 then
            scope = instanceItem("Base.x4Handle")
        elseif d5 > 1 then
            scope = instanceItem("Base.ArmsonM16")
        else
            scope = instanceItem("Base.x4ACOG")
        end
        weapon:attachWeaponPart(scope)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    if ZombRand(0,6) > 3 then
        local bayoD5 = ZombRand(0,6)
        if bayoD5 > 3 then
            weapon:attachWeaponPart(instanceItem("Base.M9BayonetPart"))
        else
            weapon:attachWeaponPart(instanceItem("Base.M7BayonetPart"))
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93HBARMilitary = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local d10 = ZombRand(0,10)
    local riser = false
    local tube = false
    if d10 > 4 then
        weapon:setName(getText("Colt ") .. getText("AR-15") .. getText(" HBAR") .. ammoNam)
        weapon:setWeaponSprite("HBAR")
        weapon:setTexture(getTexture("media/textures/item_HBAR.png"))
        weapon:getModData().Guns93Icon = "HBAR"
        riser = true
    else
        weapon:setName(getText("Olympic Arms ") .. getText("UltraMatch") .. ammoNam)
        weapon:setWeaponSprite("UltraMatch")
        weapon:setTexture(getTexture("media/textures/item_UltraMatch.png"))
        weapon:getModData().Guns93Icon = "UltraMatch"
        tube = true
    end
    if not weapon:getWeaponPart("Trigger") then
        weapon:attachWeaponPart(instanceItem("Base.AR15MatchTrigger"))
    end
    AddMagAttachment(weapon, nil)
    weapon:attachWeaponPart(instanceItem("Base.BarrelThread"))
    if not weapon:getWeaponPart("Buttstock") then
        local stock = instanceItem("Base.A2Stock")
        weapon:attachWeaponPart(stock)
    end
    if not weapon:getWeaponPart("Handguard") then
        local handguardD10 = ZombRand(0,10)
        local Handguard = nil
        if handguardD10 > 5 and tube then
            Handguard = instanceItem("Base.ARTube")
        else
            Handguard = instanceItem("Base.A2Handguard")
        end
        weapon:attachWeaponPart(Handguard)
    end
    if not weapon:getWeaponPart("Grip") then
        local Grip = instanceItem("Base.A2PistolGrip")
        weapon:attachWeaponPart(Grip)
    end
    if not weapon:getWeaponPart("Canon") then
        local Canon = instanceItem("Base.A2FlashHider")
        weapon:attachWeaponPart(Canon)
    end
    local scope = nil
    local d3 = ZombRand(1,4)
    local rail = instanceItem("Base.M16Mount")
    weapon:attachWeaponPart(rail)
    local scoped10 = ZombRand(0,10)
    if scoped10 > 7 then
        scope = instanceItem("Base.x6Scope")
    elseif scoped10 > 4 then
        scope = instanceItem("Base.x8Scope")
    elseif scoped10 > 1 then
        scope = instanceItem("Base.x10Scope")
    else
        scope = instanceItem("Base.ARTScope")
    end
    if riser then
        weapon:attachWeaponPart(instanceItem("Base.ARRiser"))
    end
    weapon:attachWeaponPart(scope)
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    if ZombRand(1,10) < 6 then
        weapon:attachWeaponPart(instanceItem("Base.RifleBipod"))
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93M16CarbineMilitary = function(weapon)
    if not weapon then return end
    local gordy = false
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    if ZombRand(0,10) > 8 then
        if weapon:getFullType() == "Base.M733" then
        weapon:setWeaponSprite("M733Camo")
        elseif weapon:getFullType() == "Base.M723" then
        weapon:setWeaponSprite("M723Camo")
        elseif weapon:getFullType() == "Base.M727" then
        weapon:setWeaponSprite("M727Camo")
        end
        weapon:setTexture(getTexture("media/textures/item_CAR15Camo.png"))
        weapon:getModData().Guns93Icon = "CAR15Camo"
        gordy = true
    end
    if not weapon:getWeaponPart("Trigger") then
        weapon:attachWeaponPart(instanceItem("Base.M16Trigger"))
    end
    AddMagAttachment(weapon, nil)
    weapon:attachWeaponPart(instanceItem("Base.BarrelThread"))
    if not gordy then
        if not weapon:getWeaponPart("Stock") then
            local stock = instanceItem("Base.CAR15StockIn")
            weapon:attachWeaponPart(stock)
        end
        if not weapon:getWeaponPart("Handguard") then
            local Handguard = instanceItem("Base.CAR15Handguard")
            weapon:attachWeaponPart(Handguard)
        end
        if not weapon:getWeaponPart("Grip") then
            local Grip = instanceItem("Base.A2PistolGrip")
            weapon:attachWeaponPart(Grip)
        end
    else
        if not weapon:getWeaponPart("Stock") then
            local stock = instanceItem("Base.CAR15StockInCamo")
            weapon:attachWeaponPart(stock)
        end
        if not weapon:getWeaponPart("Handguard") then
            local Handguard = instanceItem("Base.CAR15HandguardCamo")
            weapon:attachWeaponPart(Handguard)
        end
        if not weapon:getWeaponPart("Grip") then
            local Grip = instanceItem("Base.A2PistolGripCamo")
            weapon:attachWeaponPart(Grip)
        end
    end
    local scope = nil
    local railD3 = ZombRand(1,10)
    if railD3 > 8 or gordy then
        local rail = instanceItem("Base.M16Mount")
        weapon:attachWeaponPart(rail)
        scope = instanceItem("Base.RedDot")
        weapon:attachWeaponPart(scope)
    end
    if ZombRand(0,10) > 8 or gordy then
        local gunLight = instanceItem("Base.GunLight")
        gunLight:setCurrentUsesFloat(ZombRand(0, 10)/10);
        weapon:attachWeaponPart(gunLight)
    end
    if ZombRand(0,10) > 8 or gordy then
        if weapon:getFullType() == "Base.M733" then
            weapon:attachWeaponPart(instanceItem("Base.556Silencer"))
        else
            weapon:attachWeaponPart(instanceItem("Base.556SilencerCollar"))
            weapon:attachWeaponPart(instanceItem("Base.556ReflexCan"))
        end
    elseif not weapon:getWeaponPart("Canon") then
        local Canon = nil
        if weapon:getFullType() == "Base.M727" then
            Canon = instanceItem("Base.A2FlashHider")
        else
            Canon = instanceItem("Base.A1FlashHider")
        end
        weapon:attachWeaponPart(Canon)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93M169mm = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    if not weapon:getWeaponPart("Trigger") then
        if weapon:getFullType() == "Base.Colt9mm" then
            weapon:attachWeaponPart(instanceItem("Base.AR15Trigger"))
        else
            weapon:attachWeaponPart(instanceItem("Base.M16Trigger"))
        end
    end
    AddMagAttachment(weapon, nil)
    weapon:attachWeaponPart(instanceItem("Base.BarrelThread"))
    if not weapon:getWeaponPart("Buttstock") then
        local stock = nil
        if ZombRand(1,10) > 5 and weapon:getFullType() == "Base.Colt9mm" then
            stock = instanceItem("Base.A2Stock")
        else
            stock = instanceItem("Base.CAR15StockIn")
        end
        weapon:attachWeaponPart(stock)
    end
    if not weapon:getWeaponPart("Handguard") then
        local Handguard = instanceItem("Base.CAR15Handguard")
        weapon:attachWeaponPart(Handguard)
    end
    if not weapon:getWeaponPart("Grip") then
        local Grip = instanceItem("Base.A2PistolGrip")
        weapon:attachWeaponPart(Grip)
    end
    if not weapon:getWeaponPart("Canon") then
        local Canon = instanceItem("Base.9mmFlashHider")
        weapon:attachWeaponPart(Canon)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        weapon:getModData().Guns93Icon = "M635"
    end
end

Guns93GunConfig.Guns93AR15Rifle = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local d100 = ZombRand(0,100)
    local A2 = false
    local Gray = false
    local Black = false
    local Tube = false
    local Color = false
    if d100 > 70 then
        weapon:setName(getText("Colt ") .. getText("AR-15")  .. ammoNam)
        weapon:setTexture(getTexture("media/textures/item_AR15A1Gray.png"))
        weapon:getModData().Guns93Icon = "AR15A1Gray"
        Gray = true
    elseif d100 > 50 then
        weapon:setName(getText("Bushmaster ") .. getText("XM15") .. ammoNam)
        weapon:setTexture(getTexture("media/textures/item_AR15A2Gray.png"))
        weapon:getModData().Guns93Icon = "AR15A2Gray"
        A2 = true
    elseif d100 > 30 then
        weapon:setName(getText("Olympic Arms ") .. getText("MFR") .. ammoNam)
        weapon:setTexture(getTexture("media/textures/item_AR15A2Tube.png"))
        weapon:getModData().Guns93Icon = "AR15A2Tube"
        A2 = true
        Black = true
        Tube = true
    elseif d100 > 20 then
        weapon:setName(getText("DPMS ") .. getText("A-15") .. ammoNam)
        weapon:setTexture(getTexture("media/textures/item_AR15A2Tube.png"))
        weapon:getModData().Guns93Icon = "AR15A2Tube"
        A2 = true
        Black = true
        Tube = true
    elseif d100 > 15 then
        weapon:setName(getText("Sendra Corp. ") .. getText("XM15") .. ammoNam)
        weapon:setTexture(getTexture("media/textures/item_AR15A1Black.png"))
        weapon:getModData().Guns93Icon = "AR15A1Black"
        A2 = true
        Black = true
        Gray = true
        Tube = true
        Color = true
    else
        weapon:setName(getText("PWA ") .. getText("Commando") .. ammoNam)
        weapon:setTexture(getTexture("media/textures/item_AR15A1Black.png"))
        weapon:getModData().Guns93Icon = "AR15A1Black"
        A2 = true
        Black = true
        Gray = true
        Tube = true
        Color = true
    end
    local styleD20 = ZombRand(0,120)
    if styleD20 > 15 and A2 and Gray then
        weapon:setWeaponSprite("AR15A2Gray")
    elseif styleD20 > 10 and Black then
        weapon:setWeaponSprite("AR15A1Black")
    elseif styleD20 > 5 and A2 and Black then
        weapon:setWeaponSprite("AR15A2Black")
    else
        weapon:setWeaponSprite("AR15A1Gray")
    end
    if not weapon:getWeaponPart("Trigger") then
        local d100 = ZombRand(0,100)
        local trigger = nil
        if d100 > 99 then
            trigger = instanceItem("Base.M16Trigger")
        elseif d100 > 80 then
            trigger = instanceItem("Base.AR15MatchTrigger")
        else
            trigger = instanceItem("Base.AR15Trigger")
        end
        weapon:attachWeaponPart(trigger)
    end
    if weapon:getMagazineType() then
        local magD40 = ZombRand(0,40)
        local gunMag = nil
        if magD40 > 18 then
            gunMag = "Base.20M16Mag"
        elseif magD40 > 8 then
            gunMag = "Base.TherARMag"
        elseif magD40 > 1 then
            gunMag = "Base.M16Mag"
        else
            gunMag = "Base.BetaCMag"
        end
        if gunMag then
            weapon:setMagazineType(gunMag)
            AddMagAttachment(weapon, gunMag)
        end
    end
    local stock = nil
    local Handguard = nil
    local Grip = nil
    local Canon = nil
    local FurType = ZombRand(0,100)
    local FurType2 = ZombRand(0,8)
    local threading = instanceItem("Base.BarrelThread")
    weapon:attachWeaponPart(threading)
    if FurType > 40 and Color then
        if FurType2 > 6 then
            stock = instanceItem("Base.A2StockGray")
            Handguard = instanceItem("Base.A1HandguardGray")
            Grip = instanceItem("Base.A1PistolGripGray")
        elseif FurType2 > 4 then
            stock = instanceItem("Base.A2StockGray")
            Handguard = instanceItem("Base.A2HandguardGray")
            Grip = instanceItem("Base.A2PistolGripGray")
        elseif FurType2 > 2 then
            stock = instanceItem("Base.A2StockGreen")
            Handguard = instanceItem("Base.A1HandguardGreen")
            Grip = instanceItem("Base.A1PistolGripGreen")
        else
            stock = instanceItem("Base.A2StockGreen")
            Handguard = instanceItem("Base.A2HandguardGreen")
            Grip = instanceItem("Base.A2PistolGripGreen")
        end
    elseif FurType > 20 and Tube then
        stock = instanceItem("Base.A2Stock")
        Handguard = instanceItem("Base.ARTube")
        Grip = instanceItem("Base.A1PistolGrip")
    else
        if FurType2 > 4 then
            stock = instanceItem("Base.A2Stock")
            Handguard = instanceItem("Base.A1Handguard")
            Grip = instanceItem("Base.A1PistolGrip")
        else
            stock = instanceItem("Base.A2Stock")
            Handguard = instanceItem("Base.A2Handguard")
            Grip = instanceItem("Base.A2PistolGrip")
        end
    end
    weapon:attachWeaponPart(stock)
    weapon:attachWeaponPart(Handguard)
    weapon:attachWeaponPart(Grip)
    if ZombRand(2) == 1 then
        Canon = instanceItem("Base.A1FlashHider")
    else
        Canon = instanceItem("Base.A2FlashHider")
    end
    weapon:attachWeaponPart(Canon)
    if ZombRand(0,10) > 8 then
        local scope = nil
        local d5 = ZombRand(1,5)
        if d5 == 0 then
            scope = instanceItem("Base.x4ACOG")
        elseif d5 == 1 then
            scope = instanceItem("Base.ArmsonM16")
        elseif d5 == 2 then
            scope = instanceItem("Base.x3Handle")
        elseif d5 == 3 then
            scope = instanceItem("Base.x4Handle")
        elseif d5 == 4 then
            local rail = instanceItem("Base.M16Mount")
            weapon:attachWeaponPart(rail)
            local d6 = ZombRand(0,6)
            if d6 > 5 then
                scope = instanceItem("Base.x6Scope")
            elseif d6 > 4 then
                scope = instanceItem("Base.CMore")
            elseif d6 > 3 then
                scope = instanceItem("Base.AccuDot")
            elseif d6 > 2 then
                scope = instanceItem("Base.AccuDotSilver")
            else
                scope = instanceItem("Base.x3Scope")
            end
        end
        weapon:attachWeaponPart(scope)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        weapon:getModData().Guns93Icon = "AR15A1Gray"
    end
end

Guns93GunConfig.Guns93CAR15 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local d100 = ZombRand(0,100)
    local A2 = false
    local Gray = false
    local Black = false
    local Tube = false
    local Color = false
    if d100 > 70 then
        weapon:setName(getText("Colt ") .. getText("AR-15A2") .. getText(" Carbine") .. ammoNam)
        weapon:setTexture(getTexture("media/textures/item_CAR15A2Gray.png"))
        weapon:getModData().Guns93Icon = "CAR15A2Gray"
        Gray = true
    elseif d100 > 50 then
        weapon:setName(getText("Bushmaster ") .. getText("XM15") .. getText(" Carbine") .. ammoNam)
        weapon:setTexture(getTexture("media/textures/item_CAR15A2Gray.png"))
        weapon:getModData().Guns93Icon = "CAR15A2Gray"
        A2 = true
    elseif d100 > 30 then
        weapon:setName(getText("Olympic Arms ") .. getText("MFR") .. getText(" Carbine") .. ammoNam)
        weapon:setTexture(getTexture("media/textures/item_CAR15A2Tube.png"))
        weapon:getModData().Guns93Icon = "CAR15A2Tube"
        A2 = true
        Black = true
        Tube = true
    elseif d100 > 20 then
        weapon:setName(getText("DPMS ") .. getText("A-15") .. getText(" Carbine") .. ammoNam)
        weapon:setTexture(getTexture("media/textures/item_CAR15A2Tube.png"))
        weapon:getModData().Guns93Icon = "CAR15A2Tube"
        A2 = true
        Black = true
        Tube = true
    elseif d100 > 15 then
        weapon:setName(getText("Sendra Corp. ") .. getText("XM15") .. getText(" Carbine") .. ammoNam)
        weapon:setTexture(getTexture("media/textures/item_CAR15Gray.png"))
        weapon:getModData().Guns93Icon = "CAR15Gray"
        A2 = true
        Black = true
        Gray = true
        Tube = true
        Color = true
    else
        weapon:setName(getText("PWA ") .. getText("Commando") .. getText(" Carbine") .. ammoNam)
        weapon:setTexture(getTexture("media/textures/item_CAR15Green.png"))
        weapon:getModData().Guns93Icon = "CAR15Green"
        A2 = true
        Black = true
        Gray = true
        Tube = true
        Color = true
    end
    local styleD20 = ZombRand(0,120)
    if styleD20 > 15 and A2 and Gray then
        weapon:setWeaponSprite("CAR15Gray")
    elseif styleD20 > 10 and Black then
        weapon:setWeaponSprite("CAR15A1Black")
    elseif styleD20 > 5 and A2 and Black then
        weapon:setWeaponSprite("CAR15Black")
    else
        weapon:setWeaponSprite("CAR15A1Gray")
    end
    if not weapon:getWeaponPart("Trigger") then
        local d100 = ZombRand(0,100)
        local trigger = nil
        if d100 > 99 then
            trigger = instanceItem("Base.M16Trigger")
        elseif d100 > 80 then
            trigger = instanceItem("Base.AR15MatchTrigger")
        else
            trigger = instanceItem("Base.AR15Trigger")
        end
        weapon:attachWeaponPart(trigger)
    end
    if weapon:getMagazineType() then
        local magD40 = ZombRand(0,40)
        local gunMag = nil
        if magD40 > 18 then
            gunMag = "Base.20M16Mag"
        elseif magD40 > 8 then
            gunMag = "Base.TherARMag"
        elseif magD40 > 1 then
            gunMag = "Base.M16Mag"
        else
            gunMag = "Base.BetaCMag"
        end
        if gunMag then
            weapon:setMagazineType(gunMag)
            AddMagAttachment(weapon, gunMag)
        end
    end
    local stock = nil
    local Handguard = nil
    local Grip = nil
    local Canon = nil
    local FurType = ZombRand(0,100)
    local FurType2 = ZombRand(0,8)
    local stockType = ZombRand(0,10)
    local threading = instanceItem("Base.BarrelThread")
    weapon:attachWeaponPart(threading)
    if FurType > 40 and Color then
        if FurType2 > 6 then
            if stockType > 5 then
                stock = instanceItem("Base.A2StockGray")
            else
                stock = instanceItem("Base.CAR15StockInGray")
            end
            Handguard = instanceItem("Base.A1CARHandguardGray")
            Grip = instanceItem("Base.A1PistolGripGray")
        elseif FurType2 > 4 then
            if stockType > 5 then
            stock = instanceItem("Base.A2StockGray")
            else
                stock = instanceItem("Base.CAR15StockInGray")
            end
            Handguard = instanceItem("Base.CAR15HandguardGray")
            Grip = instanceItem("Base.A2PistolGripGray")
        elseif FurType2 > 2 then
            if stockType > 5 then
            stock = instanceItem("Base.A2StockGreen")
            else
                stock = instanceItem("Base.CAR15StockInGreen")
            end
            Handguard = instanceItem("Base.A1CARHandguardGreen")
            Grip = instanceItem("Base.A1PistolGripGreen")
        else
            if stockType > 5 then
                stock = instanceItem("Base.A2StockGreen")
            else
                stock = instanceItem("Base.CAR15StockInGreen")
            end
            Handguard = instanceItem("Base.CAR15HandguardGreen")
            Grip = instanceItem("Base.A2PistolGripGreen")
        end
    elseif FurType > 20 and Tube then
        if stockType > 5 then
            stock = instanceItem("Base.A2Stock")
        else
            stock = instanceItem("Base.CAR15StockIn")
        end
        Handguard = instanceItem("Base.ARCARTube")
        Grip = instanceItem("Base.A1PistolGrip")
    else
        if FurType2 > 4 then
            if stockType > 5 then
                stock = instanceItem("Base.A2Stock")
            else
                stock = instanceItem("Base.CAR15StockIn")
            end
            Handguard = instanceItem("Base.A1CARHandguard")
            Grip = instanceItem("Base.A1PistolGrip")
        else
            if stockType > 5 then
                stock = instanceItem("Base.A2Stock")
            else
                stock = instanceItem("Base.CAR15StockIn")
            end
            Handguard = instanceItem("Base.CAR15Handguard")
            Grip = instanceItem("Base.A2PistolGrip")
        end
    end
    weapon:attachWeaponPart(stock)
    weapon:attachWeaponPart(Handguard)
    weapon:attachWeaponPart(Grip)
    if ZombRand(2) == 1 then
        Canon = instanceItem("Base.A1FlashHider")
    else
        Canon = instanceItem("Base.A2FlashHider")
    end
    weapon:attachWeaponPart(Canon)
    if ZombRand(0,10) > 8 then
        local scope = nil
        local d5 = ZombRand(1,5)
        if d5 == 0 then
            scope = instanceItem("Base.x4ACOG")
        elseif d5 == 1 then
            scope = instanceItem("Base.ArmsonM16")
        elseif d5 == 2 then
            scope = instanceItem("Base.x3Handle")
        elseif d5 == 3 then
            scope = instanceItem("Base.x4Handle")
        elseif d5 == 4 then
            local rail = instanceItem("Base.M16Mount")
            weapon:attachWeaponPart(rail)
            local d6 = ZombRand(0,6)
            if d6 > 5 then
                scope = instanceItem("Base.x4Scope")
            elseif d6 > 4 then
                scope = instanceItem("Base.CMore")
            elseif d6 > 3 then
                scope = instanceItem("Base.AccuDot")
            elseif d6 > 2 then
                scope = instanceItem("Base.AccuDotSilver")
            else
                scope = instanceItem("Base.x3Scope")
            end
        end
        weapon:attachWeaponPart(scope)
    end
    if ZombRand(0,10) > 8 then
        local gunLight = instanceItem("Base.GunLight")
        gunLight:setCurrentUsesFloat(ZombRand(0, 10)/10);
        weapon:attachWeaponPart(gunLight)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        weapon:getModData().Guns93Icon = "CAR15Gray"
    end
end

Guns93GunConfig.Guns93Dissy = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local d100 = ZombRand(0,100)
    weapon:setName(getText("Bushmaster ") .. getText("XM15") .. getText(" Dissipator") .. ammoNam)
    if not weapon:getWeaponPart("Trigger") then
        local d100 = ZombRand(0,100)
        local trigger = nil
        if d100 > 99 then
            trigger = instanceItem("Base.M16Trigger")
        elseif d100 > 80 then
            trigger = instanceItem("Base.AR15MatchTrigger")
        else
            trigger = instanceItem("Base.AR15Trigger")
        end
        weapon:attachWeaponPart(trigger)
    end
    if weapon:getMagazineType() then
        local magD40 = ZombRand(0,40)
        local gunMag = nil
        if magD40 > 18 then
            gunMag = "Base.20M16Mag"
        elseif magD40 > 8 then
            gunMag = "Base.TherARMag"
        elseif magD40 > 1 then
            gunMag = "Base.M16Mag"
        else
            gunMag = "Base.BetaCMag"
        end
        if gunMag then
            weapon:setMagazineType(gunMag)
            AddMagAttachment(weapon, gunMag)
        end
    end
    local stock = nil
    local Handguard = nil
    local Grip = nil
    local Canon = nil
    local FurType = ZombRand(0,100)
    local FurType2 = ZombRand(0,8)
    local stockType = ZombRand(0,10)
    local threading = instanceItem("Base.BarrelThread")
    weapon:attachWeaponPart(threading)
    if FurType2 > 4 then
        if stockType > 5 then
            stock = instanceItem("Base.A2Stock")
        else
            stock = instanceItem("Base.CAR15StockIn")
        end
        Handguard = instanceItem("Base.A1Handguard")
        Grip = instanceItem("Base.A1PistolGrip")
    else
        if stockType > 5 then
            stock = instanceItem("Base.A2Stock")
        else
            stock = instanceItem("Base.CAR15StockIn")
        end
        Handguard = instanceItem("Base.A2Handguard")
        Grip = instanceItem("Base.A2PistolGrip")
    end
    weapon:attachWeaponPart(stock)
    weapon:attachWeaponPart(Handguard)
    weapon:attachWeaponPart(Grip)
    if ZombRand(2) == 1 then
        Canon = instanceItem("Base.A1FlashHider")
    else
        Canon = instanceItem("Base.A2FlashHider")
    end
    weapon:attachWeaponPart(Canon)
    if ZombRand(0,10) > 8 then
        local scope = nil
        local railD3 = ZombRand(1,10)
        if railD3 > 8 then
            local rail = instanceItem("Base.M16Mount")
            weapon:attachWeaponPart(rail)
            local d4 = ZombRand(0,5)
            if d4 > 4 then
                scope = instanceItem("Base.CMore")
            elseif d4 > 2 then
                scope = instanceItem("Base.AccuDot")
            elseif d4 > 1 then
                scope = instanceItem("Base.AccuDotSilver")
            else
                scope = instanceItem("Base.x3Scope")
            end
        end
        weapon:attachWeaponPart(scope)
    end
    if ZombRand(0,10) > 8 then
        local gunLight = instanceItem("Base.GunLight")
        gunLight:setCurrentUsesFloat(ZombRand(0, 10)/10);
        weapon:attachWeaponPart(gunLight)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        weapon:getModData().Guns93Icon = "Dissy"
    end
end

Guns93GunConfig.Guns93GreaseGun = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local modelD100 = ZombRand(0,100)
    AddMagAttachment(weapon, nil)
    if modelD100 > 60 then
        weapon:setName("GM M3A1 Grease Gun" .. ammoNam)
        weapon:setWeaponSprite("M3A1GreaseGun")
        if not weapon:getWeaponPart("Stock") then
            local stock = instanceItem("Base.A1GreaseGunStockIn")
            weapon:attachWeaponPart(stock)
        end
    else
        weapon:setName("GM M3 Grease Gun" .. ammoNam)
        weapon:setWeaponSprite("M3GreaseGun")
        if not weapon:getWeaponPart("Stock") then
            local stock = instanceItem("Base.GreaseGunStockIn")
            weapon:attachWeaponPart(stock)
        end
        if not weapon:getWeaponPart("Receiver") then
            local stock = instanceItem("Base.M3Lever")
            weapon:attachWeaponPart(stock)
        end
        if ZombRand(0,50) > 25 then
            if not weapon:getWeaponPart("Canon") then
                local stock = instanceItem("Base.M3FlashCone")
                weapon:attachWeaponPart(stock)
            end
        end
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        weapon:getModData().Guns93Icon = "M3GreaseGun"
    end
end

Guns93GunConfig.Guns93TommySpawns = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local manfacD60 = ZombRand(0,60)
    local manfac = ""
    local suffix = ""
    local drum = false
    local colt = false
    if manfacD60 > 35 then
        manfac = "Auto-Ordnance "
    elseif manfacD60 > 10 or weapon:getFullType() == "Base.TommyM1A1" then
        manfac = "Savage Arms "
    else
        manfac = "Colt "
        colt = true
    end
    if not weapon:getWeaponPart("Stock") then
        local stock = nil
        if weapon:getFullType() == "Base.TommyM1928" or colt then
            stock = instanceItem("Base.TommyM1928Stock")
        else
            stock = instanceItem("Base.TommyM1A1Stock")
        end
        weapon:attachWeaponPart(stock)
    end
    if not weapon:getWeaponPart("Handguard") then
        local foregrip = nil
        if weapon:getFullType() == "Base.TommyM1928" then
            if ZombRand(0,50) > 25 then
                foregrip = instanceItem("Base.TommyVertGrip")
                weapon:setWeaponSprite("TommyM1928Fins")
                weapon:setTexture(getTexture("media/textures/item_TommyM1928Drum.png"))
                weapon:getModData().Guns93Icon = "TommyM1928Drum"
                drum = true
            else
                foregrip = instanceItem("Base.TommyHandguard")
                weapon:setTexture(getTexture("media/textures/item_TommyM1928.png"))
                weapon:getModData().Guns93Icon = "TommyM1928"
            end
        else
            foregrip = instanceItem("Base.TommyHandguard")
            weapon:setTexture(getTexture("media/textures/item_TommyM1A1.png"))
            weapon:getModData().Guns93Icon = "TommyM1A1"
        end
        weapon:attachWeaponPart(foregrip)
    end
    if not weapon:getWeaponPart("Irons") then
        local irons = nil
        if weapon:getFullType() == "Base.TommyM1928" or colt then
            if ZombRand(0,50) > 25 or colt then
                irons = instanceItem("Base.TommyLymanSight")
            else
                irons = instanceItem("Base.TommyLSight")
                suffix = "A1"
            end
        else
            if ZombRand(0,50) > 25 then
                irons = instanceItem("Base.TommyLSight")
            else
                irons = instanceItem("Base.TommyM1A1Sight")
                suffix = "A1"
            end
        end
        weapon:attachWeaponPart(irons)
    end
    if not weapon:getWeaponPart("Canon") then
        local canon = nil
        if not colt and weapon:getFullType() ~= "Base.TommyM1A1" then
            canon = instanceItem("Base.CuttsComp")
        end
        if canon then
            weapon:attachWeaponPart(canon)
        end
    end
    if not weapon:getWeaponPart("Clip") then
        local mag = nil
        if drum then
            mag = "Base.TommyDrum"
        elseif ZombRand(0,50) > 30 then
            mag = "Base.20TommyMag"
        else
            mag = "Base.30TommyMag"
        end
        if mag then
            weapon:attachWeaponPart(instanceItem(mag))
        end
        AddMagAttachment(weapon, mag)
    end
    if not weapon:getWeaponPart("Trigger") then
        local trigger = nil
        trigger = instanceItem("Base.TommyTrigger")
        weapon:attachWeaponPart(trigger)
    end
    local model = ""
    if colt then
        model = "M1921"
    else
        model = weapon:getName()
    end
    weapon:setName(manfac .. model .. suffix .. " Thompson".. ammoNam)
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        weapon:getModData().Guns93Icon = "TommyM1928"
    end
end

Guns93GunConfig.Guns93HK91Spawns = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local manfac = nil
    if ZombRand(0,50) > 25 then
        manfac = getText("Springfield SAR-8")
    else
        manfac = weapon:getName()
    end
    weapon:setName(manfac .. ammoNam)
    local threading = instanceItem("Base.BarrelThread")
    weapon:attachWeaponPart(threading)
    local black = false
    local green = false
    local wood = false
    local bipod = false
    local fold = false
    if not weapon:getWeaponPart("Handguard") then
        local foregripD100 = ZombRand(0,100)
        local Handguard = nil
        if foregripD100 > 65 then
            Handguard = instanceItem("Base.HK91Handguard")
            black = true
            bipod = true
        elseif foregripD100 > 55 then
            Handguard = instanceItem("Base.HK91GreenHandguard")
            green = true
            bipod = true
        elseif foregripD100 > 45 then
            Handguard = instanceItem("Base.HK91Round")
            black = true
        elseif foregripD100 > 35 then
            Handguard = instanceItem("Base.HK91Wood")
            wood = true
        else
            Handguard = instanceItem("Base.HK91GreenRound")
            green = true
        end
        weapon:attachWeaponPart(Handguard)
    end
    if not weapon:getWeaponPart("Stock") then
    local d4 = ZombRand(0,5)
    local stock = nil
        if d4 < 2 then
            stock = instanceItem("Base.HK91RetractStock")
            if green then
                weapon:setTexture(getTexture("media/textures/item_HK91GreenFold.png"))
                weapon:getModData().Guns93Icon = "HK91GreenFold"
            else
                weapon:setTexture(getTexture("media/textures/item_HK91Fold.png"))
                weapon:getModData().Guns93Icon = "HK91Fold"
            end
            fold = true
        elseif black then
            stock = instanceItem("Base.HK91Stock")
            weapon:setTexture(getTexture("media/textures/item_HK91.png"))
            weapon:getModData().Guns93Icon = "HK91"
        elseif green then
            stock = instanceItem("Base.HK91GreenStock")
            weapon:setTexture(getTexture("media/textures/item_HK91Green.png"))
            weapon:getModData().Guns93Icon = "HK91Green"
        elseif wood then
            stock = instanceItem("Base.HK91WoodStock")
            weapon:setTexture(getTexture("media/textures/item_HK91Wood.png"))
            weapon:getModData().Guns93Icon = "HK91Wood"
        end
        weapon:attachWeaponPart(stock)
    end
    if not weapon:getWeaponPart("Canon") then
        local canon = instanceItem("Base.HK91FlashHider")
        weapon:attachWeaponPart(canon)
    end
    if not weapon:getWeaponPart("Grip") then
        local lower = nil
        if black or wood then
            lower = instanceItem("Base.HK91Lower")
        else
            lower = instanceItem("Base.HK91GreenLower")
        end
        weapon:attachWeaponPart(lower)
    end
    if not weapon:getWeaponPart("HandguardItem") and bipod and ZombRand(0,50) > 25 then
        local getBipod = instanceItem("Base.HKBipod")
        weapon:attachWeaponPart(getBipod)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    if not weapon:getWeaponPart("Clip") then
        local mag = "Base.HK91Mag"
        if mag then
            weapon:attachWeaponPart(instanceItem(mag))
        end
        AddMagAttachment(weapon, mag)
    end
    weapon:attachWeaponPart(instanceItem("Base.HKTrigger"))
    local opticD10 = ZombRand(0,10)
    local scoped39 = ZombRand(0,39)
    local mount = false
    local scope = nil
    if opticD10 > 7 then
        mount = true
        if scoped39 > 34 then
            scope = "Base.AccuDot"
        elseif scoped39 > 29 then
            scope = "Base.AccuDotSilver"
        elseif scoped39 > 24 then
            scope = "Base.x3Scope"
        elseif scoped39 > 19 then
            scope = "Base.x4Scope"
        elseif scoped39 > 15 then
            scope = "Base.x6Scope"
        elseif scoped39 > 11 then
            scope = "Base.x8Scope"
        elseif scoped39 > 7 then
            scope = "Base.x10Scope"
        elseif scoped39 > 4 then
            scope = "Base.x3ScopeSilver"
        elseif scoped39 > 3 then
            scope = "Base.x4ScopeSilver"
        elseif scoped39 > 2 then
            scope = "Base.x6ScopeSilver"
        elseif scoped39 > 1 then
            scope = "Base.x8ScopeSilver"
        else
            scope = "Base.x10ScopeSilver"
        end
    elseif opticD10 > 5 then
        mount = true
        scope = "Base.RedDot"
    end
    if mount then
        weapon:attachWeaponPart(instanceItem("Base.HKClaw"))
    end
    if scope and not fold then
        weapon:attachWeaponPart(instanceItem(scope))
        if ZombRand(0,50) > 25 then
            weapon:attachWeaponPart(instanceItem("Base.HKCheekRest"))
        end
    end
    if not weapon:getWeaponPart("Receiver2") and not sport and ZombRand(0,40) > 25 then
        weapon:attachWeaponPart(instanceItem("Base.HKCarryHandle"))
    end
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        weapon:getModData().Guns93Icon = "HK91"
    end
end

Guns93GunConfig.Guns93HKSR9Spawns = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local black = false
    local green = false
    local woood = false
    local sar8 = false
    local bipod = false
    local manfac = nil
    if not weapon:getWeaponPart("Handguard") then
        local foregripD100 = ZombRand(0,100)
        local Handguard = nil
        if foregripD100 > 70 then
            Handguard = instanceItem("Base.HK91Handguard")
            black = true
            bipod = true
            sar8 = true
        elseif foregripD100 > 40 then
            Handguard = instanceItem("Base.HK91Round")
            black = true
            sar8 = true
        elseif foregripD100 > 10 then
            Handguard = instanceItem("Base.SR9Handguard")
            black = true
        else
            Handguard = instanceItem("Base.SR9BakHandguard")
            wood = true
        end
        weapon:attachWeaponPart(Handguard)
    end
    if sar8 then
        manfac = getText("Springfield SAR-8")
    else
        manfac = weapon:getName()
        weapon:setWeaponSprite("HKSR9")
    end
    if manfac then
        weapon:setName(manfac .. ammoNam)
    end
    if not weapon:getWeaponPart("Stock") then
    local d4 = ZombRand(0,5)
    local stock = nil
        if black then
            if sar8 then
                stock = instanceItem("Base.SAR8Stock")
            else
                stock = instanceItem("Base.SR9Stock")
            end
            weapon:setTexture(getTexture("media/textures/item_SR9.png"))
            weapon:getModData().Guns93Icon = "SR9"
        elseif wood then
            stock = instanceItem("Base.SR9BakStock")
            weapon:setTexture(getTexture("media/textures/item_SR9Bak.png"))
            weapon:getModData().Guns93Icon = "SR9Bak"
        end
        weapon:attachWeaponPart(stock)
    end
    if sar8 and not weapon:getWeaponPart("Canon") then
        local canon = instanceItem("Base.SAR8FlashHider")
        weapon:attachWeaponPart(canon)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    if not weapon:getWeaponPart("Clip") then
        local mag = nil
        if sport and ZombRand(0,30) > 10 then
            if ZombRand(0,50) > 25 then
                mag = "Base.HK915Mag"
            else
                mag = "Base.HK9110Mag"
            end
        else
            mag = "Base.HK91Mag"
        end
        if mag then
            weapon:attachWeaponPart(instanceItem(mag))
        end
        AddMagAttachment(weapon, mag)
    end
    weapon:attachWeaponPart(instanceItem("Base.HKTrigger"))
    local opticD10 = ZombRand(0,10)
    local scoped39 = ZombRand(0,39)
    local mount = false
    local scope = nil
    if opticD10 > 7 then
        mount = true
        if scoped39 > 34 then
            scope = "Base.AccuDot"
        elseif scoped39 > 29 then
            scope = "Base.AccuDotSilver"
        elseif scoped39 > 24 then
            scope = "Base.x3Scope"
        elseif scoped39 > 19 then
            scope = "Base.x4Scope"
        elseif scoped39 > 15 then
            scope = "Base.x6Scope"
        elseif scoped39 > 11 then
            scope = "Base.x8Scope"
        elseif scoped39 > 7 then
            scope = "Base.x10Scope"
        elseif scoped39 > 4 then
            scope = "Base.x3ScopeSilver"
        elseif scoped39 > 3 then
            scope = "Base.x4ScopeSilver"
        elseif scoped39 > 2 then
            scope = "Base.x6ScopeSilver"
        elseif scoped39 > 1 then
            scope = "Base.x8ScopeSilver"
        else
            scope = "Base.x10ScopeSilver"
        end
    elseif opticD10 > 5 then
        mount = true
        scope = "Base.RedDot"
    end
    if mount then
        weapon:attachWeaponPart(instanceItem("Base.HKClaw"))
    end
    if scope then
        weapon:attachWeaponPart(instanceItem(scope))
        if ZombRand(0,50) > 25 then
            weapon:attachWeaponPart(instanceItem("Base.HKCheekRest"))
        end
    end
    if bipod and not weapon:getWeaponPart("HandguardItem") and ZombRand(0,50) > 25 then
        local getBipod = instanceItem("Base.HKBipod")
        weapon:attachWeaponPart(getBipod)
    end
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        weapon:getModData().Guns93Icon = "SR9"
    end
end

Guns93GunConfig.Guns93HK93Spawns = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    local threading = instanceItem("Base.BarrelThread")
    weapon:attachWeaponPart(threading)
    local fold = false
    if not weapon:getWeaponPart("Handguard") then
        local handguard = nil
        if ZombRand(0,50) > 45 then
            handguard = instanceItem("Base.HK93Round")
        else
            handguard = instanceItem("Base.HK93Handguard")
        end
        if handguard then
            weapon:attachWeaponPart(handguard)
        end
    end
    if not weapon:getWeaponPart("Stock") then
    local d4 = ZombRand(0,5)
    local stock = nil
        if d4 < 2 then
            stock = instanceItem("Base.HK93RetractStock")
            fold = true
            weapon:setTexture(getTexture("media/textures/item_HK93Fold.png"))
            weapon:getModData().Guns93Icon = "HK93Fold"
        else
            stock = instanceItem("Base.HK93Stock")
            weapon:setTexture(getTexture("media/textures/item_HK93.png"))
            weapon:getModData().Guns93Icon = "HK93"
        end
        weapon:attachWeaponPart(stock)
    end
    if not weapon:getWeaponPart("Canon") then
        local canon = instanceItem("Base.HK91FlashHider")
        weapon:attachWeaponPart(canon)
    end
    if not weapon:getWeaponPart("Grip") then
        local lower = instanceItem("Base.HK94Lower")
        weapon:attachWeaponPart(lower)
    end
    if not weapon:getWeaponPart("HandguardItem") and ZombRand(0,50) > 25 then
        local getBipod = instanceItem("Base.HKBipod")
        weapon:attachWeaponPart(getBipod)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    if not weapon:getWeaponPart("Clip") then
        local mag = nil
        local magD50 = ZombRand(0,50)
        if magD50 > 40 then
            mag = "Base.40HK93Mag"
        elseif magD50 > 30 then
            mag = "Base.25HK93Mag"
        else
            mag = "Base.HK93Mag"
        end
        if mag then
            weapon:attachWeaponPart(instanceItem(mag))
        end
        AddMagAttachment(weapon, mag)
    end
    weapon:attachWeaponPart(instanceItem("Base.HKTrigger"))
    local opticD10 = ZombRand(0,10)
    local scoped39 = ZombRand(0,39)
    local mount = false
    local scope = nil
    if opticD10 > 7 then
        mount = true
        if scoped39 > 34 then
            scope = "Base.AccuDot"
        elseif scoped39 > 29 then
            scope = "Base.AccuDotSilver"
        elseif scoped39 > 24 then
            scope = "Base.x3Scope"
        elseif scoped39 > 19 then
            scope = "Base.x4Scope"
        elseif scoped39 > 15 then
            scope = "Base.x6Scope"
        elseif scoped39 > 11 then
            scope = "Base.x8Scope"
        elseif scoped39 > 7 then
            scope = "Base.x10Scope"
        elseif scoped39 > 4 then
            scope = "Base.x3ScopeSilver"
        elseif scoped39 > 3 then
            scope = "Base.x4ScopeSilver"
        elseif scoped39 > 2 then
            scope = "Base.x6ScopeSilver"
        elseif scoped39 > 1 then
            scope = "Base.x8ScopeSilver"
        else
            scope = "Base.x10ScopeSilver"
        end
    elseif opticD10 > 5 then
        mount = true
        scope = "Base.RedDot"
    end
    if mount then
        weapon:attachWeaponPart(instanceItem("Base.HKClaw"))
    end
    if scope and not fold then
        weapon:attachWeaponPart(instanceItem(scope))
        if ZombRand(0,50) > 25 then
            weapon:attachWeaponPart(instanceItem("Base.HKCheekRest"))
        end
    end
    if not weapon:getWeaponPart("Receiver2") and not sport and ZombRand(0,40) > 25 then
        weapon:attachWeaponPart(instanceItem("Base.HKCarryHandle"))
    end
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        weapon:getModData().Guns93Icon = "HK93"
    end
end

Guns93GunConfig.Guns93MP5Spawns = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local old = false
    local auto = false
    local navy = false
    local light = false
    local fixStock = false
    local itemID = weapon:getFullType()
    if not weapon:getWeaponPart("Stock") then
    local d4 = ZombRand(1,5)
    local stock = nil
        if d4 == 1 then
            stock = instanceItem("Base.MP5RetractStock")
        else
            stock = instanceItem("Base.MP5Stock")
            fixStock = true
        end
        weapon:attachWeaponPart(stock)
    end
    if not weapon:getWeaponPart("Handguard") and itemID ~= "Base.MP5SD" then
        local handguard = nil
        if ZombRand(0,50) > 40 and itemID == "Base.MP5" or itemID == "Base.HK94" then
            handguard = instanceItem("Base.MP5Round")
            old = true
        elseif ZombRand(0,50) > 30 then
            handguard = instanceItem("Base.MP5ForendLight")
            light = true
        else
            handguard = instanceItem("Base.MP5Handguard")
        end
        if handguard then
            weapon:attachWeaponPart(handguard)
        end
    end
    if not weapon:getWeaponPart("Grip") then
        local grip = nil
        if itemID == "Base.HK94" then
            grip = instanceItem("Base.HK94Lower")
        elseif old then
            grip = instanceItem("Base.MP5Lower")
            auto = true
        elseif itemID == "Base.MP510" or itemID == "Base.MP540" or ZombRand(0,50) > 20 then
            grip = instanceItem("Base.MP5SEFLower")
            auto = true
        else
            grip = instanceItem("Base.MP5NavyLower")
            navy = true
        end
        if grip then
            weapon:attachWeaponPart(grip)
        end
    end
    if not weapon:getWeaponPart("Trigger") then
        local trigger = nil
        if itemID == "Base.HK94" then
            trigger = instanceItem("Base.HKTrigger")
        elseif itemID == "Base.MP5" or itemID == "Base.MP5SD" then
            if auto then
                trigger = instanceItem("Base.HKAutoTrigger")
                auto = true
            elseif navy then
                trigger = instanceItem("Base.HKBurstTrigger")
            end
        elseif itemID == "Base.MP510" or itemID == "Base.MP540" then
            if ZombRand(0,50) > 25 then
                trigger = instanceItem("Base.HKBurst2Trigger")
            else
                trigger = instanceItem("Base.HKAutoTrigger")
            end
        end
        if trigger then
            weapon:attachWeaponPart(trigger)
        end
    end
    if not weapon:getWeaponPart("Clip") then
        local mag = nil
        if itemID == "Base.MP5" or itemID == "Base.MP5SD" then
            if old then
                mag = "Base.MP5StraightMag"
            else
                mag = "Base.MP5Mag"
            end
        elseif itemID == "Base.HK94" then
            local magD50 = ZombRand(0,50)
            if magD50 > 30 then
                mag = "Base.MP5Mag"
            elseif magD50 > 10 then
                mag = "Base.15MP5Mag"
            else
                mag = "Base.40MP5Mag"
            end
        elseif itemID == "Base.MP510" then
            mag = "Base.MP5Mag10mm"
        elseif itemID == "Base.MP540" then
            mag = "Base.MP5Mag40SW"
        end
        if mag then
            weapon:attachWeaponPart(instanceItem(mag))
        end
        AddMagAttachment(weapon, mag)
    end
    if not old and itemID ~= "Base.HK94" and itemID ~= "Base.MP5SD" then
        local threading = instanceItem("Base.BarrelThread")
        weapon:attachWeaponPart(threading)
    end
    if not weapon:getWeaponPart("Magwell") and itemID ~= "Base.HK94" then
        local release = instanceItem("Base.HKMagRelease")
        if release then
            weapon:attachWeaponPart(release)
        end
    end
    if not weapon:getWeaponPart("QDMount") and itemID ~= "Base.HK94" and itemID ~= "Base.MP5SD" then
        local triLug = instanceItem("Base.MP5TriLug")
        if triLug then
            weapon:attachWeaponPart(triLug)
        end
    end
    if not weapon:getWeaponPart("BarrelItem") and itemID == "Base.HK94" and ZombRand(0,50) > 40 then
        local shroud = instanceItem("Base.HK94BarrelShroud")
        if shroud then
            weapon:attachWeaponPart(shroud)
        end
    end
    if not weapon:getWeaponPart("Cannon") and itemID ~= "Base.HK94" then
        local canon = nil
        local canonD50 = ZombRand(0,50)
        if itemID == "Base.MP5SD" then
            canon = instanceItem("Base.MP5SDSilencer")
        elseif canonD50 > 40 then
            canon = instanceItem("Base.MP5FlashHider")
        elseif canonD50 > 30 and not light then
            if itemID == "Base.MP5" then
                canon = instanceItem("Base.9mmTriLugSilencer")
            elseif itemID == ("Base.MP540" or "Base.MP510") then
                canon = instanceItem("Base.40TriLugSilencer")
            end
        end
        if canon then
            weapon:attachWeaponPart(canon)
        end
    end
    local model = ""
    if itemID == "Base.HK94" then
        if fixStock then
            weapon:setTexture(getTexture("media/textures/item_HK94.png"))
            weapon:getModData().Guns93Icon = "HK94"
        else
            weapon:setTexture(getTexture("media/textures/item_HK94Fold.png"))
            weapon:getModData().Guns93Icon = "HK94Fold"
        end
    elseif itemID == "Base.MP510" or itemID == "Base.MP540" then
        if fixStock then
            model = "A2"
            weapon:setTexture(getTexture("media/textures/item_MP510.png"))
            weapon:getModData().Guns93Icon = "MP510"
        else
            model = "A3"
            weapon:setTexture(getTexture("media/textures/item_MP510Fold.png"))
            weapon:getModData().Guns93Icon = "MP510Fold"
        end
    elseif auto and fixStock then
        if itemID == "Base.MP5SD" then
            model = "2"
            weapon:setTexture(getTexture("media/textures/item_MP5SD.png"))
            weapon:getModData().Guns93Icon = "MP5SD"
        else
            model = "A2"
            weapon:setTexture(getTexture("media/textures/item_MP5.png"))
            weapon:getModData().Guns93Icon = "MP5"
        end
    elseif auto and not fixStock then
        if itemID == "Base.MP5SD" then
            model = "3"
            weapon:setTexture(getTexture("media/textures/item_MP5SDFold.png"))
            weapon:getModData().Guns93Icon = "MP5SDFold"
        else
            model = "A3"
            weapon:setTexture(getTexture("media/textures/item_MP5Fold.png"))
            weapon:getModData().Guns93Icon = "MP5Fold"
        end
    elseif navy and fixStock then
        if itemID == "Base.MP5SD" then
            model = "5"
            weapon:setTexture(getTexture("media/textures/item_MP5SD.png"))
            weapon:getModData().Guns93Icon = "MP5SD"
        else
            model = "A4"
            weapon:setTexture(getTexture("media/textures/item_MP5.png"))
            weapon:getModData().Guns93Icon = "MP5"
        end
    elseif navy and not fixStock then
        if itemID == "Base.MP5SD" then
            model = "6"
            weapon:setTexture(getTexture("media/textures/item_MP5SDFold.png"))
            weapon:getModData().Guns93Icon = "MP5SDFold"
        else
            model = "A5"
            weapon:setTexture(getTexture("media/textures/item_MP5Fold.png"))
            weapon:getModData().Guns93Icon = "MP5Fold"
        end
    end
    if ZombRand(0,10) > 8 then
        local scope = nil
        local rail = instanceItem("Base.HKClaw")
        weapon:attachWeaponPart(rail)
        local d40 = ZombRand(0,40)
        if old and ZombRand(0,50) > 25 then
            scope = instanceItem("Base.MountedHandTorch")
        elseif d40 > 30 then
            scope = instanceItem("Base.RedDot")
        elseif d40 > 20 then
            scope = instanceItem("Base.CMore")
        elseif d40 > 10 then
            scope = instanceItem("Base.AccuDot")
        else
            scope = instanceItem("Base.AccuDotSilver")
        end
        if scope then
            weapon:attachWeaponPart(scope)
        end
    end
    if model ~= "" then
        weapon:setName(weapon:getName() .. model .. ammoNam)
    end
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        weapon:getModData().Guns93Icon = "MP5"
    end
end

Guns93GunConfig.Guns93AR180Spawns = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local d10 = ZombRand(0,10)
    if d10 > 4 then
        weapon:setName(getText("Sterling ") .. getText("AR-180")  .. ammoNam)
    elseif d10 > 2 then
        weapon:setName(getText("Howa ") .. getText("AR-180") .. ammoNam)
    else
        weapon:setName(getText("ArmaLite ") .. getText("AR-180") .. ammoNam)
    end
    local threading = instanceItem("Base.BarrelThread")
    weapon:attachWeaponPart(threading)
    AddMagAttachment(weapon, nil)
    if not weapon:getWeaponPart("Stock") then
        local stock = instanceItem("Base.AR180StockIn")
        weapon:attachWeaponPart(stock)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    weapon:attachWeaponPart(instanceItem("Base.AR180Trigger"))
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        weapon:getModData().Guns93Icon = "AR180"
    end
end

Guns93GunConfig.Guns93ValmetSpawns = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    AddMagAttachment(weapon, nil)
    if not weapon:getWeaponPart("Stock") then
        local stock = instanceItem("Base.ValmetStockIn")
        weapon:attachWeaponPart(stock)
    end
    if not weapon:getWeaponPart("Canon") then
        local Canon = instanceItem("Base.ValmetFlashHider")
        weapon:attachWeaponPart(Canon)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    local d100 = ZombRand(0,100)
    local trigger = nil
    if d100 > 98 then
        trigger = instanceItem("Base.AKAutoTrigger")
    else
        trigger = instanceItem("Base.AKTrigger")
    end
    weapon:attachWeaponPart(trigger)
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        weapon:getModData().Guns93Icon = "Valmet"
    end
end

Guns93GunConfig.Guns93AKMSpawns = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local underfold = false
    local milled = false
    local FEG = false
    local Maadi = false
    local Clayco = false
    local AKS = false
    local bake = false
    local EG = false
    local namd100 = ZombRand(0,100)
    if namd100 > 90 and weapon:getFullType() ~= "Base.T56" then
        if weapon:getFullType() == "Base.AKSport" then
            weapon:setName(getText("Norinco ") .. getText("MAK-90") .. ammoNam)
            weapon:setTexture(getTexture("media/textures/item_AKMAK90Poly.png"))
            weapon:getModData().Guns93Icon = "AKMAK90Poly"
        else
            weapon:setName(getText("Clayco ") .. getText("AKS-762") .. ammoNam)
            weapon:setTexture(getTexture("media/textures/item_AKSPoly.png"))
            weapon:getModData().Guns93Icon = "AKSPoly"
        end
        Clayco = true
    elseif namd100 > 70 and weapon:getFullType() ~= "Base.T56" then
        if weapon:getFullType() == "Base.AKSport" then
            weapon:setName(getText("FEG SA-85M") .. getText(" Sporter") .. ammoNam)
            weapon:setTexture(getTexture("media/textures/item_AKSA85Sport.png"))
            weapon:getModData().Guns93Icon = "AKSA85Sport"
        else
            weapon:setName(getText("FEG SA-85M") .. ammoNam)
            weapon:setTexture(getTexture("media/textures/item_AKSA85.png"))
            weapon:getModData().Guns93Icon = "AKSA85"
        end
        FEG = true
    elseif namd100 > 50 and weapon:getFullType() ~= "Base.T56" then
        if weapon:getFullType() == "Base.AKSport" then
            weapon:setName(getText("Maadi ARM") .. getText(" Sporter") .. ammoNam)
            weapon:setTexture(getTexture("media/textures/item_AKMaadiSport.png"))
            weapon:getModData().Guns93Icon = "AKMaadiSport"
        else
            weapon:setName(getText("Maadi ARM") .. ammoNam)
            weapon:setTexture(getTexture("media/textures/item_AKM.png"))
            weapon:getModData().Guns93Icon = "AKM"
        end
        Maadi = true
    elseif namd100 > 10 or weapon:getFullType() == "Base.AKSport" or weapon:getFullType() == "Base.T56" then
        if weapon:getFullType() == "Base.AKSport" then
            weapon:setName(getText("Norinco ") .. getText("MAK-90") .. ammoNam)
            weapon:setTexture(getTexture("media/textures/item_AKMAK90.png"))
            weapon:getModData().Guns93Icon = "AKMAK90"
            if namd100 > 30 then
                AKS = true
            else
                milled = true
            end
        else
            weapon:setName(getText("PolyTech ") .. getText("AKS-762") .. ammoNam)
            AKS = true
        end
    else
        weapon:setName(getText("PolyTech ") .. getText("AK-47/S Legend") .. ammoNam)
        weapon:setTexture(getTexture("media/textures/item_AK47.png"))
        weapon:getModData().Guns93Icon = "AK47"
        milled = true
    end
    local d100 = ZombRand(0,100)
    local trigger = nil
    if d100 > 98 and weapon:getFullType() ~= "Base.AKSport" then
        trigger = instanceItem("Base.AKAutoTrigger")
    else
        trigger = instanceItem("Base.AKTrigger")
    end
    weapon:attachWeaponPart(trigger)
    local typed100 = ZombRand(0,100)
    if typed100 > 60 and not (AKS or Clayco or milled) and weapon:getFullType() ~= "Base.AKSport" then
        weapon:setWeaponSprite("AKMS")
        underfold = true
    elseif not AKS and not Clayco and not milled then
        if weapon:getFullType() == "Base.AKSport" then
            weapon:setWeaponSprite("AKMSport")
        else
            weapon:setWeaponSprite("AKM")
        end
    elseif typed100 > 70 and (AKS or Clayco) and weapon:getFullType() ~= "Base.AKSport" then
        if weapon:getFullType() == "Base.T56" then
            weapon:setWeaponSprite("T56Folder")
        else
            weapon:setWeaponSprite("AKSFolder")
        end
        underfold = true
    elseif typed100 > 60 and milled and weapon:getFullType() ~= "Base.AKSport" then
        weapon:setWeaponSprite("AKSFolderMilled")
        underfold = true
    elseif AKS or Clayco then
        if weapon:getFullType() == "Base.AKSport" then
            weapon:setWeaponSprite("AKSSport")
        elseif weapon:getFullType() == "Base.T56" then
            weapon:setWeaponSprite("T56")
        else
            weapon:setWeaponSprite("AKS")
        end
    elseif milled then
        if weapon:getFullType() == "Base.AKSport" then
            weapon:setWeaponSprite("AKSMilledSport")
        else
            weapon:setWeaponSprite("AKSMilled")
        end
    end
    if weapon:getMagazineType() then
        local magD20 = ZombRand(0,20)
        local gunMag = nil
        if weapon:getFullType() == "Base.AKSport" then
            gunMag = "Base.AK5Mag"
        elseif magD20 > 10 then
            gunMag = "Base.AKMag"
        elseif magD20 > 6 then
            gunMag = "Base.AKBakeMag"
        elseif magD20 > 2 then
            gunMag = "Base.40AKMag"
        else
            gunMag = "Base.AKDrumMag"
        end
        if gunMag then
            weapon:setMagazineType(gunMag)
            AddMagAttachment(weapon, gunMag)
        end
    end
    if not weapon:getWeaponPart("Handguard") then
        local Handguard = nil
        if Clayco then
            Handguard = instanceItem("Base.AKPolyHandguard")
        elseif FEG then
            Handguard = instanceItem("Base.AKBeechHandguard")
        elseif Maadi then
            if ZombRand(0,10) > 8 and weapon:getFullType() ~= "Base.AKSport" then
                Handguard = instanceItem("Base.AKEGHandguard")
                EG = true
            elseif ZombRand(0,10) > 7 and weapon:getFullType() ~= "Base.AKSport" then
                Handguard = instanceItem("Base.AKDong")
            else
                Handguard = instanceItem("Base.AKMHandguard")
            end
        elseif AKS and not milled or (weapon:getFullType() == "Base.AKSport" and milled) then
            if ZombRand(0,10) > 8 and weapon:getFullType() ~= "Base.AKSport" then
                Handguard = instanceItem("Base.AKBakeHandguard")
                bake = true
                if weapon:getFullType() == "Base.T56" then
                    weapon:setTexture(getTexture("media/textures/item_T56Bake.png"))
                    weapon:getModData().Guns93Icon = "T56Bake"
                else
                    weapon:setTexture(getTexture("media/textures/item_AKSBake.png"))
                    weapon:getModData().Guns93Icon = "AKSBake"
                end
            else
                Handguard = instanceItem("Base.AKSHandguard")
                if weapon:getFullType() ~= "Base.AKSport" then
                    if weapon:getFullType() == "Base.T56" then
                        weapon:setTexture(getTexture("media/textures/item_T56.png"))
                        weapon:getModData().Guns93Icon = "T56"
                    else
                        weapon:setTexture(getTexture("media/textures/item_AKS.png"))
                        weapon:getModData().Guns93Icon = "AKS"
                    end
                end
            end
        elseif milled then
            Handguard = instanceItem("Base.AKLegendHandguard")
        end
        weapon:attachWeaponPart(Handguard)
    end
    local sporter = false
    if not weapon:getWeaponPart("Stock") then
        local Stock = nil
        local folderD30 = ZombRand(0,30)
        if underfold then
            if bake then
                Stock = instanceItem("Base.AKSideFolderIn")
            elseif folderD30 > 10 and AKS and not bake then
                Stock = instanceItem("Base.AKGalilFolderIn")
            else
                Stock = instanceItem("Base.AKMSStockIn")
            end
        elseif not underfold then
            if Clayco then
                if weapon:getFullType() == "Base.AKSport" then
                    Stock = instanceItem("Base.AKPolySportStock")
                    sporter = true
                else
                    Stock = instanceItem("Base.AKPolyStock")
                end
            elseif FEG then
                if weapon:getFullType() == "Base.AKSport" then
                    Stock = instanceItem("Base.FEGSportStock")
                    sporter = true
                elseif folderD30 > 20 then
                    Stock = instanceItem("Base.AKWireStockIn")
                else
                    Stock = instanceItem("Base.AKBeechStock")
                end
            elseif Maadi then
                if weapon:getFullType() == "Base.AKSport" then
                    Stock = instanceItem("Base.MaadiSportStock")
                    sporter = true
                elseif folderD30 > 20 then
                    Stock = instanceItem("Base.AKCrutchStockIn")
                elseif EG then
                    Stock = instanceItem("Base.AKEGStock")
                else
                    Stock = instanceItem("Base.AKMStock")
                end
            elseif bake then
                Stock = instanceItem("Base.AKBakeStock")
            elseif AKS and not milled and not bake or (weapon:getFullType() == "Base.AKSport" and milled) then
                if weapon:getFullType() == "Base.AKSport" then
                    Stock = instanceItem("Base.MAK90Stock")
                    sporter = true
                else
                    Stock = instanceItem("Base.AKSStock")
                end
            elseif milled then
                Stock = instanceItem("Base.AKLegendStock")
            end
        end
        weapon:attachWeaponPart(Stock)
    end
    if sporter == false then
        local Grip = nil
        if Clayco then
            Grip = instanceItem("Base.AKPolyGrip")
        elseif FEG then
            Grip = instanceItem("Base.AKFEGGrip")
        elseif Maadi then
            if EG then
                Grip = instanceItem("Base.AKEGGrip")
            else
                Grip = instanceItem("Base.AKMGrip")
            end
        elseif bake then
            Grip = instanceItem("Base.AKBakeGrip")
        elseif AKS and not milled and not bake then
            Grip = instanceItem("Base.AKSGrip")
        elseif milled then
            Grip = instanceItem("Base.AKLegendGrip")
        end
        weapon:attachWeaponPart(Grip)
    end
    if sporter then
        local Pad = instanceItem("Base.RecoilPad")
        weapon:attachWeaponPart(Pad)
        if ZombRand(0,10) > 7 then
            weapon:attachWeaponPart(instanceItem("Base.AKScopeMount"))
            local scope = nil
            local scopeD12 = ZombRand(0,12)
            if scopeD12 > 10 then
                scope = instanceItem("Base.x3Scope")
            elseif scopeD12 > 8 then
                scope = instanceItem("Base.x4Scope")
            elseif scopeD12 > 6 then
                scope = instanceItem("Base.x6Scope")
            elseif scopeD12 > 4 then
                scope = instanceItem("Base.x8Scope")
            elseif scopeD12 > 2 then
                scope = instanceItem("Base.AccuDot")
            elseif scopeD12 > 1 then
                scope = instanceItem("Base.AccuDotSilver")
            else
                scope = nil
            end
            if scope ~= nil then
                weapon:attachWeaponPart(scope)
            end
        end
    end
    if not sporter then
        local bayo = nil
        weapon:attachWeaponPart(instanceItem("Base.BarrelThread"))
        if weapon:getFullType() ~= "Base.T56" then
            local canonD10 = ZombRand(0,10)
            local Canon = nil            
            if ZombRand(0,10) > 6 then
                if Clayco then
                    bayo = instanceItem("Base.AKBayonetBlackPart")
                elseif bake then
                    bayo = instanceItem("Base.AKBayonetBakePart")
                elseif Maadi or AKS and not bake then
                    bayo = instanceItem("Base.AKBayonetPart")
                elseif FEG then
                    bayo = instanceItem("Base.AKOldBayonetPart")
                elseif milled then
                    bayo = instanceItem("Base.AK47BayonetPart")
                end
            end
            if canonD10 > 4 then
                Canon = instanceItem("Base.AKSlantBrake")
            elseif bayo == nil then
                Canon = instanceItem("Base.AKBrake")
            end
            weapon:attachWeaponPart(Canon)
        end
        if weapon:getFullType() == "Base.T56" then
            if not weapon:getWeaponPart("Bayonet") then
                bayo = instanceItem("Base.T56BayonetPart")
            end
        else
        end
        weapon:attachWeaponPart(bayo)
        if ZombRand(0,10) > 8 then
            weapon:attachWeaponPart(instanceItem("Base.AKGrate"))
        end
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        weapon:getModData().Guns93Icon = "AKS"
    end
end

Guns93GunConfig.Guns93CalicoSpawns = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    AddMagAttachment(weapon, nil)
    if weapon:getFullType() == "Base.CalicoRifle" then
        local stock = instanceItem("Base.CalicoStockIn")
        weapon:attachWeaponPart(stock)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    weapon:attachWeaponPart(instanceItem("Base.CalicoTrigger"))
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93SPAS12Spawns = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    local threading = instanceItem("Base.BoreThread")
    if not weapon:getWeaponPart("Stock") then
        local stock = instanceItem("Base.SPAS12StockIn")
        weapon:attachWeaponPart(stock)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93M1Garand = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    local d10 = ZombRand(0,10)
    if d10 > 6 then
        weapon:setName(getText("Springfield ") .. getText("M1 Garand") .. ammoNam)
    elseif d10 > 4 then
        weapon:setName(getText("Winchester ") .. getText("M1 Garand") .. ammoNam)
    elseif d10 > 2 then
        weapon:setName(getText("H&R ") .. getText("M1 Garand") .. ammoNam)
    else
        weapon:setName(getText("Intl. Harvester ") .. getText("M1 Garand") .. ammoNam)
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93M1Carbine = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    if weapon:getMagazineType() then
        local magD10 = ZombRand(0,10)
        local gunMag = nil
        if magD10 > 2 then
            gunMag = "Base.M1CarMag"
        else
            gunMag = "Base.30M1CarMag"
        end
        if gunMag then
            weapon:setMagazineType(gunMag)
            AddMagAttachment(weapon, gunMag)
        end
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    local d100 = ZombRand(0,100)
    if d100 > 46 then
        weapon:setName(getText("Inland ") .. getText("M1 Carbine") .. ammoNam)
    elseif d100 > 29 then
        weapon:setName(getText("Winchester ") .. getText("M1 Carbine") .. ammoNam)
    elseif d100 > 19 then
        weapon:setName(getText("Underwood ") .. getText("M1 Carbine") .. ammoNam)
    elseif d100 > 17 then
        weapon:setName(getText("Saginaw SG ") .. getText("M1 Carbine") .. ammoNam)
    elseif d100 > 15 then
        weapon:setName(getText("Irwin-Pedersen ") .. getText("M1 Carbine") .. ammoNam)
    elseif d100 > 13 then
        weapon:setName(getText("Nat. Postal Meter ") .. getText("M1 Carbine") .. ammoNam)
    elseif d100 > 11 then
        weapon:setName(getText("Quality HMC ") .. getText("M1 Carbine") .. ammoNam)
    elseif d100 > 9 then
        weapon:setName(getText("IBM Corp ") .. getText("M1 Carbine") .. ammoNam)
    elseif d100 > 4 then
        weapon:setName(getText("Std. Prod. ") .. getText("M1 Carbine") .. ammoNam)
    else
        weapon:setName(getText("Rock-Ola ") .. getText("M1 Carbine") .. ammoNam)
    end
    weapon:attachWeaponPart(instanceItem("Base.M1CarTrigger"))
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93M1903 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    AddMagAttachment(weapon, nil)
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    local d100 = ZombRand(0,100)
    if d100 > 55 then
        weapon:setName(getText("Smith Corona ") .. getText("M1903 Springfield") .. ammoNam)
    elseif d100 > 30 then
        weapon:setName(getText("Springfield ") .. getText("M1903 Springfield") .. ammoNam)
    elseif d100 > 5 then
        weapon:setName(getText("Remington ") .. getText("M1903 Springfield") .. ammoNam)
    else
        weapon:setName(getText("RIA ") .. getText("M1903 Springfield") .. ammoNam)
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93M1917 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    AddMagAttachment(weapon, nil)
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    local d100 = ZombRand(0,100)
    if d100 > 45 then
        weapon:setName(getText("Eddystone ") .. getText("M1917 Enfield") .. ammoNam)
    elseif d100 > 29 then
        weapon:setName(getText("Remington ") .. getText("M1917 Enfield") .. ammoNam)
    else
        weapon:setName(getText("Winchester ") .. getText("M1917 Enfield") .. ammoNam)
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93M14 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local d100 = ZombRand(0,100)
    local camo = false
    local NatMatch = false
    local bush = false
    local setTex = nil
    local blackPad = false
    local NoRecoil = false
    if weapon:getFullType() == "Base.M14308" then
        if d100 > 70 then
            weapon:setName(getText("Springfield ") .. getText("M14 ") .. ammoNam)
        elseif d100 > 40 then
            weapon:setName(getText("H&R ") .. getText("M14 ") .. ammoNam)
        elseif d100 > 10 then
            weapon:setName(getText("Winchester ") .. getText("M14 ") .. ammoNam)
        else
            weapon:setName(getText("TRW ") .. getText("M14 ") .. ammoNam)
        end
        if ZombRand(0,10) > 8 then
            camo = true
            weapon:setWeaponSprite("308M14Camo")
        end
        NoRecoil = true
    elseif weapon:getFullType() == "Base.M1A" then
        if d100 > 70 then
            if ZombRand(0,10) > 7 then
                NatMatch = true
                weapon:setName(getText("Springfield ") .. getText("M1A ") .. getText("National Match") .. ammoNam)
                weapon:setWeaponSprite("308M14SS")
                setTex = "M1ANatMatch"
            else
                weapon:setName(getText("Springfield ") .. getText("M1A") .. ammoNam)
            end
        elseif d100 > 40 then
            weapon:setName(getText("Smith Enterprise Inc. ") .. getText("M14 ") .. ammoNam)
        elseif d100 > 10 then
            weapon:setName(getText("Federal Ordnance ") .. getText("M14 ") .. ammoNam)
        else
            weapon:setName(getText("Norinco ") .. getText("M14 ") .. ammoNam)
        end
    elseif weapon:getFullType() == "Base.M1ABush" then
        weapon:setName(getText("Springfield ") .. getText("M1A Bush Rifle") .. ammoNam)
        bush = true
    end
    if not weapon:getWeaponPart("Stock") then
        local Stock = nil
        local UpHandguard = nil
        local Wood = nil
        local UpBlack = false
        local StockD100 = ZombRand(0,100)
        if camo == true then
            Stock = instanceItem("Base.M14CamoStock")
            setTex = "M14Camo"
        elseif StockD100 > 90 and weapon:getFullType() ~= "Base.M14308" then
            Stock = instanceItem("Base.M14SmearStock")
            if NatMatch then
                setTex = "M1ANatSmear"
            elseif bush then
                setTex = "M1ABushSmear"
            else
                setTex = "M14Smear"
            end
        elseif StockD100 > 50 then
            Stock = instanceItem("Base.M14WalnutStock")
            Wood = "Base.M14WalnutUpHandguard"
        elseif StockD100 > 45 and weapon:getFullType() == "Base.M1ABush" then
            Stock = instanceItem("Base.M14FoldStockIn")
            setTex = "M1ABushFold"
            UpBlack = true
            NoRecoil = true
        elseif StockD100 > 35 and weapon:getFullType() ~= "Base.M14308" then
            Stock = instanceItem("Base.M14PolymerStock")
            UpBlack = true
        else
            Stock = instanceItem("Base.M14DarkWalnutStock")
            Wood = "Base.M14DarkWalnutUpHandguard"
        end
        if setTex ~= nil then
            weapon:setTexture(getTexture("media/textures/item_" .. setTex .. ".png"))
            weapon:getModData().Guns93Icon = setTex
        end
        if not weapon:getWeaponPart("UpHandguard") then
            local UpHandD6 = ZombRand(0,6)
            if camo == true then
                UpHandguard = instanceItem("Base.M14CamoUpHandguard")
            elseif UpHandD6 > 4 or UpBlack then
                UpHandguard = instanceItem("Base.M14BlackUpHandguard")
            elseif UpHandD6 > 2 and Wood ~= nil and weapon:getFullType() ~= "Base.M14308" then
                UpHandguard = instanceItem(Wood)
            else
                UpHandguard = instanceItem("Base.M14BrownUpHandguard")
            end
        end
        weapon:attachWeaponPart(UpHandguard)
        weapon:attachWeaponPart(Stock)
    end
    local recoilD10 = ZombRand(0,10)
    local recoil = nil
    if NoRecoil == false then
        if recoilD10 > 4 then
            recoil = nil
        elseif recoilD10 > 2 or UpBlack == true then
            recoil = instanceItem("Base.RecoilPad")
        elseif recoilD10 > 1 then
            recoil = instanceItem("Base.RedRecoilPad")
        else 
            recoil = instanceItem("Base.BrownRecoilPad")
        end
        if recoil ~= nil then
            weapon:attachWeaponPart(recoil)
        end
    end
    local hasCan = false
    if not weapon:getWeaponPart("Canon") then
        local Canon = nil
        if camo == true then
            if ZombRand(0,9) > 6 then
                weapon:attachWeaponPart(instanceItem("Base.BarrelThread"))
                Canon = instanceItem("Base.30Silencer")
                hasCan = true
            else
                Canon = instanceItem("Base.M14CamoFlashHider")
            end
        elseif ZombRand(0,10) > 7 and weapon:getFullType() ~= "Base.M14308" then
            Canon = instanceItem("Base.M14Brake")
        else
            Canon = instanceItem("Base.M14FlashHider")
        end
        weapon:attachWeaponPart(Canon)
    end
    if not weapon:getWeaponPart("Trigger") then
        local trigger
        if weapon:getFullType() ~= "Base.M14308" then
            trigger = instanceItem("Base.M14MatchTrigger")
        else
            trigger = instanceItem("Base.M14Trigger")
        end
        weapon:attachWeaponPart(trigger)
    end
    if weapon:getMagazineType() then
        local magD10 = ZombRand(0,10)
        local gunMag = nil
        if magD10 > 3 or weapon:getFullType() == "Base.M14308" then
            gunMag = "Base.M14Mag"
        elseif magD10 > 0 then
            gunMag = "Base.10M14Mag"
        else
            gunMag = "Base.30M14Mag"
        end
        if gunMag then
            weapon:setMagazineType(gunMag)
            AddMagAttachment(weapon, gunMag)
        end
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    local scope = nil
    local mount = false
    local opticD10 = ZombRand(0,10)
    local scoped39 = ZombRand(0,39)
    if opticD10 > 7 and weapon:getFullType() ~= "Base.M14308" then
        mount = true
        if scoped39 > 34 then
            scope = instanceItem("Base.AccuDot")
        elseif scoped39 > 29 then
            scope = instanceItem("Base.AccuDotSilver")
        elseif scoped39 > 24 then
            scope = instanceItem("Base.x3Scope")
        elseif scoped39 > 19 then
            scope = instanceItem("Base.x4Scope")
        elseif scoped39 > 15 then
            scope = instanceItem("Base.x6Scope")
        elseif scoped39 > 11 then
            scope = instanceItem("Base.x8Scope")
        elseif scoped39 > 7 then
            scope = instanceItem("Base.x10Scope")
        elseif scoped39 > 4 then
            scope = instanceItem("Base.x3ScopeSilver")
        elseif scoped39 > 3 then
            scope = instanceItem("Base.x4ScopeSilver")
        elseif scoped39 > 2 then
            scope = instanceItem("Base.x6ScopeSilver")
        elseif scoped39 > 1 then
            scope = instanceItem("Base.x8ScopeSilver")
        else
            scope = instanceItem("Base.x10ScopeSilver")
        end
    elseif opticD10 > 5 then
        if scoped39 > 10 then
            scope = instanceItem("Base.M14ARTScope")
        else
            mount = true
            scope = instanceItem("Base.RedDot")
        end
    end
    if mount == true then
        weapon:attachWeaponPart(instanceItem("Base.M14Mount"))
    end
    if scope ~= nil then
        weapon:attachWeaponPart(scope)
    end
    if weapon:getFullType() == "Base.M14308" then
        if ZombRand(0,4) > 2 then
        weapon:attachWeaponPart(instanceItem("Base.M14AutoPart"))
        end
    end
    if not hasCan then
        if ZombRand(0,6) > 4 and weapon:getFullType() ~= "Base.M1ABush" then
            weapon:attachWeaponPart(instanceItem("Base.M6BayonetPart"))
        end
    end
    if ZombRand(1,10) < 3 then
        weapon:attachWeaponPart(instanceItem("Base.RifleBipod"))
    end
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        weapon:getModData().Guns93Icon = "308M14"
    end
end

Guns93GunConfig.Guns93SKS = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    if weapon:getFullType() == "Base.SKS" then
        if not weapon:getWeaponPart("Bayonet") then
            local bayo = instanceItem("Base.SKSBayonetPart")
            weapon:attachWeaponPart(bayo)
        end
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    local d100 = ZombRand(0,100)
    if d100 > 45 then
        weapon:setName(getText("Tula ") .. getText(" SKS"))
    elseif d100 > 20 then
        weapon:setName(getText("Izhevsk ") .. getText(" SKS"))
    elseif d100 > 10 then
        weapon:setName(getText("Norinco ") .. getText(" SKS"))
    else
        weapon:setName(getText("Yugoslav M59/66 ") .. getText(" SKS"))
    end
    weapon:attachWeaponPart(instanceItem("Base.SKSTrigger"))
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93Glock = function(weapon)
    if not weapon then return end
    local gunNam = weapon:getDisplayName()
    local ammoNam = GetAmmoName(weapon)
    local manNamD12 = ZombRand(0,12)
    weapon:setName(gunNam .. ammoNam)
    if not weapon:getWeaponPart("Trigger") then
        local trigger = nil
        if weapon:getFullType() == "Base.Glock20" or weapon:getFullType() == "Base.Glock21" then
            trigger = instanceItem("Base.GlockTriggerLarge")
        else
            trigger = instanceItem("Base.GlockTrigger")
        end
        weapon:attachWeaponPart(trigger)
    end
    if weapon:getMagazineType() then
        local magD20 = ZombRand(0,20)
        local gunMag = nil
        if weapon:getFullType() == "Base.Glock17" or weapon:getFullType() == "Base.Glock17L" then
            if magD20 > 8 then
                gunMag = "Base.G17Mag"
            elseif magD20 > 2 then
                gunMag = "Base.G17ExtMag"
            else
                gunMag = "Base.G17StickMag"
            end
        elseif weapon:getFullType() == "Base.Glock19" then
            if magD20 > 6 then
                gunMag = "Base.G19Mag"
            else
                gunMag = "Base.G19ExtMag"
            end
        else
            gunMag = weapon:getMagazineType()
        end
        if gunMag then
            weapon:setMagazineType(gunMag)
            AddMagAttachment(weapon, gunMag)
        end
    end
    if not weapon:getWeaponPart("Light") then
        local lightD20 = ZombRand(0,20)
        local gunLight = nil
        if lightD20 > 18 then
            gunLight = instanceItem("Base.GlockLaser")
        elseif lightD20 > 15 then
            gunLight = instanceItem("Base.GlockWML")
        end
        if gunLight then
            gunLight:setCurrentUsesFloat(ZombRand(0, 10)/10);
            weapon:attachWeaponPart(gunLight)
        end
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = nil
        local ironsD20 = ZombRand(0,20)
        if ironsD20 > 17 then
            Irons = instanceItem("Base.IronPistolTarget")
        elseif ironsD20 > 13 then
            Irons = instanceItem("Base.IronPistolCombat")
        elseif ironsD20 > 10 then
            Irons = instanceItem("Base.TritiumSights")
        else
            Irons = instanceItem("Base.IronPistolBasic")
        end
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93USP = function(weapon)
    if not weapon then return end
    local gunNam = weapon:getDisplayName()
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(gunNam .. ammoNam)
    if not weapon:getWeaponPart("Trigger") then
        local trigger = instanceItem("Base.USPTrigger")
        weapon:attachWeaponPart(trigger)
    end
    if weapon:getMagazineType() then
        gunMag = weapon:getMagazineType()
        if gunMag then
            weapon:setMagazineType(gunMag)
            AddMagAttachment(weapon, gunMag)
        end
    end
    if not weapon:getWeaponPart("Light") then
        local lightD20 = ZombRand(0,20)
        local gunLight = nil
        if lightD20 > 15 then
            gunLight = instanceItem("Base.UTL")
        end
        if gunLight then
            gunLight:setCurrentUsesFloat(ZombRand(0, 10)/10);
            weapon:attachWeaponPart(gunLight)
        end
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.IronPistolCombat")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
end

Guns93GunConfig.Guns93TEC9 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    weapon:attachWeaponPart(instanceItem("Base.BarrelThread"))
    AddMagAttachment(weapon, nil)
	weapon:setCustomName(true);
    weapon:attachWeaponPart(instanceItem("Base.TEC9Trigger"))
end

Guns93GunConfig.Guns93MAC10 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    local gunMag = nil
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
    if ZombRand(0,50) > 40 then
        weapon:attachWeaponPart(instanceItem("Base.MACBarrelExt"))
    end
    if ZombRand(0,50) > 40 then
        weapon:attachWeaponPart(instanceItem("Base.MACStrap"))
    end
    if weapon:getFullType() == "Base.MAC10" then
        weapon:attachWeaponPart(instanceItem("Base.MAC10Trigger"))
        gunMag = "Base.MAC10Mag"
    elseif weapon:getFullType() == "Base.MAC11" then
        weapon:attachWeaponPart(instanceItem("Base.MAC11Trigger"))
        gunMag = "Base.MAC11Mag"
    elseif weapon:getFullType() == "Base.MAC11A1" then
        weapon:attachWeaponPart(instanceItem("Base.MAC11A1AutoTrigger"))
        weapon:attachWeaponPart(instanceItem("Base.MAC11A1StockIn"))
        if weapon:getWeaponPart("Canon") and ZombRand(0,50) > 25 then
            weapon:attachWeaponPart(instanceItem("Base.9mmTwoStageSilencer"))
        end
        if weapon:getMagazineType() then
            if ZombRand(0,50) > 25 then
                gunMag = "Base.MAC11A1Mag"
            else
                gunMag = "Base.16MAC11A1Mag"
            end
        end
    end
    AddMagAttachment(weapon, nil)
    if gunMag then
        weapon:setMagazineType(gunMag)
    end
end

Guns93GunConfig.Guns93Uzi = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    local uzi = false
    local uziCar = false
    local mini = false
    local miniCar = false
    local micro = false
    local norinco = false
    local is9mm = false
    if weapon:getAmmoType():getItemKey() == "Base.Bullets9mm" then
        is9mm = true
    end
    if weapon:getFullType() == "Base.Uzi" or weapon:getFullType() == "Base.Uzi45" then
        uzi = true
    elseif weapon:getFullType() == "Base.UziCarbine" or weapon:getFullType() == "Base.UziCarbine45" then
        uziCar = true
        if ZombRand(1,10) > 7 and is9mm then
            norinco = true
        end
    elseif weapon:getFullType() == "Base.MiniUzi" or weapon:getFullType() == "Base.MiniUzi45" then
        mini = true
    elseif weapon:getFullType() == "Base.MiniUziCar" or weapon:getFullType() == "Base.MiniUziCar45" then
        miniCar = true
    elseif weapon:getFullType() == "Base.MicroUzi" or weapon:getFullType() == "Base.MicroUzi45" then
        micro = true
    end
    local gripGreen = false
    local gripWood = false
    local thumb = false
    local gripD10 = ZombRand(1,10)
    if ZombRand(1,10) > 5 and norinco then
        thumb = true
    end
    if gripD10 > 3 then
        if not micro then
            if mini or miniCar then
                weapon:attachWeaponPart(instanceItem("Base.MiniUziBlackHandguard"))
            else
                weapon:attachWeaponPart(instanceItem("Base.UziBlackHandguard"))
            end
        end
    elseif gripD10 > 1 then
        if not micro then
            if mini or miniCar then
                weapon:attachWeaponPart(instanceItem("Base.MiniUziGreenHandguard"))
            else
                weapon:attachWeaponPart(instanceItem("Base.UziGreenHandguard"))
            end
        end
        gripGreen = true
    elseif not micro then
        if mini or miniCar then
            weapon:attachWeaponPart(instanceItem("Base.MiniUziWoodHandguard"))
        else
            weapon:attachWeaponPart(instanceItem("Base.UziWoodHandguard"))
        end
        gripWood = true
    end
    if not thumb then
        if gripGreen then
            weapon:attachWeaponPart(instanceItem("Base.UziGreenGrips"))
        elseif gripWood then
            weapon:attachWeaponPart(instanceItem("Base.UziWoodGrips"))
        else
            weapon:attachWeaponPart(instanceItem("Base.UziBlackGrips"))
        end
        local stockD10 = ZombRand(1,10)
        if uzi or uziCar then
            if stockD10 > 4 or gripWood then
                weapon:attachWeaponPart(instanceItem("Base.UziStockIn"))
            else
                if gripGreen and norinco then
                    weapon:attachWeaponPart(instanceItem("Base.UziGreenStock"))
                elseif stockD10 > 1 and norinco then
                    weapon:attachWeaponPart(instanceItem("Base.UziPolymerStock"))
                else
                    weapon:attachWeaponPart(instanceItem("Base.UziStock"))
                end
            end
        elseif mini or miniCar then
            weapon:attachWeaponPart(instanceItem("Base.MiniUziStockIn"))
        end
    elseif ZombRand(1,10) > 5 then
        weapon:attachWeaponPart(instanceItem("Base.UziThumbStock"))
    else
        weapon:attachWeaponPart(instanceItem("Base.UziThumbPolyStock"))
    end
    if ZombRand(1,10) > 3 and (uziCar or miniCar) then
        weapon:attachWeaponPart(instanceItem("Base.UziShroud"))
    end
    if ZombRand(1,10) > 3 and uziCar then
        weapon:attachWeaponPart(instanceItem("Base.UziMount"))
        local opticD6 = ZombRand(1,6)
        if opticD6 > 5 then
            weapon:attachWeaponPart(instanceItem("Base.CMore"))
        elseif opticD6 > 4 then
            weapon:attachWeaponPart(instanceItem("Base.AccuDot"))
        elseif opticD6 > 3 then
            weapon:attachWeaponPart(instanceItem("Base.ArmsonRail"))
        elseif opticD6 > 2 then
            weapon:attachWeaponPart(instanceItem("Base.x2Scope"))
        elseif opticD6 > 1 then
            weapon:attachWeaponPart(instanceItem("Base.RailLaser"))
        end
    end
    if uzi or mini then
        if ZombRand(1,10) > 8 then
            if is9mm then
                weapon:attachWeaponPart(instanceItem("Base.Uzi9mmSilencer"))
            else
                weapon:attachWeaponPart(instanceItem("Base.Uzi45Silencer"))
            end
        end
    end        
    if weapon:getMagazineType() then
        local magD40 = ZombRand(0,40)
        local gunMag = nil
        if is9mm then
            if magD40 > 30 then
                gunMag = "Base.25UziMag"
            elseif magD40 > 10 then
                gunMag = "Base.UziMag"
            elseif magD40 > 5 then
                gunMag = "Base.10UziMag"
            else
                gunMag = "Base.40UziMag"
            end
        else
            if magD40 > 22 then
                gunMag = "Base.16Uzi45Mag"
            elseif magD40 > 5 then
                gunMag = "Base.12Uzi45Mag"
            else
                gunMag = "Base.22Uzi45Mag"
            end
        end
        if gunMag then
            weapon:setMagazineType(gunMag)
            AddMagAttachment(weapon, gunMag)
        end
    end
    local gunName = weapon:getName()
    if norinco then
        gunName = "Norinco Model 320"
    end
    weapon:setName(gunName .. ammoNam)
	weapon:setCustomName(true);
    local trigger = nil
    if uzi then
        trigger = instanceItem("Base.UziAutoTrigger")
    elseif uziCar then
        trigger = instanceItem("Base.UziTrigger")
    elseif mini then
        trigger = instanceItem("Base.UziAutoTrigger")
    elseif miniCar then
        trigger = instanceItem("Base.MiniUziTrigger")
    elseif micro then
        trigger = instanceItem("Base.MicroUziTrigger")
    end
    if trigger then
        weapon:attachWeaponPart(trigger)
    end
end

Guns93GunConfig.Guns93MarlinPPC = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    local rail = instanceItem("Base.NonremoveScopeRail")
    weapon:attachWeaponPart(rail)
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    AddMagAttachment(weapon, nil)
	weapon:setCustomName(true);
    weapon:attachWeaponPart(instanceItem("Base.MarlinPPCTrigger"))
end

Guns93GunConfig.Guns93Marlin60 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    local rail = instanceItem("Base.NonremoveScopeRail")
    weapon:attachWeaponPart(rail)
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
	weapon:setCustomName(true);
    weapon:attachWeaponPart(instanceItem("Base.Marlin60Trigger"))
end

Guns93GunConfig.Guns93FAL = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    weapon:setName(weapon:getName() .. ammoNam)
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    weapon:attachWeaponPart(instanceItem("Base.BarrelThread"))
    AddMagAttachment(weapon, nil)
	weapon:setCustomName(true);
    weapon:attachWeaponPart(instanceItem("Base.FALTrigger"))
end

Guns93GunConfig.Guns93FNC = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local d10 = ZombRand(0,10)
    if d10 > 5 then
        weapon:setWeaponSprite("FNCBlack")
    else
        weapon:setWeaponSprite("FNCGrey")
    end
    if not weapon:getWeaponPart("Trigger") then
        weapon:attachWeaponPart(instanceItem("Base.FNCTrigger"))
    end
    if weapon:getMagazineType() then
        local magD40 = ZombRand(0,40)
        local gunMag = nil
        if magD40 > 18 then
            gunMag = "Base.20M16Mag"
        elseif magD40 > 8 then
            gunMag = "Base.TherARMag"
        elseif magD40 > 1 then
            gunMag = "Base.M16Mag"
        else
            gunMag = "Base.BetaCMag"
        end
        if gunMag then
            weapon:setMagazineType(gunMag)
            AddMagAttachment(weapon, gunMag)
        end
    end
    weapon:attachWeaponPart(instanceItem("Base.BarrelThread"))
    local suffix = ""
    if not weapon:getWeaponPart("Stock") then
        local stock = nil
        if ZombRand(1,10) > 6 then
            stock = instanceItem("Base.FNCStock")
            weapon:setTexture(getTexture("media/textures/item_FNC.png"))
            weapon:getModData().Guns93Icon = "FNC"
        else
            stock = instanceItem("Base.FNCParaFolderIn")
            weapon:setTexture(getTexture("media/textures/item_FNCPara.png"))
            weapon:getModData().Guns93Icon = "FNCPara"
            suffix = "Para"
        end
        weapon:attachWeaponPart(stock)
    end
    if not weapon:getWeaponPart("Canon") then
        local Canon = instanceItem("Base.FNCFlashHider")
        weapon:attachWeaponPart(Canon)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    if ZombRand(0,10) > 8 then
        local scope = nil
        local d8 = ZombRand(0,8)
        local rail = instanceItem("Base.FNCScopeMount")
        weapon:attachWeaponPart(rail)
        if d8 < 1 then
            scope = instanceItem("Base.x4ACOG")
        elseif d8 < 2 then
            scope = instanceItem("Base.ArmsonM16")
        elseif d8 < 3 then
            scope = instanceItem("Base.x6Scope")
        elseif d8 < 4 then
            scope = instanceItem("Base.CMore")
        elseif d8 < 5 then
            scope = instanceItem("Base.AccuDot")
        elseif d8 < 6 then
            scope = instanceItem("Base.AccuDotSilver")
        else
            scope = instanceItem("Base.x3Scope")
        end
        weapon:attachWeaponPart(scope)
    end
    weapon:setName(weapon:getName() .. " " .. suffix .. " " .. ammoNam)
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        weapon:getModData().Guns93Icon = "FNC"
    end
end

Guns93GunConfig.Guns93DWK1A = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local gunNam = weapon:getName()
    if not weapon:getWeaponPart("Trigger") then
        if weapon:getFullType() == "Base.DWK1A" then
            weapon:attachWeaponPart(instanceItem("Base.K1ATrigger"))
--            weapon:setTexture(getTexture("media/textures/item_FNC.png"))
        else
            weapon:attachWeaponPart(instanceItem("Base.K1A1Trigger"))
--            weapon:setTexture(getTexture("media/textures/item_FNCPara.png"))
            local NamD6 = ZombRand(0,6)
            if NamD6 < 2 then
                gunNam = "Daewoo MAX-1"
            elseif NamD6 < 5 then
                gunNam = "Daewoo AR-110C"
            end
        end
    end
    if weapon:getMagazineType() then
        local magD40 = ZombRand(0,40)
        local gunMag = nil
        if magD40 > 18 then
            gunMag = "Base.20M16Mag"
        elseif magD40 > 8 then
            gunMag = "Base.TherARMag"
        elseif magD40 > 1 then
            gunMag = "Base.M16Mag"
        else
            gunMag = "Base.BetaCMag"
        end
        if gunMag then
            weapon:setMagazineType(gunMag)
            AddMagAttachment(weapon, gunMag)
        end
    end
    if weapon:getFullType() == "Base.DWK1A" then
        weapon:attachWeaponPart(instanceItem("Base.BarrelThread"))
    end
    if not weapon:getWeaponPart("Stock") then
        stock = instanceItem("Base.K1AFolderIn")
        weapon:attachWeaponPart(stock)
    end
    if not weapon:getWeaponPart("Canon") then
        local Canon = nil
        Canon = instanceItem("Base.K1AFlashHider")
        weapon:attachWeaponPart(Canon)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    weapon:setName(gunNam .. " " .. ammoNam)
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        if weapon:getFullType() == "Base.DWK1A" then
            weapon:getModData().Guns93Icon = "K1A"
        else
            weapon:getModData().Guns93Icon = "K1A1"
        end
    end
end

Guns93GunConfig.Guns93DWK2 = function(weapon)
    if not weapon then return end
    local ammoNam = GetAmmoName(weapon)
    local gunNam = weapon:getName()
    if not weapon:getWeaponPart("Trigger") then
        if weapon:getFullType() == "Base.DWK2" then
            local NamD6 = ZombRand(0,6)
            if NamD6 < 2 then
                gunNam = "Daewoo MAX-II"
            elseif NamD6 < 5 then
                gunNam = "Daewoo AR-100"
            end
        end
    end
    if not weapon:getWeaponPart("Trigger") then
        weapon:attachWeaponPart(instanceItem("Base.DR200Trigger"))
    end
    if weapon:getMagazineType() then
        local magD40 = ZombRand(0,40)
        local gunMag = nil
        if magD40 > 18 then
            gunMag = "Base.20M16Mag"
        elseif magD40 > 8 then
            gunMag = "Base.TherARMag"
        elseif magD40 > 1 then
            gunMag = "Base.M16Mag"
        else
            gunMag = "Base.BetaCMag"
        end
        if gunMag then
            weapon:setMagazineType(gunMag)
            AddMagAttachment(weapon, gunMag)
        end
    end
    weapon:attachWeaponPart(instanceItem("Base.BarrelThread"))
    if not weapon:getWeaponPart("Stock") then
        local stock = nil
        local grip = nil
        if weapon:getFullType() == "Base.DWK2" then
            stock = instanceItem("Base.K2FolderIn")
            grip = instanceItem("Base.K2PistolGrip")
        else
            stock = instanceItem("Base.DR200Stock")
        end
        weapon:attachWeaponPart(stock)
        if grip then
            weapon:attachWeaponPart(grip)
        end
    end
    if not weapon:getWeaponPart("Canon") then
        local Canon = instanceItem("Base.K2FlashHider")
        weapon:attachWeaponPart(Canon)
    end
    if not weapon:getWeaponPart("Irons") then
        local Irons = instanceItem("Base.NonremoveIrons")
        if Irons then
            weapon:attachWeaponPart(Irons)
        end
    end
    if ZombRand(0,10) > 8 then
        local scope = nil
        local d8 = ZombRand(0,8)
        local rail = instanceItem("Base.K2ScopeMount")
        weapon:attachWeaponPart(rail)
        if d8 < 1 then
            scope = instanceItem("Base.x4ACOG")
        elseif d8 < 2 then
            scope = instanceItem("Base.ArmsonM16")
        elseif d8 < 3 then
            scope = instanceItem("Base.x6Scope")
        elseif d8 < 4 then
            scope = instanceItem("Base.CMore")
        elseif d8 < 5 then
            scope = instanceItem("Base.AccuDot")
        elseif d8 < 6 then
            scope = instanceItem("Base.AccuDotSilver")
        else
            scope = instanceItem("Base.x3Scope")
        end
        weapon:attachWeaponPart(scope)
    end
    weapon:setName(gunNam .. " " .. ammoNam)
	weapon:setCustomName(true);
    if weapon:getModData().Guns93Icon == nil or weapon:getModData().Guns93Icon == "" then
        if weapon:getFullType() == "Base.DWK2" then
            weapon:getModData().Guns93Icon = "K2"
        else
            weapon:getModData().Guns93Icon = "DR200"
        end
    end
end