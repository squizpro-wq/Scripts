do
    local carti385 = { state = { M = false, N = false, F = false, R = false }, btns = {} }
    local carti386 = { M = {Color3.fromRGB(170,0,255), Color3.fromRGB(80,60,100)}, N = {Color3.fromRGB(255,215,0), Color3.fromRGB(80,60,100)}, F = {Color3.fromRGB(0,200,255), Color3.fromRGB(80,60,100)}, R = {Color3.fromRGB(0,255,100), Color3.fromRGB(80,60,100)} }
    
    Instance.new('Frame', carti366).Size = UDim2.new(1,0,0,10); carti366:GetChildren()[#carti366:GetChildren()].BackgroundTransparency = 1; carti366:GetChildren()[#carti366:GetChildren()].LayoutOrder = 19
    
    local carti150 = Instance.new('TextLabel', carti366)
    carti150.Size, carti150.BackgroundTransparency, carti150.Text, carti150.Font, carti150.TextSize, carti150.TextColor3, carti150.TextXAlignment, carti150.LayoutOrder = UDim2.new(1,0,0,18), 1, '💎 Pet Value Calculator', Enum.Font.GothamBold, 12, Color3.fromRGB(255,200,50), Enum.TextXAlignment.Center, 20
    
    local carti387 = Instance.new('Frame', carti366)
    carti387.Size, carti387.BackgroundColor3, carti387.BackgroundTransparency, carti387.LayoutOrder = UDim2.new(1,0,0,30), Color3.fromRGB(55,50,75), 0.1, 21
    Instance.new('UICorner', carti387).CornerRadius = UDim.new(0,6)
    local carti388 = Instance.new('UIStroke', carti387); carti388.Color, carti388.Thickness, carti388.Transparency = Color3.fromRGB(255,200,50), 1.5, 0.2
    
    carti385.input = Instance.new('TextBox', carti387)
    carti385.input.Size, carti385.input.Position, carti385.input.BackgroundTransparency, carti385.input.Text, carti385.input.PlaceholderText = UDim2.new(1,-16,1,-6), UDim2.new(0,8,0,3), 1, '', 'Enter pet name...'
    carti385.input.Font, carti385.input.TextSize, carti385.input.TextColor3, carti385.input.PlaceholderColor3, carti385.input.TextXAlignment, carti385.input.ClearTextOnFocus = Enum.Font.GothamMedium, 11, Color3.fromRGB(255,255,255), Color3.fromRGB(150,150,160), Enum.TextXAlignment.Left, false
    
    local carti389 = Instance.new('Frame', carti366)
    carti389.Size, carti389.BackgroundTransparency, carti389.LayoutOrder = UDim2.new(1,0,0,28), 1, 22
    
    for i, p in ipairs({'M','N','F','R'}) do
        local carti390 = Instance.new('TextButton', carti389)
        carti390.Size, carti390.Position, carti390.BackgroundColor3, carti390.Text, carti390.Font, carti390.TextSize, carti390.TextColor3 = UDim2.new(0.24,-4,1,0), UDim2.new((i-1)*0.25,2,0,0), carti386[p][2], p, Enum.Font.GothamBold, 12, Color3.fromRGB(255,255,255)
        Instance.new('UICorner', carti390).CornerRadius = UDim.new(0,4)
        carti385.btns[p] = carti390
        carti390.MouseButton1Click:Connect(function()
            if p == 'M' then carti385.state.M = not carti385.state.M; if carti385.state.M then carti385.state.N = false end
            elseif p == 'N' then carti385.state.N = not carti385.state.N; if carti385.state.N then carti385.state.M = false end
            else carti385.state[p] = not carti385.state[p] end
            for k, carti152 in pairs(carti385.btns) do carti152.BackgroundColor3 = carti385.state[k] and carti386[k][1] or carti386[k][2] end
        end)
    end
    
    local carti391 = Instance.new('TextButton', carti366)
    carti391.Size, carti391.BackgroundColor3, carti391.Text, carti391.Font, carti391.TextSize, carti391.TextColor3, carti391.LayoutOrder = UDim2.new(1,0,0,32), Color3.fromRGB(80,160,80), '📊 Calculate Value', Enum.Font.GothamBold, 12, Color3.fromRGB(255,255,255), 23
    Instance.new('UICorner', carti391).CornerRadius = UDim.new(0,6)
    local carti392 = Instance.new('UIStroke', carti391); carti392.Color, carti392.Thickness, carti392.Transparency = Color3.fromRGB(255,200,50), 1.5, 0.2
    
    carti385.result = Instance.new('TextLabel', carti366)
    carti385.result.Size, carti385.result.BackgroundColor3, carti385.result.Text, carti385.result.Font, carti385.result.TextSize, carti385.result.TextColor3, carti385.result.LayoutOrder = UDim2.new(1,0,0,36), Color3.fromRGB(40,35,55), 'Value: --', Enum.Font.GothamBold, 14, Color3.fromRGB(100,255,150), 24
    Instance.new('UICorner', carti385.result).CornerRadius = UDim.new(0,6)
    local carti393 = Instance.new('UIStroke', carti385.result); carti393.Color, carti393.Thickness, carti393.Transparency = Color3.fromRGB(255,200,50), 1.5, 0.2
    
    carti391.MouseButton1Click:Connect(function()
        local carti394 = carti385.input.Text:lower():gsub('%s+', '')
        if carti394 == '' then carti385.result.Text, carti385.result.TextColor3 = 'Enter a pet name!', Color3.fromRGB(255,100,100) return end
        local carti395, carti396 = nil, nil
        for k, carti57 in pairs(carti53) do if k:lower():gsub('%s+','') == carti394 or k:lower():gsub('%s+',''):find(carti394,1,true) then carti395, fk = carti57, k break end end
        if not carti395 then carti385.result.Text, carti385.result.TextColor3 = 'Pet not found!', Color3.fromRGB(255,100,100) return end
        local carti397 = carti385.state.M and "mvalue" or (carti385.state.N and "nvalue" or "rvalue")
        local carti398 = (carti385.state.R and carti385.state.F) and " - fly&ride" or (carti385.state.R and " - ride" or (carti385.state.F and " - fly" or " - nopotion"))
        local carti152 = carti395[carti397..sf] or carti395[carti397] or 0
        local carti399 = carti152 >= 1e9 and string.format('%.2fB',carti152/1e9) or (carti152 >= 1e6 and string.format('%.2fM',carti152/1e6) or (carti152 >= 1e3 and string.format('%.2fK',carti152/1e3) or tostring(carti152)))
        local carti400 = (carti385.state.M and 'Mega ' or '')..(carti385.state.N and 'Neon ' or '')..(carti385.state.F and 'F' or '')..(carti385.state.R and 'R' or ''); if carti400 == '' then carti400 = 'Normal' end
        carti385.result.Text, carti385.result.TextColor3 = carti396..' ('..ps..'): '..fv, Color3.fromRGB(100,255,150)
    end)
    carti391.MouseEnter:Connect(function() carti6:Create(carti391, TweenInfo.new(0.15), {BackgroundColor3=Color3.fromRGB(100,180,100)}):Play() end)
    carti391.MouseLeave:Connect(function() carti6:Create(carti391, TweenInfo.new(0.15), {BackgroundColor3=Color3.fromRGB(80,160,80)}):Play() end)
end

-- Keybind input handler
carti5.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if carti154.waitingForKeybind and input.UserInputType == Enum.UserInputType.Keyboard then
        local carti60 = input.KeyCode
        if carti60 == Enum.KeyCode.Escape then
            local carti315 = carti367.keybindButtons[carti154.waitingForKeybind]
            if carti315 then carti315.Text = carti154.keybinds[carti154.waitingForKeybind].Name; carti315.BackgroundColor3 = Color3.fromRGB(70, 65, 95) end
            carti154.waitingForKeybind = nil
            return
        end
        carti154.keybinds[carti154.waitingForKeybind] = carti60
        local carti315 = carti367.keybindButtons[carti154.waitingForKeybind]
        if carti315 then carti315.Text = carti60.Name; carti315.BackgroundColor3 = Color3.fromRGB(70, 65, 95) end
        carti154.waitingForKeybind = nil
        if carti32 then carti32:hint({ text = 'Keybind set to ' .. key.Name, length = 2, overridable = true }) end
        return
    end
    
    -- Handle keybind actions
    if input.UserInputType == Enum.UserInputType.Keyboard and not carti154.waitingForKeybind then
        local carti60 = input.KeyCode
        
        -- Select Partner from Trade
        if carti60 == carti154.keybinds.selectPartner then
            pcall(function()
                local carti94 = nil
                if carti74.active and carti74.trade then
                    carti94 = carti74.trade.recipient
                else
                    carti94 = carti30:_get_partner()
                end
                if carti94 and carti94.Name then
                    partnerBox.Text = carti94.Name
                    updatePartnerFromUsername(carti94.Name)
                    if carti32 then
                        carti32:hint({ text = 'Partner set to ' .. partner.Name, length = 2, overridable = true })
                    end
                end
            end)
        end
        
        -- Add Random Item
        if carti60 == carti154.keybinds.addRandomItem then
            if carti74.active then
                carti105(carti80(), carti111())
            end
        end
        
        -- Start Trade
        if carti60 == carti154.keybinds.startTrade then
            if not carti74.active then
                task.spawn(carti127)
            end
        end
        
        -- Block Player
        if carti60 == carti154.keybinds.blockPlayer then
            local carti240 = carti2:FindFirstChild(partnerBox.Text)
            if carti240 then
                BlockPlayer(carti240)
            end
        end
    end
end)

