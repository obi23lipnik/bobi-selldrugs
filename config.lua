Config = {}

Config.inventoryResource = 'ox_inventory' -- or 'qb-inventory'
Config.useTarget = true  -- or false
Config.targetResource = 'qb-target' -- or 'ox_target'
Config.policeCallClientFunction = function ()
    -- EDIT THIS TO CALL YOUR POLICE SCRIPT HOOKS --
    -- exports['ps-dispatch']:DrugSale()
    -- exports['sd-aipolice']:ApplyWantedLevel(1)
end