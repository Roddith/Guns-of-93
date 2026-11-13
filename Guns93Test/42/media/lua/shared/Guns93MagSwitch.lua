require "ISUI/ISInventoryPaneContextMenu"

MagTypeSet = {
    "Base.L395KMag","Base.L395KMagSlugs",
	"Base.1911Mag","Base.DeltaEliteMagBlue",
	"Base.1911MagExtend","Base.DeltaEliteMagExtendBlue",
	"Base.1911MagSS","Base.DeltaEliteMag",
	"Base.1911MagExtendSS","Base.DeltaEliteMagExtend",
	"Base.MP5Mag10mm","Base.MP5Mag40SW",
	"Base.SpeedStrip357","Base.SpeedStrip38",
	"Base.HKS36A357","Base.HKS36A38",
	"Base.HKS10A357","Base.HKS10A38",
	"Base.HKS586A357","Base.HKS586A38",
	"Base.HKSPYA357","Base.HKSPYA38",
	"Base.HKSMK3A357","Base.HKSMK3A38",
	"Base.3006clip","Base.Mauserclip",
	"Base.Size3CompII357","Base.Size3CompII38",
	"Base.Size4CompII357","Base.Size4CompII38",
	"Base.Size5CompII357","Base.Size5CompII38",
	"Base.Size6CompII357","Base.Size6CompII38",
	"Base.Size3CompIII357","Base.Size3CompIII38",
	"Base.Size4CompIII357","Base.Size4CompIII38",
	"Base.Size5CompIII357","Base.Size5CompIII38",
	"Base.Size6CompIII357","Base.Size6CompIII38"
}

if isServer() then
    Events.OnClientCommand.Add(function(module, command, player, args)
        if module == 'Guns93' and command == 'MagSwitch' then
            local item = player:getInventory():FindAndReturn(args.itemType)
            if item then
                MagSwitch(item, args.index, player)
            end
        end
    end)
end

Guns93MagSwitch = {}

Guns93MagSwitch.callAction = function(item, index, player) 
    ISInventoryPaneContextMenu.transferIfNeeded(player, item)
	if item then 
		ISTimedActionQueue.add(Guns93MagSwitchAction:new(item, index, player, CharacterActionAnims.Craft, 1))
	end
end

Guns93MagSwitchAction = ISBaseTimedAction:derive("Guns93MagSwitchAction");

function Guns93MagSwitchAction:new(item, index, character, anim, time)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
    o.item = item;
	o.index = index;
	o.stopOnWalk = false;
	o.stopOnRun = true;
	o.maxTime = o:getDuration();
    o.caloriesModifier = 6;
	o.animation = anim
	o.useProgressBar = false;
	return o;
end

function Guns93MagSwitchAction:getDuration()
	return 1
end


function Guns93MagSwitchAction:isValid() 
	local returnvalue = true
	if not self.item or (self.item:getContainer() ~= self.character:getInventory()) then 
		returnvalue = false;
	end
	return returnvalue;
end

function Guns93MagSwitchAction:waitToStart()
	return false;
end

function Guns93MagSwitchAction:start()
	self.item:setJobType("Switch Magazine Ammo Type");
	self.item:setJobDelta(0.0);
	self:setOverrideHandModels(self.item:getStaticModel(), nil)
	if self.item:getCurrentAmmoCount() > 0 then
		ISTimedActionQueue.add(ISUnloadBulletsFromMagazine:new(self.character, self.item))
		return ISTimedActionQueue.add(Guns93MagSwitchAction:new(self.item, self.index, self.character, self.animation, 1))
	end
end

function Guns93MagSwitchAction:perform()
    ISBaseTimedAction.perform(self);
end

function Guns93MagSwitchAction:complete()
    if self.item:getCurrentAmmoCount() == 0 then
        if isClient() then
            sendClientCommand(self.character, 'Guns93', 'MagSwitch', {itemType = self.item:getFullType(), index = self.index})
        else
            MagSwitch(self.item, self.index, self.character)
        end
    end
    return true
end

function Guns93MagSwitchAction:update()
	self.item:setJobDelta(self:getJobDelta());
    self.character:setMetabolicTarget(Metabolics.UsingTools);
end

function Guns93MagSwitchAction:stop()
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
end

function MagSwitch(item, index, player)
    if not item or not player then return end
    if not isClient() then
        local newMag = player:getInventory():AddItem(MagTypeSet[index])
        player:getInventory():DoRemoveItem(item)
        sendRemoveItemFromContainer(player:getInventory(), item)
        sendAddItemToContainer(player:getInventory(), newMag)
	end
	if isClient() then
		local needed = newMag:getMaxAmmo() - newMag:getCurrentAmmoCount()
		if needed > 0 and newMag:getAmmoType():getItemKey() then
			local transferred = ISInventoryPaneContextMenu.transferBullets(player, newMag:getAmmoType():getItemKey(), 0, needed)
			if transferred > 0 then
				ISTimedActionQueue.add(ISLoadBulletsInMagazine:new(player, newMag, transferred))
			end
		end
    end
end