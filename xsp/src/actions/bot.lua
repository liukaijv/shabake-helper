-- 挂机脚本
--dialog("警告：\n 请把角色放在要挂机的地图中……", 0)

sysLog('开始挂机……')
mSleep(1000)

local interval = 60*1000

while(true) do
  
  --死亡后重新开始任务	
  local dx,dy = isDead()		
  if dx> -1 then
    sysLog('战斗中死亡...等待复活')
    tap(dx,dy)
    sysLog('角色已复活')
    mSleep(2000)
  end 
  
  --角色啥也没干，重新开始任务
  local fx,fy = isFighting()
  local wx,wy = isWalking()
  if fx == -1 and wx ==-1 then 
    sysLog('检测到角色没有动作')	
    tap(1220,250)		
    sysLog('开启自动战斗')
    mSleep(2000)
  end
  
  sysLog('战斗中……')
  mSleep(interval)	
  
end
