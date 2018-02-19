--[[-----------------
	vRP_itemdrop By XanderWP from Ukraine with <3
------------------------]]--
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_itemdrop")


local bag = {}
RegisterServerEvent('DropSystem:create')
AddEventHandler('DropSystem:create', function(bags, item, count)
bag[bags] = {item = item, count = count}
TriggerClientEvent('DropSystem:createForAll', -1, bags)
end)



RegisterServerEvent('DropSystem:drop')
AddEventHandler('DropSystem:drop', function(bag, item, count)
local user_id = vRP.getUserId({source})
vRP.giveInventoryItem({user_id,item,count,true})
TriggerClientEvent('DropSystem:createForAll', -1, bag)

end)


RegisterServerEvent('DropSystem:take')
AddEventHandler('DropSystem:take', function(bags)
local user_id = vRP.getUserId({source})
local player = vRP.getUserSource({user_id})
local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({bag[bags].item})*bag[bags].count
            if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
vRP.giveInventoryItem({user_id,bag[bags].item,bag[bags].count,true})
vRPclient.playAnim(player,{true,{{"pickup_object","pickup_low",1}},false})
TriggerClientEvent('DropSystem:remove', -1, bags)
else
vRPclient.notify(player,{"~r~Недостаточно места"})
end

end)
