-- name: \\#FFC0CB\\Peach's Fury
-- description: Romhack Port.\n\Made by PerfectMario64 and I'mYourCat.\n\Thanks to Blocky for MS Stars.\n\n\Actual Romhack by Kaze and legendofzeina.
-- incompatible: romhack

------------------
-- level values --
------------------

gLevelValues.entryLevel = LEVEL_HMC
gLevelValues.exitCastleLevel = LEVEL_HMC
gLevelValues.disableActs = true
gLevelValues.fixCollisionBugs = true
gLevelValues.fixCollisionBugsPickBestWall = true

-------------------
-- server values --
-------------------

gServerSettings.stayInLevelAfterStar = 1

-----------------
-- "sequences" --
-----------------

audio_0A = audio_stream_load("0A_domeL.mp3")
--audio_02 = audio_stream_load("02_stardanceleft.mp3")
--audio_1C = audio_sample_load("1C.mp3")
audio_stream_set_looping(audio_0A, true)
audio_stream_play(audio_0A, true, 1)

------------------
-- bhv override --
------------------

function breakable_box_init(o)
    obj_scale_xyz(o, 2, 2, 2)
    o.oCollisionDistance = 1000
end

hook_behavior(id_bhvBreakableBox, OBJ_LIST_SURFACE, false, breakable_box_init, nil)

--------------------
-- general things --
--------------------

local function for_each_object_with_behavior(behavior, func) --* function by Isaac
    local o = obj_get_first_with_behavior_id(behavior)
    if o == nil then return end
    while o ~= nil do
        func(o)
        o = obj_get_next_with_same_behavior_id(o)
    end
end

MODEL_SILVER_STAR = smlua_model_util_get_id("silverstara_geo")
MODEL_8BIT_PIPE = smlua_model_util_get_id("bitpipe_geo")
COL_8BIT_PIPE = smlua_collision_util_get("bitpipe_collision")
MODEL_8BIT_GOOMBA = smlua_model_util_get_id("goomba_blue_geo")

played = false

function update()
    hud_hide()

    for_each_object_with_behavior(id_bhvHiddenStarTrigger, function(o) o.oFaceAngleYaw = o.oFaceAngleYaw + 0x600 end)
    for_each_object_with_behavior(id_bhvWarpPipe,
        function(o)
            if obj_has_model_extended(o, MODEL_8BIT_PIPE) ~= 0 then
                o.collisionData = COL_8BIT_PIPE
            end
        end)
end

hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_UPDATE, update)
