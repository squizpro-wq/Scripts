
carti154.installLocalPetEquipFlow()

pcall(function()
    local carti453 = (getgenv and getgenv()) or _G
    if carti453.CartiHubRealTradePetTransferWatcher then
        carti453.CartiHubRealTradePetTransferWatcher.Enabled = false
        carti453.CartiHubRealTradePetTransferWatcher = nil
    end
end)

-- Remove a client-spawned pet after it has been transferred through a fake trade.
carti154.removeTransferredLocalPets = function(carti453)
    if type(carti453) ~= 'table' or next(carti453) == nil then
        return 0
    end

    local carti454 = carti154.nativeLocalPetUnique
    if carti454 and carti453[carti454] then
        if carti154.setNativeLocalPetRiding then
            carti154.setNativeLocalPetRiding(false)
        end
        if carti154.clearNativeLocalPetHeld then
            carti154.clearNativeLocalPetHeld()
        end
        if carti154.clearLocalPetEquipState then
            carti154.clearLocalPetEquipState()
        end
    end

    local carti455 = 0
    carti161('inventory', function(carti456)
        carti456.pets = carti456.pets or {}
        for carti457 in pairs(carti453) do
            local carti458 = carti456.pets[carti457]
            if carti458 and carti458.carti_hub_local_pet then
                carti456.pets[carti457] = nil
                carti455 += 1
            end
        end
        return carti456
    end)
    return carti455
end

carti154.addReceivedFakeTradePets = function(carti453)
    if type(carti453) ~= 'table' then
        return 0
    end

    local carti454 = 0
    carti161('inventory', function(carti455)
        carti455.pets = carti455.pets or {}
        for _, carti456 in ipairs(carti453) do
            local carti457 = carti456 and (carti456.kind or carti456.id)
            if carti456 and carti456.category == 'pets' and carti457 and carti26.pets and carti26.pets[carti457] then
                local carti458 = '2_' .. carti7:GenerateGUID(false)
                carti455.pets[carti458] = {
                    unique = carti458,
                    category = 'pets',
                    carti_hub_local_pet = true,
                    id = carti457,
                    kind = carti457,
                    properties = carti24.deep_copy(carti456.properties or {}),
                    newness_order = os.time() * 1000 + carti454,
                }
                carti454 += 1
            end
        end
        return carti455
    end)

    if carti454 > 0 and carti154.organizeSpawnedPets then
        carti154.organizeSpawnedPets(carti53)
    end
    return carti454
end

pcall(function()
    local carti459 = (getgenv and getgenv()) or _G
    carti459.CartiHubRemoveTransferredLocalPets = carti154.removeTransferredLocalPets
    carti459.CartiHubAddReceivedFakeTradePets = carti154.addReceivedFakeTradePets
end)

-- ==================== USERS TAB ====================
carti349 = carti155['Users']

carti350 = Instance.new('TextBox')
carti350.Size = UDim2.new(1, 0, 0, 26)
carti350.Position = UDim2.new(0, 0, 0, 0)
carti350.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
carti350.BackgroundTransparency = 0.2
carti350.Text = ''
carti350.PlaceholderText = 'Search users...'
carti350.Font = Enum.Font.SourceSans
carti350.TextSize = 12
carti350.TextColor3 = Color3.fromRGB(255, 255, 255)
carti350.ClearTextOnFocus = false
carti350.TextXAlignment = Enum.TextXAlignment.Left
carti350.Parent = carti349
Instance.new('UICorner', carti350).CornerRadius = UDim.new(0, 4)

carti351 = Instance.new('ScrollingFrame')
carti351.Size = UDim2.new(1, 0, 0, 180)
carti351.Position = UDim2.new(0, 0, 0, 30)
carti351.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
carti351.BackgroundTransparency = 0.5
carti351.BorderSizePixel = 0
carti351.ScrollBarThickness = 4
carti351.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
carti351.ScrollBarImageTransparency = 0.5
carti351.Parent = carti349
Instance.new('UICorner', carti351).CornerRadius = UDim.new(0, 4)

