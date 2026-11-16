local Guns93ContextMenu = function(playerid, context, items)
	local player = getSpecificPlayer(playerid)
	local hasFoldStock = false
	local hasActiveItem = false
	local hasBayonet = false
	local fixBayonet = false
	local hasFoldBayo = false
	local hasAmmoSwitch = false
	local stopOnce = false
	for _, v in ipairs(items) do
		local item = v
		if not instanceof(v, "InventoryItem") then
			item = v.items[1]
		end
		if stopOnce == false then
			stopOnce = true
			if instanceof(item, "HandWeapon") then
				local subMenuUp = context:getNew(context);
				for index, preset in ipairs(FoldingStockSet) do
					if item:getWeaponPart("Stock") then
						local topBlock = false
						if item:getWeaponPart("Stock"):hasTag(Gun93Registries.guns93.TopFold) then
							if item:getWeaponPart("Scope") then
								if item:getWeaponPart("Scope"):hasTag(Gun93Registries.guns93.TopBlock) then
									topBlock = true
								end
							end
							if item:getWeaponPart("Receiver") then
								if item:getWeaponPart("Receiver"):hasTag(Gun93Registries.guns93.TopBlock) then
									topBlock = true
								end
							end
						end
						if preset == item:getWeaponPart("Stock"):getFullType() and topBlock == false then
							hasFoldStock = true
							local indexMod = (index % 2) * 2 - 1
							local actionString = ""
							if (indexMod > 0) then
								actionString = getText("IGUI_ContextMenu_FoldStock")
							else
								actionString = getText("IGUI_ContextMenu_UnfoldStock")
							end
							local listEntry = subMenuUp:addOption(actionString, item, Guns93StockAdjust.callAction, index + indexMod, player)
						end	
					end
				end
				if item:getWeaponPart("Bayonet") and not item:getWeaponPart("Bayonet"):hasTag(Gun93Registries.guns93.BayoFolded) then
					hasBayonet = true
					local actionString = ""
					if item:getSubCategory() == "Firearm" then
						actionString = getText("IGUI_ContextMenu_UseBayonet")
					else
						actionString = getText("IGUI_ContextMenu_UseFirearm")
					end
					local listEntry = subMenuUp:addOption(actionString, item, Guns93UseBayonet.callAction, item:getWeaponPart("Bayonet"), player)
				end
				if item:getWeaponPart("Bayonet") then
					if item:getWeaponPart("Bayonet"):hasTag(Gun93Registries.guns93.FoldingBayo) then
						hasFoldBayo = true
						local actionString = ""
						if MuzzleDeviceCheck(item) == true and item:getWeaponPart("Bayonet"):hasTag(Gun93Registries.guns93.BayoFolded) then
							actionString = getText("IGUI_ContextMenu_UnfoldBayonet")
						else
							actionString = getText("IGUI_ContextMenu_FoldBayonet")
						end
						local listEntry = subMenuUp:addOption(actionString, item, Guns93FoldBayo.callAction, index, player, item:getWeaponPart("Bayonet"))
					end
				end
				if not item:getWeaponPart("Bayonet") and item:hasTag(Gun93Registries.guns93.Guns93) then
					if MuzzleDeviceCheck(item) == true then
						for i=1, player:getInventory():getItems():size() do
							local findbayo = player:getInventory():getItems():get(i-1)
							local bayoTag = false
							if findbayo:hasTag(Gun93Registries.guns93.Bayonet) and findbayo:hasTag(Gun93Registries.guns93.NoScrewdriver) then
								bayoTag = findbayo:getType()
							end
							if bayoTag then
								local bayo = nil
								if item:hasTag(Gun93Registries.guns93[bayoTag]) then
									bayo = findbayo
								end
								if item:getWeaponPart("BarrelItem") then
									if item:getWeaponPart("BarrelItem"):hasTag(Gun93Registries.guns93[bayoTag]) then
										bayo = findbayo
									end
								end
								if item:getWeaponPart("BayoLug") then
									if item:getWeaponPart("BayoLug"):hasTag(Gun93Registries.guns93[bayoTag]) then
										bayo = findbayo
									end
								end
								if bayo ~= nil then
									fixBayonet = true
									actionString = getText("IGUI_FirearmRadial_PreFix") .. bayo:getDisplayName() .. " " .. "(" .. bayo:getCondition()*10 .. "%)"
									local listEntry = subMenuUp:addOption(actionString, item, Guns93FixBayonet.callAction, index, player, bayo)
								end
							end
						end
					end
				end
				if item:getWeaponPart("Bayonet") and not item:getWeaponPart("Bayonet"):hasTag(Gun93Registries.guns93.FoldingBayo) then
					if item:getWeaponPart("Bayonet") then
						actionString = getText("IGUI_FirearmRadial_PreRemove").. item:getWeaponPart("Bayonet"):getDisplayName()
					end
					local listEntry = subMenuUp:addOption(actionString, item, Guns93FixBayonet.callAction, index, player, item:getWeaponPart("Bayonet"))
				end
				local toggleParts = item:getAllWeaponParts()
				for i=0, toggleParts:size()-1 do
					local togglePart = toggleParts:get(i)
					local toggle = false
					local noBat = false
					local actionString = ""
					if togglePart:hasTag(Gun93Registries.guns93.Bipod) then
						if togglePart:hasTag(Gun93Registries.guns93.ToggleItemOn) then
							toggle = true
							actionString = getText("IGUI_ContextMenu_UnfoldBipod")
						elseif togglePart:hasTag(Gun93Registries.guns93.ToggleItemOff) then
							toggle = true
							actionString = getText("IGUI_ContextMenu_FoldBipod")
						end
					elseif togglePart:hasTag(Gun93Registries.guns93.Light) then
						if togglePart:getCurrentUses() <= 0 then
							noBat = true
							actionString = getText("IGUI_ContextMenu_NoBatLight")
						elseif togglePart:hasTag(Gun93Registries.guns93.ToggleItemOn) then
							toggle = true
							actionString = getText("IGUI_ContextMenu_ToggleOnLight")
						elseif togglePart:hasTag(Gun93Registries.guns93.ToggleItemOff) then
							toggle = true
							actionString = getText("IGUI_ContextMenu_ToggleOffLight")
						end
					elseif togglePart:hasTag(Gun93Registries.guns93.Laser) then
						if togglePart:getCurrentUses() <= 0 then
							noBat = true
							actionString = getText("IGUI_ContextMenu_NoBatLaser")
						elseif togglePart:hasTag(Gun93Registries.guns93.ToggleItemOn) then
							toggle = true
							actionString = getText("IGUI_ContextMenu_ToggleOnLaser")
						elseif togglePart:hasTag(Gun93Registries.guns93.ToggleItemOff) then
							toggle = true
							actionString = getText("IGUI_ContextMenu_ToggleOffLaser")
						end
					elseif togglePart:hasTag(Gun93Registries.guns93.RedDot) then
						if togglePart:getCurrentUses() <= 0 then
							noBat = true
							actionString = getText("IGUI_ContextMenu_NoBatSight")
						elseif togglePart:hasTag(Gun93Registries.guns93.ToggleItemOn) then
							toggle = true
							actionString = getText("IGUI_ContextMenu_ToggleOnSight")
						elseif togglePart:hasTag(Gun93Registries.guns93.ToggleItemOff) then
							toggle = true
							actionString = getText("IGUI_ContextMenu_ToggleOffSight")
						end
					end
					if noBat then
						hasActiveItem = true
						local listEntry = subMenuUp:addOption(actionString, item, Guns93ActiveItem.callAction, togglePart, player)
						listEntry.notAvailable = true
					elseif toggle then
						hasActiveItem = true
						local listEntry = subMenuUp:addOption(actionString, item, Guns93ActiveItem.callAction, togglePart, player)
					end
				end
				if hasAmmoSwitch or hasBayonet or fixBayonet or hasFoldBayo or hasFoldStock or hasActiveItem then
					local firearmOption = context:addOption(getText("IGUI_ContextMenu_FirearmOptions"));
					context:addSubMenu(firearmOption, subMenuUp);
				end
			end
			for index, preset in ipairs(MagTypeSet) do
				if preset == item:getFullType() then
					local addmenu = true
					local indexMod = (index % 2) * 2 - 1
					local magAmmo = ScriptManager.instance:getItem(MagTypeSet[index + indexMod])
					local actionString = getText("IGUI_ContextMenu_SwitchTo") .. string.gsub(getItemNameFromFullType(magAmmo:getAmmoType():getItemKey()), " Round", "")
					local listEntry = context:addOption(actionString, item, Guns93MagSwitch.callAction, index + indexMod, player)
				end	
			end
			if item:hasTag(Gun93Registries.guns93.Guns93) or item:hasTag(Gun93Registries.guns93.Guns93Can) and item:getModData().mod_fouling and not item:hasTag(Gun93Registries.guns93.NoFix) then
				local subMenuUp2 = context:getNew(context);
				local subsubMenuUp1 = subMenuUp2:getNew(context);
				local subsubMenuUp2 = subMenuUp2:getNew(context);
				local actionString = nil
				local itemType = "Firearm"
				if not SandboxVars.Guns93.Guns93Fouling then
					local cleankit = nil
					if (item:getModData().mod_fouling + item:getBloodLevel()) > 0 then
						if item:getCategory() == "WeaponPart" then
							itemType = "Silencer"
						end
						local cleankits = ArrayList.new()
						player:getInventory():getAllTagRecurse(Gun93Registries.guns93.GunCleaningKit, cleankits)

						local nokit = false
						if cleankits and cleankits:size() > 0 then
							for i = 0, cleankits:size() - 1 do
								cleankit = cleankits:get(i)
								if not cleankit:hasTag(Gun93Registries.guns93.EmptyGunCleanKit) then
									if cleankit:getCurrentUsesFloat() > 0.0 then
										if cleankit ~= nil then
											local cleanOption = subsubMenuUp1:addOption("Use " .. cleankit:getName() .. " (" .. cleankit:getCurrentUsesFloat()*100 .. "%)", item, Guns93UseCleaningKit.callAction, player, cleankit, context)
											local playerSkill = (player:getPerkLevel(Perks.Aiming)+1)*5
