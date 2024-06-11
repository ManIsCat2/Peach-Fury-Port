local towerPos = { 1361.0, 861.0, 1111.0, 361.0, 611.0, -139.0, 111.0 }

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
