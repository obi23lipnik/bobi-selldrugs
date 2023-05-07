Config = {}

Config.useTarget = true  -- currently no effect either way; A target resource is required
Config.sellingOnByDefault = false  -- If true(experimental), the player will be put into "selling mode" on spawn
                                   -- If false(recommended) the client event: bobi-selldrugs:client:StartSelling must be called to put player into "selling mode"

Config.inventoryResource = 'ox_inventory' -- Supported resources: 'ESX'(experimental), 'qb-inventory', 'ox_inventory'
Config.targetResource = 'qb-target' -- Supported resources: 'qb-target', 'ox_target'

Config.policeCallClientFunction = function ()
    -- EDIT THIS TO CALL YOUR POLICE SCRIPT HOOKS --
    -- This gets called when call police chance is triggered
    -- Must use only client side exports
    -- exports['ps-dispatch']:DrugSale()
    -- exports['sd-aipolice']:ApplyWantedLevel(1)
end