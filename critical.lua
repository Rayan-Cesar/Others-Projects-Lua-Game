local lvlcrit = 42904
local multiplier = 2.0
local effect = 31
local SOTRAGE_REFLECT = 14891
local STORAGE_PROTECTION = 14892
local STORAGE_OUTFIT = 14893
local SOTRAGE_REFLECT_ATK = 14894
local outfits = {126,127,132,140,159,366,367,139,131,331,332,336,335,359}

local function negativo(value)
  if value > 0 then
    value = 0 - value
  end
  return value
end

local function positivo(value)
  if value < 0 then
    value = -value
  end
  return value
end

function onCombat(cid, target)
  if getPlayerStorageValue(cid, CRITICAL_STORAGE) == 1 then
    setPlayerStorageValue(cid, CRITICAL_STORAGE, 2)
  end
  if getPlayerStorageValue(cid, CRITICAL_STORAGE_DOIS) == 1 then
    setPlayerStorageValue(cid, CRITICAL_STORAGE_DOIS, 2)
  end
  return true
end


function onStatsChange(cid, attacker, type, combat, value)
  local bonusAttack = 20000
  local outfit_look = getCreatureOutfit(cid)
  for _, outfit in ipairs(outfits) do
    if outfit_look.lookType == outfit then
      setPlayerStorageValue(cid, SOTRAGE_REFLECT, 0.05)
      setPlayerStorageValue(cid, STORAGE_PROTECTION, 0.05)
      setPlayerStorageValue(cid, STORAGE_OUTFIT, outfit_look.lookType)
      setPlayerStorageValue(cid, SOTRAGE_REFLECT_ATK, (getPlayerStorageValue(cid, SOTRAGE_REFLECT)*value))
      value = value-(getPlayerStorageValue(cid, STORAGE_PROTECTION)*value)

    end
  end
  for _, outfit in ipairs(outfits) do
    if outfit_look.lookType ~= getPlayerStorageValue(cid, STORAGE_OUTFIT) then

      setPlayerStorageValue(cid, SOTRAGE_REFLECT, 0)
      setPlayerStorageValue(cid, STORAGE_PROTECTION, 0)
      setPlayerStorageValue(cid, STORAGE_OUTFIT, 0)
      setPlayerStorageValue(cid, SOTRAGE_REFLECT_ATK, 0)
    end
  end

  if (type == STATSCHANGE_HEALTHLOSS or type == STATSCHANGE_MANALOSS) and isPlayer(attacker) and isPlayer(cid) then
    if getPlayerStorageValue(attacker, CRITICAL_STORAGE) <= 0 or getPlayerStorageValue(attacker, CRITICAL_STORAGE_DOIS) <= 0 then
      if getPlayerStorageValue(attacker, 201234) > os.time() then
          if getCreatureMana(cid) > bonusAttack and (getCreatureCondition(cid,CONDITION_MANASHIELD) or getPlayerSlotItem(cid,CONST_SLOT_RING).itemid == 2204) then
            doSendAnimatedText(getCreaturePos(cid),positivo(bonusAttack),89)
            doCreatureAddMana(cid,-(bonusAttack))
            doPlayerSendTextMessage(attacker,MESSAGE_EVENT_DEFAULT,getCreatureName(cid).." loses "..positivo(bonusAttack).." mana due to your bonus attack.")
          else
            doSendAnimatedText(getCreaturePos(cid),positivo(bonusAttack),180)
            doCreatureAddHealth(cid,-(bonusAttack))
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_DEFAULT,"You lose "..positivo(bonusAttack).." hitpoints due to an bonus attack by "..getCreatureName(attacker))
            doPlayerSendTextMessage(attacker,MESSAGE_EVENT_DEFAULT,getCreatureName(cid).." loses "..positivo(bonusAttack).." hitpoints due to your bonus attack.")
          end
      end
    end
  end


  if (type == STATSCHANGE_HEALTHLOSS or type == STATSCHANGE_MANALOSS) and isPlayer(attacker) and isPlayer(cid) then
  	local mult = 1
      if level then
        mult = mult + (0.03 * level)
      end
    if combat == COMBAT_PHYSICALDAMAGE or getPlayerStorageValue(attacker, CRITICAL_STORAGE) == 2 or getPlayerStorageValue(attacker, CRITICAL_STORAGE_DOIS) == 2 then
      setPlayerStorageValue(attacker, CRITICAL_STORAGE, 0)
      setPlayerStorageValue(attacker, CRITICAL_STORAGE_DOIS, 0)
      local sto_cd = tonumber(getPlayerStorageValue(attacker,722360))
      local sto_crit = tonumber(getPlayerStorageValue(attacker,lvlcrit))
      if sto_cd and sto_cd < os.time() then
        if sto_crit and (sto_crit*3) >= math.random (0,10000) then
          mult = mult + (multiplier - 1)
          doSendAnimatedText(getCreaturePos(attacker), "Super Hit!", 35)
          doSendMagicEffect(getCreaturePosition(cid), effect)
        end
      end
          if isPlayer(cid) then
            if getPlayerStorageValue(cid, SOTRAGE_REFLECT_ATK) > 0 then
              local dano = math.ceil(-(getPlayerStorageValue(cid, SOTRAGE_REFLECT_ATK)))
              if getCreatureMana(attacker) > positivo(dano) and (getCreatureCondition(attacker,CONDITION_MANASHIELD) or getPlayerSlotItem(cid,CONST_SLOT_RING).itemid == 2204) then
                doSendMagicEffect(getCreaturePosition(attacker), 1)
                doCreatureAddMana(attacker, dano)
                doPlayerSendTextMessage(cid,MESSAGE_EVENT_DEFAULT,getCreatureName(attacker).." loses "..positivo(dano).." mana due to your reflect attack.")
              else
                doCreatureAddHealth(attacker, dano, 0, 180, true)
                doPlayerSendTextMessage(attacker,MESSAGE_EVENT_DEFAULT,"You lose "..positivo(dano).." hitpoints due to an reflect attack by "..getCreatureName(cid))
                doPlayerSendTextMessage(cid,MESSAGE_EVENT_DEFAULT,getCreatureName(attacker).." loses "..positivo(dano).." hitpoints due to your reflect attack.")
              end
            end
            local dano = math.ceil(negativo(value)*(mult))
            if getCreatureMana(cid) > positivo(dano) and (getCreatureCondition(cid,CONDITION_MANASHIELD) or getPlayerSlotItem(cid,CONST_SLOT_RING).itemid == 2204) then
              doSendMagicEffect(getCreaturePosition(cid), 1)
              doCreatureAddMana(cid,dano)
              doPlayerSendTextMessage(attacker,MESSAGE_EVENT_DEFAULT,getCreatureName(cid).." loses "..positivo(dano).." mana due to your attack.")
            else
              doCreatureAddHealth(cid, dano, 0, 180, true)
              doPlayerSendTextMessage(cid,MESSAGE_EVENT_DEFAULT,"You lose "..positivo(dano).." hitpoints due to an attack by "..getCreatureName(attacker))
              doPlayerSendTextMessage(attacker,MESSAGE_EVENT_DEFAULT,getCreatureName(cid).." loses "..positivo(dano).." hitpoints due to your attack.")
            end
          end
    else--termina o if do fisico

    	if isPlayer(cid) then
            if getPlayerStorageValue(cid, SOTRAGE_REFLECT_ATK) > 0 then
              local dano = math.ceil(-(getPlayerStorageValue(cid, SOTRAGE_REFLECT_ATK)))
              if getCreatureMana(attacker) > positivo(dano) and (getCreatureCondition(attacker,CONDITION_MANASHIELD) or getPlayerSlotItem(cid,CONST_SLOT_RING).itemid == 2204) then
                doSendMagicEffect(getCreaturePosition(attacker), 1)
                doCreatureAddMana(attacker, dano)
                doPlayerSendTextMessage(cid,MESSAGE_EVENT_DEFAULT,getCreatureName(attacker).." loses "..positivo(dano).." mana due to your reflect attack.")
              else
                doCreatureAddHealth(attacker, dano, 0, 180, true)
                doPlayerSendTextMessage(attacker,MESSAGE_EVENT_DEFAULT,"You lose "..positivo(dano).." hitpoints due to an reflect attack by "..getCreatureName(cid))
                doPlayerSendTextMessage(cid,MESSAGE_EVENT_DEFAULT,getCreatureName(attacker).." loses "..positivo(dano).." hitpoints due to your reflect attack.")
              end
            end
            local dano = math.ceil(negativo(value)*(mult))
            if getCreatureMana(cid) > positivo(dano) and (getCreatureCondition(cid,CONDITION_MANASHIELD) or getPlayerSlotItem(cid,CONST_SLOT_RING).itemid == 2204) then
              doSendMagicEffect(getCreaturePosition(cid), 1)
              doCreatureAddMana(cid,dano)
              doPlayerSendTextMessage(attacker,MESSAGE_EVENT_DEFAULT,getCreatureName(cid).." loses "..positivo(dano).." mana due to your attack.")
            else
              doCreatureAddHealth(cid, dano, 0, 180, true)
              doPlayerSendTextMessage(cid,MESSAGE_EVENT_DEFAULT,"You lose "..positivo(dano).." hitpoints due to an attack by "..getCreatureName(attacker))
              doPlayerSendTextMessage(attacker,MESSAGE_EVENT_DEFAULT,getCreatureName(cid).." loses "..positivo(dano).." hitpoints due to your attack.")
            end
        end
    end
  end
  return true
end
