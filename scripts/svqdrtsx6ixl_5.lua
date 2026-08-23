carti230.FocusLost:Connect(function()
    local carti232 = tonumber(carti230.Text)
    if carti232 and carti232 >= 0 then carti69.AUTO_CONFIRM_DELAY = carti232 else carti230.Text = tostring(carti69.AUTO_CONFIRM_DELAY) end
end)
spectatorBox.FocusLost:Connect(function()
    local carti232 = tonumber(spectatorBox.Text)
    if carti232 and carti232 >= 0 then
        carti69.SPECTATOR_COUNT = carti232
        carti70 = carti232
        if carti74.trade then
            carti74.trade.subscriber_count = carti232
            if carti30.refresh_all then carti30:refresh_all() carti37(true) end
        end
    else
        spectatorBox.Text = tostring(carti69.SPECTATOR_COUNT)
    end
end)
carti231.FocusLost:Connect(function()
    local carti232 = tonumber(carti231.Text)
    if carti232 and carti232 >= 0 then carti69.TRADE_REQUEST_DELAY = carti232 else carti231.Text = tostring(carti69.TRADE_REQUEST_DELAY) end
end)

function carti233(text, bgColor, strokeColor, parent, onClick)
    local carti234 = Instance.new('TextButton')
    carti234.Size = UDim2.new(1, 0, 0, 26)
    carti234.BackgroundColor3 = bgColor
    carti234.BackgroundTransparency = 0.2
    carti234.Text = text
    carti234.Font = Enum.Font.FredokaOne
    carti234.TextSize = 12
    carti234.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti234.Parent = parent
    local carti227 = Instance.new('UICorner')
    carti227.CornerRadius = UDim.new(0, 4)
    carti227.Parent = carti234
    local carti228 = Instance.new('UIStroke')
    carti228.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    carti228.Color = strokeColor
    carti228.Thickness = 1.0
    carti228.Transparency = 0.3
    carti228.Parent = carti234
    if onClick then carti234.MouseButton1Click:Connect(onClick) end
    return carti234, carti228
end

function carti235(parent, height)
    local carti236 = Instance.new('Frame')
    carti236.Size = UDim2.new(1, 0, 0, height or 3)
    carti236.BackgroundTransparency = 1
    carti236.Parent = parent
    return carti236
end

carti235(carti222, 4)

-- AUTO SPECTATE BUTTON WITH RANDOM VARIATION - PROMINENT PLACEMENT
carti237 = Instance.new('TextButton')
carti237.Size = UDim2.new(1, 0, 0, 32)
carti237.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
carti237.BackgroundTransparency = 0.1
carti237.Text = '🎲 Auto Spectate: OFF'
carti237.Font = Enum.Font.FredokaOne
carti237.TextSize = 13
carti237.TextColor3 = Color3.fromRGB(255, 255, 255)
carti237.Parent = carti222
carti238 = Instance.new('UICorner')
carti238.CornerRadius = UDim.new(0, 4)
carti238.Parent = carti237
carti239 = Instance.new('UIStroke')
carti239.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
carti239.Color = Color3.fromRGB(255, 100, 100)
carti239.Thickness = 1.5
carti239.Parent = carti237

carti237.MouseButton1Click:Connect(function()
    carti69.AUTO_SPECTATE_ENABLED = not carti69.AUTO_SPECTATE_ENABLED
    
    if carti69.AUTO_SPECTATE_ENABLED then
        carti237.Text = '🎲 Auto Spectate: ON (Random)'
        carti237.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        carti239.Color = Color3.fromRGB(100, 255, 100)
        
        -- Store the current spectator count as the base
        carti70 = carti69.SPECTATOR_COUNT
        
        -- Start the auto spectate loop
        carti205()
        
        if carti32 then
            carti32:hint({ text = 'Auto Spectate ON! Range: ' .. (carti70 + carti69.SPECTATOR_VARIATION_MIN) .. '-' .. (carti70 + carti69.SPECTATOR_VARIATION_MAX), length = 3, overridable = true })
        end
    else
        carti237.Text = '🎲 Auto Spectate: OFF'
        carti237.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
        carti239.Color = Color3.fromRGB(255, 100, 100)
        
        carti206()
        
        if carti32 then
            carti32:hint({ text = 'Auto Spectate OFF', length = 2, overridable = true })
        end
    end
end)

carti235(carti222)

