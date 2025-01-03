#include <ultra64.h>
#include "sm64.h"
#include "behavior_data.h"
#include "model_ids.h"
#include "seq_ids.h"
#include "dialog_ids.h"
#include "segment_symbols.h"
#include "level_commands.h"

#include "game/level_update.h"

#include "levels/scripts.h"


/* Fast64 begin persistent block [includes] */
/* Fast64 end persistent block [includes] */

#include "make_const_nonconst.h"
#include "levels/hmc/header.h"

/* Fast64 begin persistent block [scripts] */
/* Fast64 end persistent block [scripts] */

const LevelScript level_hmc_entry[] = {
	INIT_LEVEL(),
	LOAD_MIO0(0x7, _hmc_segment_7SegmentRomStart, _hmc_segment_7SegmentRomEnd), 
	LOAD_MIO0(0xa, _water_skybox_mio0SegmentRomStart, _water_skybox_mio0SegmentRomEnd), 
	ALLOC_LEVEL_POOL(),
	MARIO(MODEL_MARIO, 0x00000001, bhvMario),
	JUMP_LINK(script_func_global_1),
	LOAD_MODEL_FROM_GEO(0x16, warp_pipe_geo),
	LOAD_MODEL_FROM_GEO(0xC0, goomba_geo),
	LOAD_MODEL_FROM_GEO(0xF6, bitpipe_geo),
	LOAD_MODEL_FROM_GEO(0x35, goomflagg_geo), 
	LOAD_MODEL_FROM_GEO(0x36, peachflag_geo), 
	LOAD_MODEL_FROM_GEO(0x41, chuckflag_geo), 
	LOAD_MODEL_FROM_GEO(0x47, bowserflag_geo), 

	/* Fast64 begin persistent block [level commands] */
	/* Fast64 end persistent block [level commands] */

	AREA(1, hmc_area_1),
		WARP_NODE(0x0A, LEVEL_BOB, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x0E, LEVEL_HMC, 0x02, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x10, LEVEL_HMC, 0x03, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x08, LEVEL_PSS, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, LEVEL_HMC, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		OBJECT(0x35, 6825, -6101, -4727, 0, -180, 0, 0x00000000, bhvCheckpointFlag),
		OBJECT(0, 6825, -6658, -4718, 0, -180, 0, (65 << 16), bhvPoleGrabbing),
		OBJECT(0xC0, 6948, -6658, -4503, 0, -180, 0, (1 << 16), bhvGoomba),
		OBJECT(0, 6938, -6658, -4698, 0, -180, 0, (0 << 16), bhvGoombaTripletSpawner),
		OBJECT(0, 6825, -6787, -4727, 0, -180, 0, (2 << 24), bhvGoombaStar),
		OBJECT(MODEL_BREAKABLE_BOX, 1408, -6758, -2020, 0, -180, 0, 0x00000000, bhvBreakableBox),
		OBJECT(MODEL_BREAKABLE_BOX, 1408, -6758, -2420, 0, -180, 0, 0x00000000, bhvBreakableBox),
		OBJECT(MODEL_BREAKABLE_BOX, 1808, -6758, -2420, 0, -180, 0, 0x00000000, bhvBreakableBox),
		OBJECT(MODEL_BREAKABLE_BOX, 2208, -6758, -2420, 0, -180, 0, 0x00000000, bhvBreakableBox),
		OBJECT(MODEL_STAR, 3681, -4716, 5333, 0, -180, 0, (10 << 24), bhvStar),
		OBJECT(MODEL_BREAKABLE_BOX, 2208, -6758, -2020, 0, -180, 0, 0x00000000, bhvBreakableBox),
		OBJECT(MODEL_BREAKABLE_BOX, 1408, -6758, -1620, 0, -180, 0, 0x00000000, bhvBreakableBox),
		OBJECT(MODEL_BREAKABLE_BOX, 1808, -6758, -1620, 0, -180, 0, 0x00000000, bhvBreakableBox),
		OBJECT(MODEL_BREAKABLE_BOX, 2208, -6758, -1620, 0, -180, 0, 0x00000000, bhvBreakableBox),
		OBJECT(MODEL_STAR, 1408, -6558, -2420, 0, -180, 0, (13 << 24), bhvStar),
		OBJECT(0, 6518, -5558, 5555, 0, -180, 0, (0 << 24) | (4 << 16), bhvFlamethrower),
		OBJECT(0, 6259, -5558, 4823, 0, -180, 0, (0 << 24) | (4 << 16), bhvFlamethrower),
		OBJECT(0, 8890, -5705, 4034, 0, -180, 0, (0 << 24) | (4 << 16), bhvFlamethrower),
		OBJECT(0, 7698, -6488, 2403, 0, -180, 0, (0 << 24) | (4 << 16), bhvFlamethrower),
		OBJECT(0xF6, 8952, -5055, -484, 0, -90, 0, 0x000E0001, id_bhvWarpPipe),
		OBJECT(0, 472, -2187, -10505, 0, -180, 0, (73 << 16), bhvPoleGrabbing),
		OBJECT(0x36, 475, -1656, -10505, 0, -90, 0, (64 << 16), bhvCheckpointFlag),
		OBJECT(0, 4361, -6222, -10961, 0, -180, 0, (93 << 16), bhvPoleGrabbing),
		OBJECT(MODEL_BREAKABLE_BOX, 1408, -6358, -2420, 0, -180, 0, 0x00000000, bhvBreakableBox),
		OBJECT(MODEL_BREAKABLE_BOX, 2208, -6358, -2420, 0, -180, 0, 0x00000000, bhvBreakableBox),
		OBJECT(MODEL_BREAKABLE_BOX, 1408, -6358, -1620, 0, -180, 0, 0x00000000, bhvBreakableBox),
		OBJECT(MODEL_BREAKABLE_BOX, 2208, -6358, -1620, 0, -180, 0, 0x00000000, bhvBreakableBox),
		OBJECT(MODEL_STAR, 472, -1358, -10505, 0, -180, 0, (8 << 24), bhvStar),
		OBJECT(MODEL_STAR, 7328, -5122, -8162, 0, -180, 0, (7 << 24), bhvStar),
		OBJECT(MODEL_STAR, -2547, -3874, 5611, 0, -180, 0, (9 << 24), bhvStar),
		OBJECT(MODEL_PURPLE_SWITCH, -4791, -5758, 4642, 0, -23, 0, (0 << 24), bhvFloorSwitchHiddenObjects),
		OBJECT(0, -2806, -4558, 5467, 0, -23, 0, (0 << 24), bhvHiddenObject),
		OBJECT(0, -2990, -4758, 5390, 0, -23, 0, (0 << 24), bhvHiddenObject),
		OBJECT(0, -3175, -4958, 5313, 0, -23, 0, (0 << 24), bhvHiddenObject),
		OBJECT(0, -3360, -5158, 5237, 0, -23, 0, (0 << 24), bhvHiddenObject),
		OBJECT(0, -3544, -5358, 5160, 0, -23, 0, (0 << 24), bhvHiddenObject),
		OBJECT(0, -3729, -5558, 5083, 0, -23, 0, (0 << 24), bhvHiddenObject),
		OBJECT(0, -3914, -5758, 5006, 0, -23, 0, (0 << 24), bhvHiddenObject),
		OBJECT(MODEL_GLOWSPOT, 710, -5639, 8926, 0, -180, 0, (5 << 24), bhvSpawnBlueOnGP),
		OBJECT(MODEL_STAR, -12022, -2913, 490, 0, -180, 0, (11 << 24), bhvStar),
		OBJECT(MODEL_WOODEN_SIGNPOST, 5990, -3051, -11000, 0, 82, 0, (4 << 24) | (168 << 16), bhvMessagePanel),
		OBJECT(0, 1034, -5973, 7174, 0, 155, 0, (4 << 24) | (167 << 16), bhvScavengerHunt),
		OBJECT(0, -5989, -5713, 438, 0, 155, 0, (4 << 24) | (0 << 16) | (1), bhvScavengerHunt),
		OBJECT(0, -8755, -6739, -7914, 0, 142, 0, (4 << 24) | (165 << 16), bhvScavengerHunt),
		OBJECT(MODEL_STAR, -4712, -5036, -7487, 0, -180, 0, (12 << 24), bhvStar),
		OBJECT(MODEL_BOUNCE_SHROOM, -6998, -6871, -6881, 0, -180, 0, (0 << 24) | (1 << 16), bhvBounceShroom),
		OBJECT(0, -6561, -5901, -7298, 0, -180, 0, (0 << 24) | (150 << 16), bhvPoleGrabbing),
		OBJECT(0, -5198, -5628, -6609, 0, -180, 0, (0 << 24) | (150 << 16), bhvPoleGrabbing),
		OBJECT(MODEL_STAR, -7948, -6716, -1094, 0, -180, 0, (0 << 24), bhvStar),
		OBJECT(E_MODEL_BIRDS, -8358, -6748, -8765, 0, -180, 0, (9 << 24), bhvFreeBird),
		OBJECT(E_MODEL_BIRDS, -4999, -6974, -9797, 0, -180, 0, (9 << 24), bhvFreeBird),
		OBJECT(E_MODEL_BIRDS, -7040, -6911, -10422, 0, -180, 0, (9 << 24), bhvFreeBird),
		OBJECT(E_MODEL_BIRDS, -7024, -6883, -5870, 0, -180, 0, (9 << 24), bhvFreeBird),
		OBJECT(E_MODEL_BIRDS, -4405, -6864, -7127, 0, -180, 0, (9 << 24), bhvFreeBird),
		OBJECT(E_MODEL_BIRDS, -8604, -6826, -7161, 0, -180, 0, (9 << 24), bhvFreeBird),
		OBJECT(E_MODEL_BIRDS, -9535, -6919, -8413, 0, -180, 0, (9 << 24), bhvFreeBird),
		OBJECT(E_MODEL_BIRDS, -7204, -6864, -8108, 0, -180, 0, (9 << 24), bhvFreeBird),
		OBJECT(E_MODEL_BIRDS2, -8414, -4913, -695, 0, -180, 0, (9 << 24), bhvFreeBird),
		OBJECT(E_MODEL_BIRDS2, -6598, -5534, -533, 0, -180, 0, (9 << 24), bhvFreeBird),
		OBJECT(E_MODEL_BIRDS2, -8320, -6104, -2409, 0, -180, 0, (9 << 24), bhvFreeBird),
		OBJECT(E_MODEL_BIRDS2, -6659, -6001, -2026, 0, -180, 0, (9 << 24), bhvFreeBird),
		OBJECT(E_MODEL_BIRDS2, -6742, -6092, -2807, 0, -180, 0, (9 << 24), bhvFreeBird),
		OBJECT(E_MODEL_BIRDS2, -8147, -6715, -4164, 0, -180, 0, (9 << 24), bhvFreeBird),
		OBJECT(E_MODEL_BIRDS2, -8223, -6253, -3441, 0, -180, 0, (9 << 24), bhvFreeBird),
		OBJECT(E_MODEL_BIRDS2, -7228, -6715, -3601, 0, -180, 0, (9 << 24), bhvFreeBird),
		// needed for coop
		OBJECT(E_MODEL_RED_COIN, -8414, -4913, -695, 0, -180, 0, (9 << 24), id_bhvRedCoin),
		OBJECT(E_MODEL_RED_COIN, -6598, -5534, -533, 0, -180, 0, (9 << 24), id_bhvRedCoin),
		OBJECT(E_MODEL_RED_COIN, -8320, -6104, -2409, 0, -180, 0, (9 << 24), id_bhvRedCoin),
		OBJECT(E_MODEL_RED_COIN, -6659, -6001, -2026, 0, -180, 0, (9 << 24), id_bhvRedCoin),
		OBJECT(E_MODEL_RED_COIN, -6742, -6092, -2807, 0, -180, 0, (9 << 24), id_bhvRedCoin),
		OBJECT(E_MODEL_RED_COIN, -8147, -6715, -4164, 0, -180, 0, (9 << 24), id_bhvRedCoin),
		OBJECT(E_MODEL_RED_COIN, -8223, -6253, -3441, 0, -180, 0, (9 << 24), id_bhvRedCoin),
		OBJECT(E_MODEL_RED_COIN, -7228, -6715, -3601, 0, -180, 0, (9 << 24), id_bhvRedCoin),
		OBJECT(0, -7488, -5910, -1362, 0, -180, 0, (1 << 24), bhvHiddenRedCoinStar),
		//OBJECT(MODEL_SWINGVINE, -5389, -5621, -1456, 0, 90, 0, (0 << 24), bhvSwingVein),
		OBJECT(MODEL_PURPLE_SWITCH, -6506, -3725, -5185, 0, 0, 0, (0 << 24), bhvFloorSwitchHiddenObjects),
		OBJECT(0, -2598, -6163, -1641, 0, -180, 0, (0 << 24) | (2 << 16), bhvCoinFormation),
		OBJECT(MODEL_BOUNCE_SHROOM, -6016, -6781, -3933, 0, -180, 0, (0 << 24) | (55 << 16), bhvBounceShroom),
		OBJECT(MODEL_CANNON_BASE, -3355, -6311, 3317, 0, -180, 0, (0 << 24) | (0x18 << 16), bhvCannon),
		OBJECT(0x41, 9386, -2162, -3667, 0, -180, 0, 0x00000000, bhvCheckpointFlag),
		OBJECT(0, 9386, -2816, -3667, 0, -180, 0, (14 << 24) | (1 << 16), bhvGoombaStar),
		OBJECT(MODEL_CHUCKYA, 10074, -2716, -3613, 0, -180, 0, (0 << 24) | (0 << 16), bhvChuckya),
		OBJECT(MODEL_CHUCKYA, 9090, -2716, -4334, 0, -70, 0, (0 << 24) | (0 << 16), bhvChuckya),
		OBJECT(MODEL_CHUCKYA, 9075, -2716, -3152, 0, 42, 0, (0 << 24) | (0 << 16), bhvChuckya),
		OBJECT(0, -5739, -3874, -7498, 0, -180, 0, (0 << 24) | (2 << 16), bhvCoinFormation),
		OBJECT(0, -7879, -3848, 3014, 0, -180, 0, (0 << 24) | (0x11 << 16), bhvCoinFormation),
		OBJECT(0, -7212, -5313, 488, 0, -180, 0, (0 << 24) | (0x11 << 16), bhvCoinFormation),
		OBJECT(0, 472, -6792, -8349, 0, 0, 0, (0 << 24) | (0 << 16), bhvCoinFormation),
		OBJECT(0, 7527, -6644, 4639, 0, 34, 0, (0 << 24) | (0 << 16), bhvCoinFormation),
		OBJECT(0, -6561, -5891, -7295, 0, 34, 0, (0 << 24) | (0x11 << 16), bhvCoinFormation),
		OBJECT(0, -7367, -6759, -9406, 0, -180, 0, (0 << 24) | (2 << 16), bhvCoinFormation),
		//OBJECT(MODEL_SWINGVINE, -4373, -3502, -8735, 0, 136, 0, (0 << 24) | (1 << 16), bhvSwingVein),
		OBJECT(MODEL_ROTATETHING, 10625, -1713, -555, 0, -180, 0, (20 << 24), bhvMerry),
		OBJECT(MODEL_BOUNCY_FLOWER, -2598, -6188, -1641, 0, -180, 0, (0xf0 << 24) | (0 << 16), bhvBounceFlower),
		OBJECT(MODEL_STAR, -7271, -3600, -8167, 0, -180, 0, (24 << 24), bhvStar),
		OBJECT(MODEL_BOUNCY_FLOWER, 8560, -1889, 2755, 0, -180, 0, (0xf0 << 24) | (0 << 16), bhvBounceFlower),
		OBJECT(0, -6889, -3525, -4720, 0, 90, 0, (0 << 24) | (1), bhvHiddenObject),
		OBJECT(0, -6889, -3325, -3920, 0, 90, 0, (0 << 24) | (1), bhvHiddenObject),
		OBJECT(0, -6889, -3125, -3120, 0, 90, 0, (0 << 24) | (1), bhvHiddenObject),
		OBJECT(0, -6889, -2925, -2320, 0, 90, 0, (0 << 24) | (1), bhvHiddenObject),
		// MODEL ID 0X44
		OBJECT(MODEL_SHIPWINGS, 7724, -2660, 7391, 0, -95, 0, 0x00000000, bhvShipWings),
		//end
		OBJECT(MODEL_BBARREL, 8175, -2210, 7079, 0, -180, 0, 0x00000000, bhvBbarrel),
		OBJECT(MODEL_BBARREL, 8175, -2210, 7441, 0, -180, 0, 0x00000000, bhvBbarrel),
		OBJECT(MODEL_BBARREL, 8175, -2210, 7739, 0, -180, 0, 0x00000000, bhvBbarrel),
		OBJECT(0, -6089, -3525, -4720, 0, 90, 0, (0 << 24) | (1), bhvHiddenObject),
		OBJECT(0, -6089, -3325, -3920, 0, 90, 0, (0 << 24) | (1), bhvHiddenObject),
		OBJECT(0, -6089, -3125, -3120, 0, 90, 0, (0 << 24) | (1), bhvHiddenObject),
		OBJECT(0, -6089, -2925, -2320, 0, 90, 0, (0 << 24) | (1), bhvHiddenObject),
		OBJECT(MODEL_BBARREL, 7457, -1391, 7649, 0, -180, 0, (1 << 16), bhvBbarrel),
		OBJECT(MODEL_BBARREL, 7966, -1391, 7303, 0, -180, 0, 0x00000000, bhvBbarrel),
		OBJECT(MODEL_BBARREL, 8845, -1633, 7910, 0, -180, 0, 0x00000000, bhvBbarrel),
		OBJECT(MODEL_BBARREL, 9104, -1633, 7622, 0, -180, 0, (1 << 16), bhvBbarrel),
		OBJECT(MODEL_STAR, -6445, -2542, -1425, 0, -180, 0, (15 << 24), bhvStar),
		OBJECT(MODEL_WOODEN_SIGNPOST, 472, -6792, -9163, 0, 0, 0, (0 << 24) | (0 << 16), bhvMessagePanel),
		OBJECT(MODEL_EXCLAMATION_BOX, -6, 853, 7, 0, 0, 0, (1 << 24) | (1 << 16) | (0), bhvExclamationBox),
		OBJECT(MODEL_STAR, -6, 1603, 7, 0, -180, 0, (16 << 24), bhvStar),
		OBJECT(0, 5962, 761, -10047, 0, -180, 0, (17 << 24) | (7), bhvGoombaStar),
		OBJECT(MODEL_WOODEN_SIGNPOST, 6115, 1361, -8989, 0, 90, 0, (0 << 24) | (166 << 16), bhvMessagePanel),
		OBJECT(MODEL_EXCLAMATION_BOX, 408, -4404, -11491, 0, 0, 0, (0 << 24) | (6 << 16) | (0), bhvExclamationBox),
		OBJECT(0, -446, -3020, -6578, 0, 84, 5, (0 << 24) | (0x10 << 16), bhvCoinFormation),
		OBJECT(0, 2430, -2686, -6251, 0, 84, 5, (0 << 24) | (0x10 << 16), bhvCoinFormation),
		OBJECT(MODEL_SILVER_STAR, 8868, 260, -396, 0, -180, 0, 0x00000000, id_bhvHiddenStarTrigger),
		OBJECT(MODEL_SILVER_STAR, 7489, -1237, 555, 0, -180, 0, 0x00000000, id_bhvHiddenStarTrigger),
		OBJECT(MODEL_SILVER_STAR, 7448, -237, 2613, 0, -180, 0, 0x00000000, id_bhvHiddenStarTrigger),
		OBJECT(MODEL_SILVER_STAR, 9776, -1004, 1575, 0, -180, 0, 0x00000000, id_bhvHiddenStarTrigger),
		OBJECT(MODEL_SILVER_STAR, 10460, -693, 2093, 0, -180, 0, 0x00000000, id_bhvHiddenStarTrigger),
		OBJECT(0, 8669, -1595, 804, 0, -180, 0, (19 << 24), bhvHiddenStar),
		OBJECT(MODEL_BBARREL, 8984, -1633, 7178, 0, -180, 0, 0x00000000, bhvBbarrel),
		OBJECT(MODEL_BBARREL, 6700, -2210, 7362, 0, -180, 0, (3 << 16), bhvBbarrel),
		OBJECT(MODEL_STAR, 8845, -1563, 7910, 0, -180, 0, (18 << 24), bhvStar),
		OBJECT(MODEL_GLOWSPOT, -4237, -2194, 5977, 0, -180, 0, (22 << 24), bhvSpawnBlueOnGP),
		OBJECT(0, -1700, -3764, 4368, 0, -180, 0, (0 << 24) | (167 << 16), bhvPoleGrabbing),
		OBJECT(0, -5015, -438, 5768, 0, -180, 0, (0 << 24) | (2 << 16), bhvCoinFormation),
		OBJECT(MODEL_STAR, -305, 405, 4947, 0, -180, 0, (23 << 24), bhvStar),
		OBJECT(MODEL_WINDMILL2, 483, -325, 4947, 0, 0, 0, (0 << 24) | (100 << 16), bhvWindMill2),
		OBJECT(MODEL_WINDMILL2, -5015, -961, 6321, 0, -90, 0, (0 << 24) | (81 << 16), bhvWindMill2),
		OBJECT(MODEL_WINDMILL2, -6789, -1581, 5705, 0, -90, 0, (0 << 24) | (78 << 16), bhvWindMill2),
		OBJECT(0xF6, -8164, -2282, 7032, 0, 147, 0, 0x00100001, id_bhvWarpPipe),
		OBJECT(0x47, 7730, -890, 7391, 0, -95, 0, 0x00000000, bhvCheckpointFlag),
		OBJECT(MODEL_WOODEN_SIGNPOST, -9954, -4513, 490, 0, 90, 0, (0 << 24) | (169 << 16), bhvMessagePanel),
		MARIO_POS(0x01, 0, 1764, -6772, -7590),
		OBJECT(MODEL_NONE, 1764, -6272, -7590, 0, 0, 0, (0x0A << 16), bhvSpinAirborneWarp),
		OBJECT(MODEL_PEACHY, 1809, -6772, -6435, 0, -16, 0, (6 << 16), bhvPeachy),
		OBJECT_WITH_ACTS(/* model*/ 0, /*speed*/ 4, /*axis*/4, /*vtx count*/55, 0, /*scroll type*/ 0, /*cycle*/ 1, /*index*/ 213, RM_Scroll_Texture, 31),
		TERRAIN(hmc_area_1_collision),
		MACRO_OBJECTS(hmc_area_1_macro_objs),
		SET_BACKGROUND_MUSIC(0x00, 102),
		TERRAIN_TYPE(TERRAIN_GRASS),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),

	AREA(2, hmc_area_2),
		WARP_NODE(0x0A, LEVEL_HMC, 0x01, 0x0E, WARP_NO_CHECKPOINT),
		WARP_NODE(0x0B, LEVEL_HMC, 0x01, 0x0E, WARP_NO_CHECKPOINT),
		WARP_NODE(0x10, LEVEL_HMC, 0x03, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, LEVEL_HMC, 0x02, 0x0A, WARP_NO_CHECKPOINT),
		OBJECT(0x16, 0, -872, -2314, 0, 0, 0, (0x0A << 16), bhvWarpPipe),
		OBJECT(0x16, -7350, -872, 4811, 0, 90, 0, (0x0B << 16), bhvWarpPipe),
		OBJECT(MODEL_STAR, -7875, -372, 4811, 0, -180, 0, (3 << 24), bhvStar),
		OBJECT(MODEL_8BIT_GOOMBA, -937, -122, -301, 0, -180, 0, (0 << 16) | (1), id_bhvGoomba),
		OBJECT(MODEL_8BIT_GOOMBA, -728, -372, -1357, 0, -180, 0, (0 << 16) | (1), id_bhvGoomba),
		OBJECT(MODEL_8BIT_GOOMBA, 381, 128, 910, 0, -180, 0, (0 << 16) | (1), id_bhvGoomba),
		OBJECT(MODEL_8BIT_GOOMBA, -195, 128, 1453, 0, -180, 0, (0 << 16) | (1), id_bhvGoomba),
		OBJECT(MODEL_8BIT_GOOMBA, 643, 378, 1596, 0, -180, 0, (0 << 16) | (1), id_bhvGoomba),
		OBJECT(MODEL_8BIT_GOOMBA, 119, -372, 2703, 0, -180, 0, (0 << 16) | (1), id_bhvGoomba),
		OBJECT(MODEL_8BIT_GOOMBA, -78, -372, 3334, 0, -180, 0, (0 << 16) | (1), id_bhvGoomba),
		OBJECT(MODEL_8BIT_GOOMBA, -285, 378, 4533, 0, -180, 0, (0 << 16) | (1), id_bhvGoomba),
		TERRAIN(hmc_area_2_collision),
		MACRO_OBJECTS(hmc_area_2_macro_objs),
		SET_BACKGROUND_MUSIC(0x00, 0),
		TERRAIN_TYPE(TERRAIN_GRASS),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),

	AREA(3, hmc_area_3),
		WARP_NODE(0x0A, LEVEL_HMC, 0x01, 0x10, WARP_NO_CHECKPOINT),
		WARP_NODE(0x0B, LEVEL_HMC, 0x01, 0x10, WARP_NO_CHECKPOINT),
		WARP_NODE(0x10, LEVEL_HMC, 0x03, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, LEVEL_HMC, 0x03, 0x0A, WARP_NO_CHECKPOINT),
		OBJECT(0x16, 125, 125, 141, 0, 0, 0, (0x0A << 16), bhvWarpPipe),
		OBJECT(MODEL_STAR, 3000, 3309, 6500, 0, -180, 0, (21 << 24), bhvStar),
		OBJECT(0x16, 3500, 3109, 7000, 0, -135, 0, (0x0B << 16), bhvWarpPipe),
		TERRAIN(hmc_area_3_collision),
		MACRO_OBJECTS(hmc_area_3_macro_objs),
		SET_BACKGROUND_MUSIC(0x00, 0),
		TERRAIN_TYPE(TERRAIN_GRASS),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),

	FREE_LEVEL_POOL(),
	MARIO_POS(0x01, 0, 1764, -6772, -7590),
	CALL(0, lvl_init_or_update),
	CALL_LOOP(1, lvl_init_or_update),
	CLEAR_LEVEL(),
	SLEEP_BEFORE_EXIT(1),
	EXIT(),
};
