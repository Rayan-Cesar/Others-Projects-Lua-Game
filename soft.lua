local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function creatureSayCallback(cid, type, msg) -- by Zefz
if(not npcHandler:isFocused(cid)) then
	return false
end

local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

if(msgcontains(msg, 'bonus attack') or msgcontains(msg, 'bonus')) then
	selfSay('Você gostaria de recarregar o seu item Bonus Attack por 200 Vip Coins?', cid)
	talkState[talkUser] = 1
elseif(msgcontains(msg, 'yes') and talkState[talkUser] == 1) then
	if(getPlayerItemCount(cid, 8204) >= 1) then
		if(doPlayerRemoveItem(cid, 11192, 200) == TRUE) then
			doPlayerRemoveItem(cid, 8204, 1)
			doPlayerAddItem(cid, 6547)
			selfSay('Aqui está.', cid)
		else
			selfSay('Desculpe, você não tem Vip Coins suficientes.', cid)
		end
	else
		selfSay('Desculpe, você não possui o item para a recarga.', cid)
	end
	talkState[talkUser] = 0
elseif(msgcontains(msg, 'no') and isInArray({1}, talkState[talkUser]) == TRUE) then
	talkState[talkUser] = 0
	selfSay('Ok entao.', cid)
end

return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())