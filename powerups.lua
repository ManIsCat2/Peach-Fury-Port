-- Placed here to remove the need of setting models for every powerup
-- Uses the definitive model check

-- Models

E_MODEL_cloud_MARIO = smlua_model_util_get_id("cloud_mario_geo")

-- Powerups enum

NORMAL = 0
CLOUD = 1

characterPowerupModels = {
    [CT_MARIO] = { cloud = E_MODEL_cloud_MARIO, cat = nil, bee = nil },
    [CT_LUIGI] = { cloud = E_MODEL_cloud_MARIO, cat = nil, bee = nil },
    [CT_TOAD] = { cloud = E_MODEL_cloud_MARIO, cat = nil, bee = nil },
    [CT_WARIO] = { cloud = E_MODEL_cloud_MARIO, cat = nil, bee = nil },
    [CT_WALUIGI] = { cloud = E_MODEL_cloud_MARIO, cat = nil, bee = nil },
}

powerupStates = {
    [NORMAL] = { modelId = nil },
    [CLOUD] = { modelId = nil },
}

-- Powerup States, to add more powerups here, you must first add them to the enum and assign a number
function get_character_model(m)
    if m.playerIndex ~= 0 then return end
    CPM = characterPowerupModels[m.character.type] -- To get the model easily
    CPMM = characterPowerupModels[CT_MARIO]        -- To get Mario's model easily
    powerupStates = {
        [NORMAL] = { modelId = nil },
        [CLOUD] = { modelId = CPM.cloud and CPM.cloud or CPMM.cloud },
    }
end

hook_event(HOOK_MARIO_UPDATE, get_character_model)

-- Powerup Model Functions --

function powerups()
    gPlayerSyncTable[0].modelId = powerupStates[gPlayerSyncTable[0].powerup].modelId
end

hook_event(HOOK_OBJECT_SET_MODEL, function(o)
    if obj_has_behavior_id(o, id_bhvMario) ~= 0 then
        local i = network_local_index_from_global(o.globalPlayerIndex)
        if gPlayerSyncTable[i].modelId ~= nil and obj_has_model_extended(o, gPlayerSyncTable[i].modelId) == 0 then
            obj_set_model_extended(o, gPlayerSyncTable[i].modelId)
        end

        if gPlayerSyncTable[i].powerup == nil then gPlayerSyncTable[0].powerup = NORMAL end
    end
end)

-- Resets the player stats when leaving a level or dying

function on_death_warp()
    gPlayerSyncTable[0].powerup = NORMAL
end

-- Removes the player's powerup on damage

function damage_check(m)
    --djui_chat_message_create(tostring(cloudcount))
    if m.playerIndex ~= 0 then return end
    if m.hurtCounter > 0 or m.action == ACT_BURNING_GROUND or m.action == ACT_BURNING_JUMP then
        gPlayerSyncTable[0].powerup = NORMAL
    end
end

hook_event(HOOK_UPDATE, powerups)
hook_event(HOOK_MARIO_UPDATE, damage_check)
hook_event(HOOK_ON_DEATH, on_death_warp)
hook_event(HOOK_ON_WARP, on_death_warp)
