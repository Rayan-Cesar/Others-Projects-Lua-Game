function onSay(cid, words, param)

    if words =="!resetar" or words =="!reset" then
     
            local coNdConf = {

            needPz = true,
            needPa = false,         
            withe = false,                
            red = false,                    
            battle = false,                
            teleport = true,             
            look = true,                   
            pid = getPlayerGUID(cid),  


            resetConf = {

                Level = 1000,              
                backLvl = 30,                   
                time = 0,      				

            },
        }
        x=true;X=true
        local stage = {Habilitar = {x}, DesHabilitar = {},    
            stage1= {resets= 0,  premmy= 1000, free= 1000},
            stage2= {resets= 1,  premmy= 2000, free= 2000},    
            stage3= {resets= 2, premmy= 3000, free= 3000},     
            stage4= {resets= 3, premmy= 4000, free= 4000},     
            stage5= {resets= 4, premmy= 5000, free= 5000},    
            stage6= {resets= 5, premmy= 6000, free= 6000},      
            stage7= {resets= 6, premmy= 7000, free= 7000},     
            stage8= {resets= 7, premmy= 8000, free= 8000},     
            stage9= {resets= 8, premmy= 9000, free= 9000},
            stage10={resets= 9, premmy= 10000, free= 10000},
            stage11={resets= 10, premmy= 11000, free= 11000},
            stage12={resets= 11, premmy= 12000, free= 12000},
            stage13={resets= 12, premmy= 13000, free= 13000},
            stage14={resets= 13, premmy= 14000, free= 14000},
            stage15={resets= 14, premmy= 15000, free= 15000},
            stage16={resets= 15, premmy= 16000, free= 16000},
            stage17={resets= 16, premmy= 17000, free= 17000},
            stage18={resets= 17, premmy= 18000, free= 18000},
            stage19={resets= 18, premmy= 19000, free= 19000},
            stage20={resets= 19, premmy= 20000, free= 20000},
            stage21={resets= 20, premmy= 21000, free= 21000},
            stage22={resets= 21, premmy= 22000, free= 22000},
            stage23={resets= 22, premmy= 23000, free= 23000},
            stage24={resets= 23, premmy= 24000, free= 24000},
            stage25={resets= 24, premmy= 25000, free= 25000},
            stage26={resets= 25, premmy= 26000, free= 26000},
            stage27={resets= 26, premmy= 27000, free= 27000},
            stage28={resets= 27, premmy= 28000, free= 28000},
            stage29={resets= 28, premmy= 29000, free= 29000},
            stage30={resets= 29, premmy= 30000, free= 30000},
            stage31={resets= 30, premmy= 31000, free= 31000},
            stage32={resets= 31, premmy= 32000, free= 32000},
            stage33={resets= 32, premmy= 33000, free= 33000},
            stage34={resets= 33, premmy= 34000, free= 34000},
            stage35={resets= 34, premmy= 35000, free= 35000},
            stage36={resets= 35, premmy= 36000, free= 36000},
            stage37={resets= 36, premmy= 37000, free= 37000},
            stage38={resets= 37, premmy= 38000, free= 38000},
            stage39={resets= 38, premmy= 39000, free= 39000},
            stage40={resets= 39, premmy= 40000, free= 40000},
            stage41={resets= 40, premmy= 41000, free= 41000},
            stage42={resets= 41, premmy= 42000, free= 42000},
            stage43={resets= 42, premmy= 43000, free= 43000},
            stage44={resets= 43, premmy= 44000, free= 44000},
            stage45={resets= 44, premmy= 45000, free= 45000},
            stage46={resets= 45, premmy= 46000, free= 46000},
            stage47={resets= 46, premmy= 47000, free= 47000},
            stage48={resets= 47, premmy= 48000, free= 48000},
            stage49={resets= 48, premmy= 49000, free= 49000},
            stage50={resets= 49, premmy= 50000, free= 50000},
            stage51={resets= 50, premmy= 51000, free= 51000},


        }       

        -- Pega o valor de reset
        function getPlayerReset(cid)
            local qr = db.getResult("SELECT `reset` FROM `players` WHERE `id`= "..coNdConf.pid..";")
            rss = qr:getDataInt("reset", coNdConf.pid)
            if rss < 0 then
                rss = 0
            end
            return rss
        end 

        local success = "                   ~~ Sucesso! ~~ \nVocê tem agora "..(getPlayerReset(cid)+1).." resets. \nVocê será deslogado em "..coNdConf.resetConf.time.." segundos." ;err = doPlayerSendTextMessage
        local qrt = db.getResult("SELECT `reset` FROM `players` WHERE `id`= "..coNdConf.pid..";");rss_db = qrt:getDataInt("reset", coNdConf.pid)
        local lvl_query = "UPDATE `players` SET `level` = "..(coNdConf.resetConf.backLvl)..", `experience` = 0 WHERE `id`= " .. coNdConf.pid .. ";"
        local reset_query = "UPDATE `players` SET `reset` = "..(getPlayerReset(cid)+(1)).." WHERE `id`= " .. coNdConf.pid .. ";"
        local nolook_query = "UPDATE `players` SET `description` = '' WHERE `players`.`id`= " .. coNdConf.pid .. ";"
        local look_query = "UPDATE `players` SET `description` = ' [Reset "..(getPlayerReset(cid)+(1)).."]' WHERE `players`.`id`= " .. coNdConf.pid .. ";"

        function addValue(value)
            if coNdConf.look == false then
                doRemoveCreature(cid)
                db.executeQuery(lvl_query);db.executeQuery(reset_query);db.executeQuery(nolook_query);db.executeQuery(reset_exp)
            else
                doRemoveCreature(cid)
                db.executeQuery(lvl_query);db.executeQuery(reset_query);db.executeQuery(look_query);db.executeQuery(reset_exp)
                return LUA_NO_ERROR
            end
        end   

        function nowReseting()
            if (getPlayerLevel(cid) < coNdConf.resetConf.Level) then
                print(getPlayerReset(cid))
                doPlayerPopupFYI(cid, "Para o Reset ["..(getPlayerReset(cid)+(1)).."], o minimo de level é: ["..coNdConf.resetConf.Level.."]!")
                return true
            end
            if getPlayerLevel(cid) >= coNdConf.resetConf.Level and (coNdConf.teleport == false) then
                doPlayerPopupFYI(cid, success)
                addEvent(addValue, coNdConf.resetConf.time*1000, value)
            else
                doPlayerPopupFYI(cid, success)
                addEvent(addValue, coNdConf.resetConf.time*1000, value)
                doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
                return true
            end
        end

        function checkLevelStageReset(cid)

            local stages = {
                {resets= stage.stage1.resets, premmy= stage.stage1.premmy, free= stage.stage1.free},
                {resets= stage.stage2.resets, premmy= stage.stage2.premmy, free= stage.stage2.free},
                {resets= stage.stage3.resets, premmy= stage.stage3.premmy, free= stage.stage3.free},
                {resets= stage.stage4.resets, premmy= stage.stage4.premmy, free= stage.stage4.free},
                {resets= stage.stage5.resets, premmy= stage.stage5.premmy, free= stage.stage5.free},
                {resets= stage.stage6.resets, premmy= stage.stage6.premmy, free= stage.stage6.free},
                {resets= stage.stage7.resets, premmy= stage.stage7.premmy, free= stage.stage7.free},
                {resets= stage.stage8.resets, premmy= stage.stage8.premmy, free= stage.stage8.free},
                {resets= stage.stage9.resets, premmy= stage.stage9.premmy, free= stage.stage9.free},
                {resets=stage.stage10.resets, premmy=stage.stage10.premmy, free=stage.stage10.free},
                {resets=stage.stage11.resets, premmy=stage.stage11.premmy, free=stage.stage11.free},
                {resets=stage.stage12.resets, premmy=stage.stage12.premmy, free=stage.stage12.free},
                {resets=stage.stage13.resets, premmy=stage.stage13.premmy, free=stage.stage13.free},
                {resets=stage.stage14.resets, premmy=stage.stage14.premmy, free=stage.stage14.free},
                {resets=stage.stage15.resets, premmy=stage.stage15.premmy, free=stage.stage15.free},
                {resets=stage.stage16.resets, premmy=stage.stage16.premmy, free=stage.stage16.free},
                {resets=stage.stage17.resets, premmy=stage.stage17.premmy, free=stage.stage17.free},
                {resets=stage.stage18.resets, premmy=stage.stage18.premmy, free=stage.stage18.free},
                {resets=stage.stage20.resets, premmy=stage.stage20.premmy, free=stage.stage20.free},
                {resets=stage.stage21.resets, premmy=stage.stage21.premmy, free=stage.stage21.free},
                {resets=stage.stage22.resets, premmy=stage.stage22.premmy, free=stage.stage22.free},
                {resets=stage.stage23.resets, premmy=stage.stage23.premmy, free=stage.stage23.free},
                {resets=stage.stage24.resets, premmy=stage.stage24.premmy, free=stage.stage24.free},
                {resets=stage.stage25.resets, premmy=stage.stage25.premmy, free=stage.stage25.free},
                {resets=stage.stage26.resets, premmy=stage.stage26.premmy, free=stage.stage26.free},
                {resets=stage.stage27.resets, premmy=stage.stage27.premmy, free=stage.stage27.free},
                {resets=stage.stage28.resets, premmy=stage.stage28.premmy, free=stage.stage28.free},
                {resets=stage.stage29.resets, premmy=stage.stage29.premmy, free=stage.stage29.free},
                {resets=stage.stage30.resets, premmy=stage.stage30.premmy, free=stage.stage30.free},
                {resets=stage.stage31.resets, premmy=stage.stage31.premmy, free=stage.stage31.free},
                {resets=stage.stage32.resets, premmy=stage.stage32.premmy, free=stage.stage32.free},
                {resets=stage.stage33.resets, premmy=stage.stage33.premmy, free=stage.stage33.free},
                {resets=stage.stage34.resets, premmy=stage.stage34.premmy, free=stage.stage34.free},
                {resets=stage.stage35.resets, premmy=stage.stage35.premmy, free=stage.stage35.free},
                {resets=stage.stage36.resets, premmy=stage.stage36.premmy, free=stage.stage36.free},
                {resets=stage.stage37.resets, premmy=stage.stage37.premmy, free=stage.stage37.free},
                {resets=stage.stage38.resets, premmy=stage.stage38.premmy, free=stage.stage38.free},
                {resets=stage.stage39.resets, premmy=stage.stage39.premmy, free=stage.stage39.free},
                {resets=stage.stage40.resets, premmy=stage.stage40.premmy, free=stage.stage40.free},
                {resets=stage.stage41.resets, premmy=stage.stage41.premmy, free=stage.stage41.free},
                {resets=stage.stage42.resets, premmy=stage.stage42.premmy, free=stage.stage42.free},
                {resets=stage.stage43.resets, premmy=stage.stage43.premmy, free=stage.stage43.free},
                {resets=stage.stage44.resets, premmy=stage.stage44.premmy, free=stage.stage44.free},
                {resets=stage.stage45.resets, premmy=stage.stage45.premmy, free=stage.stage45.free},
                {resets=stage.stage46.resets, premmy=stage.stage46.premmy, free=stage.stage46.free},
                {resets=stage.stage47.resets, premmy=stage.stage47.premmy, free=stage.stage47.free},
                {resets=stage.stage48.resets, premmy=stage.stage48.premmy, free=stage.stage48.free},
                {resets=stage.stage49.resets, premmy=stage.stage49.premmy, free=stage.stage49.free},
                {resets=stage.stage50.resets, premmy=stage.stage50.premmy, free=stage.stage50.free},
                {resets=stage.stage51.resets, premmy=stage.stage51.premmy, free=stage.stage51.free},
            }
            local resets = getPlayerReset(cid)
            for i, tab in ipairs(stages) do
                if resets <= tab.resets then
                    coNdConf.resetConf.Level = isPremium(cid) and tab.premmy or tab.free
                    break
                end
            end
            if (getPlayerLevel(cid) < coNdConf.resetConf.Level) then
                err(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Para o Reset ["..(getPlayerReset(cid)+(1)).."], o minimo de level é: ["..coNdConf.resetConf.Level.."]!")
                return TRUE
            end

            if getPlayerLevel(cid) >= coNdConf.resetConf.Level and (coNdConf.teleport == false) then
                doPlayerPopupFYI(cid, success)
                addEvent(addValue, coNdConf.resetConf.time*1000, value)
            else
                doPlayerPopupFYI(cid, success)
                doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
                addEvent(addValue, coNdConf.resetConf.time*2000, value)
                return true
            end
        end
        function newReset(cid)
            if(coNdConf.needPz == true) and (getTileInfo(getThingPos(cid)).protection == LUA_ERROR) then
                err(cid,MESSAGE_STATUS_CONSOLE_BLUE,"- Você Precisa estar em Protection Zone Para Resetar. -") return TRUE end
            if(coNdConf.needPa == true) and not isPremium(cid) then
                err(cid,MESSAGE_STATUS_CONSOLE_BLUE,"- Você Precisa ser Premium Account para Resetar. -") return TRUE end
            if(coNdConf.withe == false) and (getCreatureSkullType(cid) == 3) then
                err(cid,MESSAGE_STATUS_CONSOLE_BLUE,"- Você não pode resetar de PK Withe. -") return TRUE end
            if(coNdConf.red == false) and (getCreatureSkullType(cid) == 4) then
                err(cid,MESSAGE_STATUS_CONSOLE_BLUE,"- Você não pode resetar de PK Red. -") return TRUE end
            if(coNdConf.battle == true) and (getCreatureCondition(cid, CONDITION_INFIGHT) == TRUE) then
                err(cid,MESSAGE_STATUS_CONSOLE_BLUE,"- Você Precisa estar sem Battle para Resetar. -") return TRUE end

            local xy = {true,false}
            table.insert(stage.Habilitar, false)
            table.insert(stage.DesHabilitar, false)
            if stage.Habilitar[1] == xy[1] and stage.DesHabilitar[1] == xy[2] then
                checkLevelStageReset(cid)
            elseif stage.Habilitar[1] == xy[2] and stage.DesHabilitar[1] == xy[1] then
                nowReseting()
            else
                doPlayerPopupFYI(cid, "LUA_ERROR; Configure corretamente o Sistema de STAGES!")
            end
            return true
        end
        function tableResetInstall()
            print(not rss_db  and LUA_ERROR or "Tabela de Resets: Instalada ... [success] ")
            addEvent(newReset, 1000, cid)
            return false
        end
        if tableResetInstall() then
        end
    end
 
    function installReset()
        if db.executeQuery("ALTER TABLE `players` ADD reset INT(11) NOT NULL DEFAULT 0;") then
            print("[MarcelloMkez] -= Advanced Reset System 2.0 por DataBase =- Instalado com sucesso!")
            return TRUE
        end
        print('[Advanced Reset System/MarcelloMkez] Não foi Possível instalar o Sistema.')
        return FALSE
    end
   end
   
    return 1   
end