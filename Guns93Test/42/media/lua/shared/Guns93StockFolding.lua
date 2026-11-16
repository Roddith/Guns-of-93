require "ISUI/ISInventoryPaneContextMenu"

FoldingStockSet = {
	"Base.CAR15StockOut","Base.CAR15StockIn",
	"Base.CAR15StockOutCamo","Base.CAR15StockInCamo",
	"Base.CAR15StockOutGray","Base.CAR15StockInGray",
	"Base.CAR15StockOutGreen","Base.CAR15StockInGreen",
	"Base.MP5ExtendStock","Base.MP5RetractStock",
	"Base.HK91ExtendStock","Base.HK91RetractStock",
	"Base.HK93ExtendStock","Base.HK93RetractStock",
	"Base.GreaseGunStockOut","Base.GreaseGunStockIn",
	"Base.A1GreaseGunStockOut","Base.A1GreaseGunStockIn",
	"Base.AR180StockOut","Base.AR180StockIn",
	"Base.ValmetStockOut","Base.ValmetStockIn",
	"Base.AKMSStockOut","Base.AKMSStockIn",
	"Base.AKSideFolderOut","Base.AKSideFolderIn",
	"Base.AKGalilFolderOut","Base.AKGalilFolderIn",
	"Base.AKWireStockOut","Base.AKWireStockIn",
	"Base.AKCrutchStockOut","Base.AKCrutchStockIn",
	"Base.CalicoStockOut","Base.CalicoStockIn",
	"Base.SPAS12StockOut","Base.SPAS12StockIn",
	"Base.870SideFoldOut","Base.870SideFoldIn",
	"Base.870TopFoldOut","Base.870TopFoldIn",
	"Base.500SideFoldOut","Base.500SideFoldIn",
	"Base.500TopFoldOut","Base.500TopFoldIn",
	"Base.Ithaca37SideFoldOut","Base.Ithaca37SideFoldIn",
	"Base.M14FoldStockOut","Base.M14FoldStockIn",
	"Base.Mini14FoldStockOut","Base.Mini14FoldStockIn",
	"Base.Mini14FoldStockOutSS","Base.Mini14FoldStockInSS",
	"Base.MAC10StockOut","Base.MAC10StockIn",
	"Base.MAC11StockOut","Base.MAC11StockIn",
	"Base.MAC11A1StockOut","Base.MAC11A1StockIn",
	"Base.UziStockOut","Base.UziStockIn",
	"Base.MiniUziStockOut","Base.MiniUziStockIn",
	"Base.MicroUziStockOut","Base.MicroUziStockIn",
	"Base.FNCParaFolderOut","Base.FNCParaFolderIn",
	"Base.K2FolderOut","Base.K2FolderIn",
	"Base.K1AFolderOut","Base.K1AFolderIn"
}

Guns93StockAdjust = {}

Guns93StockAdjust.callAction = function(item, index, player)
	if player:getPrimaryHandItem() ~= item or player:getSecondaryHandItem() ~= item then
		ISTimedActionQueue.add(ISEquipWeaponAction:new(player, item, 50, true, true));
	end
	if item and item:getContainer() == player:getInventory() then 
		ISTimedActionQueue.add(Guns93StockAdjustAction:new(item, index, player, CharacterActionAnims.Craft, 15))
	end
end

Guns93StockAdjustAction = ISBaseTimedAction:derive("Guns93StockAdjustAction");

function Guns93StockAdjustAction:new(item, index, character, anim, time)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
    o.item = item;
	o.index = index;
	o.stopOnWalk = false;
	o.stopOnRun = true;
	o.maxTime = time;
    o.caloriesModifier = 6;
	o.animation = anim
	o.useProgressBar = false;
	return o;
end

function Guns93StockAdjustAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 15
end

function Guns93StockAdjustAction:isValid() 
	local returnvalue = true
	if not self.item or self.item:getContainer() ~= self.character:getInventory() then 
		returnvalue = false;
	end
	return returnvalue;
end

function Guns93StockAdjustAction:waitToStart()
	return false;
end

function Guns93StockAdjustAction:start() 
	self.item:setJobType("Adjusting Stock");
	self.item:setJobDelta(0.0);
	self:setActionAnim(self.animation);
end

function Guns93StockAdjustAction:perform() 
	ISBaseTimedAction.perform(self);
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
end

function Guns93StockAdjustAction:complete()
	AdjustStock(self.item, self.index, self.character)
end

function Guns93StockAdjustAction:update()
	self.item:setJobDelta(self:getJobDelta());
    self.character:setMetabolicTarget(Metabolics.UsingTools);
end

function Guns93StockAdjustAction:stop()
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
end

function AdjustStock(item, newFoldingStock, player, result)
	
    local stock = instanceItem(FoldingStockSet[newFoldingStock])

    if stock then
        item:attachWeaponPart(stock)
    end
	syncHandWeaponFields(player, item)
    player:resetEquippedHandsModels()
end