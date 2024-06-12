function on_death(m, nonStandard)
  if m.playerIndex ~= 0 then return true end

  if ROMHACK.isUnder and died and (not nonStandard) and NetP[0].currLevelNum == LEVEL_CASTLE_COURTYARD then
    m.health = 0x880
    prevHealth = 0x880
    actualHealthBeforeRender = 0x880
    m.hurtCounter = 0
    force_idle_state(m)
    reset_camera(m.area.camera)
    return false
  elseif not nonStandard and GST.mhMode ~= 2 and GST.mhState ~= 0 and NetP[0].currCourseNum == 0 and m.floor.type ~= SURFACE_INSTANT_QUICKSAND and m.floor.type ~= SURFACE_INSTANT_MOVING_QUICKSAND then -- for star road (and also 121rst star)
    m.numLives = 101
    died = true
    return true
  elseif not nonStandard and GST.voidDmg ~= -1 and prevSafePos.valid then
    local voidHurtCounter = GST.voidDmg * 4
    if apply_double_health(0) then voidHurtCounter = voidHurtCounter // 2 end
    if m.health - math.max((m.hurtCounter + voidHurtCounter - m.healCounter) * 0x40, 0) > 0xFF then
      m.hurtCounter = m.hurtCounter + GST.voidDmg * 4
      soft_reset_camera(m.area.camera)
      set_mario_action(m, ACT_MH_BUBBLE_RETURN, 0)
      fade_volume_scale(0, 127, 15)
      m.numLives = 100
      return false
    end
  end


-- custom bubble action, with some code from the base game bubble action
ACT_MH_BUBBLE_RETURN = allocate_mario_action(ACT_GROUP_CUTSCENE | ACT_FLAG_PAUSE_EXIT)
---@param m MarioState
function act_bubble_return(m)
  -- create bubble
  if (not m.bubbleObj and m.playerIndex == 0) then
    m.bubbleObj = spawn_non_sync_object(id_bhvStaticObject, E_MODEL_BUBBLE_PLAYER, m.pos.x, m.pos.y + 50, m.pos.z, nil)
    if m.bubbleObj then
      m.bubbleObj.heldByPlayerIndex = m.playerIndex
      obj_scale(m.bubbleObj, 1.5)
    end
  end

