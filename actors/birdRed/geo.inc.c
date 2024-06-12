#include "src/game/envfx_snow.h"

const GeoLayout birds2_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 0, 0, birdRed_Bone_mesh_layer_1),
		GEO_OPEN_NODE(),
			GEO_ANIMATED_PART(LAYER_OPAQUE, 10, 22, 9, birdRed_bird_l_mesh_layer_1),
			GEO_ANIMATED_PART(LAYER_OPAQUE, -10, 22, 9, birdRed_bird_r_mesh_layer_1),
		GEO_CLOSE_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, birdRed_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};