--											if player:hasTrait(CharacterTrait.Hunter) then
--												playerSkill = playerSkill + 5
--											end
											if cleankit:hasTag(Gun93Registries.guns93.BadGunClean) then
												playerSkill = round(playerSkill/1.5,0)
											end
											local dirtyAmount = item:getModData().mod_fouling
											if (item:getBloodLevel()*100) > dirtyAmount then
												dirtyAmount = item:getBloodLevel()*100
											end
											local cleanUses = round(dirtyAmount/playerSkill,0)
											if cleanUses < 1 then
												cleanUses = 1
											end
											local kitUses = cleankit:getCurrentUses()
											if kitUses < cleanUses then
												cleanUses = kitUses
											end
											local cleanAmount = (cleanUses * playerSkill)/dirtyAmount
											if cleanAmount < 0.1 then
												cleanAmount = 0.1
											elseif cleanAmount > 1 then
												cleanAmount = 1
											end
											local tooltipObject = ISWorldObjectContextMenu.addToolTip()
											tooltipObject.texture = cleankit:getTex();
											tooltipObject:setName(cleankit:getName());
											tooltipObject.description = "Will Clean " .. round(cleanAmount*100,1) .. "% of Fouling and Blood. "
											tooltipObject.description = tooltipObject.description .. "<LINE>" .. "Will use " .. cleanUses .. " of " .. cleankit:getCurrentUses() .. " remaining uses. "
											cleanOption.toolTip = tooltipObject
											nokit = true
										end
									end
								end
							end
						end
						if nokit == false then
							local cleanOption = subsubMenuUp1:addOption(getText("No Cleaning Kit Avaliable"), item, Guns93UseCleaningKit.callAction, player, cleankit)
							cleanOption.notAvailable = true
						end
					else
						local cleanOption = subsubMenuUp1:addOption(getText("Cleaning Not Necessary"), item, Guns93UseCleaningKit.callAction, player, cleankit)
						cleanOption.notAvailable = true
					end
					local howDirty = item:getModData().mod_fouling
					if item:getModData().mod_fouling < (item:getBloodLevel() * 100) then
						howDirty = round(item:getBloodLevel() * 100, 2)
					end
					local cleanState = "Clean "
					local cleanResult = "<RGB:0,1,0>" .. "No Detrimental Effects "
					local foulState = "<RGB:0,1,0>" .. "No Fouling "
					local bloodStat = "<RGB:0,1,0>" .. "No Blood "
					if howDirty > 80 then
						cleanState = "Filthy "
						cleanResult = "<RGB:1,0,0>" .. "Horribly Affected Jam Chance "
						cleanResult = cleanResult .. "<LINE> <RGB:1,0,0>" .. "Horribly Affected Condition Lower Chance "
					elseif howDirty > 60 then
						cleanState = "Very Dirty "
						cleanResult = "<RGB:1,0.5,0>" .. "Affected Jam Chance "
						cleanResult = cleanResult .. "<LINE> <RGB:1,0.5,0>" .. "Badly Affected Condition Lower Chance "
					elseif howDirty > 30 then
						cleanState = "Dirty "
						cleanResult = "<RGB:1,1,0>" .. "Slightly Affected Jam Chance "
						cleanResult = cleanResult .. "<LINE> <RGB:1,0.5,0>" .. "Affected Condition Lower Chance "
					elseif howDirty > 5 then
						cleanState = "Slight Dirty "
					end
					if item:getModData().mod_fouling > 70 then
						foulState = "<RGB:1,0,0>" .. "Heavy Fouling "
					elseif item:getModData().mod_fouling > 40 then
						foulState = "<RGB:1,0.5,0>" .. "Moderate Fouling "
					elseif item:getModData().mod_fouling > 5 then
						foulState = "<RGB:1,1,0>" .. "Light Fouling "
					end
					if item:getBloodLevel() > 0.7 then
						bloodStat = "<RGB:1,0,0>" .. "Dripping With Blood "
					elseif item:getBloodLevel() > 0.4 then
						bloodStat = "<RGB:1,0.5,0>" .. "Mostly Covered In Blood "
					elseif item:getBloodLevel() > 0.0 then
						bloodStat = "<RGB:1,1,0>" .. "Somewhat Bloody "
					end	
					local MaintOption2 = subMenuUp2:addOption(itemType .. " Is " .. cleanState);
					local tooltipObject = ISWorldObjectContextMenu.addToolTip()
					tooltipObject.description = cleanState
					tooltipObject.description = tooltipObject.description .. "<LINE>" .. foulState
					if not item:hasTag(Gun93Registries.guns93.Guns93Can) then
						tooltipObject.description = tooltipObject.description .. "<LINE>" .. bloodStat
					end
					tooltipObject.description = tooltipObject.description .. "<LINE> <LINE>" .. "<RGB:1,1,1>" .. "Effects "
					tooltipObject.description = tooltipObject.description .. "<LINE>" .. cleanResult
					MaintOption2.toolTip = tooltipObject
					subMenuUp2:addSubMenu(MaintOption2, subsubMenuUp1);
				end
				if item:getModData().modParts_Type then
					local repairParts = ArrayList.new()
					player:getInventory():getAllTagRecurse(Gun93Registries.guns93.Guns93, repairParts)
					player:getInventory():getAllTagRecurse(Gun93Registries.guns93.GunParts, repairParts)
					local partsFound = false
					local part = nil
					for i=1, repairParts:size() do
						part = repairParts:get(i-1)
						if part:hasTag(Gun93Registries.guns93.Guns93) or part:hasTag(Gun93Registries.guns93.Guns93Can) then
							local MaintOption3 = nil
							if item ~= part then
								local match = 0
								local noMatch = false
								if item:hasTag(Gun93Registries.guns93.Guns93Can) then
									if part:getModData().modBore_Eff then
										if item:getModData().modParts_Type == part:getModData().modParts_Type then
											match = match + 1
										end
										if item:getModData().modBore_Eff == part:getModData().modBore_Eff then
											match = match + 2
										end
										if item:getModData().modBore_Eff < part:getModData().modBore_Eff then
											match = match + 1
										end
										if item:getModData().modBore_Eff > part:getModData().modBore_Eff then
											noMatch = true
										end
									end
								else
									if item:getModData().modParts_Type == part:getModData().modParts_Type then
										match = match + 1
									end
									if part:getModData().modParts_Ammo then
										if item:getAmmoType():getItemKey() == part:getModData().modParts_Ammo then
											match = match + 1
										end
									elseif item:getAmmoType() == part:getAmmoType() then
										match = match + 1
									end
									if item:getModData().modParts_Group == part:getModData().modParts_Group then
										match = match + 1
									end
								end
								if (match > 1 or item:getModData().modParts_Group == part:getModData().modParts_Group) and not noMatch then
									partsFound = true
									MaintOption3 = subMenuUp2:addOption("> Repair w/ " .. part:getDisplayName(), item, Guns93RepairFirearm.callAction, player, part, context);
									local playerSkill = player:getPerkLevel(Perks.Aiming)
									local itemSkill = item:getModData().modParts_Level
									local itemCon = item:getCondition()
									local repairNum = item:getHaveBeenRepaired()
									local repairCon = part:getCondition()
									local tooltipObject2 = ISWorldObjectContextMenu.addToolTip()
									local skillRepair = 5*(playerSkill-itemSkill)
									local skillColor = ISInventoryPaneContextMenu.bhs
									if playerSkill < itemSkill then
										skillRepair = -15*(itemSkill-playerSkill)
									elseif skillRepair > 25 then
										skillRepair = 25
									end
									local potentRepair = (itemCon+((10/(repairNum+1))+skillRepair)/(item:getConditionMax()/repairCon))*(match/3)
									local chancSucc = (5+(playerSkill*30)-(repairNum*2))*(match/3)
