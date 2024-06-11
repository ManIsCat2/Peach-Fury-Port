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
