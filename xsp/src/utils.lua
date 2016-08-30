--工具函数

--打印table
function print_table(lua_table, indent)
  
  if lua_table == nil or type(lua_table) ~= "table" then
    return
  end
  
  local function print_func(str)
    sysLog("[table item] " .. tostring(str))
  end	
  indent = indent or 0
	
  for k, v in pairs(lua_table) do
    if type(k) == "string" then
      k = string.format("%q", k)
    end
    local szSuffix = ""
    if type(v) == "table" then
      szSuffix = "{"
    end
    local szPrefix = string.rep("    ", indent)
    formatting = szPrefix.."["..k.."]".." = "..szSuffix
    if type(v) == "table" then
      print_func(formatting)
      print_table(v, indent + 1)
      print_func(szPrefix.."},")
    else
      local szValue = ""
      if type(v) == "string" then
        szValue = string.format("%q", v)
      else
        szValue = tostring(v)
      end
      print_func(formatting..szValue..",")
    end
  end
end

--打印多个
function print_mutil(...)
  local params = {...}	
  local str = nil
  for k,v in pairs(params) do
    if not str then
      str = tostring(v)
    else
      str = str..', '..tostring(v)
    end
  end	
  if str == nil then 
    str = '参数为空'
  end
  sysLog(str)	
end

--字符串分割
function split(s, delim)
  if type(delim) ~= "string" or string.len(delim) <= 0 then
    return
  end
  
  local start = 1
  local t = {}
  while true do
    local pos = string.find (s, delim, start, true) -- plain find
    if not pos then
      break
    end
    
    table.insert (t, string.sub (s, start, pos - 1))
    start = pos + string.len (delim)
  end
  table.insert (t, string.sub (s, start))
  
  return t
end