carti233('Add Random Item', Color3.fromRGB(100, 50, 150), Color3.fromRGB(200, 100, 255), carti222, function()
    if carti74.active and carti74.trade then
        carti105(carti80(), carti111())
    end
end)

carti235(carti222)

carti233('Clear Trade', Color3.fromRGB(150, 50, 50), Color3.fromRGB(255, 100, 100), carti222, function()
    if carti74.active and carti74.trade then
        carti74.trade.sender_offer.items = {}
        carti74.trade.recipient_offer.items = {}
        carti74.trade.sender_offer.negotiated = false
        carti74.trade.recipient_offer.negotiated = false
        carti74.trade.current_stage = 'negotiation'
        carti74.trade.offer_version = carti74.trade.offer_version + 1
        carti30:_overwrite_local_trade_state(carti74.trade)
    end
end)

carti235(carti222)

-- FIXED: Start Trade button now uses the direct function
carti233('Start Trade', Color3.fromRGB(50, 80, 60), Color3.fromRGB(0, 255, 100), carti222, function()
    if carti74.active or carti74.pendingTradeRequest then return end
    
    if carti69.SHOW_TRADE_REQUEST then
        task.spawn(carti129)
    else
        task.spawn(carti127)
    end
end)

carti233('Block Player', Color3.fromRGB(150, 50, 50), Color3.fromRGB(255, 100, 100), carti222, function()
    local carti240 = carti2:FindFirstChild(partnerBox.Text)
    if carti240 then BlockPlayer(carti240) end
end)

carti235(carti222)

function makePartnerAccept()
    if carti74.active and carti74.trade then
        if carti74.trade.current_stage == 'negotiation' then
            if not carti74.trade.recipient_offer.negotiated then
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
            if not carti74.trade.recipient_offer.confirmed then
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
    end
end

function makePartnerUnaccept()
    if carti74.active and carti74.trade then
        if carti74.trade.current_stage == 'negotiation' then
            if carti74.trade.recipient_offer.negotiated then
                carti74.trade.recipient_offer.negotiated = false
                carti74.trade.offer_version = carti74.trade.offer_version + 1
                carti30:_overwrite_local_trade_state(carti74.trade)
            end
        elseif carti74.trade.current_stage == 'confirmation' then
            if carti74.trade.recipient_offer.confirmed then
                carti74.trade.recipient_offer.confirmed = false
                carti74.trade.offer_version = carti74.trade.offer_version + 1
                carti30:_overwrite_local_trade_state(carti74.trade)
            end
        end
    end
end

carti233('Make Partner Accept', Color3.fromRGB(50, 150, 50), Color3.fromRGB(100, 255, 100), carti222, makePartnerAccept)

carti235(carti222)

carti241, carti242 = carti233('Toggle Noclip: ON', Color3.fromRGB(80, 80, 180), Color3.fromRGB(100, 100, 255), carti222, function()
    carti154.noclipEnabled = not carti154.noclipEnabled
    if carti154.noclipEnabled then
        carti241.Text = 'Toggle Noclip: ON'
        carti241.BackgroundColor3 = Color3.fromRGB(80, 80, 180)
        carti242.Color = Color3.fromRGB(100, 100, 255)
        carti194()
        carti195()
    else
        carti241.Text = 'Toggle Noclip: OFF'
        carti241.BackgroundColor3 = Color3.fromRGB(180, 80, 80)
        carti242.Color = Color3.fromRGB(255, 100, 100)
    end
end)

carti235(carti222)

carti233('Make Partner Unaccept', Color3.fromRGB(150, 50, 50), Color3.fromRGB(255, 100, 100), carti222, makePartnerUnaccept)

carti235(carti222)

carti243 = Instance.new('Frame')
carti243.Size = UDim2.new(1, 0, 0, 24)
carti243.BackgroundTransparency = 1
carti243.Parent = carti222

carti244 = Instance.new('TextLabel')
carti244.Size = UDim2.new(0.4, 0, 1, 0)
carti244.BackgroundTransparency = 1
carti244.Text = 'Fake Player Pet:'
carti244.Font = Enum.Font.SourceSansSemibold
carti244.TextSize = 10
carti244.TextColor3 = Color3.fromRGB(180, 180, 180)
carti244.TextXAlignment = Enum.TextXAlignment.Left
carti244.Parent = carti243

