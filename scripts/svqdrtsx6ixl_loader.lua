-- Delta-safe chunked loader
local BASE_URL = 'https://raw.githubusercontent.com/squizpro-wq/Scripts/main/scripts/'
local CHUNKS = {"svqdrtsx6ixl_1.lua", "svqdrtsx6ixl_2.lua", "svqdrtsx6ixl_3.lua", "svqdrtsx6ixl_4.lua", "svqdrtsx6ixl_5.lua", "svqdrtsx6ixl_6.lua", "svqdrtsx6ixl_7.lua", "svqdrtsx6ixl_8.lua", "svqdrtsx6ixl_9.lua", "svqdrtsx6ixl_10.lua", "svqdrtsx6ixl_11.lua"}
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