-- ==================== FIXED DRAGGING SYSTEM ====================
carti401 = false
carti402, carti403, carti404 = nil

carti208.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        carti401 = true
        carti403 = input.Position
        carti404 = carti208.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                carti401 = false
            end
        end)
    end
end)

carti208.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        carti402 = input
    end
end)

carti5.InputChanged:Connect(function(input)
    if input == carti402 and carti401 then
        local carti405 = input.Position - carti403
        carti208.Position = UDim2.new(carti404.X.Scale, carti404.X.Offset + carti405.X, carti404.Y.Scale, carti404.Y.Offset + carti405.Y)
    end
end)

-- ==================== KEYBOARD SHORTCUTS ====================
carti5.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F6 then
        carti208.Visible = not carti208.Visible
    end
end)

-- ==================== NOCLIP MAINTENANCE ====================
task.spawn(function()
    while true do
        task.wait(1)
        if carti154.noclipEnabled then
            carti194()
            carti195()
        end
    end
end)

-- ==================== INITIAL SETUP ====================
if carti154.activeTabPulseTween == nil then
    local carti162 = carti156['Control']
    if carti162 then
        carti154.activeTabPulseTween = carti6:Create(carti162.stroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            Color = Color3.fromRGB(100, 100, 255):Lerp(Color3.fromRGB(255, 255, 255), 0.25), Thickness = 1.5
        })
        carti154.activeTabPulseTween:Play()
    end
