--主界面
function isMianUi()
  keepScreen(true)
  local x, y = findMultiColorInRegionFuzzy(0xf6950c,"3|24|0xfeb024,22|-2|0xfca304,36|-8|0xf69105", 95, 1222, 2, 1279, 47)
  if x > -1 then
    sysLog('主界面中……')
  else	
    sysLog('没在主界面中……')		
  end
  keepScreen(false)
  return x,y
end

--场景切换中
function inSceneCuting()
	keepScreen(true)
  local x, y = findImageInRegionFuzzy("cuting590x130_60x160.png", 60, 590,130,60,160, 0xffffff);
	if x>-1 then
		sysLog('场景切换中……')
	end
	keepScreen(false)
	return x,y;	
end 

--任务检查
function checkTask()
  keepScreen(true)	
  local x, y = findMultiColorInRegionFuzzy(0xfbbd00,"1|-6|0xffc000,1|7|0xffc000,3|8|0xffc000", 95, 0, 283, 256, 365)
  keepScreen(false)
  if x > -1 then
    sysLog('找到任务')
    return x+5, y+5
  end
  sysLog('未找到任务')
  return x,y
end

--是否在战斗中
function isFighting()
  keepScreen(true)
  local x, y = findMultiColorInRegionFuzzy(0xf0efed,"-26|32|0xd5dd2b,36|33|0xf0f624", 95, 1160, 199, 1274, 312)
  if x > -1 then
    sysLog('自动战斗中……')
    return x,y
  end                           
  sysLog("未自动战斗！")
  keepScreen(false)
  return x,y  
end

--行走中
function isWalking()
  keepScreen(true)
  local x, y = findMultiColorInRegionFuzzy(0x033af7,"-12|19|0xfcf8f7,44|14|0xf1f1f1,-4|-5|0x13162d", 95, 542, 425, 923, 536)
  if x > -1 then
    sysLog('行走中……')
    return x,y
  end                           
  sysLog("未找到行走坐标！")
  keepScreen(false)
  return x,y  
end

--死亡检测
function isDead()
  keepScreen(true)	
  local x, y = findMultiColorInRegionFuzzy(0x6e5350,"0|16|0x730700,45|2|0x6f5350,95|-2|0x705250", 95, 470, 481, 624, 533)
  if x > -1 then
    sysLog('被人杀死亡')
    return x,y,0
  else
    x, y = findImageInRegionFuzzy("rebirth_origin497x434_102x31.png", 80, 383,258,880,546, 0xffffff);
    if x > -1 then
      sysLog('被怪物杀死亡')
    end
    sysLog('没有死亡')
  end
  keepScreen(false)
  return x,y,1
end

--确认框1
function hasAlert()
  return -1,-1;
end
--确认框2
function hasConfirm()
  keepScreen(true)	
  local x, y = findMultiColorInRegionFuzzy(0x6e524f,"78|-6|0x6e5652,-12|19|0x910c02,77|16|0x830900", 95, 472, 418, 624, 477)
  if x > -1 then
    sysLog('需要确认或取消')
    return x,y,700,450	
  end
  keepScreen(false)
  return x,y,-1,-1
end