function carti121()
    carti30._get_local_trade_state = function(self)
        if carti74.active and carti74.trade then return carti24.deep_copy(carti74.trade) end
        return carti74.originalFunctions._get_local_trade_state(self)
    end

    carti30._overwrite_local_trade_state = function(self, newState)
        if carti74.active then
            if newState then
                carti74.trade = newState
                self.local_trade_state = newState
                if carti74.trade then carti74.trade.subscriber_count = carti69.SPECTATOR_COUNT end
                if self._on_local_trade_state_changed then self:_on_local_trade_state_changed(newState, newState) end
                if self.refresh_all then self:refresh_all() carti37(true) end
            else
                carti74.trade = nil
                carti74.active = false
                carti74.scamWarningShown = false
                carti74.canShowTradeRequest = true
                carti74.tradeRequestBlocked = false
                self.local_trade_state = nil
                carti118()
            end
        else
            return carti74.originalFunctions._overwrite_local_trade_state(self, newState)
        end
    end

    carti30._get_my_offer = function(self)
        local carti122 = self:_get_local_trade_state()
        if carti74.active and carti122 then
            if carti2.LocalPlayer == carti122.sender then return carti122.sender_offer, 'sender_offer' else return carti122.recipient_offer, 'recipient_offer' end
        end
        return carti74.originalFunctions._get_my_offer(self)
    end

    carti30._get_partner_offer = function(self)
        local carti122 = self:_get_local_trade_state()
        if carti74.active and carti122 then
            if carti2.LocalPlayer == carti122.sender then return carti122.recipient_offer, 'recipient_offer' else return carti122.sender_offer, 'sender_offer' end
        end
        return carti74.originalFunctions._get_partner_offer(self)
    end

    carti30._get_my_player = function(self)
        if carti74.active and carti74.trade then return carti2.LocalPlayer end
        return carti74.originalFunctions._get_my_player(self)
    end

    carti30._get_partner = function(self)
        if carti74.active and carti74.trade then return carti74.trade.recipient end
        return carti74.originalFunctions._get_partner(self)
    end

    carti30._get_current_trade_stage = function(self)
        if carti74.active and carti74.trade then return carti74.trade.current_stage end
        return carti74.originalFunctions._get_current_trade_stage(self)
    end

    carti30._change_local_trade_state = function(self, changes)
        if carti74.active then
            local function carti123(target, source)
                for k, carti152 in pairs(source) do
                    if type(carti152) == 'table' and target[k] and type(target[k]) == 'table' then carti123(target[k], carti152) else target[k] = carti152 end
                end
                return target
            end
            self:_overwrite_local_trade_state(carti123(self:_get_local_trade_state(), changes))
        else
            return carti74.originalFunctions._change_local_trade_state(self, changes)
        end
    end

    carti30._get_lock_time = function(self)
        if carti74.active and carti74.trade then
            if self:_get_current_trade_stage() == 'negotiation' then return carti69.NEGOTIATION_LOCK
            else return math.clamp(carti69.CONFIRMATION_LOCK_PER_ITEM * (#carti74.trade.sender_offer.items + #carti74.trade.recipient_offer.items), 5, 15) end
        end
        return carti74.originalFunctions._get_lock_time(self)
    end

    carti30._lock_trade_for_appropriate_time = function(self)
        if carti74.active then
            if self.lock_countdown then self.lock_countdown:stop() self.lock_countdown:set_duration(self:_get_lock_time()) self.lock_countdown:start() end
        else
            return carti74.originalFunctions._lock_trade_for_appropriate_time(self)
        end
    end

    carti30._add_item_to_my_offer = function(self)
        if carti74.active and carti74.trade then
            if carti74.isAddingItem then return end
            carti74.isAddingItem = true
            
            local carti124 = nil
            pcall(function()
                carti124 = carti31:pick_item({ 
                    keep_cached_scroll_positions_on_open = true, 
                    allow_callback = function() return true end 
                })
            end)
            
            if carti124 then
                local carti125 = false
                for _, item in ipairs(carti74.trade.sender_offer.items) do 
                    if item.unique == carti124.unique then 
                        carti125 = true 
                        break 
                    end 
                end
                if not carti125 then
                    table.insert(carti74.trade.sender_offer.items, carti124)
                    carti74.trade.sender_offer.negotiated = false
                    carti74.trade.recipient_offer.negotiated = false
                    if carti74.trade.current_stage == 'confirmation' then
                        carti74.trade.current_stage = 'negotiation'
                        carti74.trade.sender_offer.confirmed = false
                        carti74.trade.recipient_offer.confirmed = false
                    end
                    carti74.trade.offer_version = carti74.trade.offer_version + 1
                    pcall(function() self:_overwrite_local_trade_state(carti74.trade) end)
                    pcall(function() self:_lock_trade_for_appropriate_time() end)
                    pcall(function()
                        if carti31 and carti31.set_item_unique_hidden then 
                            carti31:set_item_unique_hidden(carti124.unique, 'TradeApp') 
                        end
                    end)
                end
            end
            carti74.isAddingItem = false
        else
            return carti74.originalFunctions._add_item_to_my_offer(self)
        end
    end

    carti30._remove_item_from_my_offer = function(self, item)
        if carti74.active and carti74.trade then
            for i, carti152 in ipairs(carti74.trade.sender_offer.items) do
                if carti152.unique == item.unique then
                    table.remove(carti74.trade.sender_offer.items, i)
                    carti74.trade.sender_offer.negotiated = false
                    carti74.trade.recipient_offer.negotiated = false
                    if carti74.trade.current_stage == 'confirmation' then
                        carti74.trade.current_stage = 'negotiation'
                        carti74.trade.recipient_offer.negotiated = false
                        carti74.trade.sender_offer.confirmed = false
                        carti74.trade.recipient_offer.confirmed = false
                    end
                    carti74.trade.offer_version = carti74.trade.offer_version + 1
                    self:_overwrite_local_trade_state(carti74.trade)
                    if self._lock_trade_for_appropriate_time then self:_lock_trade_for_appropriate_time() end
                    if carti31.reset_hidden_item_tag then carti31:reset_hidden_item_tag('TradeApp') end
                    break
                end
            end
        else
            return carti74.originalFunctions._remove_item_from_my_offer(self, item)
        end
    end

    carti30._on_accept_pressed = function(self)
        if carti74.active and carti74.trade then
            if carti74.trade.sender_offer.negotiated then
                carti74.trade.sender_offer.negotiated = false
                carti74.trade.offer_version = carti74.trade.offer_version + 1
                self:_overwrite_local_trade_state(carti74.trade)
            else
                carti74.trade.sender_offer.negotiated = true
                if carti74.trade.recipient_offer.negotiated then
                    carti74.trade.current_stage = 'confirmation'
                    carti74.trade.offer_version = carti74.trade.offer_version + 1
                    self:_overwrite_local_trade_state(carti74.trade)
                    if carti30._evaluate_trade_fairness then carti30:_evaluate_trade_fairness() end
                    if carti30._lock_trade_for_appropriate_time then carti30:_lock_trade_for_appropriate_time() end
                else
                    carti74.trade.offer_version = carti74.trade.offer_version + 1
                    self:_overwrite_local_trade_state(carti74.trade)
                end
            end
            if carti69.AUTO_PARTNER and not carti74.trade.recipient_offer.negotiated and carti74.trade.sender_offer.negotiated then task.spawn(carti119) end
        else
            return carti74.originalFunctions._on_accept_pressed(self)
        end
    end

    carti30._on_confirm_pressed = function(self)
        if carti74.active and carti74.trade then
            if carti74.removePartnerPetsOnConfirm then carti117() end
            carti74.trade.sender_offer.confirmed = true
            carti74.trade.offer_version = carti74.trade.offer_version + 1
            self:_overwrite_local_trade_state(carti74.trade)
            if carti69.AUTO_PARTNER and not carti74.trade.recipient_offer.confirmed then task.spawn(carti119) end
        else
            return carti74.originalFunctions._on_confirm_pressed(self)
        end
    end

    carti30._on_unaccept_pressed = function(self)
        if carti74.active and carti74.trade then
            carti74.trade.sender_offer.negotiated = false
            if carti74.trade.current_stage == 'confirmation' then
                carti74.trade.current_stage = 'negotiation'
                carti74.trade.recipient_offer.negotiated = false
                carti74.trade.sender_offer.confirmed = false
                carti74.trade.recipient_offer.confirmed = false
            end
            carti74.trade.offer_version = carti74.trade.offer_version + 1
            self:_overwrite_local_trade_state(carti74.trade)
        else
            return carti74.originalFunctions._on_unaccept_pressed(self)
        end
    end

    carti30._decline_trade = function(self, silent)
        if carti74.active then
            if self.lock_countdown then self.lock_countdown:stop() end
            carti74.active = false
            carti74.trade = nil
            carti74.isAddingItem = false
            carti74.partnerActionPending = false
            carti74.tradeCompleting = false
            carti74.scamWarningShown = false
            carti74.canShowTradeRequest = true
            carti74.tradeRequestBlocked = false
            self:_overwrite_local_trade_state(nil)
            carti22.set_app_visibility('TradeApp', false)
            if carti31.reset_hidden_item_tag then carti31:reset_hidden_item_tag('TradeApp') end
            carti118()
        else
            return carti74.originalFunctions._decline_trade(self, silent)
        end
    end

    carti30._evaluate_trade_fairness = function(self)
        if carti74.active and carti74.trade and not carti74.scamWarningShown then
            local carti126 = #carti74.trade.sender_offer.items
            local carti108 = #carti74.trade.recipient_offer.items
            if carti126 > 0 and carti108 == 0 then
                carti74.scamWarningShown = true
                if carti33 then
                    carti33:dialog({ text = 'This trade seems unbalanced. Be careful - you could be getting scammed.', button = 'Next', yields = false })
                    carti33:dialog({ text = 'Any items lost to scams WILL NOT be returned. Be sure before you accept!', button = 'I understand', yields = false })
                end
            end
        else
            return carti74.originalFunctions._evaluate_trade_fairness(self)
        end
    end
end

carti121()

-- FIXED: Function to start mock trade directly without dialog issues
function carti127()
    -- Only prevent if already in a trade
    if carti74.active then return end
    
    local carti12, carti128 = pcall(function()
        -- Reset all states first
        carti74.active = false
        carti74.trade = nil
        carti74.isAddingItem = false
        carti74.partnerActionPending = false
        carti74.tradeCompleting = false
        carti74.scamWarningShown = true
        carti74.tradeRequestBlocked = true
        carti74.blockedTradeRequests = {}
        carti74.pendingTradeRequest = false
        
        -- Create mock trade
        carti74.trade = carti93()
        
        -- Set active immediately
        carti74.active = true
        
        -- Close any existing trade UI
        pcall(function() carti22.set_app_visibility('TradeApp', false) end)
        task.wait(0.05)
        
        -- Overwrite trade state
        pcall(function() carti30:_overwrite_local_trade_state(carti74.trade) end)
        task.wait(0.05)
        
        -- Show trade UI
        pcall(function() carti22.set_app_visibility('TradeApp', true) end)
        pcall(function() carti37(true) end)
        
        -- Show intro message (public chat notice)
        pcall(function()
            if carti30._show_intro_message then
                carti30:_show_intro_message()
            end
        end)
        
        task.wait(0.05)
        pcall(function() 
            if carti30.refresh_all then 
                carti30:refresh_all() 
                carti37(true) 
            end 
        end)
    end)
    
    if not carti12 and carti32 then
        carti32:hint({ text = 'Error starting trade: ' .. tostring(carti128), length = 5, overridable = true })
    end
end

-- FIXED: showTradeRequest function with proper dialog handling
function carti129()
    if carti74.pendingTradeRequest or carti74.active then
        return
    end
    carti74.pendingTradeRequest = true
    carti74.canShowTradeRequest = false
    task.wait(carti69.TRADE_REQUEST_DELAY)
    if not carti74.pendingTradeRequest or carti74.active then
        carti74.pendingTradeRequest = false
        carti74.canShowTradeRequest = true
        return
    end
    
    local carti130 = carti69.PARTNER_NAME
    local carti131 = { 
        ["text"] = carti130 .. " sent you a trade request", 
        ["left"] = "Decline", 
        ["right"] = "Accept", 
        ["header"] = {
            ["text"] = "Verified Friend",
            ["icon"] = "rbxassetid://84667805159408" 
        },
        ["tooltip_options"] = {
            ["force_display_post_trade_values"] = true
        },
        ["yields"] = true
    } 
    local carti132 = { 
        ["text"] = carti130 .. " sent you a trade request", 
        ["left"] = "Decline", 
        ["right"] = "Accept",
        ["yields"] = true
    } 
    
    -- Set flag so hookDialogApp doesn't interfere
    carti74.isMockTradeDialog = true
    
    local carti133
    local carti12, carti128 = pcall(function()
        -- Use original function directly to avoid hook interference
        if carti74.originalDialogFunction then
            if carti69.FRIEND_PARTNER then
                carti133 = carti74.originalDialogFunction(carti33, carti131)
            else
                carti133 = carti74.originalDialogFunction(carti33, carti132)
            end
        else
            if carti69.FRIEND_PARTNER then
                carti133 = carti33:dialog(carti131)
            else
                carti133 = carti33:dialog(carti132)
            end
        end
    end)
    
    carti74.isMockTradeDialog = false
    carti74.pendingTradeRequest = false
    
    if carti12 and carti133 and (carti133 == "Accept" or carti133 == "right") then
        carti127()
    else
        carti74.canShowTradeRequest = true
    end
end

function carti134()
    local carti135 = carti25.get_event('TradeAPI/TradeRequestReceived')
    if carti135 then
        local carti136 = getconnections(carti135.OnClientEvent)
        for _, connection in pairs(carti136) do connection:Disable() end
        carti135.OnClientEvent:Connect(function(carti139)
            if carti74.active or carti74.tradeRequestBlocked then
                table.insert(carti74.blockedTradeRequests, { player = carti139, timestamp = tick() })
                return
            end
            for _, connection in pairs(carti136) do
                if connection.Function then connection.Function(carti139) end
            end
        end)
    end
end

-- FIXED: hookDialogApp to not interfere with mock trade dialogs
function carti137()
    if not carti33 or not carti33.dialog then return end
    carti74.originalDialogFunction = carti33.dialog
    carti33.dialog = function(self, dialogData)
        -- Don't interfere with expired dialogs
        if dialogData and dialogData.text and string.find(dialogData.text, 'has expired!') then return 'Okay' end
        
        -- FIXED: Don't auto-decline if this is our mock trade dialog
        if carti74.isMockTradeDialog then
            return carti74.originalDialogFunction(self, dialogData)
        end
        
        -- FIXED: Also check for Verified Friend header to not auto-decline our dialogs
        if dialogData and dialogData.header and type(dialogData.header) == 'table' and dialogData.header.text == 'Verified Friend' then
            return carti74.originalDialogFunction(self, dialogData)
        end
        
        -- Auto-decline real trade requests while mock trade is active
        if dialogData and dialogData.handle == 'trade_request' then
            if carti74.pendingTradeRequest or carti74.active or carti74.tradeRequestBlocked then return 'Decline' end
        end
        
        return carti74.originalDialogFunction(self, dialogData)
    end
end

carti137()
carti134()

carti118 = function()
    if #carti74.blockedTradeRequests > 0 then
        task.wait(0.5)
        local carti138 = carti20('TradeExcluder')
        for _, request in ipairs(carti74.blockedTradeRequests) do
            local carti139 = request.player
            if carti138 and carti138.is_player_excluded(carti139) then
                carti25.get('TradeAPI/AcceptOrDeclineTradeRequest'):InvokeServer(carti139, false)
            else
                if carti33 and carti74.originalDialogFunction then
                    local carti48 = carti74.originalDialogFunction(carti33, {
                        text = string.format('%s sent you a trade request', carti139.Name),
                        left = 'Decline', right = 'Accept', handle = 'trade_request',
                    })
                    if carti48 == 'Accept' then
                        local carti140 = true
                        if carti30._confirm_player_if_suspicious then carti140 = carti30:_confirm_player_if_suspicious(carti139) end
                        if carti140 and not carti30:check_and_warn_if_trading_restricted() then carti30:show_scam_warning() end
                        carti25.get('TradeAPI/AcceptOrDeclineTradeRequest'):InvokeServer(carti139, carti140)
                    else
                        carti25.get('TradeAPI/AcceptOrDeclineTradeRequest'):InvokeServer(carti139, false)
                    end
                end
            end
        end
        carti74.blockedTradeRequests = {}
    end
end

-- Hook partner profile button to show mock partner's profile
task.spawn(function()
    task.wait(1) -- Wait for TradeApp to fully initialize
    pcall(function()
        if carti30 and carti30.partner_profile_button then
            local carti141 = carti30.partner_profile_button
            if carti141.callbacks and carti141.callbacks.mouse_button1_click then
                local carti142 = carti141.callbacks.mouse_button1_click
                carti141.callbacks.mouse_button1_click = function()
                    if carti74.active and carti74.trade and carti74.trade.recipient then
                        if carti35 and carti35.open_player_profile_for_user_id then 
                            carti35:open_player_profile_for_user_id(carti74.trade.recipient.UserId) 
                        end
                    else
                        if carti142 then carti142() end
                    end
                end
            end
        end
    end)
end)

function updatePartnerFromUsername(username)
    local carti12, carti143 = pcall(function() return carti2:GetUserIdFromNameAsync(username) end)
    if carti12 and carti143 then
        carti69.PARTNER_USER_ID = carti143
        carti69.PARTNER_NAME = username
        carti92 = carti87()
        return true
    else
        carti69.PARTNER_NAME = username
        carti92 = carti87()
        return false
    end
end

function carti144(carti181, carti180)
    local carti145 = carti20('new:PetRigs')
    local carti146 = carti181:FindFirstChild('PetModel') or carti181
    local carti147 = carti26.pets[carti180]
    if not carti147 or not carti147.neon_parts then return end
    for neonPart, configuration in pairs(carti147.neon_parts) do
        local carti148 = carti145.get(carti146).get_geo_part(carti146, neonPart)
        if carti148 then
            carti148.Material = Enum.Material.Neon
            local carti149 = configuration.Color
            if carti149 then
                local carti150, carti151, carti152 = carti149:ToHSV()
                carti148.Color = Color3.fromHSV(carti150, math.min(carti151 * 1.3, 1), math.min(carti152 * 1.4, 1))
            else
                carti148.Color = Color3.fromRGB(170, 0, 255)
            end
        end
    end
end

function carti153(carti181, carti180)
    local carti145 = carti20('new:PetRigs')
    local carti146 = carti181:FindFirstChild('PetModel') or carti181
    local carti147 = carti26.pets[carti180]
    if not carti147 or not carti147.neon_parts then return end
    for neonPart, configuration in pairs(carti147.neon_parts) do
        local carti148 = carti145.get(carti146).get_geo_part(carti146, neonPart)
        if carti148 then
            carti148.Material = Enum.Material.Neon
            if configuration.Color then carti148.Color = configuration.Color end
        end
    end
end

carti154 = {
    currentTab = 'Control',
    tabFrames = {},
    tabButtons = {},
    activeTabPulseTween = nil,
    hasShownAnimation = {},
    playerListButtons = {},
    userListButtons = {},
    petListButtons = {},
    noclipEnabled = true,
    selectedPlayers = {},
    selectionMode = false,
    pulsationTweens = {},
    richestData = {},
    expandedPlayers = {},
    keybinds = {
        selectPartner = Enum.KeyCode.P,
        addRandomItem = Enum.KeyCode.R,
        startTrade = Enum.KeyCode.T,
        blockPlayer = Enum.KeyCode.B
    },
    waitingForKeybind = nil
}
carti155 = carti154.tabFrames
carti156 = carti154.tabButtons
carti157 = carti154.richestData
carti158 = carti154.expandedPlayers

carti159 = {}
carti160 = {}

function carti161(carti60, action)
    local carti162 = carti23.get(carti60)
    local carti163 = table.clone(carti162)
    carti23.predict(carti60, action(carti163))
end

carti164 = { running = false, checkInterval = 0.3, animationTracks = {} }

function carti164:Start()
    if self.running then return end
    self.running = true
    task.spawn(function()
        while self.running do
            task.wait(self.checkInterval)
            for _, carti147 in ipairs(carti160) do
                if carti147 and carti147.model and carti147.model.Parent then
                    pcall(function()
                        local carti165 = carti147.character
                        if carti165 and carti165.Parent then
                            local carti166 = carti165:FindFirstChild('Humanoid')
                            if carti166 then
                                local carti167 = carti166:FindFirstChild('Animator')
                                if carti167 then
                                    local carti168 = false
                                    for _, carti190 in ipairs(carti167:GetPlayingAnimationTracks()) do
                                        if carti190.Animation.AnimationId:find('PlayerRidingPet') or carti190.Animation.AnimationId:find('507766666') then carti168 = true break end
                                    end
                                    if not carti168 and carti147.hasRidingPet then
                                        if not carti147.ridingAnim or not carti147.ridingAnim.IsPlaying then
                                            if carti147.ridingAnim then carti147.ridingAnim:Stop() end
                                            carti147.ridingAnim = carti167:LoadAnimation(carti28.get_track('PlayerRidingPet'))
                                            carti147.ridingAnim.Looped = true
                                            carti147.ridingAnim:Play()
                                            carti166.Sit = true
                                        end
                                    end
                                end
                            end
                        end
                        if carti147.wrapper.mega_neon then carti144(carti147.model, carti147.wrapper.pet_id)
                        elseif carti147.wrapper.neon then carti153(carti147.model, carti147.wrapper.pet_id) end
                    end)
                end
            end
        end
    end)
end

function carti164:Stop()
    self.running = false
    for _, carti147 in ipairs(carti160) do
        if carti147.ridingAnim then carti147.ridingAnim:Stop() end
    end
end

function carti164:AddPet(carti147)
    table.insert(carti160, carti147)
    if not self.running then self:Start() end
end

function carti169(fakeCharacter, carti88, partnerId)
    return setmetatable({
        Name = carti88, DisplayName = carti88, UserId = partnerId, Character = fakeCharacter,
    }, {
        __index = function(t, k)
            if k == 'Parent' then return carti2 end
            if k == 'IsA' then return function(self, className) return className == 'Player' end end
            if k == 'GetChildren' then return function() return {} end end
            return rawget(t, k)
        end,
        __tostring = function() return carti88 end
    })
end

function OpenProfile(Id)
    carti22.apps.PlayerProfileApp:open_player_profile_for_user_id(Id)
end

task.spawn(function()
    task.wait(0.1)
    local carti170 = carti20('InteractionsEngine')
    local carti171 = carti170.register
    carti170.register = function(self, interactionData)
        if interactionData and interactionData.part then
            local carti172 = interactionData.part
            while carti172 do
                if carti172:GetAttribute('IsFakePet') == true and carti172.Parent then return end
                carti172 = carti172.Parent
            end
        end
        return carti171(self, interactionData)
    end
end)

carti173 = 'regular'
