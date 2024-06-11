local towerPos = {1361.0, 861.0, 1111.0, 361.0, 611.0, -139.0, 111.0}

function goombastar(o)
    if ((o.oBehParams & 0xFF) == 7) then
        if (gMarioStates[0].pos.y == gMarioStates[0].floorHeight) then
            if (gMarioStates[0].floor.type == 0xE0) then
                if (math.abs(gMarioStates[0].floorHeight - towerPos[o.oOpacity + 1]) < 50.0) then
                    o.oOpacity = o.oOpacity + 1
                    if (o.oOpacity == 7) then
                        obj_mark_for_deletion(o)
                        spawn_default_star(gMarioStates[0].pos.x, gMarioStates[0].pos.y + 200.0, gMarioStates[0].pos.z)
                    end
                elseif (math.abs(gMarioStates[0].pos.y - towerPos[o.oOpacity]) > 50.0) then
                    o.oOpacity = 0
                end
            else
                if (not gMarioStates[0].floor.object) then
                    o.oOpacity = 0
                end
            end
        end
    else
        if (not o.oBehParams2ndByte) then
            if (not obj_get_nearest_object_with_behavior_id(o, id_bhvGoomba) and not obj_get_nearest_object_with_behavior_id(o, id_bhvGoombaTripletSpawner)) then
                obj_mark_for_deletion(o)
                spawn_default_star(gMarioStates[0].pos.x, gMarioStates[0].pos.y + 200.0, gMarioStates[0].pos.z)
            end
        else
            if (not obj_get_nearest_object_with_behavior_id(o, id_bhvChuckya)) then
                obj_mark_for_deletion(o)
                spawn_default_star(gMarioStates[0].pos.x, gMarioStates[0].pos.y + 200.0, gMarioStates[0].pos.z)
            end
        end
    end
end

