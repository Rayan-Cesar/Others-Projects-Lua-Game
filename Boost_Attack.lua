function onUse(cid, item, fromPosition, itemEx, toPosition)
if (getPlayerStorageValue(cid, 32153) == 1) then
	doPlayerSendTextMessage(cid,22,"Você fez a segunda quest.") 
	setPlayerStorageValue(cid, 32153, 2)
	doSendMagicEffect(getCreaturePosition(cid), CONST_ME_HOLYDAMAGE)
elseif (getPlayerStorageValue(cid, 32153) == 2) then
	doPlayerSendTextMessage(cid,22,"Você ja fez essa quest!") 
else
	doPlayerSendTextMessage(cid,22,"Você precisa fazer a primeira quest.")
end
return true
end