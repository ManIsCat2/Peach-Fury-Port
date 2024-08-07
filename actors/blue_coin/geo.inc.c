// 0x16000200
const GeoLayout blue_coin_geo[] = {
   GEO_SHADOW(SHADOW_CIRCLE_4_VERTS, 0xB4, 80),
   GEO_OPEN_NODE(),
      GEO_SWITCH_CASE(16, geo_switch_anim_state),
      GEO_OPEN_NODE(),
         GEO_DISPLAY_LIST(LAYER_ALPHA, blue0),
         GEO_DISPLAY_LIST(LAYER_ALPHA, blue1),
         GEO_DISPLAY_LIST(LAYER_ALPHA, blue2),
         GEO_DISPLAY_LIST(LAYER_ALPHA, blue3),
         GEO_DISPLAY_LIST(LAYER_ALPHA, blue4),
         GEO_DISPLAY_LIST(LAYER_ALPHA, blue5),
         GEO_DISPLAY_LIST(LAYER_ALPHA, blue6),
         GEO_DISPLAY_LIST(LAYER_ALPHA, blue7),
         GEO_DISPLAY_LIST(LAYER_ALPHA, blue8),
         GEO_DISPLAY_LIST(LAYER_ALPHA, blue9),
         GEO_DISPLAY_LIST(LAYER_ALPHA, blue10),
         GEO_DISPLAY_LIST(LAYER_ALPHA, blue11),
         GEO_DISPLAY_LIST(LAYER_ALPHA, blue12),
         GEO_DISPLAY_LIST(LAYER_ALPHA, blue13),
         GEO_DISPLAY_LIST(LAYER_ALPHA, blue14),
         GEO_DISPLAY_LIST(LAYER_ALPHA, blue15),
      GEO_CLOSE_NODE(),
   GEO_CLOSE_NODE(),
   GEO_END(),
};
