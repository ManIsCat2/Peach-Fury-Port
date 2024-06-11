-- name: Peach's Fury
-- incompatible: romhack

-- description: \\#ff0000\\WARNING:\nTHE FOLLOWING MOD SHOULD NOT BE HOSTED PUBLICLY AS IT'S ONLY FOR TESTING!!\nIF YOU SEE THIS MESSAGE IN A PUBLIC SERVER, PLEASE REPORT IT TO A MODERATOR IN THE SM64EXCOOP SERVER!\n\n \\#f7f7f7\\Peach's Fury is a romhack made by \n Kaze \n & \n thelegendofzenia \n and ported by ThePerfectMario64 \n this hach was possible \n cause Kaze was nice enough \n to open-source Peach's Fury, And the models.
-- incompatible: romhack

------------------
-- level values --
------------------

gLevelValues.entryLevel = LEVEL_HMC
gLevelValues.exitCastleLevel = LEVEL_HMC
gLevelValues.disableActs = true

-------------------
-- server values --
-------------------

gServerSettings.stayInLevelAfterStar = 2

-----------------
-- "sequences" --
-----------------

audio_0A = audio_stream_load("0A_domeL.mp3")
audio_stream_set_looping(audio_0A, true)
audio_stream_play(audio_0A, true, 1)

