MagazineGunSet = MagazineGunSet or {}

	MagazineGunSet["Base.AR15"] = {"Base.M16Mag","Base.20M16Mag","Base.BetaCMag","Base.20M16AR180Mag","Base.30M16AR180Mag","Base.40M16AR180Mag","Base.TherARMag"}
	MagazineGunSet["Base.M733"] = MagazineGunSet["Base.AR15"]
	MagazineGunSet["Base.Dissy"] = MagazineGunSet["Base.AR15"]
	MagazineGunSet["Base.HBAR"] = MagazineGunSet["Base.AR15"]
	MagazineGunSet["Base.CAR15"] = MagazineGunSet["Base.AR15"]
	MagazineGunSet["Base.M16A2"] = MagazineGunSet["Base.AR15"]
	MagazineGunSet["Base.M723"] = MagazineGunSet["Base.AR15"]
	MagazineGunSet["Base.M727"] = MagazineGunSet["Base.AR15"]
	MagazineGunSet["Base.DWK1A"] = MagazineGunSet["Base.AR15"]
	MagazineGunSet["Base.DWK1A1"] = MagazineGunSet["Base.AR15"]
	MagazineGunSet["Base.DWK2"] = MagazineGunSet["Base.AR15"]
	MagazineGunSet["Base.DR200"] = MagazineGunSet["Base.AR15"]
	MagazineGunSet["Base.FNC"] = MagazineGunSet["Base.AR15"]

	MagazineGunSet["Base.M249"] = {"Base.M249Box"}
    for _, magName in ipairs(MagazineGunSet["Base.AR15"]) do
        table.insert(MagazineGunSet["Base.M249"], magName)
    end

	MagazineGunSet["Base.AR180"] = {"Base.AR180Mag","Base.40AR180Mag","Base.20M16AR180Mag","Base.30M16AR180Mag","Base.40M16AR180Mag"}

	MagazineGunSet["Base.AKM"] = {"Base.AKMag","Base.AKBakeMag","Base.40AKMag","Base.AKDrumMag","Base.AK5Mag"}
	MagazineGunSet["Base.AKSport"] = MagazineGunSet["Base.AKM"]
	MagazineGunSet["Base.T56"] = MagazineGunSet["Base.AKM"]

	MagazineGunSet["Base.Uzi"] = {"Base.UziMag","Base.25UziMag","Base.UziColtSMGMag","Base.25UziColtSMGMag","Base.10UziColtSMGMag","Base.40UziColtSMGMag","Base.10UziMag","Base.40UziMag"}
	MagazineGunSet["Base.UziCarbine"] = MagazineGunSet["Base.UziCarbine"]
	MagazineGunSet["Base.MiniUzi"] = MagazineGunSet["Base.UziCarbine"]
	MagazineGunSet["Base.MiniUziCar"] = MagazineGunSet["Base.UziCarbine"]
	MagazineGunSet["Base.MicroUzi"] = MagazineGunSet["Base.UziCarbine"]

	MagazineGunSet["Base.Uzi45"] = {"Base.12Uzi45Mag","Base.16Uzi45Mag","Base.22Uzi45Mag"}
	MagazineGunSet["Base.UziCarbine45"] = MagazineGunSet["Base.Uzi45"]
	MagazineGunSet["Base.MiniUzi45"] = MagazineGunSet["Base.Uzi45"]
	MagazineGunSet["Base.MiniUziCar45"] = MagazineGunSet["Base.Uzi45"]
	MagazineGunSet["Base.MicroUzi45"] = MagazineGunSet["Base.Uzi45"]

	MagazineGunSet["Base.M635"] = {"Base.ColtSMGMag","Base.UziColtSMGMag","Base.25UziColtSMGMag","Base.10UziColtSMGMag","Base.40UziColtSMGMag"}
	MagazineGunSet["Base.Colt9mm"] = MagazineGunSet["Base.M635"]

	MagazineGunSet["Base.HK91"] = {"Base.HK91Mag","Base.HK9110Mag","Base.HK915Mag"}
	MagazineGunSet["Base.HKSR9"] = MagazineGunSet["Base.HK91"]

	MagazineGunSet["Base.HK93"] = {"Base.HK93Mag","Base.25HK93Mag","Base.40HK93Mag"}

	MagazineGunSet["Base.MP5"] = {"Base.MP5Mag","Base.MP5StraightMag","Base.15MP5Mag","Base.40MP5Mag"}
	MagazineGunSet["Base.HK94"] = MagazineGunSet["Base.MP5"]
	MagazineGunSet["Base.MP5SD"] = MagazineGunSet["Base.MP5"]

	MagazineGunSet["Base.MAC10"] = {"Base.MAC10Mag","Base.MACGreaseMag"}
	MagazineGunSet["Base.MAC11A1"] = {"Base.MAC11A1Mag","Base.16MAC11A1Mag"}
	MagazineGunSet["Base.M3GreaseGun"] = {"Base.M3GreaseMag","Base.MACGreaseMag"}
	MagazineGunSet["Base.M1Carbine"] = {"Base.M1CarMag","Base.30M1CarMag"}

	MagazineGunSet["Base.Mini14"] = {"Base.Mini14Mag","Base.30Mini14Mag","Base.TherMini14Mag","Base.Mini14MagSS","Base.30Mini14MagSS","Base.40Mini14Mag","Base.40Mini14MagSS"}
	MagazineGunSet["Base.Mini14GB"] = MagazineGunSet["Base.Mini14"]
	MagazineGunSet["Base.AC556K"] = MagazineGunSet["Base.Mini14"]

	MagazineGunSet["Base.Mini30"] = {"Base.Mini30Mag","Base.Mini30MagSS","Base.30Mini30Mag"}

	MagazineGunSet["Base.CalicoRifle"] = {"Base.CalicoMag","Base.100CalicoMag"}
	MagazineGunSet["Base.CalicoPistol"] = MagazineGunSet["Base.CalicoRifle"]

	MagazineGunSet["Base.Rug1022"] = {"Base.1022Mag","Base.25Rug1022Mag"}

	MagazineGunSet["Base.M1911"] = {"Base.45Clip","Base.1911MagExtend","Base.1911MagSS","Base.1911MagExtendSS","Base.1911Mag"}
	MagazineGunSet["Base.Gov1911"] = MagazineGunSet["Base.M1911"]
	MagazineGunSet["Base.Longslide"] = MagazineGunSet["Base.M1911"]
	MagazineGunSet["Base.Command1911"] = MagazineGunSet["Base.M1911"]

	MagazineGunSet["Base.Officer1911"] = {"Base.OfficerMag"}
    for _, magName in ipairs(MagazineGunSet["Base.M1911"]) do
        table.insert(MagazineGunSet["Base.Officer1911"], magName)
    end

	MagazineGunSet["Base.Marlin45"] = MagazineGunSet["Base.Officer1911"]

	MagazineGunSet["Base.DeltaElite"] = {"Base.DeltaEliteMag","Base.DeltaEliteMagExtend","Base.DeltaEliteMagBlue","Base.DeltaEliteMagExtendBlue"}
	MagazineGunSet["Base.Javelina"] = MagazineGunSet["Base.DeltaElite"]

	MagazineGunSet["Base.M9"] = {"Base.9mmClip","Base.20M9Mag","Base.Beretta92Mag"}
	MagazineGunSet["Base.Beretta92FS"] = MagazineGunSet["Base.M9"]

	MagazineGunSet["Base.BHP"] = {"Base.BHPMag","Base.15BHPMag","Base.17BHPMag","Base.BHPMagSS"}

	MagazineGunSet["Base.Glock17"] = {"Base.G17Mag","Base.G17ExtMag","Base.G17StickMag"}
	MagazineGunSet["Base.Glock17L"] = MagazineGunSet["Base.Glock17"]
	
	MagazineGunSet["Base.Glock19"] = {"Base.G19Mag","Base.G19ExtMag"}
    for _, magName in ipairs(MagazineGunSet["Base.Glock17"]) do
        table.insert(MagazineGunSet["Base.Glock19"], magName)
    end

	MagazineGunSet["Base.Glock23"] = {"Base.G23Mag","Base.G22Mag"}

	MagazineGunSet["Base.M14308"] = {"Base.M14Clip","Base.10M14Mag","30M14Mag","Base.M14Mag"}
	MagazineGunSet["Base.M1A"] = MagazineGunSet["Base.M14308"]
	MagazineGunSet["Base.M1ABush"] = MagazineGunSet["Base.M14308"]

	MagazineGunSet["Base.TommyM1A1"] = {"Base.20TommyMag","Base.30TommyMag"}

	MagazineGunSet["Base.TommyM1928"] = {"Base.TommyDrum"}
    for _, magName in ipairs(MagazineGunSet["Base.TommyM1A1"]) do
        table.insert(MagazineGunSet["Base.TommyM1928"], magName)
    end

	MagazineGunSet["Base.ColtDet"] = {"Base.HKSDSA38","Base.SpeedStrip357"}
	MagazineGunSet["Base.Diamondback"] = MagazineGunSet["Base.ColtDet"]

	MagazineGunSet["Base.SW36"] = {"Base.HKS36A357","Base.SpeedStrip357"}
	MagazineGunSet["Base.SW10"] = {"Base.HKS10A357","Base.Size4CompII357","Base.Size4CompIII357","Base.SpeedStrip357"}
	MagazineGunSet["Base.SW65"] = MagazineGunSet["Base.SW10"]

	MagazineGunSet["Base.SW17"] = {"Base.HKS22K"}
	MagazineGunSet["Base.Diamondback22"] = MagazineGunSet["Base.SW17"]

	MagazineGunSet["Base.SW586"] = {"Base.HKS586A357","Base.Size5CompII357","Base.Size5CompIII357","Base.SpeedStrip357"}
	MagazineGunSet["Base.GP100"] = MagazineGunSet["Base.SW586"]

	MagazineGunSet["Base.Python"] = {"Base.HKSPYA357","Base.Size3CompII357","Base.Size3CompIII357","Base.SpeedStrip357"}

	MagazineGunSet["Base.SecuritySix"] = {"Base.HKSMK3A357","Base.Size6CompII357","Base.Size6CompIII357","Base.SpeedStrip357"}
	MagazineGunSet["Base.ColtTrooper"] = MagazineGunSet["Base.SecuritySix"]
	MagazineGunSet["Base.ColtLawman"] = MagazineGunSet["Base.SecuritySix"]
	MagazineGunSet["Base.KingCobra"] = MagazineGunSet["Base.SecuritySix"]

	MagazineGunSet["Base.GP101"] = {"Base.HKS36A357","Base.SpeedStrip357"}
	MagazineGunSet["Base.SW625"] = {"Base.45Moonclip"}

	MagazineGunSet["Base.SW29"] = {"Base.HKS29M44","Base.SpeedStrip44"}
	MagazineGunSet["Base.Anaconda"] = MagazineGunSet["Base.SW29"]

	MagazineGunSet["Base.SKS"] = {"Base.SKSclip"}

	MagazineGunSet["Base.M1903"] = {"Base.3006clip"}
	MagazineGunSet["Base.M1917"] = MagazineGunSet["Base.M1903"]

	MagazineGunSet["Base.Mauser98K"] = {"Base.Mauserclip"}