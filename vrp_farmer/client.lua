

vRP = Proxy.getInterface("vRP") 
x, y, z = 2492.8205566406,4858.9091796875,36.837772369385                                        -- coords for the field


timplagradinarit = 10      -- planting time in  seconds
timplacules =  10            -- harvesting time in seconds
 
       
local plantsObject = GetHashKey("prop_bush_lrg_01c_cr")         -- the plant
local plants = {}

caciula = false 

RegisterNetEvent('farm')
AddEventHandler('farm', function()
     local player = GetPlayerPed(-1)
     local coord = GetEntityCoords(player) 
       if (GetDistanceBetweenCoords(coord.x, coord.y, coord.z, x, y, z-1.7, true)) < 40.0 then   
         TaskStartScenarioInPlace(player,"WORLD_HUMAN_GARDENER_PLANT", 0, true)   
        vRP.notify({"~r~You are now watering the plant for "..timplagradinarit.."  second(s)"})
         Citizen.Wait(timplagradinarit * 1000)     -- time for planting
         RequestModel(plantsObject)
         plants[#plants+1] = CreateObject(plantsObject, coord.x, coord.y, coord.z-3.2, false, false, true)
         vRP.notify({"~r~You are now harvesting the plant "..timplacules.."  second(s)"})
          Citizen.Wait(timplagradinarit * 1000)     -- time for planting  
             for i,v in pairs (plants) do 
           
          DeleteObject(plants[i])
          plants[i] = nil
          TriggerServerEvent('dafaina')
          ClearPedTasksImmediately(player)   
             end
       else 
        vRP.notify({"~r~You can plant this only in the field!"})
        end   
end)
 
Citizen.CreateThread(function()
  while true do 
    Citizen.Wait(0)
  local player = GetPlayerPed(-1)
  local coord = GetEntityCoords(player) 
  if (GetDistanceBetweenCoords(coord.x, coord.y, coord.z, 2879.5114746094,4489.646484375,48.19352722168, true)) < 5.0 then    
    Draw3DText(2879.5114746094,4489.646484375,48.19352722168-0.8,"~o~Press E to sell the flour",0.1,0.1)
    DrawMarker(0, 2879.5114746094,4489.646484375,48.19352722168,0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 255, 128, 0, 50,true, true, 2, nil, nil, true )
    if(IsControlJustReleased(1, 51))then
      TriggerServerEvent('iabani')
    end
  end
 end
end)


Citizen.CreateThread(function()
    while true do 
      Citizen.Wait(0) 
      local player = GetPlayerPed(-1)
      local coord = GetEntityCoords(player)
      if (GetDistanceBetweenCoords(coord.x, coord.y, coord.z, x, y, z-1.7, true)) < 5.0 then   
        Draw3DText(x, y, z-0.8,"~g~Use the seeds in this field",0.1,0.1)
        DrawMarker(22, x, y, z,0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 2, 250, 0, 50, true, true, 2, nil, nil, true ) 
      end
    end
end)

Citizen.CreateThread(function()
  while true do 
    Citizen.Wait(0) 
    local player = GetPlayerPed(-1)
    local coord = GetEntityCoords(player)
    if (GetDistanceBetweenCoords(coord.x, coord.y, coord.z,2565.0576171875,4685.8911132813,34.08602142334 , true)) < 5.0 then   
      Draw3DText(2565.0576171875,4685.8911132813,34.08602142334-0.8,"~b~Press E to buy some seeds, it will cost 1000",0.1,0.1)
      DrawMarker(22, 2565.0576171875,4685.8911132813,34.08602142334,0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 0, 153, 250, 50, true, true, 2, nil, nil, true ) 
      if(IsControlJustReleased(1, 51))then
        TriggerServerEvent('iasamanta')
      end 
    end
  end
end)
                                                                                                      

function Draw3DText(x,y,z,textInput,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov   
    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(250, 250, 250, 255)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
end