--									if player:hasTrait(CharacterTrait.Hunter) then
--										chancSucc = chancSucc + 5
--									end
									if playerSkill >= itemSkill then
										skillColor = ISInventoryPaneContextMenu.ghs
									else
										MaintOption3.notAvailable = true
									end
									local compatible = "Barely"
									local repairNote = "Will Increase Fix Number."
									if match > 2 then
										compatible = "Yes"
										repairNote = "Will Not Increase Fix Number."
									elseif match > 1 then
										compatible = "Partial"
									end
									local repairedCol = ColorInfo.new(0, 0, 0, 1)
									local successCol = ColorInfo.new(0, 0, 0, 1)
									local conditionCol = ColorInfo.new(0, 0, 0, 1)
									local compatibleCol = ColorInfo.new(0, 0, 0, 1)
									getCore():getBadHighlitedColor():interp(getCore():getGoodHighlitedColor(), potentRepair/100, repairedCol);
									getCore():getBadHighlitedColor():interp(getCore():getGoodHighlitedColor(), chancSucc/100, successCol);
									getCore():getBadHighlitedColor():interp(getCore():getGoodHighlitedColor(), repairCon/item:getConditionMax(), conditionCol);
									getCore():getBadHighlitedColor():interp(getCore():getGoodHighlitedColor(), match/3, compatibleCol);
									local color1 = "<RGB:".. repairedCol:getR() ..",".. repairedCol:getG() ..",".. repairedCol:getB()..">";
									local color2 = "<RGB:".. successCol:getR() ..",".. successCol:getG() ..",".. successCol:getB()..">";
									local color3 = "<RGB:".. conditionCol:getR() ..",".. conditionCol:getG() ..",".. conditionCol:getB()..">";
									local color4 = "<RGB:".. compatibleCol:getR() ..",".. compatibleCol:getG() ..",".. compatibleCol:getB()..">";
									if potentRepair > 100 then
										potentRepair = 100
									elseif potentRepair < 0 then
										potentRepair = 0
									end
									if chancSucc > 100 then
										chancSucc = 100
									elseif chancSucc < 0 then
										chancSucc = 0
									end
									tooltipObject2.texture = part:getTex();
									tooltipObject2:setName("Repair " .. item:getName());
									tooltipObject2.description = " "  .. " " .. part:getName();
									tooltipObject2.description = tooltipObject2.description .. " <LINE> " .. color3 .. "Condition: " .. (repairCon/(item:getConditionMax()/10))*10 .. "%";
									tooltipObject2.description = tooltipObject2.description .. " <LINE> " .. color4  .. "Is Compatible: " .. compatible;
									tooltipObject2.description = tooltipObject2.description .. " <LINE> " .. "<RGB:1,1,1> " .. repairNote;
									tooltipObject2.description = tooltipObject2.description .. " <LINE> <LINE> " .. color1  .. " " .. getText("Tooltip_potentialRepair") .. " " .. round(potentRepair,1) .. "%";
									tooltipObject2.description = tooltipObject2.description .. " <LINE> " .. color2 .. " " .. getText("Tooltip_chanceSuccess") .. " " .. round(chancSucc,1) .. "%";
									tooltipObject2.description = tooltipObject2.description .. " <LINE> <LINE> <RGB:1,1,1> " .. getText("Tooltip_craft_Needs") .. ": <LINE> "
									tooltipObject2.description = tooltipObject2.description .. skillColor .. getText("IGUI_perks_Aiming") .. " " .. playerSkill .. "/" .. itemSkill
									MaintOption3.toolTip = tooltipObject2
								end
							end
						end
					end
					if partsFound == false then
						local newNam = string.gsub(item:getName(), ", Booster", "")
						local MaintOption3 = subMenuUp2:addOption("> Repair w/ " .. newNam, item, Guns93RepairFirearm.callAction, player, part, context);
						MaintOption3.notAvailable = true
					end
					local partsFound2 = false
					for i=1, repairParts:size() do
						local part = repairParts:get(i-1)
						local match = 0
						local noMatch = false
						if part:hasTag(Gun93Registries.guns93.GunParts) then
							if item:hasTag(Gun93Registries.guns93.Guns93Can) then
								if part:getModData().modBore_Eff then
									if item:getModData().modParts_Type == part:getFullType() then
										match = match + 1
									end
									if item:getModData().modBore_Eff == part:getModData().modBore_Eff then
										match = match + 2
									end
									if item:getModData().modBore_Eff < part:getModData().modBore_Eff then
										match = match + 1
									end
									if item:getModData().modBore_Eff > part:getModData().modBore_Eff then
										noMatch = true
									end
								end
							else
								if item:getModData().modParts_Type == part:getFullType() then
									match = match + 1
								end
								if part:getModData().modParts_Ammo then
									if item:getAmmoType():getItemKey() == part:getModData().modParts_Ammo then
										match = match + 1
									end
								elseif item:getAmmoType() == part:getAmmoType() then
									match = match + 1
								end
								if item:getModData().modParts_Group == part:getModData().modParts_Group then
									match = match + 1
								end
							end
							if (match > 1 or item:getModData().modParts_Group == part:getModData().modParts_Group) and not noMatch then
								partsFound2 = true
								local MaintOption3 = subMenuUp2:addOption("> Repair w/ " .. part:getDisplayName(), item, Guns93RepairFirearm.callAction, player, part, context);
								local playerSkill = player:getPerkLevel(Perks.Aiming)
								local itemSkill = item:getModData().modParts_Level
								local itemCon = item:getCondition()
								local repairNum = item:getHaveBeenRepaired()
								local repairCon = part:getCondition()
								local tooltipObject2 = ISWorldObjectContextMenu.addToolTip()
								local skillRepair = 5*(playerSkill-itemSkill)
								local skillColor = ISInventoryPaneContextMenu.bhs
								if playerSkill < itemSkill then
									skillRepair = -15*(itemSkill-playerSkill)
								elseif skillRepair > 25 then
									skillRepair = 25
								end
								local potentRepair = (itemCon+((10/(repairNum+1))+skillRepair)/(item:getConditionMax()/repairCon))*(match/3)
								local chancSucc = (5+(playerSkill*30)-(repairNum*2))*(match/3)
