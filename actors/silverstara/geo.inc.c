#include "src/game/envfx_snow.h"

const GeoLayout silverstara_geo[] = {
	GEO_SHADOW(0, 180, 50),
	GEO_OPEN_NODE(),
		GEO_ASM(0, geo_rotate_coin),
		GEO_ROTATION_NODE(0, 0, 0, 0),
		GEO_OPEN_NODE(),
			    GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 0, 0, silverstara_Cube_mesh),
				GEO_BILLBOARD_WITH_PARAMS_AND_DL(LAYER_TRANSPARENT, 0, 0, 0, silverstara_Cube_001_mesh),
				GEO_DISPLAY_LIST(LAYER_OPAQUE, silverstara_material_revert_render_settings),
				GEO_DISPLAY_LIST(LAYER_TRANSPARENT, silverstara_material_revert_render_settings),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
	GEO_END(),
};
