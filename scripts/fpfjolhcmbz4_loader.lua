-- Delta-safe chunked loader
local BASE_URL = 'https://raw.githubusercontent.com/squizpro-wq/Scripts/main/scripts/'
local CHUNKS = {"fpfjolhcmbz4_1.lua", "fpfjolhcmbz4_2.lua", "fpfjolhcmbz4_3.lua", "fpfjolhcmbz4_4.lua", "fpfjolhcmbz4_5.lua", "fpfjolhcmbz4_6.lua", "fpfjolhcmbz4_7.lua", "fpfjolhcmbz4_8.lua", "fpfjolhcmbz4_9.lua", "fpfjolhcmbz4_10.lua", "fpfjolhcmbz4_11.lua"}
local env = (getgenv and getgenv()) or (getfenv and getfenv()) or _G
for _, name in ipairs(CHUNKS) do
    local fn = loadstring(game:HttpGet(BASE_URL .. name))
    assert(fn, '[AdmLoader] failed to compile chunk ' .. name)
    if setfenv then setfenv(fn, env) end
    local ok, err = pcall(fn)
    if not ok then
        error('[AdmLoader] chunk ' .. name .. ' failed: ' .. tostring(err), 0)
    end
end
print('[AdmLoader] all ' .. #CHUNKS .. ' chunks executed.')
