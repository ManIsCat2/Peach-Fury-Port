const BehaviorScript bhvGoombaStar[] = {
    BEGIN(OBJ_LIST_LEVEL),
    ID(id_bhvNewId),
    CALL_NATIVE(syncobjs_init),
    OR_INT(oFlags, OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE),
    BEGIN_LOOP(),
        CALL_NATIVE(goombastar),
    END_LOOP(),
};

const BehaviorScript bhvBounceFlower[] = {
    BEGIN(OBJ_LIST_GENACTOR),
    ID(id_bhvNewId),
    OR_INT(oFlags, (OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)),
    SET_HITBOX(120, 50),
    SCALE(0, 150),
    SET_INT(oIntangibleTimer, 0),
    BEGIN_LOOP(),
    SET_INT(oInteractStatus, 0),
    CALL_NATIVE(bounceyflower),
    END_LOOP(),
};

const BehaviorScript bhvBounceShroom[] = {
    BEGIN(OBJ_LIST_SURFACE),
    ID(id_bhvNewId),
    OR_INT(oFlags, (OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_COMPUTE_DIST_TO_MARIO)),
    SET_FLOAT(oDrawingDistance, 32000),
    LOAD_COLLISION_DATA(COL_BOUNCE_SHROOM),
    BEGIN_LOOP(),
        CALL_NATIVE(diagshroom),
    END_LOOP(),
};

const BehaviorScript bhvBbarrel[] = {
    BEGIN(OBJ_LIST_SURFACE),
    ID(id_bhvNewId),
    OR_INT(oFlags, (OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)),
    SET_FLOAT(oDrawingDistance, 32000),
    CALL_NATIVE(syncobjs_init),
    BEGIN_LOOP(),
        CALL_NATIVE(bbarrelcode),
    END_LOOP(),
};

const BehaviorScript bhvScavengerHunt[] = {
    BEGIN(OBJ_LIST_GENACTOR),
    ID(id_bhvNewId),
    OR_INT(oFlags, (OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)),
    CALL_NATIVE(syncobjs_init),
    BEGIN_LOOP(),
    CALL_NATIVE(scavengersign),
    END_LOOP(),
};

const BehaviorScript bhvMerry[] = {
    BEGIN(OBJ_LIST_SURFACE),
    ID(id_bhvNewId),
    CALL_NATIVE(syncobjs_init),
    OR_INT(oFlags, (OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)),
    //LOAD_COLLISION_DATA(rotatething_collision),
    SET_FLOAT(oDrawingDistance, 15000),
    SET_HOME(),
    BEGIN_LOOP(),
        CALL_NATIVE(goround),
    END_LOOP(),
};

const BehaviorScript bhvFreeBird[] = {
    BEGIN(OBJ_LIST_DEFAULT),
    ID(id_bhvNewId),
    OR_INT(oFlags, (OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO | OBJ_FLAG_COMPUTE_DIST_TO_MARIO
                    | OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)),
    LOAD_ANIMATIONS(oAnimations, birds_seg5_anims_050009E8),
    SET_OBJ_PHYSICS(/*Wall hitbox radius*/ 50, /*Gravity*/ -200, /*Bounciness*/ -20,
                    /*Drag strength*/ 1000, /*Friction*/ 1000, /*Buoyancy*/ 200, /*Unused*/ 0, 0),
    ANIMATE(2),
    SET_HOME(),
    CALL_NATIVE(syncobjs_init),
    BEGIN_LOOP(),
    //set scale randomly
    // move around a little bit, by doing small jumps
    // flies in stored directio when approach
    // runs if mario close to home
    // 
        CALL_NATIVE(freebird),
    END_LOOP(),
};

const BehaviorScript bhvPeachy[] = {
    BEGIN(OBJ_LIST_LEVEL),
    ID(id_bhvNewId),
    OR_INT(oFlags, (OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW | OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)),
    SET_HITBOX(/*Radius*/ 100, /*Height*/ 200),
    SET_INTERACT_TYPE(INTERACT_TEXT),
    SET_INT(oInteractionSubtype, INT_SUBTYPE_NPC),
    SET_INT(oWoodenPostTotalMarioAngle, 0),
    SET_INT(oIntangibleTimer, 0),
    //LOAD_ANIMATIONS(oAnimations, peachy_anims),
    BEGIN_LOOP(),
        CALL_NATIVE(peachcode),
    END_LOOP(),
};

