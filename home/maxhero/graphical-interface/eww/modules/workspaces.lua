#!/usr/bin/env nix-shell
--[[
#! nix-shell -i luajit -p luajit luajitPackages.cjson luajitPackages.inspect
--]]
local json = require('cjson.safe')
local inspect = require('inspect')
local handle = io.popen('i3-msg -t subscribe \'["workspace"]\' > /dev/null && i3-msg -t get_workspaces')
local mapping_table = {
  ['1'] = '一',
  ['2'] = '二',
  ['3'] = '三',
  ['4'] = '四',
  ['5'] = '五',
  ['6'] = '六',
  ['7'] = '七',
  ['8'] = '八',
  ['9'] = '九',
  ['10'] = '十'
}

local mapped = {}
local output = ''
local workspaces = {}

function print_workspaces()
  mapped = {}
  handle = io.popen('i3-msg -t get_workspaces')
  output = handle:read('*a')
  workspaces = json.decode(output)
  if workspaces then
    for k, v in ipairs(workspaces) do
      v['label'] = mapping_table[v['name']]
      mapped[k] = v
    end
    print(json.encode(mapped))
  end
end

function print_workspaces_watch()
  mapped = {}
  handle = io.popen('i3-msg -t subscribe \'["workspace"]\' > /dev/null && i3-msg -t get_workspaces')
  output = handle:read('*a')
  workspaces = json.decode(output)
  if workspaces then
    for k, v in ipairs(workspaces) do
      v['label'] = mapping_table[v['name']]
      mapped[k] = v
    end
    print(json.encode(mapped))
  end
end


print_workspaces()
while true
do
  print_workspaces_watch()
end

