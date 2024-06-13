---@param parent Object
---@param model ModelExtendedId
---@param behaviorId BehaviorId
local function spawn_object(parent, model, behaviorId)
    local obj = spawn_non_sync_object(behaviorId, model, 0, 0, 0, nil)
    if not obj then return nil end

    obj_copy_pos_and_angle(obj, parent)
    return obj
end


function goombastar(o)
    if (o.oBehParams == 6) then
        if (not obj_get_nearest_object_with_behavior_id(o, id_bhvGoomba)) then
            obj_mark_for_deletion(o)
            spawn_default_star(gMarioStates[0].pos.x, gMarioStates[0].pos.y + 200.0, gMarioStates[0].pos.z)
        end
    end

    if (o.oBehParams2ndByte == 1) then
        if (not obj_get_nearest_object_with_behavior_id(o, id_bhvChuckya)) then
            obj_mark_for_deletion(o)
            spawn_default_star(gMarioStates[0].pos.x, gMarioStates[0].pos.y + 200.0, gMarioStates[0].pos.z)
        end
    end
end

function lua_bounce_off_object(m, o, velY)
    m.pos.y = o.oPosY + o.hitboxHeight
    m.vel.y = velY

    m.flags = m.flags & ~MARIO_UNKNOWN_08

    play_sound(SOUND_ACTION_BOUNCE_OFF_OBJECT, m.marioObj.header.gfx.cameraToObject)
end

local latdist = 120.0
local vertdist = 80.0

MODEL_BOUNCY_FLOWER = smlua_model_util_get_id("bouncyflower_geo")

function bounceyflower(o)
    smlua_anim_util_set_animation(o, "anim_spin_flower")
    o.oFaceAngleYaw = o.oFaceAngleYaw + 0x800
    local lateral_dist = lateral_dist_between_objects(o, gMarioStates[0].marioObj)
    local vertical_dist = math.abs(gMarioStates[0].pos.y - o.oPosY)
    if (lateral_dist < latdist) and (vertical_dist < vertdist) then
        gMarioStates[0].faceAngle.x = 0
        play_sound(SOUND_MARIO_TWIRL_BOUNCE, gMarioStates[0].marioObj.header.gfx.cameraToObject)
        drop_and_set_mario_action(gMarioStates[0], ACT_TWIRLING, 0)
        lua_bounce_off_object(gMarioStates[0], o, 100.0 - o.oBehParams2ndByte)
        gMarioStates[0].vel.y = 100.0 - o.oBehParams2ndByte
    end
end

local GOALSCALE = function(o)
    return (o.oBehParams2ndByte / 100.0 + 1.0)
end

MODEL_BOUNCE_SHROOM = smlua_model_util_get_id("bounceShroom2_geo")
COL_BOUNCE_SHROOM = smlua_collision_util_get("bounceShroom2_collision")

function diagshroom(o)
    local m = gMarioStates[0]
    load_object_collision_model()
    o.collisionData = COL_BOUNCE_SHROOM
    if o.oOpacity == 0 then
        cur_obj_scale(GOALSCALE(o))
        o.oOpacity = o.oOpacity + 1
    end
    if cur_obj_is_mario_on_platform() == 1 then
        if (m.floor.type) == 0x15 then
            if o.oBehParams2ndByte == 0 then
                m.action = ACT_WATER_JUMP
                m.vel.y = 90.0
                m.forwardVel = 48.0
                m.faceAngle.y = o.oFaceAngleYaw
            else
                m.action = ACT_TRIPLE_JUMP
                m.vel.y = 99.0 + o.oBehParams2ndByte
            end
            o.oForwardVel = 0.08
            cur_obj_play_sound_1(SOUND_OBJ_SNOWMAN_BOUNCE)
            m.marioObj.header.gfx.animInfo.animFrame = 0
            o.oTimer = 0
            spawn_mist_particles()
        end
    end
    cur_obj_scale(o.header.gfx.scale.x + o.oForwardVel)
    o.oForwardVel = approach_f32_symmetric(o.oForwardVel, (GOALSCALE(o) - o.header.gfx.scale.x), 0.01)
    o.oForwardVel = o.oForwardVel * 0.96
    if (m.action == ACT_TRIPLE_JUMP) and (o.oTimer < 45) then
        if o.oTimer < 14 then
            spawn_mist_particles()
        end
        if o.oBehParams2ndByte then
            m.faceAngle.y = approach_s16_symmetric(m.faceAngle.y, m.intendedYaw, 0x200)
        end
        m.peakHeight = -100000.0
    end