carti245 = {}
carti112 = { { name = 'regular', label = 'Reg', pos = 0.4 }, { name = 'neon', label = 'Neon', pos = 0.6 }, { name = 'mega', label = 'Mega', pos = 0.8 } }

for _, pt in ipairs(carti112) do
    local carti234 = Instance.new('TextButton')
    carti234.Size = UDim2.new(0.18, 0, 1, 0)
    carti234.Position = UDim2.new(pt.pos, 0, 0, 0)
    carti234.Text = pt.label
    carti234.BackgroundColor3 = pt.name == 'regular' and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(60, 60, 70)
    carti234.Font = Enum.Font.FredokaOne
    carti234.TextSize = 9
    carti234.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti234.Parent = carti243
    local carti227 = Instance.new('UICorner')
    carti227.CornerRadius = UDim.new(0, 4)
    carti227.Parent = carti234
    carti245[pt.name] = carti234
    carti234.MouseButton1Click:Connect(function()
        carti173 = pt.name
        for carti130, carti390 in pairs(carti245) do
            carti390.BackgroundColor3 = carti130 == pt.name and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(60, 60, 70)
        end
    end)
end

carti233('Spawn fake player', Color3.fromRGB(65, 50, 150), Color3.fromRGB(74, 207, 255), carti222, function()
    local carti147, carti246 = nil, nil
    if carti69.SPAWN_FAKE_PLAYER_WITH_RANDOM_PET then
        local carti247 = carti80()
        carti246 = { M = carti173 == 'mega', N = carti173 == 'neon', F = true, R = true }
        carti147 = { kind = GetKindPet(carti247) }
    end
    CreateFakePlayerCharacterFromPARTNER_NAME(carti69.PARTNER_NAME, carti2:GetUserIdFromNameAsync(carti69.PARTNER_NAME), carti147, carti246)
end)

carti235(carti222)

carti248 = Instance.new('TextButton')
carti248.Size = UDim2.new(1, 0, 0, 14)
carti248.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
carti248.BackgroundTransparency = 0.2
carti248.Text = 'Spawn with random pet: false'
carti248.Font = Enum.Font.FredokaOne
carti248.TextSize = 7
carti248.TextColor3 = Color3.fromRGB(255, 255, 255)
carti248.Parent = carti222
carti249 = Instance.new('UICorner')
carti249.CornerRadius = UDim.new(0, 3)
carti249.Parent = carti248
carti250 = Instance.new('UIStroke')
carti250.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
carti250.Color = Color3.fromRGB(255, 100, 100)
carti250.Thickness = 0.8
carti250.Transparency = 0.3
carti250.Parent = carti248

carti248.MouseButton1Click:Connect(function()
    carti69.SPAWN_FAKE_PLAYER_WITH_RANDOM_PET = not carti69.SPAWN_FAKE_PLAYER_WITH_RANDOM_PET
    carti248.Text = 'Spawn with random pet: ' .. (carti69.SPAWN_FAKE_PLAYER_WITH_RANDOM_PET and 'true' or 'false')
    if carti69.SPAWN_FAKE_PLAYER_WITH_RANDOM_PET then
        carti248.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        carti250.Color = Color3.fromRGB(100, 255, 100)
    else
        carti248.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
        carti250.Color = Color3.fromRGB(255, 100, 100)
    end
end)

carti235(carti222)

carti251 = Instance.new('TextButton')
carti251.Size = UDim2.new(1, 0, 0, 14)
carti251.BackgroundColor3 = Color3.fromRGB(157, 58, 0)
carti251.BackgroundTransparency = 0.2
carti251.Text = 'Delete all fake players'
carti251.Font = Enum.Font.FredokaOne
carti251.TextSize = 7
carti251.TextColor3 = Color3.fromRGB(255, 255, 255)
carti251.Parent = carti222
carti252 = Instance.new('UICorner')
carti252.CornerRadius = UDim.new(0, 3)
carti252.Parent = carti251