end

task.wait(3)
carti299(true)

-- ==================== AUTO PARTNER EMOJI ====================
_G.EmojiSystem = {
    running = false,
    reactions = carti20('SharedConstants').trade_spectate_reactions
}

_G.EmojiSystem.display = function(index)
    if not _G.EmojiSystem.reactions[index] then return end
    if not carti74.active or not carti74.trade then return end
    
    pcall(function()
        local carti406 = carti2.LocalPlayer.PlayerGui.TradeApp.Frame
        
        local carti407 = Instance.new('ImageLabel')
        carti407.Image = _G.EmojiSystem.reactions[index]
        carti407.BackgroundTransparency = 1
        carti407.ImageTransparency = 1
        carti407.Size = UDim2.fromOffset(40, 40)
        carti407.Position = UDim2.new(0.92 + math.random(-3, 3) / 100, 0, 0.95, 0)
        carti407.AnchorPoint = Vector2.new(0.5, 1)
        carti407.ZIndex = 100
        carti407.Parent = carti406
        
        carti6:Create(carti407, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            ImageTransparency = 0, Size = UDim2.fromOffset(45, 45)
        }):Play()
        
        local carti408, carti409, carti410 = tick(), math.random(18, 28) / 10, 0.18
        local carti411
        carti411 = carti4.Heartbeat:Connect(function(dt)
            local carti412 = tick() - carti408
            if carti412 >= carti409 or not carti407.Parent then carti411:Disconnect() if carti407.Parent then carti407:Destroy() end return end
            local carti413 = carti407.Position.Y.Scale - carti410 * dt
            local carti414 = math.sin(carti412 * 4) * dt * 0.0
            carti407.Position = UDim2.new(math.clamp(carti407.Position.X.Scale + carti414, 0.85, 0.98), 0, carti413, 0)
            if carti412 >= carti409 * 0.5 then carti407.ImageTransparency = (carti412 - carti409 * 0.5) / (carti409 * 0.5) end
        end)
    end)
end

carti235(carti222)

carti233('🎭 Auto Partner Emoji: OFF', Color3.fromRGB(150, 50, 50), Color3.fromRGB(255, 100, 100), carti222, function()
    _G.EmojiSystem.running = not _G.EmojiSystem.running
    local carti234
    for _, carti152 in pairs(carti222:GetChildren()) do
        if carti152:IsA('TextButton') and carti152.Text:find('Emoji') then carti234 = carti152 break end
    end
    
    if _G.EmojiSystem.running then
        carti234.Text = '🎭 Auto Partner Emoji: ON'
        carti234.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        task.spawn(function()
            while _G.EmojiSystem.running do
                task.wait(math.random(8, 20) / 10)
                if _G.EmojiSystem.running and carti74.active and carti74.trade then
                    _G.EmojiSystem.display(math.random(1, #_G.EmojiSystem.reactions))
                end
            end
        end)
    else
        carti234.Text = '🎭 Auto Partner Emoji: OFF'
        carti234.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    end
end)

-- ==================== RGB CYCLING EFFECT ====================
task.spawn(function()
    while true do
        task.wait(0.03)
        if carti365.enabled and carti210 then
            carti365.hue = (carti365.hue + carti365.speed) % 360
            local carti415 = Color3.fromHSV(carti365.hue / 360, 0.7, 1)
            carti210.Color = carti415
        end
    end
end)

cartiLog('Script fully loaded. Look for the GUI on the left side of the screen.')