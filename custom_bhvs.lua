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