carti251.MouseButton1Click:Connect(function()
    pcall(function()
        carti164:Stop()
        for _, carti147 in ipairs(carti160) do
            if carti147 and carti147.model then
                pcall(function()
                    carti161('pet_char_wrappers', function(petWrappers)
                        for i = #petWrappers, 1, -1 do
                            if petWrappers[i].pet_unique == carti147.wrapper.pet_unique then table.remove(petWrappers, i) end
                        end
                        return petWrappers
                    end)
                end)
                pcall(function()
                    carti161('pet_state_managers', function(petStates)
                        for i = #petStates, 1, -1 do
                            if petStates[i].char == carti147.model then table.remove(petStates, i) end
                        end
                        return petStates
                    end)
                end)
            end
        end
        for _, folder in pairs(carti159) do if folder and folder.Parent then folder:Destroy() end end
        carti159 = {}
        carti160 = {}
        carti8 = {}
        _G.fakePlayerIds = {}
        print('✅ All fake players and pets deleted successfully')
    end)
end)

carti235(carti222)

carti253, carti254 = carti233('Remove Partner Pets: OFF', Color3.fromRGB(150, 50, 50), Color3.fromRGB(255, 100, 100), carti222, function()
    carti74.removePartnerPetsOnConfirm = not carti74.removePartnerPetsOnConfirm
    carti69.REMOVE_PARTNER_PETS_ON_CONFIRM = carti74.removePartnerPetsOnConfirm
    if carti74.removePartnerPetsOnConfirm then
        carti253.Text = 'Remove Partner Pets: ON'
        carti253.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        carti254.Color = Color3.fromRGB(100, 255, 100)
    else
        carti253.Text = 'Remove Partner Pets: OFF'
        carti253.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
        carti254.Color = Color3.fromRGB(255, 100, 100)
    end
end)

-- ==================== PLAYERS TAB ====================
carti255 = carti155['Players']

carti256 = Instance.new('TextBox')
carti256.Size = UDim2.new(1, 0, 0, 26)
carti256.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
carti256.BackgroundTransparency = 0.2
carti256.Text = ''
carti256.PlaceholderText = 'Search players...'
carti256.Font = Enum.Font.SourceSans
carti256.TextSize = 12
carti256.TextColor3 = Color3.fromRGB(255, 255, 255)
carti256.ClearTextOnFocus = false
carti256.TextXAlignment = Enum.TextXAlignment.Left
carti256.Parent = carti255
Instance.new('UICorner', carti256).CornerRadius = UDim.new(0, 4)

carti257 = Instance.new('Frame')
carti257.Size = UDim2.new(1, 0, 0, 26)
carti257.Position = UDim2.new(0, 0, 0, 30)
carti257.BackgroundTransparency = 1
carti257.Parent = carti255

carti258 = Instance.new('TextButton')
carti258.Size = UDim2.new(0.48, 0, 1, 0)
carti258.BackgroundColor3 = Color3.fromRGB(65, 65, 81)
carti258.BackgroundTransparency = 0.2
carti258.Text = 'Select Players'
carti258.Font = Enum.Font.FredokaOne
carti258.TextSize = 10
carti258.TextColor3 = Color3.fromRGB(255, 255, 255)
carti258.Parent = carti257
Instance.new('UICorner', carti258).CornerRadius = UDim.new(0, 4)
carti259 = Instance.new('UIStroke')
carti259.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
carti259.Color = Color3.fromRGB(159, 159, 159)
carti259.Thickness = 1.0
carti259.Parent = carti258

carti260 = Instance.new('TextButton')
carti260.Size = UDim2.new(0.48, 0, 1, 0)
carti260.Position = UDim2.new(0.52, 0, 0, 0)
carti260.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
carti260.BackgroundTransparency = 0.2
carti260.Text = 'Block Selected'
carti260.Font = Enum.Font.FredokaOne
carti260.TextSize = 10
carti260.TextColor3 = Color3.fromRGB(255, 255, 255)
carti260.Parent = carti257
Instance.new('UICorner', carti260).CornerRadius = UDim.new(0, 4)

carti261 = Instance.new('ScrollingFrame')
carti261.Size = UDim2.new(1, 0, 0, 250)
carti261.Position = UDim2.new(0, 0, 0, 60)
carti261.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
carti261.BackgroundTransparency = 0.5
carti261.BorderSizePixel = 0
carti261.ScrollBarThickness = 4
carti261.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
carti261.ScrollBarImageTransparency = 0.5
carti261.Parent = carti255
Instance.new('UICorner', carti261).CornerRadius = UDim.new(0, 4)

carti262 = Instance.new('UIListLayout')
carti262.SortOrder = Enum.SortOrder.LayoutOrder
carti262.Padding = UDim.new(0, 3)
carti262.Parent = carti261

