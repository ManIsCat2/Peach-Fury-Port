void scroll_gfx_mat_glowspot_f3d_material_007_layer6() {
	Gfx *mat = segmented_to_virtual(mat_glowspot_f3d_material_007_layer6);


	shift_t(mat, 10, PACK_TILESIZE(0, 1));
	shift_t_down(mat, 12, PACK_TILESIZE(0, 1));

};

void scroll_bob_level_geo_glowspot() {
	scroll_gfx_mat_glowspot_f3d_material_007_layer6();
};
