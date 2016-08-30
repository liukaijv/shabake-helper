local bb = require("badboy")
local strutils = bb.getStrUtils()
require 'helpers'

screen_width, screen_height = getScreenSize()
viewport_width = screen_width-1
viewport_height = screen_height-1

print_mutil('screen_width:'..screen_width,'screen_height:'..screen_height)

local supportSize = (screen_width==720 and screen_height==1280)
if not supportSize then 
  mSleep(100)
  forceRun = dialogRet("不支持当前分辨率".."宽:"..screen_width..",高:"..screen_height, "停止运行", "强制运行", "", 0)
  if forceRun == 0 then 
    lua_exit();
  end
  if forceRun == 1 then
    dialog("警告：\n 强制运行无法保证脚本功能能够正常运转", 0)
    setScreenScale(720,1280,0)
  end
end

local appId = frontAppName()
sysLog('appId:'..appId)
if strutils.contains(appId,'sbkcq') then
  -- home键在下初始化
  init(appId,0) 
else
  dialog("警告：\n 请先运行沙巴克传奇游戏", 0)
  lua_exit()
end 

local x, y = isMianUi()
if x == -1 then	
  dialog("警告：\n 请在主界面中运行脚本", 0)
  lua_exit()
end