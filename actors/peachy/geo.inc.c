#include "src/game/envfx_snow.h"

const GeoLayout peachy_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 0, 0, peachy_Bone_mesh_layer_1),
		GEO_OPEN_NODE(),
			GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 100, 0, peachy_Bone_001_mesh_layer_1),
			GEO_OPEN_NODE(),
				GEO_DISPLAY_LIST(LAYER_OPAQUE, peachy_Bone_002_skinned_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 0, 33, 0, peachy_Bone_002_mesh_layer_1),
				GEO_ANIMATED_PART(LAYER_OPAQUE, 16, 24, 0, peachy_Bone_004_l_mesh_layer_1),
				GEO_OPEN_NODE(),
					GEO_DISPLAY_LIST(LAYER_OPAQUE, peachy_Bone_006_l_skinned_mesh_layer_1),
					GEO_ANIMATED_PART(LAYER_OPAQUE, 30, 0, 0, peachy_Bone_006_l_mesh_layer_1),
				GEO_CLOSE_NODE(),
				GEO_ANIMATED_PART(LAYER_OPAQUE, -16, 24, 0, peachy_Bone_004_r_mesh_layer_1),
				GEO_OPEN_NODE(),
					GEO_DISPLAY_LIST(LAYER_OPAQUE, peachy_Bone_006_r_skinned_mesh_layer_1),
					GEO_ANIMATED_PART(LAYER_OPAQUE, -30, 0, 0, peachy_Bone_006_r_mesh_layer_1),
				GEO_CLOSE_NODE(),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, peachy_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};