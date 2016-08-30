require 'utils'
local bb = require("badboy")
bb.loadutilslib()

--入口函数
function main()  
  
  require 'init'
  require 'helpers'	
  
  --显示UI并获取设置
  start,setting = showUI("ui.json")
  
  --取消则退出
  if start == 0 or setting["actionRadio"] == "" then
    sysLog("取消执行")
    lua_exit()
  end
  
  if start == 1 then
    
    --任务
    if string.find(setting["actionRadio"], "0", 1) then      
      require 'actions.task' 
    end
    
    --挂机
    if string.find(setting["actionRadio"], "1", 1) then      
      require 'actions.bot' 
    end
    
    --喊话
    if string.find(setting["actionRadio"], "2", 1) then      
      require 'actions.shout'
    end
    
  end  
  
end

main()