end

MODEL_BBARREL = smlua_model_util_get_id("bbarrel_geo")

function bbarrelcode(o)
    o.collisionData = smlua_collision_util_get("bbarrel_collision")
    if o.oAction == 0 then
        if o.oTimer == 0 then
            o.oFaceAngleYaw = math.random(0, 65535)
        end
        if cur_obj_is_mario_ground_pounding_platform() == 1 then
            o.oAction = 1
            o.oTimer = 0
        end
    end

    local MINSUB = 0.1167

    if o.oAction == 1 then
        o.header.gfx.scale.y = o.header.gfx.scale.y - MINSUB
        o.header.gfx.scale.x = math.sqrt(1 / o.header.gfx.scale.y)
        o.header.gfx.scale.z = o.header.gfx.scale.x
        if o.header.gfx.scale.y < (MINSUB * 4) then
            obj_mark_for_deletion(o)
            spawn_mist_particles_variable(0, 0, 46)
            spawn_triangle_break_particles(30, 138, 3.0, 4)
            local behParams2ndByte = o.oBehParams2ndByte
            if behParams2ndByte == 0 then
                spawn_object(o, 0, id_bhvTemporaryYellowCoin)
            elseif behParams2ndByte == 1 then
                spawn_object(o, 0, id_bhvThreeCoinsSpawn)
            elseif behParams2ndByte == 2 then
                spawn_object(o, E_MODEL_BLUE_COIN, id_bhvMrIBlueCoin)
            elseif behParams2ndByte == 3 then
                spawn_object(o, 0, id_bhvTenCoinsSpawn)
            end
        end
    end
    load_object_collision_model()
end

function scavengersign(o)
    local sign
    if o.oAction == 0 then
        if (gMarioStates[0].action == ACT_GROUND_POUND_LAND) and (o.oDistanceToMario < 1000) then
            if o.oBehParams & 0x00ff ~= 0 then
                spawn_default_star(gMarioStates[0].pos.x, gMarioStates[0].pos.y + 200, gMarioStates[0].pos.z)
                obj_mark_for_deletion(o)
            else
                sign = spawn_object(o, E_MODEL_WOODEN_SIGNPOST, id_bhvMessagePanel)
                spawn_object(o, 0, id_bhvMistCircParticleSpawner)
                sign.oBehParams2ndByte = o.oBehParams2ndByte
                sign.oMoveAngleYaw = atan2s(o.oPosZ - gMarioStates[0].marioObj.oPosZ,
                    o.oPosX - gMarioStates[0].marioObj.oPosX) + 0x8000
                sign.oFaceAngleYaw = sign.oMoveAngleYaw
                o.oAction = 1
                sign.oPosY = sign.oPosY - 200
                o.oHiddenBlueCoinSwitch = sign
                play_sound(SOUND_GENERAL2_RIGHT_ANSWER, { x = 0, y = 0, z = 0 })
            end
        end
    else
        if o.oHiddenBlueCoinSwitch then
            if o.oTimer < 10 then
                o.oHiddenBlueCoinSwitch.oPosY = o.oHiddenBlueCoinSwitch.oPosY + 3
            end
        end
    end
end

MODEL_ROTATETHING = smlua_model_util_get_id("rotatething_geo")
COL_ROTATETHING = smlua_collision_util_get("rotatething_collision")