--								if player:hasTrait(CharacterTrait.Hunter) or CharacterProfessionDefinition.getCharacterProfessionDefinition(CharacterProfession.veteran) then
--									chancSucc = chancSucc + 5
--								end
								if playerSkill >= itemSkill then
									skillColor = ISInventoryPaneContextMenu.ghs
								else
									MaintOption3.notAvailable = true
								end
								local compatible = "Barely"
								local repairNote = "Will Increase Fix Number."
								if match > 2 then
									compatible = "Yes"
									repairNote = "Will Not Increase Fix Number."
								elseif match > 1 then
									compatible = "Partial"
								end
								local repairedCol = ColorInfo.new(0, 0, 0, 1)
								local successCol = ColorInfo.new(0, 0, 0, 1)
								local conditionCol = ColorInfo.new(0, 0, 0, 1)
								local compatibleCol = ColorInfo.new(0, 0, 0, 1)
								getCore():getBadHighlitedColor():interp(getCore():getGoodHighlitedColor(), potentRepair/100, repairedCol);
								getCore():getBadHighlitedColor():interp(getCore():getGoodHighlitedColor(), chancSucc/100, successCol);
								getCore():getBadHighlitedColor():interp(getCore():getGoodHighlitedColor(), repairCon/item:getConditionMax(), conditionCol);
								getCore():getBadHighlitedColor():interp(getCore():getGoodHighlitedColor(), match/3, compatibleCol);
								local color1 = "<RGB:".. repairedCol:getR() ..",".. repairedCol:getG() ..",".. repairedCol:getB()..">";
								local color2 = "<RGB:".. successCol:getR() ..",".. successCol:getG() ..",".. successCol:getB()..">";
								local color3 = "<RGB:".. conditionCol:getR() ..",".. conditionCol:getG() ..",".. conditionCol:getB()..">";
								local color4 = "<RGB:".. compatibleCol:getR() ..",".. compatibleCol:getG() ..",".. compatibleCol:getB()..">";
								if potentRepair > 100 then
									potentRepair = 100
								elseif potentRepair < 0 then
									potentRepair = 0
								end
								if chancSucc > 100 then
									chancSucc = 100
								elseif chancSucc < 0 then
									chancSucc = 0
								end
								tooltipObject2.texture = part:getTex();
								tooltipObject2:setName("Repair " .. item:getName());
								tooltipObject2.description = " "  .. " " .. part:getName();
								tooltipObject2.description = tooltipObject2.description .. " <LINE> " .. color3 .. "Condition: " .. (repairCon/(item:getConditionMax()/10))*10 .. "%";
								tooltipObject2.description = tooltipObject2.description .. " <LINE> " .. color4  .. "Is Compatible: " .. compatible;
								tooltipObject2.description = tooltipObject2.description .. " <LINE> " .. "<RGB:1,1,1> " .. repairNote;
								tooltipObject2.description = tooltipObject2.description .. " <LINE> <LINE> " .. color1  .. " " .. getText("Tooltip_potentialRepair") .. " " .. round(potentRepair*(match/3),1) .. "%";
								tooltipObject2.description = tooltipObject2.description .. " <LINE> " .. color2 .. " " .. getText("Tooltip_chanceSuccess") .. " " .. round(chancSucc*(match/3),1) .. "%";
								tooltipObject2.description = tooltipObject2.description .. " <LINE> <LINE> <RGB:1,1,1> " .. getText("Tooltip_craft_Needs") .. ": <LINE> "
								tooltipObject2.description = tooltipObject2.description .. skillColor .. getText("IGUI_perks_Aiming") .. " " .. playerSkill .. "/" .. itemSkill
								MaintOption3.toolTip = tooltipObject2
							end
						end
					end
					if partsFound2 == false then
						local partNam = ""
						if item:hasTag(Gun93Registries.guns93.Guns93Can) then
							local newNam = string.gsub(item:getName(), ", Booster", "")
							partNam = getItemNameFromFullType(item:getModData().modParts_Type) .. " " .. newNam
						else
							local ammoNam = item:getAmmoType():getItemKey()
							ammoNam = getItemNameFromFullType(ammoNam)
							ammoNam = string.gsub(ammoNam, " Round", "")
							partNam = ammoNam .. " " .. getItemNameFromFullType(item:getModData().modParts_Type) .. " " .. getText(item:getModData().modParts_Group)
						end
						local MaintOption3 = subMenuUp2:addOption("> Repair w/ " .. partNam, item, Guns93RepairFirearm.callAction, player, part, context);
						MaintOption3.notAvailable = true
					end
				end
				local stripOption = subsubMenuUp2:addOption("Strip " .. item:getDisplayName() .. " For Parts (Destroy)", item, Guns93StripFirearmParts.callAction, player, true, context);
	--			local stripOption = subsubMenuUp2:addOption("Destroy " .. item:getDisplayName() .. " For Parts", item, Guns93StripFirearmParts.callAction, player, false);
				local MaintOption = context:addOption("Maintenance")
                context:addSubMenu(MaintOption, subMenuUp2)
                local MaintOption4 = subMenuUp2:addOption("Remove Parts")
                subMenuUp2:addSubMenu(MaintOption4, subsubMenuUp2)
			end
		end
	end