const BehaviorScript bhvSpawnBlueOnGP[] = {
    BEGIN(OBJ_LIST_LEVEL),
    ID(id_bhvNewId),
    OR_INT(oFlags, OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_COMPUTE_DIST_TO_MARIO),
    SET_FLOAT(oDrawingDistance, 32000),
    CALL_NATIVE(syncobjs_init),
    BEGIN_LOOP(),
    CALL_NATIVE(bhvbluespawenrosadhbgiuogdsiuzfghdsaiuzofgo),
    END_LOOP(),
};

const BehaviorScript bhvSwingVein[] = {
    BEGIN(OBJ_LIST_GENACTOR),
    ID(id_bhvNewId),
    OR_INT(oFlags, (OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)),
   //LOAD_ANIMATIONS(oAnimations, swingVine_anims),
    SET_FLOAT(oGraphYOffset, 1000),
    BEGIN_LOOP(),
        CALL_NATIVE(swingVein),
    END_LOOP(),
};

const BehaviorScript bhvWindMill2[] = {
    BEGIN(OBJ_LIST_SURFACE),
    ID(id_bhvNewId),
    SET_FLOAT(oDrawingDistance, 32000),
    OR_INT(oFlags, (OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)),
    //LOAD_COLLISION_DATA(windmill2_collision),
    BEGIN_LOOP(),
        CALL_NATIVE(wingmillcode),
    END_LOOP(),
};

const BehaviorScript bhvShipWings[] = {
    BEGIN(OBJ_LIST_LEVEL),
    ID(id_bhvNewId),
    OR_INT(oFlags, OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE),
    SET_FLOAT(oDrawingDistance, 32000),
    //LOAD_ANIMATIONS(oAnimations, shipwings_anims),
    //ANIMATE(0),
    BEGIN_LOOP(),
    CALL_NATIVE(shipwingcode),
    END_LOOP(),
};

const BehaviorScript bhvCheckpointFlag[] = {
    BEGIN(OBJ_LIST_LEVEL),
    ID(id_bhvNewId),
    OR_INT(oFlags, (OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)),
    //LOAD_ANIMATIONS(oAnimations, goomflagg_geo_anims),
    //ANIMATE(0),
        CALL_NATIVE(scaleByParam2),
    BEGIN_LOOP(),
    END_LOOP(),
};

const BehaviorScript bhvCloudSafety[] = {
    BEGIN(OBJ_LIST_SURFACE),
    ID(id_bhvNewId),
    OR_INT(oFlags, (OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)),
    LOAD_COLLISION_DATA(cloud_collision),
    SET_FLOAT(oDrawingDistance, 28000),
    SET_FLOAT(oCollisionDistance, 28000),
    SET_FLOAT(oGraphYOffset, -20),
    SET_HOME(),
    BEGIN_LOOP(),
        CALL_NATIVE(safetyCloud),
    END_LOOP(),
};

const BehaviorScript bhvCloudSpawn[] = {
    BEGIN(OBJ_LIST_SURFACE),
    ID(id_bhvNewId),
    SCALE(0, 5),
    ADD_FLOAT(oPosY, -80),
    OR_INT(oFlags, OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE),
    LOAD_COLLISION_DATA(cloudspawn_collision),
    BEGIN_LOOP(),
    CALL_NATIVE(cloudbox),
    END_LOOP(),
};

const BehaviorScript bhvCloudFollow[] = {
    BEGIN(OBJ_LIST_GENACTOR),
    ID(id_bhvNewId),
    BILLBOARD(),
    OR_INT(oFlags, OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE),
    BEGIN_LOOP(),
    CALL_NATIVE(cloudfollowing),
    END_LOOP(),
};