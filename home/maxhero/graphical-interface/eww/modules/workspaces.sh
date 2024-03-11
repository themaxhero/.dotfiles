#!/usr/bin/env lua

local json = require('cjson')
local handle = io.popen('i3-msg -t get_workspaces')

while true
do
  local mapped = {}
  local workspaces = json.decode(handle:read('*a'))
  for k, v in ipairs(workspaces) do
    mapped[k] = table.concat(v, {['label' = 'x']})
  end
  print(json.encode(mapped))
end