---@param o Object
function goround(o)
    o.collisionData = COL_ROTATETHING
    if o.oAction == 0 then
        o.oOpacity = obj_angle_to_object(o, gMarioStates[0].marioObj)
        if cur_obj_is_mario_on_platform() == 1 then
            o.oAction = 1
        end
    else
        if (math.abs(o.oAngleVelYaw) > 70) and o.oMacroUnk10C == 0 then
            spawn_object(o, E_MODEL_SPARKLES, id_bhvSparkleParticleSpawner)
            if o.oTimer % 8 == 0 then
                cur_obj_play_sound_1(SOUND_GENERAL_BOAT_ROCK)
            end
        end
        o.oAngleVelYaw = o.oAngleVelYaw -
            ((math.floor(obj_angle_to_object(o, gMarioStates[0].marioObj) - o.oOpacity)) / 10)
        o.oOpacity = obj_angle_to_object(o, gMarioStates[0].marioObj)
        if cur_obj_is_mario_on_platform() == 0 then
            o.oAction = 0
        end
        if math.abs(o.oMacroUnk108) > 10000 then
            if o.oMacroUnk10C == 0 then
                o.oMacroUnk10C = 1
                spawn_default_star(gMarioStates[0].pos.x, gMarioStates[0].pos.y + 200, gMarioStates[0].pos.z)
            end
        end
    end
    if math.abs(o.oMacroUnk108) > 10000 then
        o.oPosY = 66 + o.oHomeY
    else
        o.oPosY = math.abs(o.oMacroUnk108) / 500 + o.oHomeY
    end
    o.oAngleVelYaw = approach_s16_asymptotic(o.oAngleVelYaw, 0, 3)
    o.oFaceAngleYaw = o.oFaceAngleYaw + o.oAngleVelYaw
    o.oMacroUnk108 = o.oMacroUnk108 + o.oAngleVelYaw
    load_object_collision_model()
end

function checkRun(currentObj)
    if (currentObj.oDistanceToMario < 500.0) then
        currentObj.oBehParams2ndByte = obj_angle_to_object(gMarioStates[0].marioObj, currentObj);
        currentObj.oAction = 3;
        cur_obj_play_sound_1(SOUND_GENERAL_BIRDS_FLY_AWAY);
    end
end

E_MODEL_BIRDS2 = smlua_model_util_get_id("birds2_geo")

function freebird(o)
    local coin
    local x, y, z
    x = o.oPosX
    y = o.oPosY
    z = o.oPosZ
    -- o.oGraphYOffset = 18.0 * o.header.gfx.scale[1]
    if o.oAction == 0 then
        -- init values
        if obj_has_model_extended(o, E_MODEL_BIRDS) ~= 0 then
            cur_obj_scale(1.0 + random_f32_around_zero(0.5))
        else
            cur_obj_scale(2.0)
            o.oDrawingDistance = 16000.0
        end
        o.oOpacity = o.oMoveAngleYaw
        o.oMoveAngleYaw = math.random(0, 65536)
        o.oAction = o.oAction + 1
        o.header.gfx.animInfo.animFrame = math.random(0, 65536) % 50
        cur_obj_init_animation(1)
    elseif o.oAction == 1 then
        -- stand around
        if o.header.gfx.animInfo.animFrame == 53 then
            if ((math.random(0, 65536) & 1) == 0) then
                o.oAction = 2
            else
                o.header.gfx.animInfo.animFrame = 0
            end
        end
        o.oForwardVel = approach_f32_symmetric(o.oForwardVel, 0.0, 1.0)
        checkRun(o)
    elseif o.oAction == 2 then
        -- smol hop
        if o.oTimer == 5 then
            o.oVelY = 20.0
            o.oForwardVel = 8.0
            if cur_obj_lateral_dist_to_home() < 400.0 then
                o.oMoveAngleYaw = math.random(0, 65536)
            else
                o.oMoveAngleYaw = cur_obj_angle_to_home()
            end
        end
        if o.oTimer == 25 then
            o.oAction = 1
        end
        checkRun(o)
    elseif o.oAction == 3 then
        cur_obj_init_animation(0)
        -- fly away, drop coin
        if o.oTimer == 0 then
            if obj_has_model_extended(o, E_MODEL_BIRDS) ~= 0 then
                coin = spawn_object(o, E_MODEL_YELLOW_COIN, id_bhvMovingYellowCoin)
                coin.oForwardVel = 0.67 * 10
                coin.oVelY = 0.67 * 40 + 20
                coin.oMoveAngleYaw = math.random(0, 65536)
            end
        end
        o.oForwardVel = approach_f32_symmetric(o.oForwardVel, 50.0, 5.0)
        o.oVelY = approach_f32_symmetric(o.oVelY, 30.0, 3.0)
        if o.oTimer > 8 then
            o.oMoveAngleYaw = approach_s16_symmetric(o.oMoveAngleYaw, o.oOpacity, 0x800)
        else
            o.oMoveAngleYaw = approach_s16_symmetric(o.oMoveAngleYaw, o.oBehParams2ndByte, 0x200)
        end
        if o.oTimer > 210 then
            obj_mark_for_deletion(o)
        end
    end
    if o.oAction == 3 and o.oTimer > 40 then
        cur_obj_move_using_vel()
    elseif o.oAction ~= 1 then
        cur_obj_update_floor_and_walls()
        cur_obj_move_standard(-78)
        if o.oAction ~= 3 then
            if o.oFloorHeight < o.oHomeY then
                o.oPosX = x
                o.oPosZ = z
            end
        end
    end