carti352 = Instance.new('UIListLayout')
carti352.SortOrder = Enum.SortOrder.LayoutOrder
carti352.Padding = UDim.new(0, 3)
carti352.Parent = carti351

carti353 = Instance.new('UIPadding')
carti353.PaddingTop = UDim.new(0, 4)
carti353.PaddingBottom = UDim.new(0, 4)
carti353.PaddingLeft = UDim.new(0, 4)
carti353.PaddingRight = UDim.new(0, 4)
carti353.Parent = carti351

carti354 = Instance.new('TextLabel')
carti354.Size = UDim2.new(1, 0, 0, 16)
carti354.Position = UDim2.new(0, 0, 0, 215)
carti354.BackgroundTransparency = 1
carti354.Text = 'Chat Messages'
carti354.Font = Enum.Font.SourceSansSemibold
carti354.TextSize = 11
carti354.TextColor3 = Color3.fromRGB(180, 180, 180)
carti354.TextXAlignment = Enum.TextXAlignment.Left
carti354.Parent = carti349

carti355 = Instance.new('TextBox')
carti355.Size = UDim2.new(1, 0, 0, 26)
carti355.Position = UDim2.new(0, 0, 0, 233)
carti355.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
carti355.BackgroundTransparency = 0.2
carti355.Text = ''
carti355.PlaceholderText = 'Enter custom message...'
carti355.Font = Enum.Font.SourceSans
carti355.TextSize = 12
carti355.TextColor3 = Color3.fromRGB(255, 255, 255)
carti355.ClearTextOnFocus = false
carti355.TextXAlignment = Enum.TextXAlignment.Left
carti355.Parent = carti349
Instance.new('UICorner', carti355).CornerRadius = UDim.new(0, 4)

carti356 = Instance.new('TextButton')
carti356.Size = UDim2.new(1, 0, 0, 26)
carti356.Position = UDim2.new(0, 0, 0, 263)
carti356.BackgroundColor3 = Color3.fromRGB(50, 120, 50)
carti356.BackgroundTransparency = 0.2
carti356.Text = 'Send Chat Message'
carti356.Font = Enum.Font.FredokaOne
carti356.TextSize = 12
carti356.TextColor3 = Color3.fromRGB(255, 255, 255)
carti356.Parent = carti349
Instance.new('UICorner', carti356).CornerRadius = UDim.new(0, 4)

carti356.MouseButton1Click:Connect(function()
    local carti357 = carti355.Text
    if carti357 and carti357 ~= '' then
        carti116(carti357)
        carti355.Text = ''
    end
end)

carti358 = Instance.new('TextLabel')
carti358.Size = UDim2.new(1, 0, 0, 16)
carti358.Position = UDim2.new(0, 0, 0, 295)
carti358.BackgroundTransparency = 1
carti358.Text = 'Quick Messages'
carti358.Font = Enum.Font.SourceSansSemibold
carti358.TextSize = 11
carti358.TextColor3 = Color3.fromRGB(180, 180, 180)
carti358.TextXAlignment = Enum.TextXAlignment.Left
carti358.Parent = carti349

carti359 = Instance.new('ScrollingFrame')
carti359.Size = UDim2.new(1, 0, 0, 300)
carti359.Position = UDim2.new(0, 0, 0, 313)
carti359.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
carti359.BackgroundTransparency = 0.5
carti359.BorderSizePixel = 0
carti359.ScrollBarThickness = 4
carti359.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
carti359.ScrollBarImageTransparency = 0.5
carti359.Parent = carti349
Instance.new('UICorner', carti359).CornerRadius = UDim.new(0, 4)

carti360 = Instance.new('UIListLayout')
carti360.SortOrder = Enum.SortOrder.LayoutOrder
carti360.Padding = UDim.new(0, 3)
carti360.Parent = carti359

carti361 = Instance.new('UIPadding')
carti361.PaddingTop = UDim.new(0, 4)
carti361.PaddingBottom = UDim.new(0, 4)
carti361.PaddingLeft = UDim.new(0, 4)
carti361.PaddingRight = UDim.new(0, 4)
carti361.Parent = carti359

