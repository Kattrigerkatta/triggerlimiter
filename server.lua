Config = {}
Config.BlEvents = {
  {name="esx_bank:redeem", limit=5, clrepeat=1} --clrepeat = min = what's the limit in clrepeat minutes, how often the event should get triggered, per player.
}
Citizen.CreatThread(function()
  local hits = {}
  for k, v in ipairs(Config.BlEvents) do
    hits[v.name] = {}
    AddEventHandler(v.name, function()
      hits[v.name][source] = {}
      if hits[v.name][source].hits == nil then
        hits[v.name][source].hits = 1
      else
        hits[v.name][source].hits = hits[v.name].hits + 1
      end
      
      if hits[v.name][source].hits > v.limit then -- The number of times you can trigger the event before the player is banned. IMPORTANT: You have to put your ban trigger in the empty column, because I don't provide a ban system.
        -- ban-shit
        print('The player: ' .. GetPlayerName(source) .. ' triggered the event ' .. v.name ' more than ' .. v.limit .. ' times') -- EXAMPLE
      end
    end)
    
    while true do
       Citizen.Wait(v.clrepeat*60000)
       hits[v.name][source].hits = 0
    end
  end

end)
