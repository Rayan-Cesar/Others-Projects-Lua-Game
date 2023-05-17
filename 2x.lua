function onUse(cid, item, frompos, item2, topos)
local pausa = 30*60*1000 -- (1000 = 1 segundos) Tempo que o script durará
local texto = "Agora voce ira receber 2x exp por 30 minutos." -- Texto que irá receber ao usar a potion.
local exp_normal = 2 -- O quanto que você quer que dobre sua experiencia, por exemplo 2 é 2x as rates do seu server.
local exp_alterada = 1
local limitedeuso = 61002
local storage_ativo = 61222
local textofinal1 = "Você já esta sob efeito da pot de experiência espere o efeito acabar."
local seuitem = 7440 -- seu item que dará double exp
local efeito2 = 35 -- efeito que acontecera no momento que usar a pot
local tempo = 1800

  if getPlayerLevel(cid) <= 2000 then
      return doPlayerSendCancel(cid,"Somente jogadores acima do level 2000 podem usar a potion 2x")
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
 