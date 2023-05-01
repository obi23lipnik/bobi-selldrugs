local regularDrugOdds = {
    policeCallChance = 5,
    robberyChance = 5,
    aggroChance = 5,
    sellChance = 60,
}

local hardDrugOdds = {
    policeCallChance = 15,
    robberyChance = 15,
    aggroChance = 10,
    sellChance = 35,
}

local superHardDrugOdds = {
    policeCallChance = 15,
    robberyChance = 35,
    aggroChance = 35,
    sellChance = 15,
}

SellableDrugs = {
    ["meth"] = {
        priceRange = {100, 160},
        odds = hardDrugOdds,
    },
    -- ["meth_big"] = {
    --     priceRange = {9000, 15000},
    --     odds = superHardDrugOdds,
    -- },
    ["crack_baggy"] = {
        priceRange = {120, 180},
        odds = hardDrugOdds,
    },
    ["cokebaggy"] = {
        priceRange = {70, 110},
        odds = hardDrugOdds,
    },
    ["joint"] = {
        priceRange = {12, 19},
        odds = regularDrugOdds,
    },
    ["xtcbaggy"] = {
        priceRange = {50, 90},
        odds = regularDrugOdds,
    },
    ["oxy"] = {
        priceRange = {150, 190},
        odds = regularDrugOdds,
    },
}