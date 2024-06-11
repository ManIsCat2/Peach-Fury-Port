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
audio_02 = audio_stream_load("02_stardanceleft.mp3")
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

played = false

function mario_update(m)
    hud_hide()
    if m.action == ACT_STAR_DANCE_NO_EXIT and not played then
        play_music(SEQ_PLAYER_ENV, 0, 0);
        audio_stream_set_looping(audio_02, false)
        audio_stream_play(audio_02, false, 1)
        played = true
    end

    if m.action ~= ACT_STAR_DANCE_NO_EXIT then
        played = false
    end
end

hook_event(HOOK_MARIO_UPDATE, mario_update)
