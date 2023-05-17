function onUse(cid, item, frompos, item2, topos)
local pausa = 30*60*1000
local texto = "Agora voce ira receber 4x exp por 30 minutos." 
local exp_normal = 4 -- O quanto que você quer que dobre sua experiencia, por exemplo 2 é 2x as rates do seu server.
local exp_alterada = 3
local limitedeuso = 61004
local storage_ativo = 61224
local textofinal1 = "Você já esta sob efeito da pot de experiência espere o efeito acabar."
local seuitem = 10142 
local efeito2 = 35 
local tempo = 1800

  if getPlayerLevel(cid) <= 8 then
      return doPlayerSendCancel(cid,"Somente jogadores acima do level 3000 podem usar a potion 3x")
    else
      if (item.itemid == seuitem) and (getPlayerStorageValue(cid, limitedeuso) - os.time() <= 0) then
        if getPlayerRates(cid)[SKILL__LEVEL] > 1 then
          doPlayerSetExperienceRate(cid, getPlayerRates(cid)[SKILL__LEVEL] + exp_alterada)
        else
          doPlayerSetExperienceRate(cid, exp_normal)
        end
          setPlayerStorageValue(cid, storage_ativo, 1)
          doRemoveItem(item.uid,1)
          doSendMagicEffect(frompos,efeito2)
          setPlayerStorageValue(cid, limitedeuso, os.time() + tempo)
          doPlayerSendTextMessage(cid,22,texto)
      elseif item.itemid == seuitem and (getPlayerStorageValue(cid, limitedeuso) - os.time() > 0) then
        doPlayerSendTextMessage(cid,22,textofinal1)
      end
  end
  return true
end
 