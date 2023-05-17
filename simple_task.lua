function ShowMsg(cid)
local str = ""
local str = str .. "Número - Nome da Task:\n\n"
  for k, v in ipairs(tasktabble) do
    local completed = getPlayerStorageValue(cid, v.storage_start)
    local contagem = getPlayerStorageValue(cid, v.storage)
      if completed == 0 then
        str = str..k.." - "..v.monster_name.." [OK]\n"
      else
        str = str..k.." - "..v.monster_name.."\n"
      end
    str = str .. ""
  end
  return doShowTextDialog(cid, 8983, str)
end
---------------
function TaskName(numb)
  for k, v in pairs(tasktabble) do
    if k == numb then
      return v.monster_name
    end
  end
end
---------------
function CheckTask(cid)

for k, v in pairs(tasktabble) do

if getPlayerStorageValue(cid,v.storage_start) >= 1 then return true end

end

return false

end

---------------

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

          local msg = string.lower(msg)

          if isInArray({"task","tasks","missao","mission"}, msg) then

            npcHandler:say("Qual o {número} da task que você quer fazer? Quando terminar de fazer a task, volte aqui para me entregar a task que você terminou e diga report e depois o {número} da task.", cid)
            ShowMsg(cid)

            talkState[talkUser] = 1
            
          elseif talkState[talkUser] == 1 then
            if tasktabble[tonumber(msg)] then
              
              if getPlayerStorageValue(cid,tasktabble[tonumber(msg)].storage_start) < 1 then
                
                local contagem = getPlayerStorageValue(cid, tasktabble[tonumber(msg)].storage)

                if (contagem == -1) then contagem = 1 end

                if not tonumber(contagem) then npcHandler:say('Você já terminou essa task!', cid) return true end

                setPlayerStorageValue(cid, tasktabble[tonumber(msg)].storage_start, 1)

                npcHandler:say("Parabéns, agora você está participando da missão task do "..TaskName(tonumber(msg))..", falta matar "..string.sub(((contagem)-1)-tasktabble[tonumber(msg)].count, 2)..".", cid)

                talkState[talkUser] = 0

              else

                npcHandler:say('Você já está fazendo essa task!', cid)

                talkState[talkUser] = 0

              end

            else

              npcHandler:say('digite o numero correto da task!', cid)

              talkState[talkUser] = 1

            end

          elseif isInArray({"report"}, msg) then

            npcHandler:say("Me diga o numero da task que você deseja pegar a recompensa!", cid)
            local msg = string.lower(msg)
            talkState[talkUser] = 2
            elseif talkState[talkUser] == 2 then
              if tasktabble[tonumber(msg)] then
                    if getPlayerStorageValue(cid,tasktabble[tonumber(msg)].storage_start) >= 1 then

                      local contagem = getPlayerStorageValue(cid, tasktabble[tonumber(msg)].storage)
                      if (contagem == -1) then contagem = 0 end
                      if not tonumber(contagem) then
                       npcHandler:say('você só pode receber os items uma única vez!', cid)
                        return true 
                      end

                      if contagem >= tasktabble[tonumber(msg)].count then

                        local str = ""

                        if tasktabble[tonumber(msg)].exp ~= nil then doPlayerAddExp(cid, tasktabble[tonumber(msg)].exp ) str = str.."".. (str == "" and "" or ",") .." "..tasktabble[tonumber(msg)].exp.." de exp" end

                        if tasktabble[tonumber(msg)].money ~= nil then doPlayerAddMoney(cid, tasktabble[tonumber(msg)].money) str = str.."".. (str == "" and "" or ",") ..""..tasktabble[tonumber(msg)].money.." gps" end

                        if tasktabble[tonumber(msg)].reward ~= nil then doAddItemsFromList(cid,tasktabble[tonumber(msg)].reward) str = str.."".. (str == "" and "" or ",") ..""..getItemsFromList(tasktabble[tonumber(msg)].reward) end

                        npcHandler:say("Obrigado pela sua ajuda Recompensas: "..(str == "" and "nenhuma" or ""..str.."").." por ter completado a task do "..tasktabble[tonumber(msg)].monster_name, cid)

                        setPlayerStorageValue(cid, tasktabble[tonumber(msg)].storage, "Finished")

                        setPlayerStorageValue(cid, tasktabble[tonumber(msg)].storage_start, 0)

                        setPlayerStorageValue(cid, 521456, getPlayerStorageValue(cid, 521456) == -1 and 1 or getPlayerStorageValue(cid, 521456)+1)
                      else
                        npcHandler:say('Já matou: {'..(contagem)..'} '..tasktabble[tonumber(msg)].monster_name..' mortos. Você precisa matar: {'..tasktabble[tonumber(msg)].count..'} '..tasktabble[tonumber(msg)].monster_name..' para concluir a task.', cid)
                      end
                    else
                      npcHandler:say("Você ainda não começou essa task.", cid)
                    end
			end
			
	     end

          return true

        end

        npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

        npcHandler:addModule(FocusModule:new())