end

Events.OnPreFillInventoryObjectContextMenu.Add(Guns93ContextMenu)

local function guns93ApplyStoredIcon(item)
    if not item then return end
    local icon = item:getModData() and item:getModData().Guns93Icon
    if not icon or icon == "" then return end
    item:setTexture(getTexture("media/textures/item_" .. icon .. ".png"))
end

local function guns93ApplyIconsInContainer(container)
    if not container or not container.getItems then return end
    local items = container:getItems()
    if not items then return end
    for i = 0, items:size() - 1 do
        local item = items:get(i)
        guns93ApplyStoredIcon(item)
        if item and instanceof(item, "InventoryContainer") then
            guns93ApplyIconsInContainer(item:getInventory())
        end
    end
end

local function guns93PlayerIconRefresh(player, type)
    if not isClient() and isServer() then return end
    if not player then return end
	if instanceof(player, "isoPlayer") then
    	guns93ApplyIconsInContainer(player:getInventory())
	end
end

Events.OnRefreshInventoryWindowContainers.Add(guns93PlayerIconRefresh)

local old_refreshContainer = ISInventoryPane.refreshContainer
function ISInventoryPane:refreshContainer()
    if self.inventory then
        guns93ApplyIconsInContainer(self.inventory)
    end
    return old_refreshContainer(self)
end