#!/usr/bin/env nix-shell
--[[
#!nix-shell -i luajit -p luajit luajitPackages.cjson luajitPackages.inspect luajitPackages.luasec luajitPackages.luasocket lua51Packages.cjson
]]
local inspect = require "inspect"
local json = require "cjson"
local http = require "socket.http"
local base_url = "https://economia.awesomeapi.com.br/json/last/"

local desired_currencies = {
  {"USD", "BRL"},
  {"USD", "JPY"},
  {"USD", "EUR"}
}

function currency_url()
  local currencies = ""
  for k, v in pairs(desired_currencies) do
    if currencies ~= "" then
      currencies = currencies .. "," .. v[1] .. "-" .. v[2]
    else
      currencies = currencies .. v[1] .. "-" .. v[2]
    end
  end
  return base_url .. currencies
end


function get_currency_ratios()
  local body, _ = http.request(currency_url())
  local response = json.decode(body)
  local output = ""
  for k, v in pairs(desired_currencies) do
    local target = v[2]
    local key = v[1] .. v[2]
    local data = response[key]
    if output ~= "" then
      output = output .. " | " .. v[1] .. "/" .. v[2] .. ": " .. data["ask"]
    else
      output = v[1] .. "/" .. v[2] .. ": " .. data["ask"]
    end
  end
  return output
end

print(get_currency_ratios())
