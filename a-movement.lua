-------------------------------------
--            Wall Slide           --
-- from: mods/extended-moveset.lua --
-------------------------------------
function act_wall_slide(m)
    if not ENABLE_ONLY_UP_MOVESET then return end

    if (m.input & INPUT_A_PRESSED) ~= 0 then
        m.vel.y = 52.0
        -- m.faceAngle.y = limit_angle(m.faceAngle.y + 0x8000)
        return set_mario_action(m, ACT_WALL_KICK_AIR, 0)
    end

    -- attempt to stick to the wall a bit. if it's 0, sometimes you'll get kicked off of slightly sloped walls
    mario_set_forward_vel(m, -1.0)

    m.particleFlags = m.particleFlags | PARTICLE_DUST

    play_sound(SOUND_MOVING_TERRAIN_SLIDE + m.terrainSoundAddend, m.marioObj.header.gfx.cameraToObject)
    set_mario_animation(m, MARIO_ANIM_START_WALLKICK)

    if perform_air_step(m, 0) == AIR_STEP_LANDED then
        mario_set_forward_vel(m, 0.0)
        if check_fall_damage_or_get_stuck(m, ACT_HARD_BACKWARD_GROUND_KB) == 0 then
            return set_mario_action(m, ACT_FREEFALL_LAND, 0)
        end
    end

    m.actionTimer = m.actionTimer + 1
    if m.wall == nil and m.actionTimer > 2 then
        mario_set_forward_vel(m, 0.0)
        return set_mario_action(m, ACT_FREEFALL, 0)
    end

    return 0
end

function act_wall_slide_gravity(m)
    if not ENABLE_ONLY_UP_MOVESET then return end

    m.vel.y = m.vel.y - 2

    if m.vel.y < -30 then
        m.vel.y = -30
    end
end

function act_kaze_air_hit_wall(m)
    if m.heldObj ~= 0 then
        mario_drop_held_object(m)
    end

    m.actionTimer = m.actionTimer + 1
    if m.actionTimer <= 1 and (m.input & INPUT_A_PRESSED) ~= 0 then
        m.vel.y = 52.0
        m.faceAngle.y = limit_angle(m.faceAngle.y + 0x8000)
        m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
        return set_mario_action(m, ACT_WALL_KICK_AIR, 0)
    else
        m.faceAngle.y = limit_angle(m.faceAngle.y + 0x8000)
        return set_mario_action(m, ACT_WALL_SLIDE, 0)
    end

    --! Missing return statement (in original C code). The returned value is the result of the call
    -- to set_mario_animation. In practice, this value is nonzero.
    -- This results in this action "cancelling" into itself. It is supposed to
    -- execute three times, each on a separate frame, but instead it executes
    -- three times on the same frame.
    -- This results in firsties only being possible for a single frame, instead
    -- of three.
    return set_mario_animation(m, MARIO_ANIM_START_WALLKICK)
end

function act_kaze_dive_slide(m)
    if (m.input & INPUT_ABOVE_SLIDE) == 0 and ((m.input & INPUT_A_PRESSED) ~= 0 or (m.input & INPUT_B_PRESSED) ~= 0) then
        queue_rumble_data_mario(m, 5, 80)
		if m.actionTimer <= 0 then
			m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
		end
        if m.forwardVel > 0 then
            return set_mario_action(m, ACT_FORWARD_ROLLOUT, 0)
        else
            return set_mario_action(m, ACT_BACKWARD_ROLLOUT, 0)
        end
    end

    play_mario_landing_sound_once(m, SOUND_ACTION_TERRAIN_BODY_HIT_GROUND)

    --! If the dive slide ends on the same frame that we pick up on object,
    -- Mario will not be in the dive slide action for the call to
    -- mario_check_object_grab, and so will end up in the regular picking action,
    -- rather than the picking up after dive action.

    if update_sliding(m, 8.0) ~= 0 and is_anim_at_end(m) ~= 0 then
        mario_set_forward_vel(m, 0.0)
        set_mario_action(m, ACT_STOMACH_SLIDE_STOP, 0)
    end

    if mario_check_object_grab(m) ~= 0 then
        mario_grab_used_object(m)
        if m.heldObj ~= 0 then
            m.marioBodyState.grabPos = GRAB_POS_LIGHT_OBJ
        end
        return true
    end

    common_slide_action(m, ACT_STOMACH_SLIDE_STOP, ACT_FREEFALL, MARIO_ANIM_DIVE)
	m.actionTimer = m.actionTimer + 1
    return false
end