function on_mario_update(m)
    if m.action == ACT_GROUND_POUND_LAND and m.input & INPUT_A_PRESSED ~= 0 then
        set_mario_action(m, ACT_TRIPLE_JUMP, 0)
        m.vel.y = 70
    end
        m.hurtCounter = 0
        m.health = 0x880
    if m.action == ACT_GROUND_POUND and m.input & INPUT_B_PRESSED ~= 0 then
        m.forwardVel = 48.0
        m.vel.y = 24.0
        m.faceAngle.y = m.intendedYaw
        set_mario_action(m, ACT_DIVE, 0)
    end
end

hook_event(HOOK_MARIO_UPDATE, on_mario_update)