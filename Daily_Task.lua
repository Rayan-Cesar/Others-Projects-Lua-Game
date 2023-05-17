function doAddItemsFromList(cid,items)

if table.maxn(items) > 0 then

local backpack = doCreateItemEx(10521)

for i = 1, table.maxn(items) do

local count = items[i][2]

while count > 0 do

if isItemStackable(items[i][1]) then

doAddContainerItem(backpack, items[i][1], 1)
doPlayerAddItemEx(cid,backpack)
else

doAddContainerItem(backpack, items[i][1],1)
doPlayerAddItemEx(cid,backpack)

end

count = count - 1

end

end

end

end
-----------------
function restTempo(storage)
  local segundos, minutos, horas = 0,0,0
  local tot = storage - os.time()
  horas = math.floor(tot/3600)
  tot = tot - horas * 3600
  minutos = math.floor(tot/60)
  tot = tot - minutos * 60
  segundos = tot
  return string.format("%.2d:%.2d:%.2d", horas, minutos, segundos)
end

------------------

function getItemsFromList(items)

local str = ''

if table.maxn(items) > 0 then

for i = 1, table.maxn(items) do

str = str .. items[i][2] .. ' ' .. getItemNameById(items[i][1])

if i ~= table.maxn(items) then str = str .. ', ' end end end

return str

end
--------------------

local keywordHandler = KeywordHandler:new()

local npcHandler = NpcHandler:new(keywordHandler)

NpcSystem.parseParameters(npcHandler)

local talkState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end

  function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end

    function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

      function onThink() npcHandler:onThink() end

        function creatureSayCallback(cid, type, msg)

          if(not npcHandler:isFocused(cid)) then

            return false

          end

          local talkUser = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid
          local dailyStorageTime = 220220
          local msg = string.lower(msg)

          if isInArray({"daily","task","missao","mission"}, msg) then
              
             if getPlayerStorageValue(cid, dailyStorageTime) - os.time() <= 0 then
              local daily = tostring(math.random(1,3))
              local contagem = getPlayerStorageValue(cid, dailytasktabble[daily].storage)
                if (contagem == -1) then contagem = 1 end
                if not tonumber(contagem) then npcHandler:say('Você já terminou essa task!', cid) return true end
              setPlayerStorageValue(cid, dailytasktabble[daily].storage_start, 1)
              setPlayerStorageValue(cid, dailyStorageTime, os.time() + 24 * 60 * 60)
              npcHandler:say("Parabéns, agora você está participando da missão task do "..dailytasktabble[daily].monster_name..", falta matar "..string.sub(((contagem)-1)-dailytasktabble[daily].count, 2)..".", cid)
            else
              npcHandler:say("Você precisa esperar "..restTempo(getPlayerStorageValue(cid,dailyStorageTime)).." para pegar a daily novamente", cid)
            end

          elseif isInArray({"report"}, msg) then
            local zz = 0
            local zzz = 0
            for k, v in pairs(dailytasktabble) do
              if getPlayerStorageValue(cid,dailytasktabble[k].storage_start) >= 1 then
                 local contagem = getPlayerStorageValue(cid, dailytasktabble[k].storage)
                    if (contagem == -1) then contagem = 0 end
                    if contagem >= dailytasktabble[k].count then
                      local str = ""
                        if dailytasktabble[k].exp ~= nil then doPlayerAddExp(cid, dailytasktabble[k].exp ) str = str.."".. (str == "" and "" or ",") .." "..dailytasktabble[k].exp.." de exp" end
                        if dailytasktabble[k].money ~= nil then doPlayerAddMoney(cid, dailytasktabble[k].money) str = str.."".. (str == "" and "" or ",") ..""..dailytasktabble[k].money.." gps" end
                        if dailytasktabble[k].reward ~= nil then doAddItemsFromList(cid,dailytasktabble[k].reward) str = str.."".. (str == "" and "" or ",") ..""..getItemsFromList(dailytasktabble[k].reward) end
                        setPlayerStorageValue(cid, dailytasktabble[k].storage, 0)
                        setPlayerStorageValue(cid, dailytasktabble[k].storage_start, -1)
                        if zz <= 0 then
                          zz = zz + 1
                          npcHandler:say("Obrigado pela sua ajuda aqui está a sua recompensa.", cid)
                        end
                    else
                      npcHandler:say('Já matou: {'..(contagem)..'} '..dailytasktabble[k].monster_name..' mortos. Você precisa matar: {'..dailytasktabble[k].count..'} '..dailytasktabble[k].monster_name..' para concluir a task.', cid)
                    end
              else
                zzz = zzz+1
                if zzz == 4 then
                  npcHandler:say("Você ainda não começou a daily.", cid)
                end
              end
            end
	     end

          return true

        end

        npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

        npcHandler:addModule(FocusModule:new())