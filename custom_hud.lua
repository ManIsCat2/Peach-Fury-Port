STAR01 = ("WHERE THE RED BIRDS ROOST")
STAR02 = ("RED BIRD CANYON")
STAR03 = ("GOOMBA ISLE")
STAR04 = ("8 BIT UNDERGROUND")
STAR05 = ("PIRATE TREASSURE HUNT")
STAR06 = ("GLOWING ROCK")
STAR07 = ("100 COINS")
STAR08 = ("THE CANYON HOLE")
STAR09 = ("PEACHS CASTLE FLAG")
STAR10 = ("GHOST LOOKOUT")
STAR11 = ("VOLCANO")
STAR12 = ("PYRAMID PILLARS")
STAR13 = ("BIRDHOUSE")
STAR14 = ("SAND CASTLE")
STAR15 = ("CHUCKYA ISLE")
STAR16 = ("LONELY ISLAND")
STAR17 = ("CLOUD CLIMB")
STAR18 = ("HEXAGON PUZZLE")
STAR19 = ("BOWSERS AIRCRAFT")
STAR20 = ("PLAYGROUND SILVERS")
STAR21 = ("MARIO GO ROUND")
STAR22 = ("8 BIT CLOUDS")
STAR23 = ("GLOWING ISLAND")
STAR24 = ("WINDMILL HEIGHTS")
STAR25 = ("CRAWLSPOT")
STAR26 = ("NO MORE STARS!")

starTexts = {
    [0] = { STAR01 },
    { STAR02 },
    { STAR03 },
    { STAR04 },
    { STAR05 },
    { STAR06 },
    { STAR07 },
    { STAR08 },
    { STAR09 },
    { STAR10 },
    { STAR11 },
    { STAR12 },
    { STAR13 },
    { STAR14 },
    { STAR15 },
    { STAR16 },
    { STAR17 },
    { STAR18 },
    { STAR19 },
    { STAR20 },
    { STAR21 },
    { STAR22 },
    { STAR23 },
    { STAR24 },
    { STAR25 },
    { STAR26 }
};

gStarNameAlpha = 0
gStarName = ""
gDecAlphaStar = false
gIncAlphaStar = false

function render_stars_and_coin()
    local m = gMarioStates[0]
    local starIcon = charSelect and charSelect.character_get_star_icon(0) or gTextures.star
    djui_hud_render_texture(starIcon == nil and gTextures.star or starIcon, 8, 4, charSelect and 16 / starIcon.width or 1,
        charSelect and 16 / starIcon.height or 1)
    djui_hud_print_text("@", 24, 4, 1)
    djui_hud_print_text(tostring(save_file_get_total_star_count(get_current_save_file_num() - 1, 0, COURSE_MAX - 1)), 40,
        4, 1)

    djui_hud_render_texture(gTextures.coin, djui_hud_get_screen_width() - 62, 4, 1, 1)
    if m.numCoins < 100 then
        djui_hud_print_text("@", djui_hud_get_screen_width() - 46, 4, 1)
    end
    djui_hud_print_text(tostring(m.numCoins), djui_hud_get_screen_width() - (32 + (m.numCoins < 100 and 0 or 14)), 4, 1)
end

function render_star_name()
    if (gStarNameAlpha > 0 and gDecAlphaStar) then
        gStarNameAlpha = gStarNameAlpha - 3
    end

    if (gStarNameAlpha < 255 and gIncAlphaStar) then
        gStarNameAlpha = gStarNameAlpha + 3
    end

    if gStarNameAlpha == 0 then gDecAlphaStar = false end

    djui_hud_set_font(FONT_NORMAL)
    djui_hud_set_color(255, 255, 255, gStarNameAlpha)
    local starscale = 1
    --thankyou Squishy6094
    djui_hud_print_text(gStarName, djui_hud_get_screen_width() * 0.5 - djui_hud_measure_text(gStarName) * starscale * 0.5,
        djui_hud_get_screen_height() / 2 + 30, starscale)
end

function on_behind_hud()
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_HUD)
    djui_hud_set_color(255, 255, 255, 255)
    -- Hide Hud
    hud_set_value(HUD_DISPLAY_FLAGS, hud_get_value(HUD_DISPLAY_FLAGS) & ~HUD_DISPLAY_FLAG_LIVES)
    hud_set_value(HUD_DISPLAY_FLAGS, hud_get_value(HUD_DISPLAY_FLAGS) & ~HUD_DISPLAY_FLAG_STAR_COUNT)
    hud_set_value(HUD_DISPLAY_FLAGS, hud_get_value(HUD_DISPLAY_FLAGS) & ~HUD_DISPLAY_FLAG_COIN_COUNT)
    hud_set_value(HUD_DISPLAY_FLAGS, hud_get_value(HUD_DISPLAY_FLAGS) & ~HUD_DISPLAY_FLAG_CAMERA)
    if charSelect then
        charSelect.hud_hide_element(HUD_DISPLAY_FLAG_LIVES)
        charSelect.hud_hide_element(HUD_DISPLAY_FLAG_STAR_COUNT)
        charSelect.hud_hide_element(HUD_DISPLAY_FLAG_CAMERA)
        charSelect.hud_hide_element(HUD_DISPLAY_FLAG_COIN_COUNT)
    end
    if _G.OmmEnabled and _G.OmmApi.omm_get_setting(gMarioStates[0], "hud") == 0 or not _G.OmmEnabled then
        render_stars_and_coin()
    end

    if not _G.OmmEnabled then
        render_star_name()
    end
end

hook_event(HOOK_ON_HUD_RENDER_BEHIND, on_behind_hud)
