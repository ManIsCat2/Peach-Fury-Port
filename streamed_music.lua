---custom music system by imyourcat/maniscat2

audio_02 = audio_stream_load("02_stardanceleft.mp3")
audio_0A = audio_stream_load("0A_domeL.mp3")
audio_0B = audio_stream_load("0B_realBrushWoods.mp3")
audio_0C = audio_stream_load("0C_YoshiVillage.mp3")
audio_0D = audio_stream_load("0D_dinodinoL.mp3")

def_audio_vol = 0.43

gPlayingStreamed = nil

---@param audio ModAudio
local function play_seq_streamed(audio)
    audio_stream_set_looping(audio, true)
    audio_stream_play(audio, true, def_audio_vol)
    gPlayingStreamed = audio
end

local audios = {
    -- { course = COURSE_NONE, audio = audio_0A, area = 1 },
    --{ course = COURSE_NONE, audio = audio_0D, area = 1 },
    { course = COURSE_HMC, audio = audio_0B, area = 2 },
    { course = COURSE_HMC, audio = audio_0C, area = 3 },
}

function audio_stop_all()
    for i = 1, #audios do
        audio_stream_stop(audios[i].audio)
    end
end

function streamed_init()
    if not obj_get_first_with_behavior_id(id_bhvActSelector) then
        ---@type NetworkPlayer
        local np = gNetworkPlayers[0]
        audio_stop_all()

        for i = 1, #audios do
            if np.currAreaIndex == audios[i].area and np.currCourseNum == audios[i].course then
                play_seq_streamed(audios[i].audio)
            end
        end
    end
end

function streamed_loop()
    for i = 1, #audios do
        if audios[i].audio ~= nil then
            if is_game_paused() then
                audio_stream_set_volume(audios[i].audio, 0.1)
            else
                audio_stream_set_volume(audios[i].audio, def_audio_vol)
            end
        end
    end
end

function audio_fadeout_start_fadeinmusic(timer, timer2, audioDie, audioAlive)
    timer = approach_f32_symmetric(timer, 0, 0.1)
    audio_stream_set_volume(audioDie, timer)
    --djui_chat_message_create("timer".. timer)

    timer2 = approach_f32_symmetric(timer2, def_audio_vol, 0.1)
    audio_stream_set_volume(audioAlive, timer2)
    -- djui_chat_message_create("timer2".. timer2)
end

audio_stream_set_looping(audio_0D, true)
audio_stream_play(audio_0D, true, def_audio_vol)
audio_stream_set_looping(audio_0A, true)
audio_stream_play(audio_0A, true, def_audio_vol)


local sNORMALHUBVol = def_audio_vol
local sNORMALHUBSKYVol = 0
local FADESPEED = 0.02
local PAUSEDSO = 0.1
function streamed_mario_update(m)
    if m.playerIndex == 0 then
        audio_stream_set_volume(audio_0A, sNORMALHUBVol)
        audio_stream_set_volume(audio_0D, sNORMALHUBSKYVol)
        if gNetworkPlayers[0].currAreaIndex == 1 then
            if m.pos.y >= -2759 then
                --audio_stream_set_position(audio_0A, 0)
                sNORMALHUBVol = approach_f32_symmetric(sNORMALHUBVol, 0, FADESPEED)
                if not is_game_paused() then
                    sNORMALHUBSKYVol = approach_f32_symmetric(sNORMALHUBSKYVol, def_audio_vol, FADESPEED)
                else
                    sNORMALHUBSKYVol = approach_f32_symmetric(sNORMALHUBSKYVol, PAUSEDSO, FADESPEED)
                end
            else
                --audio_stream_set_position(audio_0D, 0)
                if not is_game_paused() then
                    sNORMALHUBVol = approach_f32_symmetric(sNORMALHUBVol, def_audio_vol, FADESPEED)
                else
                    sNORMALHUBVol = approach_f32_symmetric(sNORMALHUBVol, PAUSEDSO, FADESPEED)
                end
                sNORMALHUBSKYVol = approach_f32_symmetric(sNORMALHUBSKYVol, 0, FADESPEED)
            end
        else
            sNORMALHUBVol = 0
            sNORMALHUBSKYVol = 0
        end
    end
end

hook_event(HOOK_UPDATE, streamed_loop)
hook_event(HOOK_MARIO_UPDATE, streamed_mario_update)
hook_event(HOOK_ON_SYNC_VALID, streamed_init)
