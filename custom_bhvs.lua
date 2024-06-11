local towerPos = {1361.0, 861.0, 1111.0, 361.0, 611.0, -139.0, 111.0}

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