end

MODEL_PEACHY = smlua_model_util_get_id("peachy_geo")

function peachcode(o)
    smlua_anim_util_set_animation(o, "anim_peachy_0")
    bhv_bobomb_buddy_loop()
end

MODEL_GLOWSPOT = smlua_model_util_get_id("glowspot_geo")

function bhvbluespawenrosadhbgiuogdsiuzfghdsaiuzofgo(o)
    o.hitboxHeight = 70
    o.hitboxRadius = 70
    if gMarioStates[0].action == ACT_GROUND_POUND_LAND and obj_check_hitbox_overlap(o, gMarioStates[0].marioObj) then
        spawn_default_star(gMarioStates[0].pos.x, gMarioStates[0].pos.y + 200, gMarioStates[0].pos.z)
        obj_mark_for_deletion(o)
    end
end

local SEGMENTLENGTH = -200.0

function calcMarioVinePos(o)
    local rotation = o.oMoveAnglePitch / 5
    local xc = math.sin(math.rad(o.oFaceAngleYaw))
    local zc = math.cos(math.rad(o.oFaceAngleYaw))
    local currX = o.oPosX
    local currY = o.oPosY + 1000.0
    local currZ = o.oPosZ

    for i = 1, 4 do
        currX = currX + xc * math.sin(math.rad(rotation * i)) * SEGMENTLENGTH
        currY = currY + math.cos(math.rad(rotation * i)) * SEGMENTLENGTH
        currZ = currZ + zc * math.sin(math.rad(rotation * i)) * SEGMENTLENGTH
    end

    local VISUALOFFSET = -50.0
    currX = currX + xc * math.sin(math.rad(0x4000 + rotation * 4)) * VISUALOFFSET
    currY = currY + math.cos(math.rad(0x4000 + rotation * 4)) * VISUALOFFSET
    currZ = currZ + zc * math.sin(math.rad(0x4000 + rotation * 4)) * VISUALOFFSET

    if (o.oTimer < 15) then
        gMarioStates[0].pos.x =
            approach_f32_asymptotic(gMarioStates[0].pos.x, currX, 0.06666 * (o.oTimer + 1));
        gMarioStates[0].pos.y =
            approach_f32_asymptotic(gMarioStates[0].pos.y, currY, 0.06666 * (o.oTimer + 1));
        gMarioStates[0].pos.z =
            approach_f32_asymptotic(gMarioStates[0].pos.z, currZ, 0.06666 * (o.oTimer + 1));
        gMarioStates[0].pos.x = approach_f32_symmetric(gMarioStates[0].pos.x, currX, 10.0);
        gMarioStates[0].pos.y = approach_f32_symmetric(gMarioStates[0].pos.y, currY, 10.0);
        gMarioStates[0].pos.z = approach_f32_symmetric(gMarioStates[0].pos.z, currZ, 10.0);
    else
        gMarioStates[0].pos.x = currX;
        gMarioStates[0].pos.y = currY;
        gMarioStates[0].pos.z = currZ;
    end
end

ACT_HANG_VINE =        allocate_mario_action(0x151 | ACT_FLAG_STATIONARY | ACT_FLAG_ON_POLE | ACT_FLAG_PAUSE_EXIT)

MODEL_SWINGVINE = smlua_model_util_get_id("swingvine_geo")

