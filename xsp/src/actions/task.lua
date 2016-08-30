-- 任务脚本
local bb = require("badboy")
bb.loadutilslib()
require 'helpers'

function findAcceptBtn()	
  local x,y = -1,-1;
  keepScreen(true)
  -- 比奇，日任务接受按钮
  x, y = findMultiColorInRegionFuzzy(0xd9caa1,"98|-15|0x6d514e,27|17|0xda1403,-29|-15|0x6f5552", 95, 878, 491, 1053, 556);   
  if x > -1 then		
    sysLog('发现接受比奇，日任务按钮');	   
  else
    --环任务接受按钮
    x, y = findMultiColorInRegionFuzzy(0xb19647,"40|-4|0xf9e27f,68|-18|0x775552,130|-1|0x7b4f4c", 95, 644, 461, 925, 564);
    if x>-1 then      
      sysLog('发现接受环任务按钮');     
    end
  end
  keepScreen(false)
  return x,y
end

function findDoneBtn()
  keepScreen(true)
  local x,y = findMultiColorInRegionFuzzy(0xad9350,"26|6|0xe6c458,91|-14|0x7a5854,116|17|0xd39035", 95, 642, 487, 916, 565);
  keepScreen(false)
  if x>-1 then
    sysLog('任务完成按钮')
  end  
  return x,y
end

local duringTasking = false
--是否使用小飞鞋
local useBoot = false
if string.find(setting["taskSetting"], "0", 1) then
  useBoot = true
end
local quickRebirth = false
if string.find(setting["taskSetting"], "1", 1) then
  quickRebirth = true
end
local interval = 5*1000
local taskCount = 0
--死亡次数
local deadCount,deadMCount,deadPCount= 0,0,0
--卡停计数
local lockedCount = 0

sysLog('任务脚本开始')

--点击任务按钮
tap(50,190)
mSleep(1000) 

while(true) do 
  
  --怪物太强大
  if (deadMCount >= 5 or deadPCount >= 5) then
    local confirmRun = dialogRet("你被怪物杀死了"..deadMCount.."次，\n被人杀死了"..deadPCount.."次", "停止运行", "继续运行", "", 0)
    if confirmRun==0 then
      lua_exit()
    end
    if confirmRun==1 then
      deadMCount = 0
      deadPCount = 0
      mSleep(1000)
    end		
  end
  
  --死亡检查
  x,y,z= isDead()
  if x>-1 then
    if z == 0 then
      deadPCount = deadPCount + 1;
    else
      deadMCount = deadMCount + 1;
    end
    deadCount = deadCount + 1
    if quickRebirth then
			mSleep(10*1000)
      tap(x,y)
      sysLog('角色原地复活')
    else
      tap(x+180,y)
      sysLog('角色回城复活')
    end	
    mSleep(3000)
  end
  
  --完成任务
  x,y = findDoneBtn()
  if x>-1 then
    tap(x,y)
    taskCount = taskCount + 1
    sysLog('完成了任务')
    duringTasking = false
    mSleep(2000)
  end	
  
  --接受任务
  x,y = findAcceptBtn()
  if x >-1 then
    tap(x,y)
    sysLog('接受了任务')
    duringTasking = true
    mSleep(2000)
  end  
  
  --是否有任务
  x,y = checkTask()
  if (x==-1 and duringTasking == false) then 
		x,y = inSceneCuting()
		if x==-1 then
			--todo其它判断
			break 
		end		
	end
  
  tap(x,y)
  mSleep(4000)
  
  --检测行走中
  x,y = isWalking()
  if (x>-1 and useBoot==true) then
    tap(x,y)
    mSleep(4000)
  else
    mSleep(interval)
  end 
  
  x,y = isFighting()
  if x>-1 then
    mSleep(5000)		
  end
  
  if duringTasking then
    sysLog('任务进行中……')  
  else
    sysLog('查找任务中……')  
  end
  
  --角色啥也没干，可能是卡住了
  local fx,fy = isFighting()
  local wx,wy = isWalking()
  if fx == -1 and wx ==-1 then
		sysLog('检测到角色没有动作') 
		lockedCount = lockedCount + 1    
		if lockedCount > 4 then
			--飞回城
			tap(1220,440)
			lockedCount = 0
			sysLog('飞回城再试')					
		  mSleep(3000)
		end
	else
		lockedCount = 0
  end
  
end

sysLog('任务脚本结束')
dialog("提示：\n 完成了"..taskCount.."个任务，\n死亡"..deadCount.."次", 0)