for i, carti357 in ipairs(carti69.CHAT_MESSAGES) do
    local carti315 = Instance.new('TextButton')
    carti315.Size = UDim2.new(1, -8, 0, 24)
    carti315.BackgroundColor3 = Color3.fromRGB(55, 50, 75)
    carti315.BackgroundTransparency = 0.1
    carti315.Text = '  ' .. carti357
    carti315.Font = Enum.Font.GothamMedium
    carti315.TextSize = 10
    carti315.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti315.TextTruncate = Enum.TextTruncate.AtEnd
    carti315.TextXAlignment = Enum.TextXAlignment.Left
    carti315.LayoutOrder = i
    carti315.Parent = carti359
    Instance.new('UICorner', carti315).CornerRadius = UDim.new(0, 5)
    
    local carti316 = Instance.new('UIStroke')
    carti316.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    carti316.Color = Color3.fromRGB(255, 200, 50)
    carti316.Thickness = 1.5
    carti316.Transparency = 0.2
    carti316.Parent = carti315

    carti315.MouseEnter:Connect(function()
        carti6:Create(carti315, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(70, 65, 95) }):Play()
        carti6:Create(carti316, TweenInfo.new(0.15), { Color = Color3.fromRGB(255, 220, 80), Transparency = 0 }):Play()
    end)
    
    carti315.MouseLeave:Connect(function()
        carti6:Create(carti315, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(55, 50, 75) }):Play()
        carti6:Create(carti316, TweenInfo.new(0.15), { Color = Color3.fromRGB(255, 200, 50), Transparency = 0.2 }):Play()
    end)

    carti315.MouseButton1Click:Connect(function()
        carti116(carti357)
    end)
end

carti359.CanvasSize = UDim2.new(0, 0, 0, (#carti69.CHAT_MESSAGES * 27) + 8)

function carti362(username, index)
    local carti315 = Instance.new('TextButton')
    carti315.Size = UDim2.new(1, -8, 0, 28)
    carti315.BackgroundColor3 = Color3.fromRGB(55, 50, 75)
    carti315.BackgroundTransparency = 0.1
    carti315.Text = '  ' .. username
    carti315.Font = Enum.Font.GothamBold
    carti315.TextSize = 11
    carti315.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti315.TextXAlignment = Enum.TextXAlignment.Left
    carti315.LayoutOrder = index
    carti315.Parent = carti351
    Instance.new('UICorner', carti315).CornerRadius = UDim.new(0, 6)
    
    local carti316 = Instance.new('UIStroke')
    carti316.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    carti316.Color = Color3.fromRGB(255, 200, 50)
    carti316.Thickness = 1.5
    carti316.Transparency = 0.2
    carti316.Parent = carti315

    carti315.MouseEnter:Connect(function()
        carti6:Create(carti315, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(70, 65, 95) }):Play()
        carti6:Create(carti316, TweenInfo.new(0.2), { Color = Color3.fromRGB(255, 220, 80), Transparency = 0 }):Play()
    end)
    
    carti315.MouseLeave:Connect(function()
        carti6:Create(carti315, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(55, 50, 75) }):Play()
        carti6:Create(carti316, TweenInfo.new(0.2), { Color = Color3.fromRGB(255, 200, 50), Transparency = 0.2 }):Play()
    end)

    carti315.MouseButton1Click:Connect(function()
        setActiveTab('Control')
        partnerBox.Text = username
        updatePartnerFromUsername(username)
    end)

    return carti315
end

