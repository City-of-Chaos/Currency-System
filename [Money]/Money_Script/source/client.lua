-- For support join my discord: https://discord.gg/Z9Mxu72zZ6

local cash = ""
local bank = ""

function getMoney()
    return {["cash"] = cash, ["bank"] = bank}
end



-- Trigger the server event "getMoney" when the resource starts.
AddEventHandler("onResourceStart", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
    	return
    end
    Citizen.Wait(1000)
    TriggerServerEvent("getMoney")
end)  

-- Trigger the server event "getMoney" when the player spawns.
AddEventHandler("playerSpawned", function()
    TriggerServerEvent("getMoney")
end)

-- update the money on the client.
RegisterNetEvent("updateMoney")
AddEventHandler("updateMoney", function(updatedCash, updatedBank)
    cash, bank = updatedCash, updatedBank
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local moneyData = getMoney()  

            SendNUIMessage({
                display = true,
                cash = moneyData.cash,
                bank = moneyData.bank
            })

        if IsPauseMenuActive() then
            BeginScaleformMovieMethodOnFrontendHeader("SET_HEADING_DETAILS")
            ScaleformMovieMethodAddParamPlayerNameString(GetPlayerName(PlayerId()))
            PushScaleformMovieFunctionParameterString("Cash: $" .. cash)
            PushScaleformMovieFunctionParameterString("Bank: $" .. bank)
            EndScaleformMovieMethod()
        end
    end
end)

