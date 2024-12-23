local coinx = 322 + 60 + 15

function render_stars_and_coin()
    local m = gMarioStates[0]
    djui_hud_render_texture(gTextures.star, 8, 4, 1, 1)
    djui_hud_print_text("@", 24, 4, 1)
    djui_hud_print_text(tostring(gMarioStates[0].numStars), 40, 4, 1)

    djui_hud_render_texture(gTextures.coin, djui_hud_get_screen_width() - 62, 4, 1, 1)
    if m.numCoins < 100 then
        djui_hud_print_text("@", djui_hud_get_screen_width() - 46, 4, 1)
    end
    djui_hud_print_text(tostring(m.numCoins), djui_hud_get_screen_width() - (32 + (m.numCoins < 100 and 0 or 14)), 4, 1)
end

function on_behind_hud()
    hud_hide()
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_HUD)
    render_stars_and_coin()
end

hook_event(HOOK_ON_HUD_RENDER_BEHIND, on_behind_hud)
