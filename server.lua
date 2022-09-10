Config = {}
Config.BlEvents = {
  {name="esx_bank:redeem", limit=5, clrepeat=1} --clrepeat = min = what's the limit in clrepeat minutes, how often the event should get triggered, per player.
}
local hits = {}

Citizen.CreateThread(function()
    for k, v in ipairs(Config.BlEvents) do
        hits[v.name] = {}
        RegisterServerEvent(v.name)
        AddEventHandler(v.name, function()
            if hits[v.name][source] == nil then
                hits[v.name][source] = {}
                hits[v.name][source].hits = 1
            else
                hits[v.name][source].hits = hits[v.name][source].hits + 1
            end
          
            if not hits[v.name][source].time then 
                hits[v.name][source].time = GetGameTimer()
            end
            
            if (hits[v.name][source].time) + (v.clrepeat * 60000) >= GetGameTimer() then
                hits[name][player].hits = 0
                hits[v.name][source].time = nil
            end

            if hits[v.name][source].hits > v.limit then
                print("" ..GetPlayerName(source).. " triggerte zu oft das Event: " ..v.name)
                --Ban Event
            end
        end)
    end
end)
