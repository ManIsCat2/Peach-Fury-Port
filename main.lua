-- name: \\#FFC0CB\\Peach's Fury
-- description: Romhack Port.\n\Made by PerfectMario64 and I'mYourCat\n\n\Actual Romhack by Kaze and LegendOfZeina
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
audio_stream_set_looping(audio_0A, true)
audio_stream_play(audio_0A, true, 1)

------------------
-- bhv override --
------------------

function breakable_box_init(o)
    obj_scale_xyz(o,2,2,2)
    o.oCollisionDistance = 1000
end

hook_behavior(id_bhvBreakableBox, OBJ_LIST_SURFACE, false, breakable_box_init, nil)

