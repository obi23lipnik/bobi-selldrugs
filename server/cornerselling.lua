if Config.inventoryResource == 'ox_inventory' then
    if GetResourceState('ox_inventory') == 'missing' then
        print('Resource "ox_inventory" missing, but is set as your inventory resource in bobi-selldrugs/config.lua')
    else
        lib.callback.register('bobi-selldrugs:server:RemoveDrugs', function (_, drugName, drugAmount)
            return exports.ox_inventory:RemoveItem(source, drugName, drugAmount)
        end)
        lib.callback.register('bobi-selldrugs:server:GetAvailableDrugs', function (_, sellableDrugNames)
            return exports.ox_inventory:Search(source, 'count', sellableDrugNames)
        end)
        RegisterNetEvent('bobi-selldrugs:server:RetrieveDrugs', function (drugName, drugAmount)
            exports.ox_inventory:AddItem(source, drugName, drugAmount)
        end)
        RegisterNetEvent('bobi-selldrugs:server:PayMoneyForDrugs', function (drugName, drugAmount)
            local price = math.random(SellableDrugs[drugName].priceRange[1], SellableDrugs[drugName].priceRange[2])
            exports.ox_inventory:AddItem(source, 'money', price * drugAmount)
        end)
    end
elseif Config.inventoryResource == 'qb-inventory' then
    if GetResourceState('qb-inventory') == 'missing' then
        print('Resource "qb-inventory" missing, but is set as your inventory resource in bobi-selldrugs/config.lua')
    else
        local QBCore = exports['qb-core']:GetCoreObject()
        lib.callback.register('bobi-selldrugs:server:RemoveDrugs', function (_, drugName, drugAmount)
            local Player = QBCore.Functions.GetPlayer(source)
            return Player.Functions.RemoveItem(drugName, drugAmount)
        end)
        lib.callback.register('bobi-selldrugs:server:GetAvailableDrugs', function (_, sellableDrugNames)
            local Player = QBCore.Functions.GetPlayer(source)
            local drugsCount = {}
            for _, drugName in pairs(sellableDrugNames) do
                local item = Player.Functions.GetItemByName(drugName)
                if item then
                    drugsCount[drugName] = item.amount
                end
            end
            return drugsCount
        end)
        RegisterNetEvent('bobi-selldrugs:server:RetrieveDrugs', function (drugName, drugAmount)
            local Player = QBCore.Functions.GetPlayer(source)
            Player.Functions.AddItem(drugName, drugAmount)
        end)
        RegisterNetEvent('bobi-selldrugs:server:PayMoneyForDrugs', function (drugName, drugAmount)
            local Player = QBCore.Functions.GetPlayer(source)
            local price = math.random(SellableDrugs[drugName].priceRange[1], SellableDrugs[drugName].priceRange[2])
            Player.Functions.AddMoney('cash', price * drugAmount)
        end)
    end
elseif Config.inventoryResource == 'ESX' then
    if GetResourceState('es_extended') == 'missing' then
        print('Resource "es_extended" missing, but is set as your inventory resource in bobi-selldrugs/config.lua')
    else
        local ESX = exports["es_extended"]:getSharedObject()
        lib.callback.register('bobi-selldrugs:server:GetDrugLabel', function(_, drugName)
            return ESX.GetItemLabel(drugName)
        end)
        lib.callback.register('bobi-selldrugs:server:RemoveDrugs', function (_, drugName, drugAmount)
            local xPlayer = ESX.GetPlayerFromId(source)
            return xPlayer.removeInventoryItem(drugName, drugAmount)
        end)
        lib.callback.register('bobi-selldrugs:server:GetAvailableDrugs', function (_, sellableDrugNames)
            local xPlayer = ESX.GetPlayerFromId(source)
            local drugsCount = {}
            for _, drugName in pairs(sellableDrugNames) do
                local item = xPlayer.hasItem(drugName)
                if item then
                    drugsCount[drugName] = item.count
                end
            end
            return drugsCount
        end)
        RegisterNetEvent('bobi-selldrugs:server:RetrieveDrugs', function (drugName, drugAmount)
            local xPlayer = ESX.GetPlayerFromId(source)
            xPlayer.addInventoryItem(drugName, drugAmount)
        end)
        RegisterNetEvent('bobi-selldrugs:server:PayMoneyForDrugs', function (drugName, drugAmount)
            local xPlayer = ESX.GetPlayerFromId(source)
            local price = math.random(SellableDrugs[drugName].priceRange[1], SellableDrugs[drugName].priceRange[2])
            xPlayer.AddMoney(price * drugAmount)
        end)
    end
else
    print('Set inventory resource inside bobi-selldrugs/config.lua')
end

RegisterCommand("selldrugs", function(source, _, _)
    if (source > 0) then
        TriggerClientEvent('bobi-selldrugs:client:StartSelling', source)
    else
        print("This command can only be used by players")
    end
end, false)