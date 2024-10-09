#include "src/game/envfx_snow.h"

const GeoLayout cloudchase[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_ALPHA, cloudchase_cloudchase_Plane_mesh_mesh_mesh_layer_4),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
