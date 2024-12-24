---@param obj Object
function bhv_cloud_init(obj)
    obj.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    --obj.oInteractType = INTERACT_CAP
    obj_set_model_extended(obj, smlua_model_util_get_id("cloudflowergeo"))
    obj.oFaceAngleYaw = obj.oFaceAngleYaw - 32768 
    obj.hitboxRadius = 30
    obj.hitboxHeight = 30
    obj.oIntangibleTimer = 0
    obj.oGravity = 2.4;
    --obj.oFriction = 0.999;
    obj.oBuoyancy = 1.5;
    obj.oOpacity = 0xFF;
    --network_init_object(obj, true, nil)
end

mark_obj_for_deletion = obj_mark_for_deletion

local cloudcount = 0

---@param obj Object
function bhv_cloud_loop(obj)
    object_step()

    local mstatesOBJ = gMarioStates[0].marioObj
    if (obj_check_hitbox_overlap(mstatesOBJ, obj)) then
        obj_mark_for_deletion(obj)
        gPlayerSyncTable[network_local_index_from_global(mstatesOBJ.globalPlayerIndex)].powerup = CLOUD
        cloudcount = 3
        play_sound(SOUND_MENU_STAR_SOUND, gGlobalSoundSource);
    end


    if obj.oTimer > 300 then
        obj_flicker_and_disappear(obj, 300)
    end
end

function cloudbox(o)
    o.oCollisionDistance = 1400
    o.oFaceAnglePitch = 0
    o.oFaceAngleRoll = 0
    --djui_chat_message_create(tostring(o.oTimer))
    if o.oTimer < 15 then
        o.header.gfx.scale.x = o.header.gfx.scale.x + 0.097;
        o.header.gfx.scale.y = o.header.gfx.scale.x;
        o.header.gfx.scale.z = o.header.gfx.scale.x;
        o.oFaceAngleYaw = o.oFaceAngleYaw + 0x0800;
    else
        if cur_obj_wait_then_blink(360, 20) ~= 0 or cur_obj_is_mario_ground_pounding_platform() == 1 then
            spawn_mist_particles_variable(0, -40.0, 46.0)
            mark_obj_for_deletion(o)
        else
            load_object_collision_model()
        end
    end
end

-- Function to check the cloud count
function checkCloudCount()
    local gMarioState = gMarioStates[0]
    local gMarioObject = gMarioStates[0].marioObj
    local o

    if cloudcount > obj_count_objects_with_behavior_id(bhvCloudFollow) then
        o = spawn_object(gMarioObject, smlua_model_util_get_id("cloudchase"), bhvCloudFollow)
        o.oHiddenBlueCoinSwitch = gMarioObject.oHiddenBlueCoinSwitch
        gMarioObject.oHiddenBlueCoinSwitch = o
    end
end

