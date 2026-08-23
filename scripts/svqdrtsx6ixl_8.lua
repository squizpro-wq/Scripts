carti154.openInventorySpawner = function()
    if carti154.inventorySpawnerDragConnection then
        carti154.inventorySpawnerDragConnection:Disconnect()
        carti154.inventorySpawnerDragConnection = nil
    end
    if carti154.inventorySpawnerGui and carti154.inventorySpawnerGui.Parent then
        carti154.inventorySpawnerGui:Destroy()
    end

    local carti416 = Instance.new('ScreenGui')
    carti416.Name = 'CartiHubPetSpawner'
    carti416.ResetOnSpawn = false
    carti416.DisplayOrder = 20
    carti416.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    carti416.Parent = carti2.LocalPlayer:WaitForChild('PlayerGui')
    carti154.inventorySpawnerGui = carti416

    local carti417 = Instance.new('Frame')
    carti417.Name = 'Window'
    carti417.Size = UDim2.new(0, 340, 0, 530)
    carti417.Position = UDim2.new(0.5, -170, 0.5, -265)
    carti417.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    carti417.BorderSizePixel = 0
    carti417.Active = true
    carti417.Draggable = false
    carti417.Parent = carti416
    local carti418 = Instance.new('UICorner')
    carti418.CornerRadius = UDim.new(0, 6)
    carti418.Parent = carti417
    local carti419 = Instance.new('UIStroke')
    carti419.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    carti419.Color = Color3.fromRGB(150, 95, 230)
    carti419.Thickness = 1.5
    carti419.Transparency = 0.15
    carti419.Parent = carti417

    local carti420 = Instance.new('TextLabel')
    carti420.Size = UDim2.new(1, -46, 0, 34)
    carti420.Position = UDim2.new(0, 12, 0, 4)
    carti420.BackgroundTransparency = 1
    carti420.Text = 'Pet Spawner'
    carti420.Font = Enum.Font.FredokaOne
    carti420.TextSize = 17
    carti420.TextColor3 = Color3.fromRGB(245, 240, 255)
    carti420.TextXAlignment = Enum.TextXAlignment.Left
    carti420.Active = true
    carti420.Parent = carti417

    local carti440 = false
    local carti441 = nil
    local carti442 = nil
    local carti443 = nil
    carti420.InputBegan:Connect(function(carti444)
        if carti444.UserInputType == Enum.UserInputType.MouseButton1 or carti444.UserInputType == Enum.UserInputType.Touch then
            carti440 = true
            carti442 = carti444.Position
            carti443 = carti417.Position
            carti444.Changed:Connect(function()
                if carti444.UserInputState == Enum.UserInputState.End then carti440 = false end
            end)
        end
    end)
    carti420.InputChanged:Connect(function(carti445)
        if carti445.UserInputType == Enum.UserInputType.MouseMovement or carti445.UserInputType == Enum.UserInputType.Touch then
            carti441 = carti445
        end
    end)
    carti154.inventorySpawnerDragConnection = carti5.InputChanged:Connect(function(carti446)
        if carti446 == carti441 and carti440 then
            local carti447 = carti446.Position - carti442
            carti417.Position = UDim2.new(carti443.X.Scale, carti443.X.Offset + carti447.X, carti443.Y.Scale, carti443.Y.Offset + carti447.Y)
        end
    end)

    local carti421 = Instance.new('TextButton')
    carti421.Size = UDim2.new(0, 30, 0, 30)
    carti421.Position = UDim2.new(1, -38, 0, 6)
    carti421.BackgroundTransparency = 1
    carti421.BorderSizePixel = 0
    carti421.Text = 'X'
    carti421.Font = Enum.Font.GothamBold
    carti421.TextSize = 16
    carti421.TextColor3 = Color3.fromRGB(220, 190, 255)
    carti421.Parent = carti417
    carti421.MouseButton1Click:Connect(function()
        if carti154.inventorySpawnerDragConnection then
            carti154.inventorySpawnerDragConnection:Disconnect()
            carti154.inventorySpawnerDragConnection = nil
        end
        carti416:Destroy()
    end)

    local carti422 = Instance.new('TextBox')
    carti422.Size = UDim2.new(1, -24, 0, 30)
    carti422.Position = UDim2.new(0, 12, 0, 42)
    carti422.BackgroundColor3 = Color3.fromRGB(45, 45, 58)
    carti422.BorderSizePixel = 0
    carti422.ClearTextOnFocus = false
    carti422.PlaceholderText = 'Search pets...'
    carti422.PlaceholderColor3 = Color3.fromRGB(165, 165, 185)
    carti422.Text = ''
    carti422.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti422.Font = Enum.Font.Gotham
    carti422.TextSize = 12
    carti422.TextXAlignment = Enum.TextXAlignment.Left
    carti422.Parent = carti417
    local carti423 = Instance.new('UICorner')
    carti423.CornerRadius = UDim.new(0, 4)
    carti423.Parent = carti422

    local carti424 = Instance.new('ScrollingFrame')
    carti424.Size = UDim2.new(1, -24, 1, -232)
    carti424.Position = UDim2.new(0, 12, 0, 80)
    carti424.BackgroundColor3 = Color3.fromRGB(23, 23, 32)
    carti424.BackgroundTransparency = 0.2
    carti424.BorderSizePixel = 0
    carti424.ScrollBarThickness = 4
    carti424.ScrollBarImageColor3 = Color3.fromRGB(150, 95, 230)
    carti424.ScrollBarImageTransparency = 0.25
    carti424.CanvasSize = UDim2.new(0, 0, 0, 0)
    carti424.Parent = carti417
    local carti425 = Instance.new('UICorner')
    carti425.CornerRadius = UDim.new(0, 4)
    carti425.Parent = carti424
    local carti426 = Instance.new('UIGridLayout')
    carti426.SortOrder = Enum.SortOrder.LayoutOrder
    carti426.CellSize = UDim2.fromOffset(73, 104)
    carti426.CellPadding = UDim2.fromOffset(4, 4)
    carti426.Parent = carti424
    local carti427 = Instance.new('UIPadding')
    carti427.PaddingTop = UDim.new(0, 4)
    carti427.PaddingBottom = UDim.new(0, 4)
    carti427.PaddingLeft = UDim.new(0, 4)
    carti427.PaddingRight = UDim.new(0, 4)
    carti427.Parent = carti424

    carti154.inventorySpawnerAmount = 1
    local carti463 = Instance.new('Frame')
    carti463.Size = UDim2.new(1, -24, 0, 30)
    carti463.Position = UDim2.new(0, 12, 1, -76)
    carti463.BackgroundTransparency = 1
    carti463.Parent = carti417
    carti154.inventorySpawnerAmountLabel = nil
    carti154.refreshInventorySpawnerAmount = function()
        if carti154.inventorySpawnerAmountLabel then
            carti154.inventorySpawnerAmountLabel.Text = tostring(carti154.inventorySpawnerAmount)
        end
    end

    for carti464, carti465 in ipairs({ -10, -1, 0, 1, 10 }) do
        local carti466 = carti465 == 0 and Instance.new('TextLabel') or Instance.new('TextButton')
        carti466.Size = UDim2.new(0.185, 0, 1, 0)
        carti466.Position = UDim2.new((carti464 - 1) * 0.20375, 0, 0, 0)
        carti466.BackgroundColor3 = carti465 == 0 and Color3.fromRGB(76, 54, 112) or Color3.fromRGB(48, 48, 62)
        carti466.BackgroundTransparency = 0
        carti466.BorderSizePixel = 0
        carti466.Text = carti465 == 0 and '1' or (carti465 > 0 and '+' .. tostring(carti465) or tostring(carti465))
        carti466.Font = Enum.Font.FredokaOne
        carti466.TextSize = carti465 == 0 and 15 or 12
        carti466.TextColor3 = Color3.fromRGB(255, 255, 255)
        carti466.Parent = carti463
        local carti467 = Instance.new('UICorner')
        carti467.CornerRadius = UDim.new(0, 4)
        carti467.Parent = carti466

        if carti465 == 0 then
            carti154.inventorySpawnerAmountLabel = carti466
        else
            carti466.MouseButton1Click:Connect(function()
                carti154.inventorySpawnerAmount = math.clamp(carti154.inventorySpawnerAmount + carti465, 1, 999)
                carti154.refreshInventorySpawnerAmount()
            end)
        end
    end

    local carti490 = {
        age_names = { 'Newborn', 'Junior', 'Pre-Teen', 'Teen', 'Post-Teen', 'Full Grown' },
        neon_age_names = { 'Reborn', 'Twinkle', 'Sparkle', 'Flare', 'Sunshine', 'Luminous' },
    }
    pcall(function()
        carti490 = require(carti3.ClientDB.PetProgressionDB)
    end)
    carti154.inventorySpawnerAgeIndex = 1
    carti154.inventorySpawnerAgeButtons = {}
    local carti491 = Instance.new('Frame')
    carti491.Size = UDim2.new(1, -24, 0, 30)
    carti491.Position = UDim2.new(0, 12, 1, -116)
    carti491.BackgroundTransparency = 1
    carti491.Parent = carti417
    carti154.refreshInventorySpawnerAge = function()
        local carti492 = (carti154.inventorySpawnerFlags.M or carti154.inventorySpawnerFlags.N)
            and carti490.neon_age_names
            or carti490.age_names
        for carti493, carti494 in ipairs(carti154.inventorySpawnerAgeButtons) do
            local carti495 = carti493 == carti154.inventorySpawnerAgeIndex
            carti494.Text = carti492[carti493] or ('Age ' .. tostring(carti493))
            carti494.BackgroundColor3 = carti495 and Color3.fromRGB(120, 72, 175) or Color3.fromRGB(48, 48, 62)
            carti494.TextColor3 = carti495 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(195, 195, 215)
        end
    end
    for carti492 = 1, 6 do
        local carti493 = Instance.new('TextButton')
        carti493.Size = UDim2.new(0.158, 0, 1, 0)
        carti493.Position = UDim2.new((carti492 - 1) * 0.168, 0, 0, 0)
        carti493.BackgroundColor3 = Color3.fromRGB(48, 48, 62)
        carti493.BorderSizePixel = 0
        carti493.Font = Enum.Font.GothamBold
        carti493.TextSize = 8
        carti493.TextWrapped = true
        carti493.TextColor3 = Color3.fromRGB(195, 195, 215)
        carti493.Parent = carti491
        local carti494 = Instance.new('UICorner')
        carti494.CornerRadius = UDim.new(0, 4)
        carti494.Parent = carti493
        carti154.inventorySpawnerAgeButtons[carti492] = carti493
        carti493.MouseButton1Click:Connect(function()
            carti154.inventorySpawnerAgeIndex = carti492
            carti154.refreshInventorySpawnerAge()
        end)
    end

    carti154.inventorySpawnerFlags = { N = false, F = false, R = false, M = false }
    carti154.inventorySpawnerFlagButtons = {}
    local carti454 = Instance.new('Frame')
    carti454.Size = UDim2.new(1, -24, 0, 32)
    carti454.Position = UDim2.new(0, 12, 1, -40)
    carti454.BackgroundTransparency = 1
    carti454.Parent = carti417

    carti154.refreshInventorySpawnerFlags = function()
        for carti455, carti456 in pairs(carti154.inventorySpawnerFlagButtons) do
            local carti457 = carti154.inventorySpawnerFlags[carti455]
            carti456.BackgroundColor3 = carti457 and Color3.fromRGB(120, 72, 175) or Color3.fromRGB(48, 48, 62)
            carti456.TextColor3 = carti457 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(195, 195, 215)
        end
        if carti154.refreshInventorySpawnerAge then
            carti154.refreshInventorySpawnerAge()
        end
    end

    for carti458, carti459 in ipairs({ 'N', 'F', 'R', 'M' }) do
        local carti460 = Instance.new('TextButton')
        carti460.Size = UDim2.new(0.235, 0, 1, 0)
        carti460.Position = UDim2.new((carti458 - 1) * 0.255, 0, 0, 0)
        carti460.BackgroundColor3 = Color3.fromRGB(48, 48, 62)
        carti460.BorderSizePixel = 0
        carti460.Text = carti459
        carti460.Font = Enum.Font.FredokaOne
        carti460.TextSize = 14
        carti460.TextColor3 = Color3.fromRGB(195, 195, 215)
        carti460.Parent = carti454
        local carti461 = Instance.new('UICorner')
        carti461.CornerRadius = UDim.new(0, 4)
        carti461.Parent = carti460
        local carti462 = Instance.new('UIStroke')
        carti462.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        carti462.Color = carti459 == 'N' and Color3.fromRGB(175, 95, 255)
            or carti459 == 'F' and Color3.fromRGB(70, 175, 255)
            or carti459 == 'R' and Color3.fromRGB(255, 100, 175)
            or Color3.fromRGB(255, 185, 50)
        carti462.Thickness = 1
        carti462.Transparency = 0.2
        carti462.Parent = carti460
        carti154.inventorySpawnerFlagButtons[carti459] = carti460

        carti460.MouseButton1Click:Connect(function()
            if carti459 == 'N' and carti154.inventorySpawnerFlags.M then
                carti154.inventorySpawnerFlags.M = false
            elseif carti459 == 'M' and carti154.inventorySpawnerFlags.N then
                carti154.inventorySpawnerFlags.N = false
            end
            carti154.inventorySpawnerFlags[carti459] = not carti154.inventorySpawnerFlags[carti459]
            carti154.refreshInventorySpawnerFlags()
        end)
    end
    carti154.refreshInventorySpawnerFlags()
    carti154.refreshInventorySpawnerAge()

    local carti428 = {}
    local carti429 = {
        legendary = 1,
        ultra_rare = 2,
        rare = 3,
        uncommon = 4,
        common = 5,
    }
    for carti430, carti431 in pairs(carti26.pets or {}) do
        table.insert(carti428, {
            id = carti430,
            name = tostring(carti431.name or carti430),
            image = tostring(carti431.image or ''),
            rarity = tostring(carti431.rarity or ''):lower(),
            value = carti55(carti430, {
                flyable = false,
                rideable = false,
                neon = false,
                mega_neon = false,
            }),
        })
    end
    table.sort(carti428, function(carti432, carti433)
        local carti434 = carti429[carti432.rarity] or 99
        local carti435 = carti429[carti433.rarity] or 99
        if carti432.value ~= carti433.value then return carti432.value > carti433.value end
        if carti434 == carti435 then return carti432.name:lower() < carti433.name:lower() end
        return carti434 < carti435
    end)

    for carti436, carti437 in ipairs(carti428) do
        local carti438 = Instance.new('ImageButton')
        carti438.Name = 'Pet_' .. tostring(carti437.id)
        carti438.BackgroundColor3 = Color3.fromRGB(54, 45, 76)
        carti438.BackgroundTransparency = 0.08
        carti438.BorderSizePixel = 0
        carti438.Image = ''
        carti438.AutoButtonColor = false
        carti438.LayoutOrder = carti436
        carti438:SetAttribute('PetName', carti437.name)
        carti438.Parent = carti424
        local carti439 = Instance.new('UICorner')
        carti439.CornerRadius = UDim.new(0, 5)
        carti439.Parent = carti438
        local carti448 = Instance.new('UIStroke')
        carti448.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        carti448.Color = carti437.rarity == 'legendary' and Color3.fromRGB(255, 185, 50)
            or carti437.rarity == 'ultra_rare' and Color3.fromRGB(255, 90, 110)
            or carti437.rarity == 'rare' and Color3.fromRGB(70, 165, 255)
            or carti437.rarity == 'uncommon' and Color3.fromRGB(100, 225, 125)
            or Color3.fromRGB(170, 170, 180)
        carti448.Thickness = 1
        carti448.Transparency = 0.2
        carti448.Parent = carti438

        local carti449 = Instance.new('ImageLabel')
        carti449.Size = UDim2.fromOffset(64, 64)
        carti449.Position = UDim2.new(0.5, -32, 0, 4)
        carti449.BackgroundTransparency = 1
        carti449.BorderSizePixel = 0
        carti449.Image = carti437.image
        carti449.ScaleType = Enum.ScaleType.Fit
        carti449.Parent = carti438

        local carti450 = Instance.new('TextLabel')
        carti450.Size = UDim2.new(1, -6, 0, 30)
        carti450.Position = UDim2.new(0, 3, 1, -33)
        carti450.BackgroundTransparency = 1
        carti450.Text = carti437.name
        carti450.Font = Enum.Font.GothamBold
        carti450.TextSize = 9
        carti450.TextColor3 = Color3.fromRGB(255, 255, 255)
        carti450.TextWrapped = true
        carti450.TextYAlignment = Enum.TextYAlignment.Center
        carti450.Parent = carti438

        carti438.MouseButton1Click:Connect(function()
            carti161('inventory', function(carti454)
                carti454.pets = carti454.pets or {}
                for carti455 = 1, carti154.inventorySpawnerAmount do
                    local carti456 = math.clamp(carti154.inventorySpawnerAgeIndex or 1, 1, 6)
                    if carti154.inventorySpawnerFlags.M then
                        carti154.inventorySpawnerMegaSequence = (carti154.inventorySpawnerMegaSequence or 0) + 1
                    end
                    local carti457 = '2_' .. carti7:GenerateGUID(false)
                    carti454.pets[carti457] = {
                        unique = carti457,
                        category = 'pets',
                        carti_hub_local_pet = true,
                        id = carti437.id,
                        kind = carti437.id,
                        properties = {
                            rideable = carti154.inventorySpawnerFlags.R,
                            flyable = carti154.inventorySpawnerFlags.F,
                            neon = carti154.inventorySpawnerFlags.N,
                            mega_neon = carti154.inventorySpawnerFlags.M,
                            pet_trick_level = 0,
                            friendship_level = 0,
                            xp = carti154.inventorySpawnerFlags.M
                                and (carti154.inventorySpawnerMegaSequence / 10000)
                                or 0,
                            age = carti456,
                        },
                        newness_order = carti154.inventorySpawnerFlags.M
                            and (os.time() * 1000 + carti154.inventorySpawnerMegaSequence)
                            or 0,
                    }
                end
                return carti454
            end)
        end)

        if carti436 % 50 == 0 then task.wait() end
    end

    local carti451 = function()
        carti424.CanvasSize = UDim2.new(0, 0, 0, carti426.AbsoluteContentSize.Y + 8)
    end
    carti426:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(carti451)
    carti451()
    carti422:GetPropertyChangedSignal('Text'):Connect(function()
        local carti452 = carti422.Text:lower()
        for _, carti453 in ipairs(carti424:GetChildren()) do
            if carti453:IsA('ImageButton') then
                carti453.Visible = carti452 == '' or carti453:GetAttribute('PetName'):lower():find(carti452, 1, true) ~= nil
            end
        end
        task.defer(carti451)
    end)
end

carti154.inventorySpawnerButton.MouseButton1Click:Connect(carti154.openInventorySpawner)
