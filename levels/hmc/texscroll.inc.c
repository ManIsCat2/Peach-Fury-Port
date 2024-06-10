void scroll_gfx_mat_hmc_dl_Watermat_001_layer0() {
	Gfx *mat = segmented_to_virtual(mat_hmc_dl_Watermat_001_layer0);


	shift_s(mat, 11, PACK_TILESIZE(0, 1));
	shift_t(mat, 11, PACK_TILESIZE(0, 1));
	shift_s_down(mat, 16, PACK_TILESIZE(0, 1));
	shift_t(mat, 16, PACK_TILESIZE(0, 1));

};

void scroll_gfx_mat_hmc_dl_f3d_material_204_layer5() {
	Gfx *mat = segmented_to_virtual(mat_hmc_dl_f3d_material_204_layer5);


	shift_s(mat, 14, PACK_TILESIZE(0, 1));
	shift_t(mat, 14, PACK_TILESIZE(0, 2));
	shift_s(mat, 19, PACK_TILESIZE(0, 2));
	shift_t_down(mat, 19, PACK_TILESIZE(0, 1));

};

void scroll_gfx_mat_hmc_dl_f3d_material_019_layer1() {
	Gfx *mat = segmented_to_virtual(mat_hmc_dl_f3d_material_019_layer1);


	shift_s(mat, 14, PACK_TILESIZE(0, 1));
	shift_t_down(mat, 14, PACK_TILESIZE(0, 1));
	shift_s(mat, 19, PACK_TILESIZE(0, 1));
	shift_t(mat, 19, PACK_TILESIZE(0, 1));

};

void scroll_hmc() {
	scroll_gfx_mat_hmc_dl_Watermat_001_layer0();
	scroll_gfx_mat_hmc_dl_f3d_material_204_layer5();
	scroll_gfx_mat_hmc_dl_f3d_material_019_layer1();
};