-- Function to swing the vine
function swingVein(o)
    local i
    local transformers
    local speedScale = 1.0
    ---@type MarioState
    local m = gMarioStates[0]
    o.oAnimState = o.oBehParams2ndByte

    if o.oAction == 0 then
        if (math.random(0, 65535) & 0x3F) == 0 then
            o.oAngleVelPitch = o.oAngleVelPitch + (math.random(0, 200) - 100)
        end
        if o.oTimer > 20 then
            if (lateral_dist_between_objects(o, gMarioStates[0].marioObj) < 100.0) and
                (gMarioStates[0].pos.y + 100.0 > o.oPosY) and
                (gMarioStates[0].pos.y < o.oPosY + 1000.0) then
                if (m.controller.buttonDown & Y_BUTTON) ~= 0 then
                    o.oAction = 1
                    gMarioStates[0].action = ACT_HANG_VINE
                    gMarioStates[0].usedObj = o
                    o.oAngleVelPitch = -gMarioStates[0].forwardVel / 0.01581917687 / 2.0
                    play_sound(SOUND_MARIO_WHOA, m.marioObj.header.gfx.cameraToObject)
                end
            end
        end
    elseif o.oAction == 1 then
        local OFFSET = -1000.0
        speedScale = speedScale + 4.0 - math.abs((o.oAngleVelPitch - (o.oMoveAnglePitch / 64)) / 0x1000)
        gMarioStates[0].faceAngle.y = approach_s16_symmetric(gMarioStates[0].faceAngle.y, o.oFaceAngleYaw, 0xC00)
        gMarioStates[0].action = ACT_HANG_VINE
        gMarioStates[0].usedObj = o
        calcMarioVinePos(o)
        o.oAngleVelPitch = o.oAngleVelPitch - math.cos(gMarioStates[0].intendedYaw - o.oFaceAngleYaw) *
            gMarioStates[0].intendedMag * speedScale * 0.5
        o.oAngleVelPitch = o.oAngleVelPitch * 0.975
        if gMarioStates[0].controller.buttonPressed & A_BUTTON ~= 0 then
            o.oAction = 0
            gMarioStates[0].action = ACT_TRIPLE_JUMP
            play_sound(SOUND_MARIO_YAHOO_WAHA_YIPPEE + ((math.random(0, 4) * 0x10000)),
                gMarioStates[0].marioObj.header.gfx.cameraToObject)
            gMarioStates[0].vel.y = o.oAngleVelPitch * math.cos(o.oMoveAnglePitch - 0x4000) * 0.01581917687 * 2.5 + 25.0
            gMarioStates[0].forwardVel = o.oAngleVelPitch * math.sin(o.oMoveAnglePitch - 0x4000) * 0.01581917687 * 2.5 *
                1.2
        end

        if o.oOpacity == 0 then
            if math.abs(o.oAngleVelPitch) > 0x400 then
                o.oOpacity = o.oOpacity + 1
                cur_obj_play_sound_2(SOUND_GENERAL_SWISH_AIR)
            end
        elseif o.oOpacity == 1 then
            if math.abs(o.oAngleVelPitch) < 0x200 then
                o.oOpacity = 0
            end
        end
    end

    cur_obj_init_animation(o.oBehParams2ndByte)

    o.oArrowLiftUnk100 = o.oMoveAnglePitch
    o.oAngleVelPitch = o.oAngleVelPitch - o.oMoveAnglePitch / 64
    o.oAngleVelPitch = o.oAngleVelPitch * 0.99
    o.oMoveAnglePitch = o.oMoveAnglePitch + o.oAngleVelPitch
end

-- Function to handle the "hang vine" action

---@param m MarioState
function act_hang_vine(m)
    m.actionTimer = m.actionTimer + 1
    m.unkB0 = -100
    set_mario_animation(m, MARIO_ANIM_IDLE_ON_POLE)
    play_sound_if_no_flag(m, SOUND_ACTION_HANGING_STEP, MARIO_ACTION_SOUND_PLAYED)
    m.marioObj.header.gfx.pos = m.pos
    m.marioObj.header.gfx.angle.x = (m.usedObj.oArrowLiftUnk100 * 5) / 5
    m.marioObj.header.gfx.angle.y = m.faceAngle.y
    m.marioObj.header.gfx.angle.z = 0
    return 0
end

MODEL_WINDMILL2 = smlua_model_util_get_id("windmill2_geo")
COL_WINDMILL2 = smlua_collision_util_get("windmill2_collision")

function wingmillcode(o)
    if o.oTimer == 0 then
        cur_obj_scale(o.oBehParams2ndByte / 100)
    end
    o.collisionData = COL_WINDMILL2
    o.oFaceAnglePitch = o.oFaceAnglePitch + 0x100 - o.oBehParams2ndByte / 8
    load_object_collision_model()
end



hook_mario_action(ACT_HANG_VINE, {every_frame = act_hang_vine})

function syncobjs_init(o)
    network_init_object(o, true, nil)
end
