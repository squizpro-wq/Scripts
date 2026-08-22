for i, carti295 in ipairs(carti334) do
    local carti337 = Instance.new('TextButton')
    carti337.Size = UDim2.new(0.23, 0, 1, 0)
    carti337.Position = UDim2.new((i - 1) * 0.25 + 0.01, 0, 0, 0)
    carti337.Text = carti295
    carti337.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    carti337.BackgroundTransparency = 0.2
    carti337.Font = Enum.Font.FredokaOne
    carti337.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti337.TextSize = 13
    carti337.Parent = carti333
    Instance.new('UICorner', carti337).CornerRadius = UDim.new(0, 4)
    local carti316 = Instance.new('UIStroke')
    carti316.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    carti316.Color = carti335[carti295]
    carti316.Thickness = 1.0
    carti316.Transparency = 0.5
    carti316.Parent = carti337

    carti336[carti295] = { button = carti337, stroke = carti316 }

    carti337.MouseButton1Click:Connect(function()
        if carti295 == 'M' and carti75.activeFlags['N'] then return end
        if carti295 == 'N' and carti75.activeFlags['M'] then return end
        carti75.activeFlags[carti295] = not carti75.activeFlags[carti295]
        if carti75.activeFlags[carti295] then
            carti337.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            carti6:Create(carti316, TweenInfo.new(0.3, Enum.EasingStyle.Quad), { Color = Color3.fromRGB(0, 255, 0), Thickness = 1.2, Transparency = 0.2 }):Play()
        else
            carti337.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
            carti6:Create(carti316, TweenInfo.new(0.3, Enum.EasingStyle.Quad), { Color = carti335[carti295], Thickness = 1.0, Transparency = 0.5 }):Play()
        end
    end)
end

carti338 = Instance.new('TextLabel')
carti338.Size = UDim2.new(1, 0, 0, 14)
carti338.Position = UDim2.new(0, 0, 0, 68)
carti338.BackgroundTransparency = 1
carti338.Text = 'Add Pet Delay (s)'
carti338.Font = Enum.Font.SourceSansSemibold
carti338.TextSize = 10
carti338.TextColor3 = Color3.fromRGB(180, 180, 180)
carti338.TextXAlignment = Enum.TextXAlignment.Left
carti338.Parent = carti329

carti339 = Instance.new('TextBox')
carti339.Size = UDim2.new(1, 0, 0, 24)
carti339.Position = UDim2.new(0, 0, 0, 82)
carti339.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
carti339.BackgroundTransparency = 0.2
carti339.Text = tostring(carti69.ADD_PET_REQUEST_DELAY)
carti339.Font = Enum.Font.SourceSans
carti339.TextSize = 12
carti339.TextColor3 = Color3.fromRGB(255, 255, 255)
carti339.ClearTextOnFocus = false
carti339.TextXAlignment = Enum.TextXAlignment.Center
carti339.Parent = carti329
Instance.new('UICorner', carti339).CornerRadius = UDim.new(0, 4)

carti339.FocusLost:Connect(function()
    local carti232 = tonumber(carti339.Text)
    if carti232 and carti232 >= 0 then carti69.ADD_PET_REQUEST_DELAY = carti232 else carti339.Text = tostring(carti69.ADD_PET_REQUEST_DELAY) end
end)

carti340 = Instance.new('TextButton')
carti340.Size = UDim2.new(1, 0, 0, 26)
carti340.Position = UDim2.new(0, 0, 0, 114)
carti340.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
carti340.BackgroundTransparency = 0.2
carti340.Text = 'Add Pet to Trade'
carti340.Font = Enum.Font.FredokaOne
carti340.TextSize = 12
carti340.TextColor3 = Color3.fromRGB(255, 255, 255)
carti340.Parent = carti329
Instance.new('UICorner', carti340).CornerRadius = UDim.new(0, 4)

carti340.MouseButton1Click:Connect(function()
    local carti341 = carti331.Text
    if carti341 and carti341 ~= '' then carti105(carti341, carti75.activeFlags) end
end)

carti342 = Instance.new('TextButton')
carti342.Size = UDim2.new(1, 0, 0, 26)
carti342.Position = UDim2.new(0, 0, 0, 145)
carti342.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
carti342.BackgroundTransparency = 0.2
carti342.Text = 'Remove Latest Pet'
carti342.Font = Enum.Font.FredokaOne
carti342.TextSize = 12
carti342.TextColor3 = Color3.fromRGB(255, 255, 255)
carti342.Parent = carti329
Instance.new('UICorner', carti342).CornerRadius = UDim.new(0, 4)