carti263 = Instance.new('UIPadding')
carti263.PaddingTop = UDim.new(0, 4)
carti263.PaddingBottom = UDim.new(0, 4)
carti263.PaddingLeft = UDim.new(0, 4)
carti263.PaddingRight = UDim.new(0, 4)
carti263.Parent = carti261

-- ==================== TOP 35 RICHEST SECTION WITH AUTOMATIC REFRESH ====================
carti264 = Instance.new('TextLabel')
carti264.Size = UDim2.new(1, 0, 0, 18)
carti264.Position = UDim2.new(0, 0, 0, 315)
carti264.BackgroundTransparency = 1
carti264.Text = '💰 Top 35 Richest Players (Auto-Refresh)'
carti264.Font = Enum.Font.FredokaOne
carti264.TextSize = 11
carti264.TextColor3 = Color3.fromRGB(255, 215, 0)
carti264.TextXAlignment = Enum.TextXAlignment.Left
carti264.Parent = carti255

carti265 = Instance.new('TextButton')
carti265.Size = UDim2.new(0.3, 0, 0, 18)
carti265.Position = UDim2.new(0.7, 0, 0, 315)
carti265.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
carti265.BackgroundTransparency = 0.2
carti265.Text = 'Auto: ON'
carti265.Font = Enum.Font.FredokaOne
carti265.TextSize = 8
carti265.TextColor3 = Color3.fromRGB(255, 255, 255)
carti265.Parent = carti255
Instance.new('UICorner', carti265).CornerRadius = UDim.new(0, 4)

carti266 = Instance.new('TextButton')
carti266.Size = UDim2.new(0.3, 0, 0, 18)
carti266.Position = UDim2.new(0.35, 0, 0, 315)
carti266.BackgroundColor3 = Color3.fromRGB(50, 120, 50)
carti266.BackgroundTransparency = 0.2
carti266.Text = '🔄 Manual'
carti266.Font = Enum.Font.FredokaOne
carti266.TextSize = 8
carti266.TextColor3 = Color3.fromRGB(255, 255, 255)
carti266.Parent = carti255
Instance.new('UICorner', carti266).CornerRadius = UDim.new(0, 4)

carti267 = Instance.new('ScrollingFrame')
carti267.Size = UDim2.new(1, 0, 0, 320)
carti267.Position = UDim2.new(0, 0, 0, 337)
carti267.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
carti267.BackgroundTransparency = 0.5
carti267.BorderSizePixel = 0
carti267.ScrollBarThickness = 4
carti267.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
carti267.ScrollBarImageTransparency = 0.5
carti267.Parent = carti255
Instance.new('UICorner', carti267).CornerRadius = UDim.new(0, 4)

carti268 = Instance.new('UIListLayout')
carti268.SortOrder = Enum.SortOrder.LayoutOrder
carti268.Padding = UDim.new(0, 3)
carti268.Parent = carti267

carti269 = Instance.new('UIPadding')
carti269.PaddingTop = UDim.new(0, 4)
carti269.PaddingBottom = UDim.new(0, 4)
carti269.PaddingLeft = UDim.new(0, 4)
carti269.PaddingRight = UDim.new(0, 4)
carti269.Parent = carti267

carti270 = {
    autoRefreshEnabled = true,
    playerCache = {},
    isRefreshing = false,
    lastRefreshTime = 0,
    REFRESH_COOLDOWN = 2,
    playerContainers = {}
}

function carti271()
    local carti272 = {}
    for _, child in ipairs(carti267:GetChildren()) do
        if child:IsA('Frame') and child.Name:sub(1, 14) == 'RichestPlayer_' then
            carti272[child.Name:sub(15)] = true
        end
    end
    return carti272
end

function carti273(playerName)
    for _, child in ipairs(carti267:GetChildren()) do
        if child:IsA('Frame') and child.Name == 'RichestPlayer_' .. playerName then
            child:Destroy()
        end
    end
    carti270.playerContainers[playerName] = nil
    carti270.playerCache[playerName] = nil
    carti158[playerName] = nil
end

function carti274()
    task.wait(0.05)
    local carti275 = 8
    for _, child in ipairs(carti267:GetChildren()) do
        if child:IsA('Frame') then
            carti275 = carti275 + child.AbsoluteSize.Y + 3
        end
    end
    carti267.CanvasSize = UDim2.new(0, 0, 0, carti275)
end
