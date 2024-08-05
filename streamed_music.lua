audio_02 = audio_stream_load("02_stardanceleft.mp3") 
audio_0A = audio_stream_load("0A_domeL.mp3")
audio_0B = audio_stream_load("0B_realBrushWoods.mp3")
audio_0C = audio_stream_load("0C_YoshiVillage.mp3")

---@param audio ModAudio
local function play_seq_streamed(audio)
    audio_stream_set_looping(audio, true)
    audio_stream_play(audio, true, 1)
end

local audios = {
    { course = COURSE_HMC, audio = audio_0A, area = 1 },
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
                audio_stream_set_volume(audios[i].audio, 0.3)
            else
                audio_stream_set_volume(audios[i].audio, 1)
            end
        end
    end
end

hook_event(HOOK_UPDATE, streamed_loop)
hook_event(HOOK_ON_SYNC_VALID, streamed_init)
