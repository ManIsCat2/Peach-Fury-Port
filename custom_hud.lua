local coinx = 322+60 + 15

function render_stars_and_coin()
    djui_hud_render_texture(gTextures.star, 8, 4, 1, 1)
    djui_hud_print_text("@", 24, 4, 1)
    djui_hud_print_text(tostring(gMarioStates[0].numStars), 40, 4, 1)

    djui_hud_render_texture(gTextures.coin, (68 * 4.5) + 60, 4, 1, 1)
    if gMarioStates[0].numCoins < 100 then
        djui_hud_print_text("@", 322 + 60, 4, 1)
    else
        coinx = 322+60
    end
    djui_hud_print_text(tostring(gMarioStates[0].numCoins), coinx, 4, 1)
end

function on_behind_hud()
    hud_hide()
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_HUD)
    render_stars_and_coin()
end

hook_event(HOOK_ON_HUD_RENDER_BEHIND, on_behind_hud)