-- Function for cloud following
local gapclose = 0.1
function cloudfollowing(o)
    local gMarioState = gMarioStates[0]
    local gMarioObject = gMarioStates[0].marioObj
    --obj_set_billboard(o)
    local x, y, z
    if gMarioObject.oHiddenBlueCoinSwitch == o then
        y = gMarioState.pos.y + 150
        x = gMarioState.pos.x + sins(gMarioState.faceAngle.y) * 50
        z = gMarioState.pos.z + coss(gMarioState.faceAngle.y) * 50
    elseif gMarioObject.oHiddenBlueCoinSwitch and (gMarioObject.oHiddenBlueCoinSwitch.oHiddenBlueCoinSwitch == o) then
        y = gMarioObject.oHiddenBlueCoinSwitch.oPosY + 10
        x = gMarioObject.oHiddenBlueCoinSwitch.oPosX + sins(gMarioObject.oHiddenBlueCoinSwitch.oMoveAngleYaw) * 50
        z = gMarioObject.oHiddenBlueCoinSwitch.oPosZ + coss(gMarioObject.oHiddenBlueCoinSwitch.oMoveAngleYaw) * 50
    elseif gMarioObject.oHiddenBlueCoinSwitch and (gMarioObject.oHiddenBlueCoinSwitch.oHiddenBlueCoinSwitch) then
        y = gMarioObject.oHiddenBlueCoinSwitch.oHiddenBlueCoinSwitch.oPosY + 10
        x = gMarioObject.oHiddenBlueCoinSwitch.oHiddenBlueCoinSwitch.oPosX +
            sins(gMarioObject.oHiddenBlueCoinSwitch.oHiddenBlueCoinSwitch.oMoveAngleYaw) * 50
        z = gMarioObject.oHiddenBlueCoinSwitch.oHiddenBlueCoinSwitch.oPosZ +
            coss(gMarioObject.oHiddenBlueCoinSwitch.oHiddenBlueCoinSwitch.oMoveAngleYaw) * 50
    end
    o.oPosX = o.oPosX + (x - o.oPosX) * gapclose
    o.oPosY = o.oPosY + (y - o.oPosY) * gapclose
    o.oPosZ = o.oPosZ + (z - o.oPosZ) * gapclose

    if gPlayerSyncTable[0].powerup ~= CLOUD then
        mark_obj_for_deletion(o)
    end
end

MODEL_CLOUDSPAWN = smlua_model_util_get_id("cloudspawn")

function cloud_powerup(m)
    if gPlayerSyncTable[0].powerup == CLOUD then
        checkCloudCount()
    end
    --djui_chat_message_create(tostring(cloudcount))
    if m.playerIndex ~= 0 then return end

    local gMarioState = gMarioStates[0]
    local gMarioObject = gMarioState.marioObj
    --djui_chat_message_create(tostring(gMarioObject.oHiddenBlueCoinSwitch))
    if gPlayerSyncTable[0].powerup == CLOUD then
        local a
        if (m.action & ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION) ~= 0 then
            if (m.action & ACT_FLAG_INVULNERABLE) == 0 then
                if (m.controller.buttonPressed & A_BUTTON) ~= 0 then
                    if m.pos.y > m.floorHeight + 72 then
                        if (m.action ~= ACT_WALL_KICK_AIR) or (m.actionTimer > 1) then
                            if (m.action ~= ACT_FORWARD_ROLLOUT) and (m.action ~= ACT_FLYING_TRIPLE_JUMP) then
                                if cloudcount > 0 then
                                    spawn_sync_object(bhvCloudSpawn, MODEL_CLOUDSPAWN, m.pos.x,
                                        m.pos.y - 130, m.pos.z, nil)
                                    spawn_mist_particles_variable(0, -40.0, 46.0)
                                    m.vel.y = 30
                                    m.forwardVel = 0
                                    --[[gMarioState.inertia[1] = 0
                                    gMarioState.inertia[2] = 0
                                    gMarioState.inertia[3] = 0]]
                                    set_mario_action(m, ACT_FORWARD_ROLLOUT, 0)
                                    cloudcount = cloudcount - 1
                                    if cloudcount == 0 then
                                        gPlayerSyncTable[0].powerup = NORMAL
                                        obj_mark_for_deletion(gMarioObject.oHiddenBlueCoinSwitch)
                                    elseif cloudcount == 1 then
                                        obj_mark_for_deletion(gMarioObject.oHiddenBlueCoinSwitch.oHiddenBlueCoinSwitch)
                                    elseif cloudcount == 2 then
                                        obj_mark_for_deletion(gMarioObject.oHiddenBlueCoinSwitch.oHiddenBlueCoinSwitch
                                            .oHiddenBlueCoinSwitch)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

hook_event(HOOK_MARIO_UPDATE, cloud_powerup)
hook_behavior(id_bhvMetalCap, OBJ_LIST_GENACTOR, true, bhv_cloud_init, bhv_cloud_loop)
