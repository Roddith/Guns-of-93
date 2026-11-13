require "Definitions/AttachedWeaponDefinitions"

AttachedWeaponDefinitions.BayonetBack = {
    chance = 0.5,
    weaponLocation = {"Knife in Back"},
    bloodLocations = {"Back"},
    addHoles = false,
    daySurvived = 40,
    weapons = {
    },
}

AttachedWeaponDefinitions.BayonetLeftLeg = {
    chance = 0.5,
    weaponLocation = {"Knife Left Leg"},
    bloodLocations = {"UpperLeg_L"},
    addHoles = false,
    daySurvived = 40,
    weapons = {
    },
}

AttachedWeaponDefinitions.BayonetRightLeg = {
    chance = 0.5,
    weaponLocation = {"Knife Right Leg"},
    bloodLocations = {"UpperRight_L"},
    addHoles = false,
    daySurvived = 40,
    weapons = {
    },
}

AttachedWeaponDefinitions.BayonetShoulder = {
    chance = 0.5,
    weaponLocation = {"Knife Shoulder"},
    bloodLocations = {"UpperArm_L", "Torso_Upper"},
    addHoles = false,
    daySurvived = 40,
    weapons = {
    },
}

AttachedWeaponDefinitions.BayonetStomach = {
    chance = 0.5,
    weaponLocation = {"Knife Stomach"},
    bloodLocations = {"Torso_Lower", "Back"},
    addHoles = false,
    daySurvived = 40,
    weapons = {
    },
}

	-- militia Knives
	AttachedWeaponDefinitions.militiaknivesBeltGuns93 = {
		chance = 50,
		outfit = {"Survivalist", "Survivalist02", "Survivalist03", "Survivalist04", "Survivalist05", "PrivateMilitia"},
		weaponLocation = {"Belt Right Upside"},
		bloodLocations = nil,
		addHoles = false,
		daySurvived = 0,
		weapons = {
		},
	}

	-- Military Knives
	AttachedWeaponDefinitions.armyknivesBeltGuns93 = {
		chance = 50,
		outfit = {"ArmyCamoDesert", "ArmyCamoGreen", "ArmyInstructor", "Ghillie"},
		weaponLocation = {"Belt Right Upside"},
		bloodLocations = nil,
		addHoles = false,
		daySurvived = 0,
		weapons = {
		},
	}

	-- Army --
	AttachedWeaponDefinitions.attachedWeaponCustomOutfit.ArmyCamoDesert = {
		chance = 50;
		maxitem = 3;
		weapons = {
			AttachedWeaponDefinitions.handgunHolsterArmy,
			AttachedWeaponDefinitions.assaultRifleArmyOnBack,
			AttachedWeaponDefinitions.armyknivesBeltGuns93,
		},
	}

	AttachedWeaponDefinitions.attachedWeaponCustomOutfit.ArmyCamoGreen = {
		chance = 50;
		maxitem = 3;
		weapons = {
			AttachedWeaponDefinitions.handgunHolsterArmy,
			AttachedWeaponDefinitions.assaultRifleArmyOnBack,
			AttachedWeaponDefinitions.armyknivesBeltGuns93,
		},
	}

	AttachedWeaponDefinitions.attachedWeaponCustomOutfit.ArmyInstructor = {
		chance = 60;
		maxitem = 3;
		weapons = {
			AttachedWeaponDefinitions.handgunHolsterArmy,
			AttachedWeaponDefinitions.assaultRifleArmyOnBack,
			AttachedWeaponDefinitions.rifleOnBackGhillie,
			AttachedWeaponDefinitions.armyknivesBeltGuns93,
		},
	}

	AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Ghillie = {
		chance = 70;
		maxitem = 2;
		weapons = {
			AttachedWeaponDefinitions.handgunHolsterArmy,
			AttachedWeaponDefinitions.rifleOnBackGhillie,
			AttachedWeaponDefinitions.armyknivesBeltGuns93,
		},
	}

Events.OnPreDistributionMerge.Add(ModifyAllLootTables)