carti342.MouseButton1Click:Connect(carti107)

carti343 = Instance.new('TextButton')
carti343.Size = UDim2.new(1, 0, 0, 26)
carti343.Position = UDim2.new(0, 0, 0, 176)
carti343.BackgroundColor3 = Color3.fromRGB(100, 50, 150)
carti343.BackgroundTransparency = 0.2
carti343.Text = 'Add Random High-Value Pet'
carti343.Font = Enum.Font.FredokaOne
carti343.TextSize = 10
carti343.TextColor3 = Color3.fromRGB(255, 255, 255)
carti343.Parent = carti329
Instance.new('UICorner', carti343).CornerRadius = UDim.new(0, 4)

carti343.MouseButton1Click:Connect(function()
    carti105(carti80(), carti111())
end)

carti344 = Instance.new('Frame')
carti344.Size = UDim2.new(1, 0, 0, 400)
carti344.Position = UDim2.new(0, 0, 0, 195)
carti344.BackgroundTransparency = 1
carti344.Parent = carti328

carti345 = Instance.new('TextLabel')
carti345.Size = UDim2.new(1, 0, 0, 16)
carti345.BackgroundTransparency = 1
carti345.Text = 'High-Value Pets (Balloon Unicorn+)'
carti345.Font = Enum.Font.SourceSansSemibold
carti345.TextSize = 11
carti345.TextColor3 = Color3.fromRGB(180, 180, 180)
carti345.TextXAlignment = Enum.TextXAlignment.Left
carti345.Parent = carti344

carti346 = Instance.new('ScrollingFrame')
carti346.Size = UDim2.new(1, 0, 0, 380)
carti346.Position = UDim2.new(0, 0, 0, 18)
carti346.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
carti346.BackgroundTransparency = 0.5
carti346.BorderSizePixel = 0
carti346.ScrollBarThickness = 4
carti346.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
carti346.ScrollBarImageTransparency = 0.5
carti346.Parent = carti344
Instance.new('UICorner', carti346).CornerRadius = UDim.new(0, 4)

carti347 = Instance.new('UIListLayout')
carti347.SortOrder = Enum.SortOrder.LayoutOrder
carti347.Padding = UDim.new(0, 3)
carti347.Parent = carti346

carti348 = Instance.new('UIPadding')
carti348.PaddingTop = UDim.new(0, 4)
carti348.PaddingBottom = UDim.new(0, 4)
carti348.PaddingLeft = UDim.new(0, 4)
carti348.PaddingRight = UDim.new(0, 4)
carti348.Parent = carti346

for i, carti341 in ipairs(carti77) do
    local carti315 = Instance.new('TextButton')
    carti315.Size = UDim2.new(1, -8, 0, 28)
    carti315.BackgroundColor3 = Color3.fromRGB(55, 50, 75)
    carti315.BackgroundTransparency = 0.1
    carti315.Text = carti341
    carti315.Font = Enum.Font.GothamBold
    carti315.TextSize = 10
    carti315.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti315.LayoutOrder = i
    carti315.Parent = carti346
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
        carti331.Text = carti341
        carti6:Create(carti332, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Color = Color3.fromRGB(255, 200, 50), Thickness = 1.5 }):Play()
        task.wait(0.5)
        carti6:Create(carti332, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Color = Color3.fromRGB(100, 100, 100), Thickness = 0.8 }):Play()
    end)
end