function carti363()
    for _, child in ipairs(carti351:GetChildren()) do
        if child:IsA('TextButton') then child:Destroy() end
    end
    carti154.userListButtons = {}

    local carti324 = carti350.Text:lower()
    local carti364 = {}
    for _, username in ipairs(carti78) do
        if carti324 == '' or username:lower():sub(1, #carti324) == carti324 then
            table.insert(carti364, username)
        end
    end
    table.sort(carti364, function(a, carti390) return a:lower() < carti390:lower() end)

    for i, username in ipairs(carti364) do
        local carti315 = carti362(username, i)
        table.insert(carti154.userListButtons, carti315)
    end
    carti351.CanvasSize = UDim2.new(0, 0, 0, (#carti364 * 29) + 8)
end

carti350:GetPropertyChangedSignal("Text"):Connect(carti363)
carti363()

-- ==================== RGB STATE (defined early for Sets tab access) ====================
carti365 = { hue = 0, speed = 0.5, enabled = true }

-- ==================== SETS TAB (KEYBINDS) ====================
carti366 = carti155['Sets']
carti367 = { keybindButtons = {}, currentScale = 1.0 }

do
    local carti368 = Instance.new('UIListLayout')
    carti368.SortOrder = Enum.SortOrder.LayoutOrder
    carti368.Padding = UDim.new(0, 6)
    carti368.Parent = carti366
    
    local carti369 = Instance.new('UIPadding')
    carti369.PaddingTop = UDim.new(0, 8)
    carti369.PaddingLeft = UDim.new(0, 4)
    carti369.PaddingRight = UDim.new(0, 4)
    carti369.Parent = carti366
    
    local carti225 = Instance.new('TextLabel')
    carti225.Size = UDim2.new(1, 0, 0, 20)
    carti225.BackgroundTransparency = 1
    carti225.Text = '⌨️ Keybind Settings'
    carti225.Font = Enum.Font.GothamBold
    carti225.TextSize = 14
    carti225.TextColor3 = Color3.fromRGB(255, 200, 50)
    carti225.TextXAlignment = Enum.TextXAlignment.Center
    carti225.LayoutOrder = 0
    carti225.Parent = carti366
end

function carti370(labelText, keybindKey, layoutOrder)
    local carti371 = Instance.new('Frame')
    carti371.Size = UDim2.new(1, 0, 0, 36)
    carti371.BackgroundColor3 = Color3.fromRGB(55, 50, 75)
    carti371.BackgroundTransparency = 0.1
    carti371.LayoutOrder = layoutOrder
    carti371.Parent = carti366
    Instance.new('UICorner', carti371).CornerRadius = UDim.new(0, 6)
    
    local carti228 = Instance.new('UIStroke')
    carti228.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    carti228.Color = Color3.fromRGB(255, 200, 50)
    carti228.Thickness = 1.5
    carti228.Transparency = 0.2
    carti228.Parent = carti371
    
    local carti372 = Instance.new('TextLabel')
    carti372.Size = UDim2.new(0.6, 0, 1, 0)
    carti372.Position = UDim2.new(0, 8, 0, 0)
    carti372.BackgroundTransparency = 1
    carti372.Text = labelText
    carti372.Font = Enum.Font.GothamMedium
    carti372.TextSize = 11
    carti372.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti372.TextXAlignment = Enum.TextXAlignment.Left
    carti372.Parent = carti371
    
    local carti234 = Instance.new('TextButton')
    carti234.Size = UDim2.new(0.35, -8, 0, 26)
    carti234.Position = UDim2.new(0.65, 0, 0.5, -13)
    carti234.BackgroundColor3 = Color3.fromRGB(70, 65, 95)
    carti234.BackgroundTransparency = 0.1
    carti234.Text = carti154.keybinds[keybindKey].Name
    carti234.Font = Enum.Font.GothamBold
    carti234.TextSize = 11
    carti234.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti234.Parent = carti371
    Instance.new('UICorner', carti234).CornerRadius = UDim.new(0, 4)
    Instance.new('UIStroke', carti234).Color = Color3.fromRGB(100, 100, 150)
    
    carti367.keybindButtons[keybindKey] = carti234
    
    carti234.MouseEnter:Connect(function()
        if carti154.waitingForKeybind ~= keybindKey then
            carti6:Create(carti234, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(90, 85, 120) }):Play()
        end
    end)
    carti234.MouseLeave:Connect(function()
        if carti154.waitingForKeybind ~= keybindKey then
            carti6:Create(carti234, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(70, 65, 95) }):Play()
        end
    end)
    carti234.MouseButton1Click:Connect(function()
        if carti154.waitingForKeybind then
            local carti373 = carti367.keybindButtons[carti154.waitingForKeybind]
            if carti373 then carti373.Text = carti154.keybinds[carti154.waitingForKeybind].Name; carti373.BackgroundColor3 = Color3.fromRGB(70, 65, 95) end
        end
        carti154.waitingForKeybind = keybindKey
        carti234.Text = '...'
        carti234.BackgroundColor3 = Color3.fromRGB(100, 80, 150)
    end)
    return carti371
end

carti370('Select Partner from Trade', 'selectPartner', 1)
carti370('Add Random Item', 'addRandomItem', 2)
carti370('Start Trade', 'startTrade', 3)
carti370('Block Player', 'blockPlayer', 4)

-- RGB Speed Section (using do-end to limit scope)
do
    local carti236 = Instance.new('Frame')
    carti236.Size = UDim2.new(1, 0, 0, 10)
    carti236.BackgroundTransparency = 1
    carti236.LayoutOrder = 10
    carti236.Parent = carti366
    
    local carti225 = Instance.new('TextLabel')
    carti225.Size = UDim2.new(1, 0, 0, 18)
    carti225.BackgroundTransparency = 1
    carti225.Text = '🌈 RGB Settings'
    carti225.Font = Enum.Font.GothamBold
    carti225.TextSize = 12
    carti225.TextColor3 = Color3.fromRGB(255, 200, 50)
    carti225.TextXAlignment = Enum.TextXAlignment.Center
    carti225.LayoutOrder = 11
    carti225.Parent = carti366
    
    local carti371 = Instance.new('Frame')
    carti371.Size = UDim2.new(1, 0, 0, 36)
    carti371.BackgroundColor3 = Color3.fromRGB(55, 50, 75)
    carti371.BackgroundTransparency = 0.1
    carti371.LayoutOrder = 12
    carti371.Parent = carti366
    Instance.new('UICorner', carti371).CornerRadius = UDim.new(0, 6)
    
    local carti228 = Instance.new('UIStroke')
    carti228.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    carti228.Color = Color3.fromRGB(255, 200, 50)
    carti228.Thickness = 1.5
    carti228.Transparency = 0.2
    carti228.Parent = carti371
    
    local carti372 = Instance.new('TextLabel')
    carti372.Size = UDim2.new(0.5, 0, 1, 0)
    carti372.Position = UDim2.new(0, 8, 0, 0)
    carti372.BackgroundTransparency = 1
    carti372.Text = 'RGB Speed'
    carti372.Font = Enum.Font.GothamMedium
    carti372.TextSize = 11
    carti372.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti372.TextXAlignment = Enum.TextXAlignment.Left
    carti372.Parent = carti371
    
    local carti374 = Instance.new('TextBox')
    carti374.Size = UDim2.new(0.2, 0, 0, 24)
    carti374.Position = UDim2.new(0.5, 0, 0.5, -12)
    carti374.BackgroundColor3 = Color3.fromRGB(70, 65, 95)
    carti374.Text = '0.5'
    carti374.Font = Enum.Font.GothamBold
    carti374.TextSize = 11
    carti374.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti374.Parent = carti371
    Instance.new('UICorner', carti374).CornerRadius = UDim.new(0, 4)
    
    local carti375 = Instance.new('TextButton')
    carti375.Size = UDim2.new(0, 26, 0, 24)
    carti375.Position = UDim2.new(0.72, 0, 0.5, -12)
    carti375.BackgroundColor3 = Color3.fromRGB(150, 60, 60)
    carti375.Text = '-'
    carti375.Font = Enum.Font.GothamBold
    carti375.TextSize = 14
    carti375.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti375.Parent = carti371
    Instance.new('UICorner', carti375).CornerRadius = UDim.new(0, 4)
    
    local carti376 = Instance.new('TextButton')
    carti376.Size = UDim2.new(0, 26, 0, 24)
    carti376.Position = UDim2.new(0.86, 0, 0.5, -12)
    carti376.BackgroundColor3 = Color3.fromRGB(60, 150, 60)
    carti376.Text = '+'
    carti376.Font = Enum.Font.GothamBold
    carti376.TextSize = 14
    carti376.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti376.Parent = carti371
    Instance.new('UICorner', carti376).CornerRadius = UDim.new(0, 4)
    
    carti375.MouseButton1Click:Connect(function()
        local carti377 = math.max(0.1, (tonumber(carti374.Text) or 0.5) - 0.1)
        carti374.Text = string.format('%.1f', carti377)
        carti365.speed = carti377
    end)
    carti376.MouseButton1Click:Connect(function()
        local carti377 = math.min(2.0, (tonumber(carti374.Text) or 0.5) + 0.1)
        carti374.Text = string.format('%.1f', carti377)
        carti365.speed = carti377
    end)
    carti374.FocusLost:Connect(function()
        local carti378 = tonumber(carti374.Text)
        if carti378 then
            carti378 = math.clamp(carti378, 0.1, 2.0)
            carti374.Text = string.format('%.1f', carti378)
            carti365.speed = carti378
        else
            carti374.Text = '0.5'
            carti365.speed = 0.5
        end
    end)
end

-- Server Uptime Section (using do-end to limit scope)
do
    local carti236 = Instance.new('Frame')
    carti236.Size = UDim2.new(1, 0, 0, 10)
    carti236.BackgroundTransparency = 1
    carti236.LayoutOrder = 13
    carti236.Parent = carti366
    
    local carti225 = Instance.new('TextLabel')
    carti225.Size = UDim2.new(1, 0, 0, 18)
    carti225.BackgroundTransparency = 1
    carti225.Text = '🕐 Server Info'
    carti225.Font = Enum.Font.GothamBold
    carti225.TextSize = 12
    carti225.TextColor3 = Color3.fromRGB(255, 200, 50)
    carti225.TextXAlignment = Enum.TextXAlignment.Center
    carti225.LayoutOrder = 14
    carti225.Parent = carti366
    
    local carti371 = Instance.new('Frame')
    carti371.Size = UDim2.new(1, 0, 0, 36)
    carti371.BackgroundColor3 = Color3.fromRGB(55, 50, 75)
    carti371.BackgroundTransparency = 0.1
    carti371.LayoutOrder = 15
    carti371.Parent = carti366
    Instance.new('UICorner', carti371).CornerRadius = UDim.new(0, 6)
    
    local carti228 = Instance.new('UIStroke')
    carti228.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    carti228.Color = Color3.fromRGB(255, 200, 50)
    carti228.Thickness = 1.5
    carti228.Transparency = 0.2
    carti228.Parent = carti371
    
    local carti372 = Instance.new('TextLabel')
    carti372.Size = UDim2.new(0.45, 0, 1, 0)
    carti372.Position = UDim2.new(0, 8, 0, 0)
    carti372.BackgroundTransparency = 1
    carti372.Text = 'Server Uptime'
    carti372.Font = Enum.Font.GothamMedium
    carti372.TextSize = 11
    carti372.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti372.TextXAlignment = Enum.TextXAlignment.Left
    carti372.Parent = carti371
    
    local carti285 = Instance.new('TextLabel')
    carti285.Size = UDim2.new(0.5, -8, 1, 0)
    carti285.Position = UDim2.new(0.5, 0, 0, 0)
    carti285.BackgroundTransparency = 1
    carti285.Text = '0h 0m 0s'
    carti285.Font = Enum.Font.GothamBold
    carti285.TextSize = 11
    carti285.TextColor3 = Color3.fromRGB(100, 255, 150)
    carti285.TextXAlignment = Enum.TextXAlignment.Right
    carti285.Parent = carti371
    
    task.spawn(function()
        while true do
            local carti379 = workspace.DistributedGameTime
            carti285.Text = string.format('%dh %dm %ds', math.floor(carti379/3600), math.floor((carti379%3600)/60), math.floor(carti379%60))
            task.wait(1)
        end
    end)
end

-- Mobile GUI Size Section (using do-end to limit scope)
do
    local carti236 = Instance.new('Frame')
    carti236.Size = UDim2.new(1, 0, 0, 10)
    carti236.BackgroundTransparency = 1
    carti236.LayoutOrder = 16
    carti236.Parent = carti366
    
    local carti225 = Instance.new('TextLabel')
    carti225.Size = UDim2.new(1, 0, 0, 18)
    carti225.BackgroundTransparency = 1
    carti225.Text = '📱 GUI Size (Mobile)'
    carti225.Font = Enum.Font.GothamBold
    carti225.TextSize = 12
    carti225.TextColor3 = Color3.fromRGB(255, 200, 50)
    carti225.TextXAlignment = Enum.TextXAlignment.Center
    carti225.LayoutOrder = 17
    carti225.Parent = carti366
    
    local carti371 = Instance.new('Frame')
    carti371.Size = UDim2.new(1, 0, 0, 40)
    carti371.BackgroundTransparency = 1
    carti371.LayoutOrder = 18
    carti371.Parent = carti366
    
    local carti380 = Instance.new('TextButton')
    carti380.Size = UDim2.new(0.48, 0, 1, 0)
    carti380.Position = UDim2.new(0, 0, 0, 0)
    carti380.BackgroundColor3 = Color3.fromRGB(80, 60, 120)
    carti380.Text = '🔍 Small'
    carti380.Font = Enum.Font.GothamBold
    carti380.TextSize = 12
    carti380.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti380.Parent = carti371
    Instance.new('UICorner', carti380).CornerRadius = UDim.new(0, 6)
    local carti381 = Instance.new('UIStroke', carti380)
    carti381.Color = Color3.fromRGB(255, 200, 50)
    carti381.Thickness = 1.5
    carti381.Transparency = 0.2
    
    local carti382 = Instance.new('TextButton')
    carti382.Size = UDim2.new(0.48, 0, 1, 0)
    carti382.Position = UDim2.new(0.52, 0, 0, 0)
    carti382.BackgroundColor3 = Color3.fromRGB(60, 120, 80)
    carti382.Text = '🔎 Big'
    carti382.Font = Enum.Font.GothamBold
    carti382.TextSize = 12
    carti382.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti382.Parent = carti371
    Instance.new('UICorner', carti382).CornerRadius = UDim.new(0, 6)
    local carti383 = Instance.new('UIStroke', carti382)
    carti383.Color = Color3.fromRGB(255, 200, 50)
    carti383.Thickness = 1.5
    carti383.Transparency = 0.2
    
    -- Create UIScale for proper scaling
    local carti384 = carti208:FindFirstChild('UIScale') or Instance.new('UIScale')
    carti384.Name = 'UIScale'
    carti384.Parent = carti208
    
    carti380.MouseButton1Click:Connect(function()
        carti367.currentScale = math.max(0.7, carti367.currentScale - 0.05)
        carti384.Scale = carti367.currentScale
        if carti32 then carti32:hint({ text = 'GUI Scale: ' .. string.format('%.0f%%', carti367.currentScale * 100), length = 1, overridable = true }) end
    end)
    
    carti382.MouseButton1Click:Connect(function()
        carti367.currentScale = math.min(1.3, carti367.currentScale + 0.05)
        carti384.Scale = carti367.currentScale
        if carti32 then carti32:hint({ text = 'GUI Scale: ' .. string.format('%.0f%%', carti367.currentScale * 100), length = 1, overridable = true }) end
    end)
    
    carti380.MouseEnter:Connect(function() carti6:Create(carti380, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(100, 80, 150) }):Play() end)
    carti380.MouseLeave:Connect(function() carti6:Create(carti380, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(80, 60, 120) }):Play() end)
    carti382.MouseEnter:Connect(function() carti6:Create(carti382, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(80, 150, 100) }):Play() end)
    carti382.MouseLeave:Connect(function() carti6:Create(carti382, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(60, 120, 80) }):Play() end)
end

-- Pet Value Calculator Section