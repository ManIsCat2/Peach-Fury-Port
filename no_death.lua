local ACT_DYING_QUICKSAND = allocate_mario_action(ACT_FLAG_IDLE)

---@param m MarioState
function act_dying_quicksand(m)
    m.marioObj.header.gfx.pos.y = m.pos.y - m.actionTimer
    m.actionTimer = m.actionTimer + 4
end

function save_pos_update(m)
    local e = gMarioStateExtras[m.playerIndex]
    m.peakHeight = m.pos.y
    --if m.playerIndex ~= 0 then return end

    if m.floor then
        if m.floor.type ~= SURFACE_DEEP_QUICKSAND and m.floor.type ~= SURFACE_SLIPPERY then
            if m.action == ACT_IDLE or m.action == ACT_WALKING then
                vec3f_copy(e.saved_pos, m.pos)
            end
        end
    end
    if m.floor and m.floor.type == SURFACE_DEEP_QUICKSAND and m.pos.y == m.floorHeight then
        m.action = ACT_DYING_QUICKSAND
        e.saved_transition_timer = e.saved_transition_timer + 1
        if e.saved_transition_timer > 20 then
            if m.playerIndex == 0 then
                play_transition(WARP_TRANSITION_FADE_FROM_MARIO, 30, 0, 0, 0)
            end
            m.vel.y = 0
            mario_set_forward_vel(m, 0)
            m.pos.x = e.saved_pos.x
            m.pos.y = e.saved_pos.y + 300
            m.pos.z = e.saved_pos.z
            m.action = ACT_FREEFALL
            e.saved_transition_timer = 0
        end
    end
end

hook_event(HOOK_MARIO_UPDATE, save_pos_update)
hook_mario_action(ACT_DYING_QUICKSAND, { every_frame = act_dying_quicksand })
