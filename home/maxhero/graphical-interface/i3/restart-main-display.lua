#!/usr/bin/env nix-shell
--[[
#! nix-shell -i luajit -p luajit luajitPackages.cjson luajitPackages.inspect
--]]

local json = require('cjson.safe')

function get_workspaces()
  local handle = io.popen('i3-msg -t get_workspaces')
  return json.decode(handle:read('*a'))
end

function get_workspaces_to_move(display)
  local workspaces = get_workspaces()
  local moving_workspaces = {}
  for k, v in ipairs(workspaces) do
    if v['output'] == display then
      table.insert(moving_workspaces, v['name'])
    end
  end
  return moving_workspaces
end

function restart_display(display)
  local workspaces_to_move_back = get_workspaces_to_move(display)
  print(io.popen('xrandr --output ' .. display .. ' --off && xrandr --output ' .. display .. ' --left-of DP-3 --auto'):read('*a'))
  for k, workspace in ipairs(workspaces_to_move_back) do
    local cmd = 'i3-msg \'[workspace="' .. workspace .. '"]\' move workspace to output ' .. display
    local result = io.popen(cmd):read('*a')
    print(result)
  end
end

restart_display("DP-2")
