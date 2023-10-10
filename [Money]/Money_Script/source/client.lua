-- For support join my discord: https://discord.gg/Z9Mxu72zZ6

local cash = ""
local bank = ""

function getMoney()
    return {["cash"] = cash, ["bank"] = bank}
end

-- Text on screen.
function text(text, x, y, scale)
    SetTextFont(7)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextOutline()
    SetTextJustification(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
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

