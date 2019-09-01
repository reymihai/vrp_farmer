
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPclient = Tunnel.getInterface("vRP", "vrp_Farmer") 
vRP = Proxy.getInterface("vRP")  

vRP.defInventoryItem({"plantseeds", "Seeds", "Some seeds, plant them in the near field", function(args) 
    local choices = {}
	
	choices["Use"] = {function(player,choice,mod)
		local user_id = vRP.getUserId({player})
        if user_id ~= nil then
            vRP.tryGetInventoryItem({user_id, "plantseeds", 1, true})
            TriggerClientEvent('farm', player)
            vRP.closeMenu({player})
        end
    end}
   
    return choices
end, 0.05})  

amount = 1000           -- the cost for 1 plant seed

RegisterServerEvent('iasamanta')
AddEventHandler('iasamanta',function()
    local thePlayer = source
    local user_id = vRP.getUserId({thePlayer})
    local money =  vRP.getMoney({user_id})
      if user_id ~= nil then 
        vRP.prompt({thePlayer, "How many do you want to buy?", "", function(player,cat) 
            cat = tonumber(cat)  
              if (cat > 0) then 
                local cost = cat *amount 
                if (money >= cost) then 
                    vRP.tryPayment({user_id, cost}) 
                    vRP.giveInventoryItem({user_id,"plantseeds",cat,true})
                    vRPclient.notify(thePlayer,{"~g~You payed "..cost})
                else 
                    vRPclient.notify(thePlayer,{"You don't have enough money"})
                end
            else  
                vRPclient.notify(thePlayer,{"You can't buy negative quantities"})
            end
        end})
    end

end)
RegisterServerEvent('dafaina')
AddEventHandler('dafaina', function()
     local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
   if user_id ~= nil then 
    vRP.giveInventoryItem({user_id, "flour", 1, true}) 
   end

end) 
 
plata = 3000     -- the cost for 1 sac of flour

RegisterServerEvent('iabani') 
AddEventHandler('iabani', function()
     local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
 local faina = vRP.getInventoryItemAmount({user_id,"flour"}) 
 local paycheck =  plata * faina  
   if vRP.tryGetInventoryItem({user_id, "flour", faina, true}) then           
          vRP.giveMoney({user_id, paycheck})
          vRPclient.notify(thePlayer, {"~b~You recived: "..paycheck.." ~r~$"})  
          
   else 
    vRPclient.notify(thePlayer, {"~b~You don't have any flour"})  
   end
end) 

