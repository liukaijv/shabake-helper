local bb = require("badboy")
bb.loadutilslib()
local pos = bb.loadpos()
require 'helpers'

mSleep(2000)
sysLog('自动喊话开始')

local shoutText = tostring(setting["shoutText"])
if shoutText == '' then
  dialog("警告：\n 请设置喊话内容后重新运行脚本", 0)
  lua_exit()
end

local interval = tonumber(setting["shoutInterval"])*60*1000
local mode = tonumber(setting["shoutMode"]) or 0
local modes = {
  --  [0]='0xf94414',--号令
  --  [1]='0xf015fe',--传音
  [0]='0xffffff',--世界
  [1]='0xefda26',--行会
  [2]='0x5ef900',--组队
  [3]='0x86dee3'--附近
}
local modeColor = nil

while(true) do
  
  sysLog('开始喊话')
  
  local x, y = findMultiColorInRegionFuzzy(0x653b10,"7|-11|0xfae08d,15|2|0x6e461a,28|10|0xbe8d1d", 95, 799, 631, 920, 706)
  if x > -1 then
    tap(x,y)
    mSleep(5000)	
  end   
  
  if modeColor == nil then
    modeColor = modes[mode]
    --选择喊话方式
    tap(250,670)
    mSleep(500) 
    local x, y = findColorInRegionFuzzy(modeColor, 95, 221,310,294,623); 
    if x ~= -1 then			
      tap(x,y)
      sysLog('选择喊话方式')
      mSleep(1000)			
    end 
  end	
  
  local x, y = findMultiColorInRegionFuzzy(0xf1bf72,"29|1|0xde8d3a,-3|23|0xe08431,20|17|0xe6e5da", 95, 889, 606, 1003, 706)
  if x > -1 then
    tap(420,640)
    sysLog('设置焦点')		
  end	
  
  mSleep(3000)
  
  inputText("#CLEAR#") 
  inputText(shoutText)
	sysLog('输入内容'..shoutText)
  mSleep(2000)
  
  tap(1050,670)
  mSleep(1000)
  
  local x,y,m,n = hasConfirm()
  if x > -1 then
    tap(x,y)
    --    tap(m,n)
  end  
  
  mSleep(interval)
end