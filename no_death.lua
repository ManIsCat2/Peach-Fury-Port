prevSafePos = { x = 0, y = 0, z = 0, obj = nil, valid = false }

-- from base code
function bubbled_offset_visual(m)
    if not m then return end
    -- scary 3d trig ahead

    local forwardOffset = 25;
    local upOffset = -35;

    -- figure out forward vector
    local forward = {
        x = sins(m.faceAngle.y) * coss(m.faceAngle.x),
        y = -sins(m.faceAngle.x),
        z = coss(m.faceAngle.y) * coss(m.faceAngle.x),
    };
    vec3f_normalize(forward);

    -- figure out right vector
    local globalUp = { x = 0, y = 1, z = 0 };
    local right = { x = 0, y = 0, z = 0 };
    vec3f_cross(right, forward, globalUp);
    vec3f_normalize(right);

    -- figure out up vector
    local up = { x = 0, y = 0, z = 0 };
    vec3f_cross(up, right, forward);
    vec3f_normalize(up);

    -- offset forward direction
    vec3f_mul(forward, forwardOffset);
    vec3f_add(m.marioObj.header.gfx.pos, forward);

    -- offset up direction
    vec3f_mul(up, upOffset);
    vec3f_add(m.marioObj.header.gfx.pos, up);

    -- offset global up direction
    m.marioObj.header.gfx.pos.y = m.marioObj.header.gfx.pos.y - upOffset;
end

-- custom bubble action, with some code from the base game bubble action
ACT_MH_BUBBLE_RETURN = allocate_mario_action(ACT_GROUP_CUTSCENE | ACT_FLAG_PAUSE_EXIT)
---@param m MarioState
function act_bubble_return(m)
    -- create bubble
    if (not m.bubbleObj and m.playerIndex == 0) then
        m.bubbleObj = spawn_non_sync_object(id_bhvStaticObject, E_MODEL_BUBBLE_PLAYER, m.pos.x, m.pos.y + 50, m.pos.z,
            nil)
        if m.bubbleObj then
            m.bubbleObj.heldByPlayerIndex = m.playerIndex
            obj_scale(m.bubbleObj, 1.5)
        end
    end

    -- force inactive state
    if m.heldObj then mario_drop_held_object(m) end
    m.heldByObj = nil
    m.marioObj.oIntangibleTimer = -1
    m.squishTimer = 0
    m.bounceSquishTimer = 0
    m.quicksandDepth = 0
    set_mario_animation(m, MARIO_ANIM_BEING_GRABBED)

    m.actionTimer = m.actionTimer + 1
    m.faceAngle.x = 0
    if m.actionTimer < 15 or (m.playerIndex ~= 0 and m.actionTimer >= 45) then
        vec3f_copy(m.marioObj.header.gfx.pos, m.pos)
        vec3s_copy(m.marioObj.header.gfx.angle, m.faceAngle)
        return
    elseif m.playerIndex ~= 0 then
        m.pos.x = m.pos.x + m.vel.x
        m.pos.y = m.pos.y + m.vel.y
        m.pos.z = m.pos.z + m.vel.z
        vec3f_copy(m.marioObj.header.gfx.pos, m.pos)
        vec3s_copy(m.marioObj.header.gfx.angle, m.faceAngle)
        return
    end

    local goToPos = { x = 0, y = 0, z = 0 }
    if prevSafePos.obj and (prevSafePos.obj.oVelX ~= 0 or prevSafePos.obj.oVelY ~= 0 or prevSafePos.obj.oVelZ ~= 0) then
        prevSafePos.x = prevSafePos.obj.oPosX
        prevSafePos.y = prevSafePos.obj.oPosY
        prevSafePos.z = prevSafePos.obj.oPosZ
    end
    vec3f_copy(goToPos, prevSafePos)
    goToPos.y = goToPos.y + 200
    if m.actionTimer < 45 then
        m.vel.x = (goToPos.x - m.pos.x) // 10
        m.vel.y = (goToPos.y - m.pos.y) // 10
        m.vel.z = (goToPos.z - m.pos.z) // 10
        m.pos.x = m.pos.x + m.vel.x
        m.pos.y = m.pos.y + m.vel.y
        m.pos.z = m.pos.z + m.vel.z
        vec3f_copy(gLakituState.goalPos, m.pos)
    else
        m.faceAngle.x = 0
        vec3f_copy(m.pos, goToPos)
        if m.actionTimer == 45 then
            vec3f_copy(gLakituState.goalPos, goToPos)
        end
    end
    vec3f_copy(m.marioObj.header.gfx.pos, m.pos)
    vec3s_copy(m.marioObj.header.gfx.angle, m.faceAngle)
    bubbled_offset_visual(m)
    if m.bubbleObj then
        m.bubbleObj.oPosX = m.pos.x
        m.bubbleObj.oPosY = m.pos.y + 50
        m.bubbleObj.oPosZ = m.pos.z
    end

    if m.actionTimer > 60 then
        vec3f_copy(m.pos, goToPos)
        m.forwardVel, m.vel.x, m.vel.y, m.vel.z = 0, 0, -60, 0
        common_air_action_step(m, ACT_FREEFALL_LAND, MARIO_ANIM_GENERAL_FALL, 0) -- done to update floor
        if m.input & INPUT_NONZERO_ANALOG ~= 0 then
            m.forwardVel = 5
            m.faceAngle.y = m.intendedYaw
        else
            m.forwardVel = 0
        end

        obj_mark_for_deletion(m.bubbleObj)
        m.bubbleObj = nil

        m.particleFlags = m.particleFlags | PARTICLE_MIST_CIRCLE
        play_sound(SOUND_OBJ_DIVING_IN_WATER, m.pos)
        m.invincTimer = 70
        m.marioObj.oIntangibleTimer = 0

        if m.waterLevel > m.pos.y then
            set_mario_action(m, ACT_WATER_IDLE, 0)
        elseif (m.floor.type == SURFACE_DEATH_PLANE or m.floor.type == SURFACE_BURNING or m.floor.type == SURFACE_INSTANT_QUICKSAND or m.floor.type == SURFACE_VERTICAL_WIND or m.floor.type == SURFACE_INSTANT_MOVING_QUICKSAND) then
            set_mario_action(m, ACT_TRIPLE_JUMP, 0)
        else
            set_mario_action(m, ACT_SOFT_BONK, 0)
        end
    end
end

function on_death()
    local m = gMarioStates[0]
    m.hurtCounter = m.hurtCounter + 8
    soft_reset_camera(m.area.camera)
    set_mario_action(m, ACT_MH_BUBBLE_RETURN, 0)
    fade_volume_scale(0, 127, 15)
    m.numLives = 100
end

--hook_event(HOOK_ON_DEATH, on_death)
--hook_mario_action(ACT_MH_BUBBLE_RETURN, act_bubble_return)
