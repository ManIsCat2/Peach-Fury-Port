const BehaviorScript bhvGoombaStar[] = {
    BEGIN(OBJ_LIST_LEVEL),
    ID(id_bhvNewId),
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
    BEGIN_LOOP(),
        CALL_NATIVE(bbarrelcode),
    END_LOOP(),
};

const BehaviorScript bhvScavengerHunt[] = {
    BEGIN(OBJ_LIST_GENACTOR),
    ID(id_bhvNewId),
    OR_INT(oFlags, (OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)),
    BEGIN_LOOP(),
    CALL_NATIVE(scavengersign),
    END_LOOP(),
};

