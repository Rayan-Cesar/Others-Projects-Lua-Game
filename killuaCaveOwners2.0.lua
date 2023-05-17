function restTempo(storage)-- By Zefz
  local segundos, minutos, horas = 0,0,0
  local tot = storage - os.time()
  horas = math.floor(tot/3600)
  tot = tot - horas * 3600
  minutos = math.floor(tot/60)
  tot = tot - minutos * 60
  segundos = tot
  return string.format("Você já usou este item e precisa esperar %.2d:%.2d:%.2d para usar novamente.", horas, minutos, segundos)
end


local storages = {
        
        722340,
        722341,
        722342,
        722343,
        722344,
        722345,
        722346,
        722347,
        722348,
        722349,
        722363,
        722364,
        722365,
        722366,
        722367,
        722368,
        722369,
        722370,
        722371,
        722372

}

local stg = 722340

local function hasCave(cid)
	local storages = {722340,722341,722342,722343,722344,722345,722346,722347,722348,722349,722363,722364,722365,722366,722367,722368,722369,722370,722371,722372}

	for a,b in pairs(storages) do
		sto = getGlobalTableStorage(b)
		if sto.guid and sto.guid == getCreatureName(cid) then
			if tonumber(sto.time) > os.time() then
				return a
			end
		end
	end
	return false
end
local points = 7
local query = db.query or db.executeQuery



function onUse(cid, item, fromPosition, itemEx, toPosition)

    if getPlayerLevel(cid) >= 500 then
        return doPlayerSendCancel(cid,"Somente jogadores abaixo do level 500 podem upar em caves exclusivas.")
    end
	if hasCave(cid) then
		return doPlayerSendCancel(cid,"Você já é o dono da cave "..hasCave(cid).." e não pode alugar outra até o aluguel dela acabar.")
	end
if getPlayerStorageValue(cid, stg) < os.time() then
		setPlayerStorageValue(cid, stg, os.time() + (24*3600))
        local check, cave = false, 0
        for i = 1, #storages do
                sto = getGlobalTableStorage(storages[i])
                if not sto.time then
                        setGlobalTableStorage(storages[i],{guid = getCreatureName(cid), time = os.time() + (6*3600)})
                        doRemoveItem(item.uid,1)
                        doSendMagicEffect(getThingPos(cid), 12)
                        cave = i
                        check = true
                        break;
                end
                if sto.time and tonumber(sto.time) > 0 then
                        if tonumber(sto.time) < os.time() then
                            setGlobalTableStorage(storages[i],{guid = getCreatureName(cid), time = os.time() + (6*3600)})
                            doRemoveItem(item.uid,1)
                            doSendMagicEffect(getThingPos(cid), 12)
                            cave = i
                            check = true
                            break;
                        end
                end
        end

        if check then
                doSaveServer()
                doPlayerSendTextMessage(cid,25,"Você acabou de alugar a cave "..cave.." por 6 horas. Aproveite!")
        else
                doPlayerSendCancel(cid,"Todas as caves já estão alugadas no momento... Tente novamente mais tarde.")
        end
    else
    	doPlayerSendTextMessage(cid,25, restTempo(getPlayerStorageValue(cid, stg)))
    end
        --[[query("UPDATE `accounts` SET `premium_points` = `premium_points` + '"..points.."' WHERE `id` = '"..getPlayerAccountId(cid).."'")
        doPlayerPopupFYI(cid,"As caves exclusivas não estão mais disponíveis no servidor. Você recebeu 7 pontos na shop do site.")
        doRemoveItem(item.uid)]]
        return true
end
