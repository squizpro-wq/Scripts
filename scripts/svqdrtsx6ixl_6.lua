function carti276(carti310, index)
    local carti277 = Instance.new('Frame')
    carti277.Size = UDim2.new(1, -8, 0, 32)
    carti277.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    carti277.BackgroundTransparency = 0.1
    carti277.LayoutOrder = index
    carti277.Name = 'RichestPlayer_' .. carti310.playerName
    carti277.ClipsDescendants = true
    carti277.Parent = carti267
    Instance.new('UICorner', carti277).CornerRadius = UDim.new(0, 8)
    
    local carti278 = Instance.new('UIGradient')
    carti278.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 45, 65)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 32, 48))
    })
    carti278.Rotation = 90
    carti278.Parent = carti277
    
    local carti279 = Instance.new('UIStroke')
    carti279.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    carti279.Color = Color3.fromRGB(255, 200, 50)
    carti279.Thickness = 1.5
    carti279.Transparency = 0.2
    carti279.Parent = carti277

    local carti280 = {
        [1] = Color3.fromRGB(255, 215, 0),
        [2] = Color3.fromRGB(200, 200, 210),
        [3] = Color3.fromRGB(205, 140, 80),
    }

    local carti281 = Instance.new('TextLabel')
    carti281.Size = UDim2.new(0, 22, 0, 22)
    carti281.Position = UDim2.new(0, 5, 0, 5)
    carti281.BackgroundColor3 = carti280[index] or Color3.fromRGB(70, 70, 90)
    carti281.BackgroundTransparency = 0.2
    carti281.Text = tostring(index)
    carti281.Font = Enum.Font.GothamBlack
    carti281.TextSize = 11
    carti281.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti281.Parent = carti277
    Instance.new('UICorner', carti281).CornerRadius = UDim.new(0, 11)

    local carti282 = Instance.new('TextButton')
    carti282.Size = UDim2.new(0, 32, 0, 22)
    carti282.Position = UDim2.new(1, -74, 0, 5)
    carti282.BackgroundColor3 = Color3.fromRGB(50, 130, 100)
    carti282.BackgroundTransparency = 0.1
    carti282.Text = '🤝'
    carti282.Font = Enum.Font.GothamBold
    carti282.TextSize = 12
    carti282.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti282.Parent = carti277
    Instance.new('UICorner', carti282).CornerRadius = UDim.new(0, 6)

    carti282.MouseEnter:Connect(function()
        carti6:Create(carti282, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(70, 160, 120) }):Play()
    end)
    
    carti282.MouseLeave:Connect(function()
        carti6:Create(carti282, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(50, 130, 100) }):Play()
    end)

    carti282.MouseButton1Click:Connect(function()
        local carti198 = carti2:FindFirstChild(carti310.playerName)
        if carti198 then
            carti197(carti198)
        else
            for _, carti240 in ipairs(carti2:GetPlayers()) do
                if carti240.Name == carti310.playerName then
                    carti197(carti240)
                    return
                end
            end
            if carti32 then
                carti32:hint({ text = carti310.playerName .. ' is not in this server', length = 3, overridable = true })
            end
        end
    end)

    local carti141 = Instance.new('TextButton')
    carti141.Size = UDim2.new(0, 32, 0, 22)
    carti141.Position = UDim2.new(1, -38, 0, 5)
    carti141.BackgroundColor3 = Color3.fromRGB(100, 70, 150)
    carti141.BackgroundTransparency = 0.1
    carti141.Text = '👤'
    carti141.Font = Enum.Font.GothamBold
    carti141.TextSize = 12
    carti141.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti141.Parent = carti277
    Instance.new('UICorner', carti141).CornerRadius = UDim.new(0, 6)

    carti141.MouseEnter:Connect(function()
        carti6:Create(carti141, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(130, 90, 180) }):Play()
    end)
    
    carti141.MouseLeave:Connect(function()
        carti6:Create(carti141, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(100, 70, 150) }):Play()
    end)

    carti141.MouseButton1Click:Connect(function()
        local carti198 = carti2:FindFirstChild(carti310.playerName)
        if carti198 then
            pcall(function()
                OpenProfile(carti198.UserId)
            end)
        else
            for _, carti240 in ipairs(carti2:GetPlayers()) do
                if carti240.Name == carti310.playerName then
                    pcall(function()
                        OpenProfile(carti240.UserId)
                    end)
                    return
                end
            end
            if carti32 then
                carti32:hint({ text = carti310.playerName .. ' is not in this server', length = 3, overridable = true })
            end
        end
    end)

    local carti283 = Instance.new('TextButton')
    carti283.Size = UDim2.new(1, -110, 0, 32)
    carti283.Position = UDim2.new(0, 30, 0, 0)
    carti283.BackgroundTransparency = 1
    carti283.Text = ''
    carti283.Parent = carti277

    local carti284 = Instance.new('TextLabel')
    carti284.Size = UDim2.new(0.55, 0, 1, 0)
    carti284.Position = UDim2.new(0, 0, 0, 0)
    carti284.BackgroundTransparency = 1
    carti284.Text = carti310.playerName
    carti284.Font = Enum.Font.GothamBold
    carti284.TextSize = 10
    carti284.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti284.TextXAlignment = Enum.TextXAlignment.Left
    carti284.TextTruncate = Enum.TextTruncate.AtEnd
    carti284.Parent = carti283

    local carti285 = Instance.new('TextLabel')
    carti285.Size = UDim2.new(0.45, 0, 1, 0)
    carti285.Position = UDim2.new(0.55, 0, 0, 0)
    carti285.BackgroundTransparency = 1
    carti285.Text = carti67(carti310.totalValue)
    carti285.Font = Enum.Font.GothamBold
    carti285.TextSize = 10
    carti285.TextColor3 = Color3.fromRGB(120, 255, 120)
    carti285.TextXAlignment = Enum.TextXAlignment.Right
    carti285.Parent = carti283

    -- Pets section inside container
    local carti286 = Instance.new('Frame')
    carti286.Size = UDim2.new(1, -8, 0, 0)
    carti286.Position = UDim2.new(0, 4, 0, 34)
    carti286.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    carti286.BackgroundTransparency = 0.3
    carti286.Visible = false
    carti286.Name = 'PetsSection'
    carti286.Parent = carti277
    Instance.new('UICorner', carti286).CornerRadius = UDim.new(0, 6)

    local carti287 = Instance.new('UIListLayout')
    carti287.SortOrder = Enum.SortOrder.LayoutOrder
    carti287.Padding = UDim.new(0, 2)
    carti287.Parent = carti286

    local carti288 = Instance.new('UIPadding')
    carti288.PaddingTop = UDim.new(0, 4)
    carti288.PaddingBottom = UDim.new(0, 4)
    carti288.PaddingLeft = UDim.new(0, 6)
    carti288.PaddingRight = UDim.new(0, 6)
    carti288.Parent = carti286

    local carti289 = false
    local carti290 = 0

    carti283.MouseButton1Click:Connect(function()
        if carti289 then
            carti289 = false
            carti290 = carti290 + 1
            carti286.Visible = false
            carti286.Size = UDim2.new(1, -8, 0, 0)
            carti277.Size = UDim2.new(1, -8, 0, 32)
        else
            carti289 = true
            carti290 = carti290 + 1
            local carti291 = carti290

            for _, child in ipairs(carti286:GetChildren()) do
                if child:IsA('TextLabel') then child:Destroy() end
            end

            local carti292 = 0
            if carti310.pets and #carti310.pets > 0 then
                local carti293 = {}
                for _, carti57 in ipairs(carti310.pets) do table.insert(carti293, carti57) end
                table.sort(carti293, function(a, carti390) return a.value > carti390.value end)

                local carti294 = math.min(#carti293, 8)
                for i = 1, carti294 do
                    local carti57 = carti293[i]
                    local carti295 = ""
                    if carti57.isMega then carti295 = "M "
                    elseif carti57.isNeon then carti295 = "N " end
                    if carti57.isFly then carti295 = carti295 .. "F" end
                    if carti57.isRide then carti295 = carti295 .. "R" end
                    if carti295 ~= "" then carti295 = "[" .. prefix:gsub("%s+$", "") .. "] " end

                    local carti296 = Instance.new('TextLabel')
                    carti296.Size = UDim2.new(1, 0, 0, 14)
                    carti296.BackgroundTransparency = 1
                    carti296.Text = carti295 .. pet.displayName .. ' - ' .. formatValue(carti57.value)
                    carti296.Font = Enum.Font.SourceSans
                    carti296.TextSize = 9
                    carti296.TextColor3 = carti57.isMega and Color3.fromRGB(170, 100, 255) or (carti57.isNeon and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(200, 200, 200))
                    carti296.TextXAlignment = Enum.TextXAlignment.Left
                    carti296.LayoutOrder = i
                    carti296.Parent = carti286
                end

                if #carti293 > 8 then
                    local carti297 = Instance.new('TextLabel')
                    carti297.Size = UDim2.new(1, 0, 0, 12)
                    carti297.BackgroundTransparency = 1
                    carti297.Text = '... and ' .. (#carti293 - 8) .. ' more pets'
                    carti297.Font = Enum.Font.SourceSansItalic
                    carti297.TextSize = 8
                    carti297.TextColor3 = Color3.fromRGB(150, 150, 150)
                    carti297.TextXAlignment = Enum.TextXAlignment.Left
                    carti297.LayoutOrder = 999
                    carti297.Parent = carti286
                end

                carti292 = (carti294 * 16) + 10
                if #carti293 > 8 then carti292 = carti292 + 14 end
            else
                local carti298 = Instance.new('TextLabel')
                carti298.Size = UDim2.new(1, 0, 0, 14)
                carti298.BackgroundTransparency = 1
                carti298.Text = 'No pets listed in profile'
                carti298.Font = Enum.Font.SourceSansItalic
                carti298.TextSize = 9
                carti298.TextColor3 = Color3.fromRGB(150, 150, 150)
                carti298.TextXAlignment = Enum.TextXAlignment.Left
                carti298.Parent = carti286
                carti292 = 22
            end

            carti286.Size = UDim2.new(1, -8, 0, carti292)
            carti286.Visible = true
            carti277.Size = UDim2.new(1, -8, 0, 36 + carti292)
            
            -- Auto-close after 10 seconds
            task.spawn(function()
                task.wait(10)
                if carti289 and carti290 == carti291 then
                    carti289 = false
                    carti286.Visible = false
                    carti286.Size = UDim2.new(1, -8, 0, 0)
                    carti277.Size = UDim2.new(1, -8, 0, 32)
                    
                    -- Update canvas size
                    task.wait(0.05)
                    local carti275 = 8
                    for _, child in ipairs(carti267:GetChildren()) do
                        if child:IsA('Frame') then
                            carti275 = carti275 + child.AbsoluteSize.Y + 3
                        end
                    end
                    carti267.CanvasSize = UDim2.new(0, 0, 0, carti275)
                end
            end)
        end

        -- Update canvas size
        task.wait(0.05)
        local carti275 = 8
        for _, child in ipairs(carti267:GetChildren()) do
            if child:IsA('Frame') then
                carti275 = carti275 + child.AbsoluteSize.Y + 3
            end
        end
        carti267.CanvasSize = UDim2.new(0, 0, 0, carti275)
    end)

    return carti277
end

function carti299(forceRefresh)
    if carti270.isRefreshing then return end
    
    local carti300 = tick()
    if not forceRefresh and (carti300 - carti270.lastRefreshTime) < carti270.REFRESH_COOLDOWN then
        return
    end
    
    carti270.isRefreshing = true
    carti270.lastRefreshTime = carti300
    
    local carti301 = carti2.LocalPlayer
    local carti302 = {}
    for _, carti240 in ipairs(carti2:GetPlayers()) do
        if carti240 ~= carti301 then
            carti302[carti240.Name] = carti240
        end
    end
    
    local carti303 = carti271()
    
    -- Remove players who left
    for playerName in pairs(carti303) do
        if not carti302[playerName] then
            carti273(playerName)
            for i, carti162 in ipairs(carti157) do
                if carti162.playerName == playerName then
                    table.remove(carti157, i)
                    break
                end
            end
        end
    end
    
    -- If force refresh, clear everything
    if forceRefresh then
        for _, child in ipairs(carti267:GetChildren()) do
            if child:IsA('Frame') then child:Destroy() end
        end
        carti158 = {}
        carti157 = {}
        carti270.playerContainers = {}
        carti303 = {}
        
        local carti304 = Instance.new('TextLabel')
        carti304.Size = UDim2.new(1, -8, 0, 30)
        carti304.BackgroundTransparency = 1
        carti304.Text = '⏳ Scanning players...'
        carti304.Font = Enum.Font.FredokaOne
        carti304.TextSize = 11
        carti304.TextColor3 = Color3.fromRGB(200, 200, 200)
        carti304.LayoutOrder = 0
        carti304.Name = 'LoadingLabel'
        carti304.Parent = carti267
    end
    
    task.spawn(function()
        local carti305 = {}
        for playerName, carti240 in pairs(carti302) do
            if forceRefresh or not carti303[playerName] then
                table.insert(carti305, carti240)
            end
        end
        
        for _, carti240 in ipairs(carti305) do
            local carti12, carti306 = pcall(function()
                return carti68:InvokeServer(carti240.UserId)
            end)
            
            local carti307 = 0
            local carti308 = {}
            
            if carti12 and carti306 then
                local carti309 = carti61(carti306)
                carti308 = carti64(carti309)
                for _, carti57 in ipairs(carti308) do carti307 = carti307 + carti57.value end
            end
            
            local carti310 = { playerName = carti240.Name, totalValue = carti307, pets = carti308, player = carti240 }
            carti270.playerCache[carti240.Name] = { totalValue = carti307, pets = carti308, player = carti240, lastUpdated = tick() }
            table.insert(carti157, carti310)
        end
        
        local carti304 = carti267:FindFirstChild('LoadingLabel')
        if carti304 then carti304:Destroy() end
        
        table.sort(carti157, function(a, carti390) return a.totalValue > carti390.totalValue end)
        
        local carti294 = math.min(#carti157, 35)
        local carti280 = { [1] = Color3.fromRGB(255, 215, 0), [2] = Color3.fromRGB(192, 192, 192), [3] = Color3.fromRGB(205, 127, 50) }
        
        for i = 1, carti294 do
            local carti162 = carti157[i]
            local carti311 = carti267:FindFirstChild('RichestPlayer_' .. carti162.playerName)
            
            if not carti311 then
                carti276(carti162, i)
                carti270.playerContainers[carti162.playerName] = true
            else
                carti311.LayoutOrder = i
                local carti281 = carti311:FindFirstChildOfClass('TextLabel')
                if carti281 and carti281.Size == UDim2.new(0, 20, 0, 20) then
                    carti281.Text = tostring(i)
                    carti281.BackgroundColor3 = carti280[i] or Color3.fromRGB(80, 80, 100)
                end
            end
        end
        
        for i = carti294 + 1, #carti157 do
            local carti162 = carti157[i]
            local carti277 = carti267:FindFirstChild('RichestPlayer_' .. carti162.playerName)
            if carti277 then carti277:Destroy() end
        end
        
        carti274()
        
        if forceRefresh and carti32 then 
            carti32:hint({ text = 'Updated ' .. #carti157 .. ' players!', length = 2, overridable = true }) 
        end
        
        carti270.isRefreshing = false
    end)
end

function carti312()
    if not carti270.autoRefreshEnabled then return end
    carti299(false)
end

task.spawn(function()
    while true do
        task.wait(5)
        carti312()
    end
end)

carti266.MouseButton1Click:Connect(function()
    carti299(true)
end)

carti265.MouseButton1Click:Connect(function()
    carti270.autoRefreshEnabled = not carti270.autoRefreshEnabled
    if carti270.autoRefreshEnabled then
        carti265.Text = 'Auto: ON'
        carti265.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        carti299(true)
    else
        carti265.Text = 'Auto: OFF'
        carti265.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    end
end)

carti2.PlayerAdded:Connect(function(carti240)
    if carti270.autoRefreshEnabled then
        task.wait(1)
        if carti240 ~= carti2.LocalPlayer then
            task.spawn(function()
                local carti12, carti306 = pcall(function()
                    return carti68:InvokeServer(carti240.UserId)
                end)
                
                local carti307 = 0
                local carti308 = {}
                
                if carti12 and carti306 then
                    local carti309 = carti61(carti306)
                    carti308 = carti64(carti309)
                    for _, carti57 in ipairs(carti308) do carti307 = carti307 + carti57.value end
                end
                
                local carti310 = { playerName = carti240.Name, totalValue = carti307, pets = carti308, player = carti240 }
                carti270.playerCache[carti240.Name] = { totalValue = carti307, pets = carti308, player = carti240, lastUpdated = tick() }
                table.insert(carti157, carti310)
                
                table.sort(carti157, function(a, carti390) return a.totalValue > carti390.totalValue end)
                
                local carti313 = 1
                for i, carti162 in ipairs(carti157) do
                    if carti162.playerName == carti240.Name then carti313 = i break end
                end
                
                if carti313 <= 35 then
                    carti276(carti310, carti313)
                    carti270.playerContainers[carti240.Name] = true
                    
                    local carti280 = { [1] = Color3.fromRGB(255, 215, 0), [2] = Color3.fromRGB(192, 192, 192), [3] = Color3.fromRGB(205, 127, 50) }
                    for i, carti162 in ipairs(carti157) do
                        if i <= 35 then
                            local carti277 = carti267:FindFirstChild('RichestPlayer_' .. carti162.playerName)
                            if carti277 then
                                carti277.LayoutOrder = i
                                local carti281 = carti277:FindFirstChildOfClass('TextLabel')
                                if carti281 and carti281.Size == UDim2.new(0, 20, 0, 20) then
                                    carti281.Text = tostring(i)
                                    carti281.BackgroundColor3 = carti280[i] or Color3.fromRGB(80, 80, 100)
                                end
                            end
                        end
                    end
                    carti274()
                end
            end)
        end
    end
end)

carti2.PlayerRemoving:Connect(function(carti240)
    if carti270.autoRefreshEnabled then
        carti273(carti240.Name)
        
        for i, carti162 in ipairs(carti157) do
            if carti162.playerName == carti240.Name then
                table.remove(carti157, i)
                break
            end
        end
        
        local carti280 = { [1] = Color3.fromRGB(255, 215, 0), [2] = Color3.fromRGB(192, 192, 192), [3] = Color3.fromRGB(205, 127, 50) }
        for i, carti162 in ipairs(carti157) do
            if i <= 35 then
                local carti277 = carti267:FindFirstChild('RichestPlayer_' .. carti162.playerName)
                if carti277 then
                    carti277.LayoutOrder = i
                    local carti281 = carti277:FindFirstChildOfClass('TextLabel')
                    if carti281 and carti281.Size == UDim2.new(0, 20, 0, 20) then
                        carti281.Text = tostring(i)
                        carti281.BackgroundColor3 = carti280[i] or Color3.fromRGB(80, 80, 100)
                    end
                end
            end
        end
        carti274()
    end
end)

function carti314(carti240, index, carti326)
    local carti315 = Instance.new('TextButton')
    carti315.Size = UDim2.new(1, -8, 0, 32)
    carti315.BackgroundColor3 = carti326 and Color3.fromRGB(50, 80, 100) or Color3.fromRGB(40, 40, 50)
    carti315.BackgroundTransparency = 0.2
    carti315.Text = ''
    carti315.LayoutOrder = index
    carti315.Parent = carti261
    Instance.new('UICorner', carti315).CornerRadius = UDim.new(0, 4)
    local carti316 = Instance.new('UIStroke')
    carti316.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    carti316.Color = carti326 and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(80, 80, 80)
    carti316.Thickness = 1.0
    carti316.Parent = carti315

    local carti284 = Instance.new('TextLabel')
    carti284.Size = UDim2.new(1, -30, 1, 0)
    carti284.Position = UDim2.new(0, 4, 0, 0)
    carti284.BackgroundTransparency = 1
    carti284.Text = carti240.Name
    carti284.Font = Enum.Font.FredokaOne
    carti284.TextSize = 12
    carti284.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti284.TextXAlignment = Enum.TextXAlignment.Left
    carti284.Parent = carti315

    local carti317 = Instance.new('Frame')
    carti317.Size = UDim2.new(0, 20, 0, 20)
    carti317.Position = UDim2.new(1, -25, 0.5, -10)
    carti317.BackgroundColor3 = carti326 and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(60, 60, 70)
    carti317.BackgroundTransparency = 0.2
    carti317.Visible = carti154.selectionMode
    carti317.Parent = carti315
    Instance.new('UICorner', carti317).CornerRadius = UDim.new(0, 4)
    local carti318 = Instance.new('UIStroke')
    carti318.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    carti318.Color = carti326 and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(80, 80, 80)
    carti318.Thickness = 1.0
    carti318.Parent = carti317

    local carti319 = Instance.new('TextLabel')
    carti319.Size = UDim2.new(1, 0, 1, 0)
    carti319.BackgroundTransparency = 1
    carti319.Text = '✓'
    carti319.Font = Enum.Font.FredokaOne
    carti319.TextSize = 14
    carti319.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti319.Visible = carti326
    carti319.Parent = carti317

    carti315.MouseButton1Click:Connect(function()
        if carti154.selectionMode then
            local carti320 = not carti154.selectedPlayers[carti240.Name]
            carti154.selectedPlayers[carti240.Name] = carti320
            carti317.BackgroundColor3 = carti320 and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(60, 60, 70)
            carti318.Color = carti320 and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(80, 80, 80)
            carti319.Visible = carti320
            carti315.BackgroundColor3 = carti320 and Color3.fromRGB(50, 80, 100) or Color3.fromRGB(40, 40, 50)
            carti316.Color = carti320 and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(80, 80, 80)
        else
            setActiveTab('Control')
            partnerBox.Text = carti240.Name
            updatePartnerFromUsername(carti240.Name)
        end
    end)

    return carti315, carti317
end

function carti321()
    local carti315 = Instance.new('TextButton')
    carti315.Size = UDim2.new(1, -8, 0, 32)
    carti315.BackgroundColor3 = Color3.fromRGB(65, 65, 81)
    carti315.BackgroundTransparency = 0.2
    carti315.Text = ''
    carti315.Name = 'SelectFromTradeButton'
    carti315.LayoutOrder = -999
    carti315.Parent = carti261
    Instance.new('UICorner', carti315).CornerRadius = UDim.new(0, 4)
    local carti284 = Instance.new('TextLabel')
    carti284.Size = UDim2.new(1, -8, 1, 0)
    carti284.Position = UDim2.new(0, 4, 0, 0)
    carti284.BackgroundTransparency = 1
    carti284.Text = 'Select Partner From Trade'
    carti284.Font = Enum.Font.FredokaOne
    carti284.TextSize = 12
    carti284.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti284.TextXAlignment = Enum.TextXAlignment.Left
    carti284.Parent = carti315

    carti315.MouseButton1Click:Connect(function()
        setActiveTab('Control')
        pcall(function()
            local carti322 = carti2.LocalPlayer.PlayerGui.TradeApp.Frame.NegotiationFrame.Header.PartnerFrame.NameLabel.Text
            for _, carti240 in ipairs(carti2:GetPlayers()) do
                if carti240.Name:lower() == carti322:lower() then
                    partnerBox.Text = carti240.Name
                    updatePartnerFromUsername(carti240.Name)
                    break
                end
            end
        end)
    end)

    return carti315
end

function carti323()
    for _, child in ipairs(carti261:GetChildren()) do
        if child:IsA('TextButton') and child.Name ~= 'SelectFromTradeButton' then child:Destroy() end
    end
    carti154.playerListButtons = {}

    local carti324 = carti256.Text:lower()
    local carti325 = {}
    for _, carti240 in ipairs(carti2:GetPlayers()) do
        if carti324 == '' or carti240.Name:lower():sub(1, #carti324) == carti324 then
            table.insert(carti325, carti240)
        end
    end
    table.sort(carti325, function(a, carti390) return a.Name:lower() < carti390.Name:lower() end)

    for i, carti240 in ipairs(carti325) do
        local carti326 = carti154.selectedPlayers[carti240.Name] == true
        local carti315 = carti314(carti240, i, carti326)
        table.insert(carti154.playerListButtons, carti315)
    end
    carti261.CanvasSize = UDim2.new(0, 0, 0, (#carti325 * 36) + 40)
end

carti256:GetPropertyChangedSignal("Text"):Connect(carti323)

carti258.MouseButton1Click:Connect(function()
    carti154.selectionMode = not carti154.selectionMode
    if carti154.selectionMode then
        carti258.Text = 'Cancel Selection'
        carti258.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
        carti259.Color = Color3.fromRGB(255, 100, 100)
    else
        carti258.Text = 'Select Players'
        carti258.BackgroundColor3 = Color3.fromRGB(65, 65, 81)
        carti259.Color = Color3.fromRGB(159, 159, 159)
        carti154.selectedPlayers = {}
    end
    for _, child in ipairs(carti261:GetChildren()) do
        if child:IsA('TextButton') and child.Name ~= 'SelectFromTradeButton' then
            local carti317 = child:FindFirstChildOfClass('Frame')
            if carti317 then carti317.Visible = carti154.selectionMode end
        end
    end
end)

carti260.MouseButton1Click:Connect(function()
    if not carti154.selectionMode then return end
    local carti327 = 0
    for playerName, carti326 in pairs(carti154.selectedPlayers) do
        if carti326 then
            local carti240 = carti2:FindFirstChild(playerName)
            if carti240 then
                pcall(function() BlockPlayer(carti240) carti327 = carti327 + 1 end)
                task.wait(0.15)
            end
        end
    end
    carti154.selectionMode = false
    carti258.Text = 'Select Players'
    carti258.BackgroundColor3 = Color3.fromRGB(65, 65, 81)
    carti259.Color = Color3.fromRGB(159, 159, 159)
    carti154.selectedPlayers = {}
    carti323()
    if carti32 then carti32:hint({ text = 'Blocked ' .. count .. ' player(s)', length = 3, overridable = true }) end
end)

carti323()
carti321()

carti2.PlayerAdded:Connect(carti323)
carti2.PlayerRemoving:Connect(carti323)

-- ==================== PETS TAB ====================
carti328 = carti155['Pets']

carti329 = Instance.new('Frame')
carti329.Size = UDim2.new(1, 0, 0, 190)
carti329.Position = UDim2.new(0, 0, 0, 0)
carti329.BackgroundTransparency = 1
carti329.Parent = carti328

carti330 = Instance.new('TextLabel')
carti330.Size = UDim2.new(1, 0, 0, 16)
carti330.BackgroundTransparency = 1
carti330.Text = 'Pet Name To Add'
carti330.Font = Enum.Font.SourceSansSemibold
carti330.TextSize = 11
carti330.TextColor3 = Color3.fromRGB(180, 180, 180)
carti330.TextXAlignment = Enum.TextXAlignment.Left
carti330.Parent = carti329

carti331 = Instance.new('TextBox')
carti331.Size = UDim2.new(1, 0, 0, 26)
carti331.Position = UDim2.new(0, 0, 0, 18)
carti331.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
carti331.BackgroundTransparency = 0.2
carti331.Text = ''
carti331.PlaceholderText = 'Enter pet name...'
carti331.Font = Enum.Font.FredokaOne
carti331.TextSize = 11
carti331.TextColor3 = Color3.fromRGB(255, 255, 255)
carti331.ClearTextOnFocus = false
carti331.Parent = carti329
Instance.new('UICorner', carti331).CornerRadius = UDim.new(0, 4)
carti332 = Instance.new('UIStroke')
carti332.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
carti332.Color = Color3.fromRGB(100, 100, 100)
carti332.Thickness = 0.8
carti332.Transparency = 0.5
carti332.Parent = carti331

carti333 = Instance.new('Frame')
carti333.Size = UDim2.new(1, 0, 0, 26)
carti333.Position = UDim2.new(0, 0, 0, 49)
carti333.BackgroundTransparency = 1
carti333.Parent = carti329

carti334 = { 'M', 'N', 'F', 'R' }
carti335 = {
    M = Color3.fromRGB(170, 0, 255),
    N = Color3.fromRGB(0, 255, 100),
    F = Color3.fromRGB(0, 200, 255),
    R = Color3.fromRGB(255, 50, 150),
}

carti336 = {}