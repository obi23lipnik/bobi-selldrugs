
local selling = false
local usedEntities = {}
local robbedByEntities = {}
local occupied = false

local cornersellingLabels = {}
for k, _ in pairs(SellableDrugs) do
    table.insert(cornersellingLabels, "Take back your " .. k)
    table.insert(cornersellingLabels, "Try to sell " .. k)
end

local function getNpcPeds()
    local playerPeds = {}
    local pedPool = GetGamePool('CPed')
    local peds = {}
    for _, activePlayer in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(activePlayer)
        playerPeds[#playerPeds + 1] = ped
    end
    for i = 1, #pedPool, 1 do
        local found = false
        for j = 1, #playerPeds, 1 do
            if playerPeds[j] == pedPool[i] then
                found = true
            end
        end
        if not found then
            peds[#peds + 1] = pedPool[i]
        end
    end
    return peds
end

local function canSellDrugs()
    local availableDrugs = {}
    local sellableDrugNames = {}
    local canSell = false
    for drugName, _ in pairs(SellableDrugs) do
        table.insert(sellableDrugNames, drugName)
    end
    availableDrugs = lib.callback.await('bobi-selldrugs:server:GetAvailableDrugs', false, sellableDrugNames)
    for _, drugsCount in pairs(availableDrugs) do
        if drugsCount ~= 0 then
            canSell = true
        end
    end
    return canSell, availableDrugs
end

local function successfulSell(entity, drugName, drugCount)
    exports['qb-target']:RemoveTargetEntity(entity, cornersellingLabels)
    table.insert(usedEntities, entity)
    ClearPedTasksImmediately(entity)
    TaskTurnPedToFaceEntity(entity, PlayerPedId(), -1)
    TaskLookAtEntity(entity, PlayerPedId(), -1, 2048, 3)
    Wait(1000)
    ClearPedTasksImmediately(entity)
    local moveto = GetEntityCoords(PlayerPedId())
    TaskGoStraightToCoord(ped, moveto.x, moveto.y, moveto.z, 15.0, -1, GetEntityHeading(PlayerPedId()) - 180.0, 0.0)
    Wait(1900)
    TriggerEvent('animations:client:EmoteCommandStart', {'bumbin'})
    FreezeEntityPosition(PlayerPedId(), true)
    TaskStartScenarioInPlace(entity, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, false)
    Wait(5000)
    local success = lib.callback.await('bobi-selldrugs:server:RemoveDrugs', false, drugName, drugCount)
    if not success then
        -- player trying to do something fishy
        lib.notify({
            id='fishy_selling_drugs',
            title='Nice try, your actions were reported to the administrators',
            position='top',
        })
    else
        lib.notify({
            id='selling_drugs',
            title='You sold some '..drugName..'!',
            position='top',
        })
        TriggerServerEvent('bobi-selldrugs:server:PayMoneyForDrugs', drugName, drugCount)
    end
    SetPedKeepTask(entity, false)
    SetEntityAsNoLongerNeeded(entity)
    ClearPedTasksImmediately(entity)
    TriggerEvent('animations:client:EmoteCommandStart', {'c'})
    FreezeEntityPosition(PlayerPedId(), false)
end

local function robbedOnSell(entity, drugName, drugCount)
    ClearPedTasksImmediately(entity)
    TaskTurnPedToFaceEntity(entity, PlayerPedId(), -1)
    TaskLookAtEntity(entity, PlayerPedId(), -1, 2048, 3)
    Wait(1000)
    ClearPedTasksImmediately(entity)
    local moveto = GetEntityCoords(PlayerPedId())
    TaskGoStraightToCoord(ped, moveto.x, moveto.y, moveto.z, 15.0, -1, GetEntityHeading(PlayerPedId()) - 180.0, 0.0)
    Wait(1900)
    TriggerEvent('animations:client:EmoteCommandStart', {'bumbin'})
    FreezeEntityPosition(PlayerPedId(), true)
    TaskStartScenarioInPlace(entity, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, false)
    exports['qb-target']:RemoveTargetEntity(entity, cornersellingLabels)
    Wait(5000)
    ClearPedTasksImmediately(entity)
    local success = lib.callback.await('bobi-selldrugs:server:RemoveDrugs', false, drugName, drugCount)    
    Wait(200)
    if not success then
        -- player trying to do something fishy
        lib.notify({
            id='fishy_selling_drugs',
            title='Nice try, your actions were reported to the administrators',
            position='top',
        })
    else
        lib.notify({
            id='robbed',
            title='HEY! This fucker didn\'t pay for the '..drugName..'!',
            icon='warning',
            iconColor='#EBE134',
            position='top',
        })
        exports['qb-target']:RemoveTargetEntity(entity, cornersellingLabels)
        table.insert(robbedByEntities, entity)
        exports['qb-target']:AddTargetEntity(entity, {
            options = {{
                action = function ()
                    lib.notify({
                        id='took_back',
                        title='Took back '..drugCount.. 'x '..drugName,
                        position='top',
                    })
                    TriggerServerEvent('bobi-selldrugs:server:RetrieveDrugs', drugName, drugCount)
                    exports['qb-target']:RemoveTargetEntity(entity, cornersellingLabels)
                    robbedByEntities[entity] = nil
                    table.insert(usedEntities, entity)
                    -- take back the drugs
                end,
                label = "Take back your " .. drugName,
            }},
            distance = 4.0,
        })
    end
    TaskSmartFleeCoord(entity, moveto.x, moveto.y, moveto.z, 1000.5, 60000, true, true)
    SetEntityAsNoLongerNeeded(entity)
    TriggerEvent('animations:client:EmoteCommandStart', {'c'})
    FreezeEntityPosition(PlayerPedId(), false)
end

local function aggroOnSell(entity)
    table.insert(usedEntities, entity)
    ClearPedTasksImmediately(entity)
    TaskTurnPedToFaceEntity(entity, PlayerPedId(), -1)
    TaskLookAtEntity(entity, PlayerPedId(), -1, 2048, 3)
    Wait(1000)
    ClearPedTasksImmediately(entity)
    local moveto = GetEntityCoords(PlayerPedId())
    TaskGoStraightToCoord(ped, moveto.x, moveto.y, moveto.z, 15.0, -1, GetEntityHeading(PlayerPedId()) - 180.0, 0.0)
    Wait(1900)
    SetPedCombatAttributes(entity, 5, true)
    SetPedCombatAttributes(entity, 46, true)
    TaskCombatPed(entity, PlayerPedId(), 0, 16)
end

local function denyOnSell(entity)
    table.insert(usedEntities, entity)
    table.insert(usedEntities, entity)
    ClearPedTasksImmediately(entity)
    TaskTurnPedToFaceEntity(entity, PlayerPedId(), -1)
    TaskLookAtEntity(entity, PlayerPedId(), -1, 2048, 3)
    Wait(2000)
    TriggerEvent('animations:client:EmoteCommandStart', {'shrug'})
    ClearPedTasksImmediately(entity)
end

local function startDrugSellingLoop()
    CreateThread(function ()
        while true do
            if not selling then
                lib.hideTextUI()
                return
            end
            local buyers = getNpcPeds()
            for _, npcBuyer in pairs(buyers) do
                if not lib.table.contains(robbedByEntities, npcBuyer) then
                    exports['qb-target']:RemoveTargetEntity(npcBuyer, cornersellingLabels)
                end
            end
            local canSell, availableDrugs = canSellDrugs()
            if not canSell then
                selling = false
            end
            local sellOptions = {}
            for drugName, drugCount in pairs(availableDrugs) do
                if drugCount >= 1 then
                    table.insert(sellOptions, {
                        action = function (entity)
                            if occupied then
                                lib.notify({
                                    id='already_selling',
                                    title='You are busy with a client already!',
                                    position='top',
                                    icon='ban',
                                    iconColor='#C53030'
                                })
                                return
                            end
                            occupied = true
                            if math.random(1, 100) > SellableDrugs[drugName].odds.sellChance then
                                if math.random(1, 100) < SellableDrugs[drugName].odds.aggroChance then
                                    aggroOnSell(entity)
                                else
                                    denyOnSell(entity)
                                end
                            else
                                if math.random(1, 100) < SellableDrugs[drugName].odds.robberyChance then
                                    robbedOnSell(entity, drugName, math.random(1, drugCount >= 15 and 15 or drugCount))
                                else
                                    successfulSell(entity, drugName, math.random(1, drugCount >= 15 and 15 or drugCount))
                                end
                                if SellableDrugs[drugName].odds.policeCallChance > math.random(1, 100) then
                                    exports['dispatch']:DrugSale()
                                    exports['sd-aipolice']:ApplyWantedLevel(1)
                                end
                            end
                            occupied = false
                        end,
                        label = "Try to sell " .. drugName
                    })
                end
            end
            for _, npcBuyer in pairs(buyers) do
                if not lib.table.contains(usedEntities, npcBuyer) then
                    exports['qb-target']:AddTargetEntity(npcBuyer, {
                        options = sellOptions,
                        distance = 4.0,
                    })
                end
            end
            Wait(5000)
        end
    end)
end

RegisterNetEvent('bobi-selldrugs:client:StartSelling', function ()
    local buyers = getNpcPeds()
    for _, npcBuyer in pairs(buyers) do
        exports['qb-target']:RemoveTargetEntity(npcBuyer, cornersellingLabels)
    end
    local canSell, _ = canSellDrugs()
    if not canSell then
        selling = false
        lib.notify({
            id='no_drugs',
            title='No drugs to sell!',
            position='top',
            icon='ban',
            iconColor='#C53030'
        })
        return
    end
    selling = not selling
    if selling then
        lib.showTextUI('Selling Drugs', {
            position = 'left-center',
            icon = 'cannabis',
            iconColor = '34EB37'
        })
        startDrugSellingLoop()
    else
        lib.hideTextUI()
    end
end)

RegisterNetEvent('bobi-selldrugs:client:SellToCustomer', function (drugName)
    lib.notify({
        id='selling_drugs',
        title='You successfully sold some '..drugName..'!',
        position='top',
    })
end)