carti346.CanvasSize = UDim2.new(0,0, 0, (#carti77 * 31) + 8)

-- ==================== INVENTORY TAB ====================
carti154.inventoryTab = carti155['Inventory']
carti154.inventoryTitle = Instance.new('TextLabel')
carti154.inventoryTitle.Size = UDim2.new(1, 0, 0, 24)
carti154.inventoryTitle.Position = UDim2.new(0, 0, 0, 0)
carti154.inventoryTitle.BackgroundTransparency = 1
carti154.inventoryTitle.Text = 'Inventory'
carti154.inventoryTitle.Font = Enum.Font.FredokaOne
carti154.inventoryTitle.TextSize = 15
carti154.inventoryTitle.TextColor3 = Color3.fromRGB(240, 240, 255)
carti154.inventoryTitle.TextXAlignment = Enum.TextXAlignment.Left
carti154.inventoryTitle.Parent = carti154.inventoryTab

carti154.inventorySpawnerButton = Instance.new('TextButton')
carti154.inventorySpawnerButton.Size = UDim2.new(1, 0, 0, 30)
carti154.inventorySpawnerButton.Position = UDim2.new(0, 0, 0, 32)
carti154.inventorySpawnerButton.BackgroundColor3 = Color3.fromRGB(100, 50, 150)
carti154.inventorySpawnerButton.BackgroundTransparency = 0.15
carti154.inventorySpawnerButton.BorderSizePixel = 0
carti154.inventorySpawnerButton.Text = 'SPAWNER GUI'
carti154.inventorySpawnerButton.Font = Enum.Font.FredokaOne
carti154.inventorySpawnerButton.TextSize = 12
carti154.inventorySpawnerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
carti154.inventorySpawnerButton.Parent = carti154.inventoryTab
carti154.inventorySpawnerCorner = Instance.new('UICorner')
carti154.inventorySpawnerCorner.CornerRadius = UDim.new(0, 4)
carti154.inventorySpawnerCorner.Parent = carti154.inventorySpawnerButton

carti154.inventorySpawnerStroke = Instance.new('UIStroke')
carti154.inventorySpawnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
carti154.inventorySpawnerStroke.Color = Color3.fromRGB(190, 120, 255)
carti154.inventorySpawnerStroke.Thickness = 1
carti154.inventorySpawnerStroke.Transparency = 0.25
carti154.inventorySpawnerStroke.Parent = carti154.inventorySpawnerButton

carti154.inventorySpawnHighTierButton = Instance.new('TextButton')
carti154.inventorySpawnHighTierButton.Size = UDim2.new(1, 0, 0, 30)
carti154.inventorySpawnHighTierButton.Position = UDim2.new(0, 0, 0, 72)
carti154.inventorySpawnHighTierButton.BackgroundColor3 = Color3.fromRGB(125, 76, 180)
carti154.inventorySpawnHighTierButton.BackgroundTransparency = 0.15
carti154.inventorySpawnHighTierButton.BorderSizePixel = 0
carti154.inventorySpawnHighTierButton.Text = 'SPAWN ALL HIGH TIER PETS'
carti154.inventorySpawnHighTierButton.Font = Enum.Font.FredokaOne
carti154.inventorySpawnHighTierButton.TextSize = 11
carti154.inventorySpawnHighTierButton.TextColor3 = Color3.fromRGB(255, 255, 255)
carti154.inventorySpawnHighTierButton.Parent = carti154.inventoryTab
Instance.new('UICorner', carti154.inventorySpawnHighTierButton).CornerRadius = UDim.new(0, 4)

carti154.inventoryClearPetsButton = Instance.new('TextButton')
carti154.inventoryClearPetsButton.Size = UDim2.new(1, 0, 0, 30)
carti154.inventoryClearPetsButton.Position = UDim2.new(0, 0, 0, 108)
carti154.inventoryClearPetsButton.BackgroundColor3 = Color3.fromRGB(145, 58, 82)
carti154.inventoryClearPetsButton.BackgroundTransparency = 0.15
carti154.inventoryClearPetsButton.BorderSizePixel = 0
carti154.inventoryClearPetsButton.Text = 'CLEAR ALL PETS'
carti154.inventoryClearPetsButton.Font = Enum.Font.FredokaOne
carti154.inventoryClearPetsButton.TextSize = 11
carti154.inventoryClearPetsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
carti154.inventoryClearPetsButton.Parent = carti154.inventoryTab
Instance.new('UICorner', carti154.inventoryClearPetsButton).CornerRadius = UDim.new(0, 4)

carti154.inventoryRenameBox = Instance.new('TextBox')
carti154.inventoryRenameBox.Size = UDim2.new(0.7, -4, 0, 30)
carti154.inventoryRenameBox.Position = UDim2.new(0, 0, 0, 148)
carti154.inventoryRenameBox.BackgroundColor3 = Color3.fromRGB(45, 45, 58)
carti154.inventoryRenameBox.BorderSizePixel = 0
carti154.inventoryRenameBox.ClearTextOnFocus = false
carti154.inventoryRenameBox.PlaceholderText = 'Rename equipped pet...'
carti154.inventoryRenameBox.PlaceholderColor3 = Color3.fromRGB(165, 165, 185)
carti154.inventoryRenameBox.Text = ''
carti154.inventoryRenameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
carti154.inventoryRenameBox.Font = Enum.Font.Gotham
carti154.inventoryRenameBox.TextSize = 11
carti154.inventoryRenameBox.TextXAlignment = Enum.TextXAlignment.Left
carti154.inventoryRenameBox.Parent = carti154.inventoryTab
Instance.new('UICorner', carti154.inventoryRenameBox).CornerRadius = UDim.new(0, 4)

carti154.inventoryRenameButton = Instance.new('TextButton')
carti154.inventoryRenameButton.Size = UDim2.new(0.3, 0, 0, 30)
carti154.inventoryRenameButton.Position = UDim2.new(0.7, 0, 0, 148)
carti154.inventoryRenameButton.BackgroundColor3 = Color3.fromRGB(100, 50, 150)
carti154.inventoryRenameButton.BorderSizePixel = 0
carti154.inventoryRenameButton.Text = 'RENAME'
carti154.inventoryRenameButton.Font = Enum.Font.FredokaOne
carti154.inventoryRenameButton.TextSize = 10
carti154.inventoryRenameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
carti154.inventoryRenameButton.Parent = carti154.inventoryTab
Instance.new('UICorner', carti154.inventoryRenameButton).CornerRadius = UDim.new(0, 4)

carti154.renameInventoryPet = function()
    if carti154.renameNativeLocalPet and carti154.renameNativeLocalPet(carti154.inventoryRenameBox.Text) then
        carti154.inventoryRenameBox.Text = ''
        carti154.inventoryRenameBox.PlaceholderText = 'Pet renamed'
    else
        carti154.inventoryRenameBox.PlaceholderText = 'Equip a spawned pet first'
    end
    task.delay(1.5, function()
        if carti154.inventoryRenameBox.Parent then
            carti154.inventoryRenameBox.PlaceholderText = 'Rename equipped pet...'
        end
    end)
end
carti154.inventoryRenameButton.MouseButton1Click:Connect(carti154.renameInventoryPet)
carti154.inventoryRenameBox.FocusLost:Connect(function(carti415)
    if carti415 then carti154.renameInventoryPet() end
end)

carti154.organizeSpawnedPets = function(carti415)
    local carti416 = {
        common = 1,
        uncommon = 2,
        rare = 3,
        ultra_rare = 4,
        legendary = 5,
    }
    local carti417 = {}
    local carti418 = carti23.get('inventory')
    for _, carti419 in pairs(carti418 and carti418.pets or {}) do
        if carti419 and carti419.carti_hub_local_pet then
            local carti420 = carti26.pets and carti26.pets[carti419.kind]
            local carti421 = carti420 and carti415 and carti415[carti420.name]
            local carti422 = carti421 and tonumber(carti421['rvalue - nopotion'] or carti421.rvalue) or 0
            table.insert(carti417, {
                pet = carti419,
                rarity = carti416[(carti420 and carti420.rarity) or 'common'] or 0,
                value = carti422,
                name = (carti420 and carti420.name) or tostring(carti419.kind),
            })
        end
    end
    table.sort(carti417, function(carti423, carti424)
        if carti423.rarity ~= carti424.rarity then
            return carti423.rarity > carti424.rarity
        end
        if carti423.value ~= carti424.value then
            return carti423.value > carti424.value
        end
        return carti423.name < carti424.name
    end)
    local carti423 = os.time() * 1000
    carti161('inventory', function(carti424)
        for carti425, carti426 in ipairs(carti417) do
            carti426.pet.newness_order = carti423 + carti426.rarity * 100000 + (#carti417 - carti425)
        end
        return carti424
    end)
end

task.defer(function()
    carti154.organizeSpawnedPets(carti53)
end)

carti154.spawnAllHighTierPets = function()
    if carti154.inventoryHighTierSpawnBusy then
        return
    end
    carti154.inventoryHighTierSpawnBusy = true
    carti154.inventorySpawnHighTierButton.Text = 'CHECKING VALUES...'

    task.spawn(function()
        local carti415 = carti47()
        local carti416 = {}
        for _, carti417 in pairs(carti415 or {}) do
            if type(carti417) == 'table' and carti417.name then
                carti416[carti417.name] = carti417
            end
        end

        local carti417 = {}
        for carti418, carti419 in pairs(carti26.pets or {}) do
            local carti420 = carti419.name or carti45[carti418]
            local carti421 = carti420 and carti416[carti420]
            local carti422 = carti421 and tonumber(carti421['rvalue - nopotion'] or carti421.rvalue) or 0
            if carti422 > 50 then
                table.insert(carti417, { id = carti418, value = carti422 })
            end
        end
        table.sort(carti417, function(carti423, carti424)
            return carti423.value > carti424.value
        end)

        if #carti417 > 0 then
            carti161('inventory', function(carti423)
                carti423.pets = carti423.pets or {}
                for carti424, carti425 in ipairs(carti417) do
                    local carti426 = '2_' .. carti7:GenerateGUID(false)
                    carti423.pets[carti426] = {
                        unique = carti426,
                        category = 'pets',
                        carti_hub_local_pet = true,
                        id = carti425.id,
                        kind = carti425.id,
                        properties = {
                            rideable = false,
                            flyable = false,
                            neon = false,
                            mega_neon = false,
                            pet_trick_level = 0,
                            friendship_level = 0,
                            age = 1,
                        },
                        newness_order = os.time() * 1000,
                    }
                end
                return carti423
            end)
            carti154.organizeSpawnedPets(carti416)
        end

        carti154.inventoryHighTierSpawnBusy = false
        carti154.inventorySpawnHighTierButton.Text = #carti417 > 0
            and ('SPAWNED ' .. tostring(#carti417) .. ' HIGH TIER PETS')
            or 'NO HIGH TIER PETS FOUND'
        task.delay(1.6, function()
            if carti154.inventorySpawnHighTierButton.Parent then
                carti154.inventorySpawnHighTierButton.Text = 'SPAWN ALL HIGH TIER PETS'
            end
        end)
    end)
end

carti154.clearAllSpawnedPets = function()
    if carti154.clearLocalPetEquipState then
        carti154.clearLocalPetEquipState()
    end
    local carti415 = 0
    carti161('inventory', function(carti416)
        carti416.pets = carti416.pets or {}
        for carti417, carti418 in pairs(carti416.pets) do
            if carti418 and carti418.carti_hub_local_pet then
                carti416.pets[carti417] = nil
                carti415 += 1
            end
        end
        return carti416
    end)
    carti154.inventoryClearPetsButton.Text = carti415 > 0 and ('CLEARED ' .. tostring(carti415) .. ' PETS') or 'NO SPAWNED PETS'
    task.delay(1.4, function()
        if carti154.inventoryClearPetsButton.Parent then
            carti154.inventoryClearPetsButton.Text = 'CLEAR ALL PETS'
        end
    end)
end

carti154.inventorySpawnHighTierButton.MouseButton1Click:Connect(carti154.spawnAllHighTierPets)
carti154.inventoryClearPetsButton.MouseButton1Click:Connect(carti154.clearAllSpawnedPets)

carti154.inventoryToySpawnerTitle = Instance.new('TextLabel')
carti154.inventoryToySpawnerTitle.Size = UDim2.new(1, 0, 0, 20)
carti154.inventoryToySpawnerTitle.Position = UDim2.new(0, 0, 0, 188)
carti154.inventoryToySpawnerTitle.BackgroundTransparency = 1
carti154.inventoryToySpawnerTitle.Text = 'Toy Spawner'
carti154.inventoryToySpawnerTitle.Font = Enum.Font.FredokaOne
carti154.inventoryToySpawnerTitle.TextSize = 11
carti154.inventoryToySpawnerTitle.TextColor3 = Color3.fromRGB(225, 190, 255)
carti154.inventoryToySpawnerTitle.TextXAlignment = Enum.TextXAlignment.Left
carti154.inventoryToySpawnerTitle.Parent = carti154.inventoryTab

carti154.inventoryTopValueToys = {
    { id = 'candy_cannon', value = 138 },
    { id = 'flying_broomstick', value = 66 },
    { id = 'tombstone', value = 36 },
    { id = 'antler_chew_toy', value = 14 },
    { id = 'pumpkin_toy', value = 12 },
}

carti154.spawnToyById = function(carti415)
    local carti416 = carti26.toys and carti26.toys[carti415]
    if not carti416 then
        return false
    end
    local carti417 = '2_' .. carti7:GenerateGUID(false)
    carti161('inventory', function(carti418)
        carti418.toys = carti418.toys or {}
        carti418.toys[carti417] = {
            unique = carti417,
            category = 'toys',
            id = carti415,
            kind = carti415,
            properties = {},
            newness_order = os.time() * 1000,
        }
        return carti418
    end)
    return true
end

carti154.inventoryToySearchBox = Instance.new('TextBox')
carti154.inventoryToySearchBox.Size = UDim2.new(0.7, -4, 0, 26)
carti154.inventoryToySearchBox.Position = UDim2.new(0, 0, 0, 212)
carti154.inventoryToySearchBox.BackgroundColor3 = Color3.fromRGB(45, 45, 58)
carti154.inventoryToySearchBox.BorderSizePixel = 0
carti154.inventoryToySearchBox.ClearTextOnFocus = false
carti154.inventoryToySearchBox.PlaceholderText = 'Spawn toy by name...'
carti154.inventoryToySearchBox.PlaceholderColor3 = Color3.fromRGB(165, 165, 185)
carti154.inventoryToySearchBox.Text = ''
carti154.inventoryToySearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
carti154.inventoryToySearchBox.Font = Enum.Font.Gotham
carti154.inventoryToySearchBox.TextSize = 10
carti154.inventoryToySearchBox.TextXAlignment = Enum.TextXAlignment.Left
carti154.inventoryToySearchBox.Parent = carti154.inventoryTab
Instance.new('UICorner', carti154.inventoryToySearchBox).CornerRadius = UDim.new(0, 4)

carti154.inventoryToySpawnButton = Instance.new('TextButton')
carti154.inventoryToySpawnButton.Size = UDim2.new(0.3, 0, 0, 26)
carti154.inventoryToySpawnButton.Position = UDim2.new(0.7, 0, 0, 212)
carti154.inventoryToySpawnButton.BackgroundColor3 = Color3.fromRGB(112, 62, 168)
carti154.inventoryToySpawnButton.BorderSizePixel = 0
carti154.inventoryToySpawnButton.Text = 'SPAWN'
carti154.inventoryToySpawnButton.Font = Enum.Font.FredokaOne
carti154.inventoryToySpawnButton.TextSize = 10
carti154.inventoryToySpawnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
carti154.inventoryToySpawnButton.Parent = carti154.inventoryTab
Instance.new('UICorner', carti154.inventoryToySpawnButton).CornerRadius = UDim.new(0, 4)

carti154.spawnToyByName = function()
    local carti415 = carti154.inventoryToySearchBox.Text:lower():gsub('^%s+', ''):gsub('%s+$', '')
    if carti415 == '' then
        return false
    end
    local carti416 = nil
    for carti417, carti418 in pairs(carti26.toys or {}) do
        local carti419 = tostring(carti418.name or carti417):lower()
        if carti419 == carti415 then
            carti416 = carti417
            break
        end
        if not carti416 and carti419:find(carti415, 1, true) then
            carti416 = carti417
        end
    end
    if carti416 and carti154.spawnToyById(carti416) then
        carti154.inventoryToySearchBox.Text = ''
        carti154.inventoryToySearchBox.PlaceholderText = 'Toy spawned'
        task.delay(1, function()
            if carti154.inventoryToySearchBox.Parent then
                carti154.inventoryToySearchBox.PlaceholderText = 'Spawn toy by name...'
            end
        end)
        return true
    end
    carti154.inventoryToySearchBox.PlaceholderText = 'Toy not found'
    task.delay(1, function()
        if carti154.inventoryToySearchBox.Parent then
            carti154.inventoryToySearchBox.PlaceholderText = 'Spawn toy by name...'
        end
    end)
    return false
end

carti154.inventoryToySpawnButton.MouseButton1Click:Connect(carti154.spawnToyByName)
carti154.inventoryToySearchBox.FocusLost:Connect(function(carti415)
    if carti415 then carti154.spawnToyByName() end
end)

carti154.inventoryToySpawnerButtons = {}
for carti415, carti416 in ipairs(carti154.inventoryTopValueToys) do
    local carti417 = carti26.toys and carti26.toys[carti416.id]
    if carti417 then
        local carti418 = Instance.new('TextButton')
        carti418.Size = UDim2.new(1, -27, 0, 25)
        carti418.Position = UDim2.new(0, 27, 0, 244 + (carti415 - 1) * 27)
        local carti419 = ({
            legendary = Color3.fromRGB(144, 104, 42),
            ultra_rare = Color3.fromRGB(83, 95, 164),
            rare = Color3.fromRGB(48, 105, 171),
            uncommon = Color3.fromRGB(56, 128, 79),
            common = Color3.fromRGB(82, 82, 98),
        })[carti417.rarity or 'common'] or Color3.fromRGB(67, 47, 98)
        carti418.BackgroundColor3 = carti419
        carti418.BackgroundTransparency = 0.12
        carti418.BorderSizePixel = 0
        carti418.Text = tostring(carti417.name or carti416.id)
        carti418.Font = Enum.Font.GothamBold
        carti418.TextSize = 10
        carti418.TextColor3 = Color3.fromRGB(245, 240, 255)
        carti418.TextXAlignment = Enum.TextXAlignment.Left
        carti418.Parent = carti154.inventoryTab
        Instance.new('UICorner', carti418).CornerRadius = UDim.new(0, 4)

        local carti420 = Instance.new('ImageLabel')
        carti420.Size = UDim2.new(0, 25, 0, 25)
        carti420.Position = UDim2.new(0, 0, 0, 244 + (carti415 - 1) * 27)
        carti420.BackgroundColor3 = carti419
        carti420.BackgroundTransparency = 0.12
        carti420.BorderSizePixel = 0
        carti420.Image = tostring(carti417.image or '')
        carti420.ScaleType = Enum.ScaleType.Fit
        carti420.ZIndex = carti418.ZIndex
        carti420.Parent = carti154.inventoryTab
        Instance.new('UICorner', carti420).CornerRadius = UDim.new(0, 4)

        local carti421 = Instance.new('UIPadding')
        carti421.PaddingLeft = UDim.new(0, 7)
        carti421.Parent = carti418
        local carti422 = Instance.new('UIStroke')
        carti422.Color = carti419:Lerp(Color3.fromRGB(255, 255, 255), 0.4)
        carti422.Transparency = 0.18
        carti422.Thickness = 1
        carti422.Parent = carti418
        carti154.inventoryToySpawnerButtons[carti416.id] = carti418

        carti418.MouseButton1Click:Connect(function()
            if carti154.spawnToyById(carti416.id) then
                local carti423 = carti418.Text
                carti418.Text = 'SPAWNED ' .. tostring(carti417.name or carti416.id)
                task.delay(0.9, function()
                    if carti418.Parent then
                        carti418.Text = carti423
                    end
                end)
            end
        end)
    end
end

carti154.inventorySpawnTopToysButton = Instance.new('TextButton')
carti154.inventorySpawnTopToysButton.Name = 'SpawnTopToysButton'
carti154.inventorySpawnTopToysButton.Size = UDim2.new(1, 0, 0, 30)
carti154.inventorySpawnTopToysButton.Position = UDim2.new(0, 0, 0, 384)
carti154.inventorySpawnTopToysButton.BackgroundColor3 = Color3.fromRGB(118, 67, 180)
carti154.inventorySpawnTopToysButton.BorderSizePixel = 0
carti154.inventorySpawnTopToysButton.Text = 'SPAWN ALL HIGH LEVEL TOYS (5X EACH)'
carti154.inventorySpawnTopToysButton.TextColor3 = Color3.fromRGB(255, 245, 255)
carti154.inventorySpawnTopToysButton.Font = Enum.Font.GothamBold
carti154.inventorySpawnTopToysButton.TextSize = 10
carti154.inventorySpawnTopToysButton.Parent = carti154.inventoryTab
Instance.new('UICorner', carti154.inventorySpawnTopToysButton).CornerRadius = UDim.new(0, 5)

carti154.inventorySpawnTopToysButton.MouseButton1Click:Connect(function()
    local carti415 = 0
    for _, carti416 in ipairs(carti154.inventoryTopValueToys) do
        for _ = 1, 5 do
            if carti154.spawnToyById(carti416.id) then
                carti415 += 1
            end
        end
    end

    local carti417 = carti154.inventorySpawnTopToysButton.Text
    carti154.inventorySpawnTopToysButton.Text = 'SPAWNED ' .. tostring(carti415) .. ' TOYS'
    task.delay(1.2, function()
        if carti154.inventorySpawnTopToysButton.Parent then
            carti154.inventorySpawnTopToysButton.Text = carti417
        end
    end)
end)
