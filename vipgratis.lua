function onLogin(cid)

local storage_acc = 15002
local days = 3
local acc = getPlayerAccountId(cid)
local time = isVip(cid) and getAccountVipTime(acc) or os.time()

	if getAccountStorageValue(getPlayerAccountId(cid), storage_acc) <= 0 then	
			setAccountStorageValue(acc, storage_acc, 1)	
        	addEvent(setAccountVipTime, 1010, acc, time + 3600*24*days)
			doSendMagicEffect(getThingPosition(cid),38)
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voce recebeu "..days.." dia de vip.")
			addEvent(doRemoveCreature,1000,cid)
			return true
	end
	return true
end