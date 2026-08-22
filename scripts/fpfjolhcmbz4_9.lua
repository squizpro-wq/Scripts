carti154.installLocalPetEquipFlow = function()
    carti154.clientToolManager = carti20('ClientToolManager')
    carti154.petEntityManager = carti20('PetEntityManager')
    carti154.charWrapperClient = carti20('CharWrapperClient')
    local carti453 = (getgenv and getgenv()) or _G
    local carti454 = carti453.CartiHubAdoptMeLocalPetHooks

    if carti454 and carti454.manager == carti154.clientToolManager then
        pcall(carti454.clear)
        if carti454.equip then
            carti154.clientToolManager.equip = carti454.equip
        end
        if carti454.unequip then
            carti154.clientToolManager.unequip = carti454.unequip
        end
        if carti454.backpackEquip then
            carti154.clientToolManager.backpack_equip = carti454.backpackEquip
        end
    elseif getupvalues then
        pcall(function()
            for _, carti455 in pairs(getupvalues(carti154.clientToolManager.equip)) do
                if type(carti455) == 'table'
                    and carti455.originalClientToolEquip
                    and carti455.originalClientToolUnequip then
                    if carti455.clearNativeLocalPetEntity then
                        carti455.clearNativeLocalPetEntity()
                    end
                    carti154.clientToolManager.equip = carti455.originalClientToolEquip
                    carti154.clientToolManager.unequip = carti455.originalClientToolUnequip
                    if carti455.originalClientToolBackpackEquip then
                        carti154.clientToolManager.backpack_equip = carti455.originalClientToolBackpackEquip
                    end
                    break
                end
            end
        end)
    end

    if carti454 and carti454.stopMountButton then
        pcall(function()
            carti22.apps.ExtraButtonsApp:unregister_button(carti454.stopMountButton)
        end)
    end

    carti154.originalClientToolEquip = carti154.clientToolManager.equip
    carti154.originalClientToolUnequip = carti154.clientToolManager.unequip
    carti154.originalClientToolBackpackEquip = carti154.clientToolManager.backpack_equip
    carti154.nativeLocalPetStopMountButton = carti22.apps.ExtraButtonsApp:register_button({
        priority = 4,
        text = 'Stop Ride',
        mouse_button1_click = function()
            if carti154.setNativeLocalPetRiding then
                carti154.setNativeLocalPetRiding(false)
            end
        end,
    })
    carti154.setNativeLocalPetStopMountButton = function(carti454)
        local carti455 = carti154.nativeLocalPetStopMountButton
        if not carti455 then
            return
        end
        if carti454 then
            pcall(function()
                carti455.instance.Face.TextLabel.Text = carti454 == 'PetBeingFlown' and 'Stop Fly' or 'Stop Ride'
                carti455:show()
            end)
        else
            pcall(function()
                carti455:hide()
            end)
        end
    end

    carti154.clearNativeLocalPetEntity = function()
        local carti454 = carti2.LocalPlayer.Character
        local carti455 = carti454 and carti454:FindFirstChild('HumanoidRootPart')
        if carti154.setNativeLocalPetStopMountButton then
            carti154.setNativeLocalPetStopMountButton(nil)
        end
        if carti154.nativeLocalPetRideConnection then
            pcall(function()
                carti154.nativeLocalPetRideConnection:Destroy()
            end)
            carti154.nativeLocalPetRideConnection = nil
        end
        if carti154.nativeLocalPetRideFollowConnection then
            carti154.nativeLocalPetRideFollowConnection:Disconnect()
            carti154.nativeLocalPetRideFollowConnection = nil
        end
        if carti154.nativeLocalPetRideTargetAttachment then
            pcall(function()
                carti154.nativeLocalPetRideTargetAttachment:Destroy()
            end)
            carti154.nativeLocalPetRideTargetAttachment = nil
        end
        local carti456 = carti454 and carti454:FindFirstChildOfClass('Humanoid')
        if carti456 then
            pcall(function() carti456.Sit = false end)
        end
        if carti154.nativeLocalPetRidePetHumanoid then
            pcall(function()
                carti154.nativeLocalPetRidePetHumanoid.AutoRotate = carti154.nativeLocalPetRideAutoRotate ~= false
            end)
            carti154.nativeLocalPetRidePetHumanoid = nil
            carti154.nativeLocalPetRideAutoRotate = nil
        end
        if carti154.nativeLocalPetRideAnimation then
            pcall(function()
                carti154.nativeLocalPetRideAnimation:Stop(0.1)
            end)
            carti154.nativeLocalPetRideAnimation = nil
        end
        if carti154.nativeLocalPetRideMountState then
            local carti456 = carti154.nativeLocalPetRideMountState
            if carti456.motor and carti456.motor.Parent then
                carti456.motor.Part1 = carti456.part1
                carti456.motor.C0 = carti456.c0
                carti456.motor.C1 = carti456.c1
                carti456.motor.Transform = carti456.transform
            end
            carti154.nativeLocalPetRideMountState = nil
        elseif carti154.nativeLocalPetRideWeld then
            pcall(function()
                carti154.nativeLocalPetRideWeld:Destroy()
            end)
        end
        if carti455 then
            local carti456 = carti455:FindFirstChild('CartiHubLocalPetRideMountMotor6D')
            if carti456 then carti456:Destroy() end
        end
        carti154.nativeLocalPetRideWeld = nil
        if carti154.nativeLocalPetFollowPosition then
            carti154.nativeLocalPetFollowPosition.Enabled = true
        end
        if carti154.nativeLocalPetFollowOrientation then
            carti154.nativeLocalPetFollowOrientation.Enabled = true
        end
        if carti154.nativeLocalPetMotionConnection then
            carti154.nativeLocalPetMotionConnection:Disconnect()
            carti154.nativeLocalPetMotionConnection = nil
        end
        for _, carti454 in ipairs(carti154.nativeLocalPetTracks or {}) do
            pcall(function()
                carti454:Stop(0.12)
            end)
        end
        carti154.nativeLocalPetTracks = nil
        if carti154.clearNativeLocalPetFlightWings then
            carti154.clearNativeLocalPetFlightWings()
        end
        if carti154.clearNativeLocalPetHeld then
            carti154.clearNativeLocalPetHeld()
        end
        if carti154.nativeLocalPetModel then
            if carti154.nativeLocalPetState then
                carti161('pet_state_managers', function(carti454)
                    for carti455 = #carti454, 1, -1 do
                        if carti454[carti455].char == carti154.nativeLocalPetModel then
                            table.remove(carti454, carti455)
                        end
                    end
                    return carti454
                end)
            end
            if carti154.nativeLocalPetWrapper then
                carti161('pet_char_wrappers', function(carti454)
                    for carti455 = #carti454, 1, -1 do
                        if carti454[carti455].char == carti154.nativeLocalPetModel then
                            table.remove(carti454, carti455)
                        end
                    end
                    return carti454
                end)
            end
            pcall(function()
                carti154.charWrapperClient.register_debug_wrapper(carti154.nativeLocalPetModel, nil)
            end)
            pcall(function()
                carti154.petEntityManager.remove_pet_entity_by_char(carti154.nativeLocalPetModel)
            end)
            pcall(function()
                carti154.nativeLocalPetModel:Destroy()
            end)
        end
        if carti154.nativeLocalPetFollowAttachment and carti154.nativeLocalPetFollowAttachment.Parent then
            carti154.nativeLocalPetFollowAttachment:Destroy()
        end
        carti154.nativeLocalPetModel = nil
        carti154.nativeLocalPetUnique = nil
        carti154.nativeLocalPetFollowAttachment = nil
        carti154.nativeLocalPetWrapper = nil
        carti154.nativeLocalPetState = nil
        carti154.nativeLocalPetFollowPosition = nil
        carti154.nativeLocalPetFollowOrientation = nil
        carti154.nativeLocalPetRideScale = nil
        carti154.nativeLocalPetMountStateId = nil
    end

    carti154.clearNativeLocalPetFlightWings = function()
        if carti154.nativeLocalPetFlightWingTrack then
            pcall(function()
                carti154.nativeLocalPetFlightWingTrack:Stop(0.12)
                carti154.nativeLocalPetFlightWingTrack:Destroy()
            end)
            carti154.nativeLocalPetFlightWingTrack = nil
        end
        if carti154.nativeLocalPetFlightWings then
            pcall(function()
                carti154.nativeLocalPetFlightWings:Destroy()
            end)
            carti154.nativeLocalPetFlightWings = nil
        end
    end

    carti154.attachNativeLocalPetFlightWings = function(carti454)
        carti154.clearNativeLocalPetFlightWings()

        local carti455 = carti154.nativeLocalPetModel
        local carti456 = carti154.nativeLocalPetWrapper
        local carti457 = carti456 and carti26.pets and carti26.pets[carti456.pet_id]
        if not carti455 or not carti457 or carti457.already_has_flying_wings then
            return false
        end

        local carti458 = carti455:FindFirstChild('WingsAttachment', true)
        local carti459 = carti3:FindFirstChild('Resources')
        local carti460 = carti459 and carti459:FindFirstChild('Effects')
        local carti461 = carti460 and carti460:FindFirstChild('DefaultWings')
        if not carti458 or not carti458:IsA('Attachment') or not carti461 then
            return false
        end

        local carti462 = carti461:Clone()
        carti462.Name = 'temp_wings_equipped'
        local carti463 = carti462:FindFirstChild('WingsAttachment', true)
        if not carti463 or not carti463:IsA('Attachment') then
            carti462:Destroy()
            return false
        end

        pcall(function()
            carti462:ScaleTo(carti455:GetScale())
        end)
        for _, carti464 in ipairs(carti462:GetDescendants()) do
            if carti464:IsA('BasePart') then
                carti464.Anchored = false
                carti464.CanCollide = false
                carti464.Massless = true
            end
        end

        local carti464 = Instance.new('RigidConstraint')
        carti464.Name = 'CartiHubLocalPetFlightWingConstraint'
        carti464.Attachment0 = carti458
        carti464.Attachment1 = carti463
        carti464.Parent = carti463.Parent
        carti462.Parent = carti455
        carti154.nativeLocalPetFlightWings = carti462

        local carti465 = carti462:FindFirstChildOfClass('AnimationController')
        local carti466 = carti465 and carti465:FindFirstChildOfClass('Animator')
        if carti466 then
            pcall(function()
                local carti467 = carti20('AnimationManager').get_track('PetFlyingWingFlap')
                local carti468 = carti466:LoadAnimation(carti467)
                carti468.Looped = true
                carti468:Play(0.12)
                carti154.nativeLocalPetFlightWingTrack = carti468
            end)
        end

        return true
    end

    carti154.clearNativeLocalPetHeld = function()
        if carti154.nativeLocalPetHoldMotor then
            pcall(function()
                carti154.nativeLocalPetHoldMotor:Destroy()
            end)
            carti154.nativeLocalPetHoldMotor = nil
        end
        if carti154.nativeLocalPetHoldSourceAttachment then
            pcall(function()
                carti154.nativeLocalPetHoldSourceAttachment:Destroy()
            end)
            carti154.nativeLocalPetHoldSourceAttachment = nil
        end
        if carti154.nativeLocalPetHoldTargetAttachment then
            pcall(function()
                carti154.nativeLocalPetHoldTargetAttachment:Destroy()
            end)
            carti154.nativeLocalPetHoldTargetAttachment = nil
        end
        if carti154.nativeLocalPetHoldTrack then
            pcall(function()
                carti154.nativeLocalPetHoldTrack:Stop(0.12)
                carti154.nativeLocalPetHoldTrack:Destroy()
            end)
            carti154.nativeLocalPetHoldTrack = nil
        end
        if carti154.nativeLocalPetHeldPetTrack then
            pcall(function()
                carti154.nativeLocalPetHeldPetTrack:Stop(0.12)
                carti154.nativeLocalPetHeldPetTrack:Destroy()
            end)
            carti154.nativeLocalPetHeldPetTrack = nil
        end
        if carti154.nativeLocalPetHeldHumanoid then
            pcall(function()
                carti154.nativeLocalPetHeldHumanoid.PlatformStand = false
                carti154.nativeLocalPetHeldHumanoid.AutoRotate = false
            end)
            carti154.nativeLocalPetHeldHumanoid = nil
        end
        if carti154.nativeLocalPetHeld then
            local carti454 = carti154.nativeLocalPetState
            if carti454 then
                carti454.states = {}
            end
            if carti154.nativeLocalPetFollowPosition then
                carti154.nativeLocalPetFollowPosition.Enabled = true
            end
            if carti154.nativeLocalPetFollowOrientation then
                carti154.nativeLocalPetFollowOrientation.Enabled = true
            end
        end
        carti154.nativeLocalPetHeld = nil
    end

    carti154.setNativeLocalPetHeld = function(carti454)
        if not carti454 then
            carti154.clearNativeLocalPetHeld()
            return true
        end

        if carti154.nativeLocalPetMountStateId and carti154.setNativeLocalPetRiding then
            carti154.setNativeLocalPetRiding(false)
        end
        carti154.clearNativeLocalPetHeld()

        local carti455 = carti154.nativeLocalPetModel
        local carti456 = carti2.LocalPlayer.Character
        local carti457 = carti455 and carti455:FindFirstChild('HumanoidRootPart')
        local carti458 = carti456 and (carti456:FindFirstChild('UpperTorso') or carti456:FindFirstChild('Torso'))
        if not carti455 or not carti457 or not carti458 then
            return false
        end

        local carti459 = carti154.nativeLocalPetWrapper
        local carti460 = carti459 and carti26.pets and carti26.pets[carti459.pet_id]
        local carti461 = (carti460 and carti460.hold_offset) or CFrame.new()

        if carti154.nativeLocalPetFollowPosition then
            carti154.nativeLocalPetFollowPosition.Enabled = false
        end
        if carti154.nativeLocalPetFollowOrientation then
            carti154.nativeLocalPetFollowOrientation.Enabled = false
        end
        if carti154.nativeLocalPetState then
            carti154.nativeLocalPetState.states = { { id = 'BabyBeingHeld' } }
        end

        local carti462 = carti455:FindFirstChildOfClass('Humanoid')
        if carti462 then
            carti462.AutoRotate = false
            carti462.PlatformStand = false
            carti154.nativeLocalPetHeldHumanoid = carti462
        end

        local carti463 = Instance.new('Attachment')
        carti463.Name = 'SourceAttachment'
        carti463.CFrame = CFrame.new(0, 0, -1) * carti461
        carti463.Parent = carti458
        local carti464 = Instance.new('Attachment')
        carti464.Name = 'TargetAttachment'
        carti464.Parent = carti457
        local carti465 = Instance.new('RigidConstraint')
        carti465.Name = 'StateConnection'
        carti465.Attachment0 = carti463
        carti465.Attachment1 = carti464
        carti465.Parent = carti455
        carti154.nativeLocalPetHoldSourceAttachment = carti463
        carti154.nativeLocalPetHoldTargetAttachment = carti464
        carti154.nativeLocalPetHoldMotor = carti465
        carti154.nativeLocalPetHeld = true

        local carti466 = carti456:FindFirstChildOfClass('Humanoid')
        local carti467 = carti466 and carti466:FindFirstChildOfClass('Animator')
        if carti467 then
            pcall(function()
                local carti468 = carti20('AnimationManager').get_track('HoldingBaby')
                local carti469 = carti467:LoadAnimation(carti468)
                carti469.Priority = Enum.AnimationPriority.Action
                carti469.Looped = true
                carti469:Play(0.12)
                carti154.nativeLocalPetHoldTrack = carti469
            end)
        end
        local carti470 = carti154.petEntityManager.get_pet_entity(carti455)
        if carti470 then
            carti470.move_state.is_moving = false
            carti470.speed_state.calculated_speed = 0
        end
        return true
    end

    carti154.setNativeLocalPetRiding = function(carti454, carti455)
        local carti476 = carti455
        local carti455 = carti154.nativeLocalPetModel
        local carti456 = carti154.nativeLocalPetState
        local carti457 = carti455 and carti455:FindFirstChild('HumanoidRootPart')
        local carti458 = carti2.LocalPlayer.Character
        local carti459 = carti458 and carti458:FindFirstChild('HumanoidRootPart')
        if not carti455 or not carti456 or not carti457 or not carti459 then
            return false
        end

        if not carti454 then
            carti456.states = {}
            carti154.nativeLocalPetMountStateId = nil
            carti154.setNativeLocalPetStopMountButton(nil)
            carti154.clearNativeLocalPetFlightWings()
            if carti154.nativeLocalPetRideConnection then
                carti154.nativeLocalPetRideConnection:Destroy()
                carti154.nativeLocalPetRideConnection = nil
            end
            if carti154.nativeLocalPetRideFollowConnection then
                carti154.nativeLocalPetRideFollowConnection:Disconnect()
                carti154.nativeLocalPetRideFollowConnection = nil
            end
            if carti154.nativeLocalPetRideTargetAttachment then
                carti154.nativeLocalPetRideTargetAttachment:Destroy()
                carti154.nativeLocalPetRideTargetAttachment = nil
            end
            local carti460 = carti458:FindFirstChildOfClass('Humanoid')
            if carti460 then
                pcall(function() carti460.Sit = false end)
            end
            if carti154.nativeLocalPetRidePetHumanoid then
                pcall(function()
                    carti154.nativeLocalPetRidePetHumanoid.AutoRotate = carti154.nativeLocalPetRideAutoRotate ~= false
                end)
                carti154.nativeLocalPetRidePetHumanoid = nil
                carti154.nativeLocalPetRideAutoRotate = nil
            end
            if carti154.nativeLocalPetRideAnimation then
                pcall(function()
                    carti154.nativeLocalPetRideAnimation:Stop(0.1)
                end)
                carti154.nativeLocalPetRideAnimation = nil
            end
            if carti154.nativeLocalPetRideMountState then
                local carti460 = carti154.nativeLocalPetRideMountState
                if carti460.motor and carti460.motor.Parent then
                    carti460.motor.Part1 = carti460.part1
                    carti460.motor.C0 = carti460.c0
                    carti460.motor.C1 = carti460.c1
                    carti460.motor.Transform = carti460.transform
                end
                carti154.nativeLocalPetRideMountState = nil
            elseif carti154.nativeLocalPetRideWeld then
                carti154.nativeLocalPetRideWeld:Destroy()
            end
            carti154.nativeLocalPetRideWeld = nil
            if carti154.nativeLocalPetRideScale then
                pcall(function()
                    carti455:ScaleTo(1)
                end)
                carti154.nativeLocalPetRideScale = nil
            end
            if carti154.nativeLocalPetFollowPosition then
                carti154.nativeLocalPetFollowPosition.Enabled = true
            end
            if carti154.nativeLocalPetFollowOrientation then
                carti154.nativeLocalPetFollowOrientation.Enabled = true
            end
            return true
        end

        carti154.clearNativeLocalPetHeld()

        carti456.states = { { id = carti476 or 'PetBeingRidden' } }
        carti154.nativeLocalPetMountStateId = carti476 or 'PetBeingRidden'
        carti154.setNativeLocalPetStopMountButton(carti154.nativeLocalPetMountStateId)
        local carti460 = carti455:FindFirstChildOfClass('Humanoid')
        if carti460 then
            carti154.nativeLocalPetRidePetHumanoid = carti460
            carti154.nativeLocalPetRideAutoRotate = carti460.AutoRotate
            carti460.AutoRotate = true
        end
        if carti154.nativeLocalPetFollowPosition then
            carti154.nativeLocalPetFollowPosition.Enabled = false
        end
        if carti154.nativeLocalPetFollowOrientation then
            carti154.nativeLocalPetFollowOrientation.Enabled = false
        end

        if carti154.nativeLocalPetRideWeld then
            carti154.nativeLocalPetRideWeld:Destroy()
        end

        local carti460 = carti26.pets and carti26.pets[carti154.nativeLocalPetWrapper.pet_id]
        local carti461 = (carti460 and carti460.max_ride_scale) or 2
        local carti462 = carti455:GetExtentsSize().Y
        pcall(function()
            carti455:ScaleTo(carti461)
        end)
        local carti463 = carti455:GetExtentsSize().Y
        if carti463 > carti462 then
            carti455:PivotTo(carti455:GetPivot() * CFrame.new(0, (carti463 - carti462) * 0.5, 0))
        end
        carti154.nativeLocalPetRideScale = carti461
        if carti476 == 'PetBeingFlown' then
            carti154.attachNativeLocalPetFlightWings()
        else
            carti154.clearNativeLocalPetFlightWings()
        end

        local carti464 = carti455:FindFirstChild('RidePosition', true)
        local carti465 = carti464 and carti464:FindFirstChild('SourceAttachment')
        local carti466 = CFrame.new()
        if not carti465 and carti464 and carti464:IsA('Attachment') then
            carti465 = carti464
            carti466 = CFrame.new(0, 1.09591794, 0)
        end
        if carti465 and carti465:IsA('Attachment') then
            local carti467 = Instance.new('Attachment')
            carti467.Name = 'CartiHubLocalPetRideTargetAttachment'
            carti467.Parent = carti459
            carti154.nativeLocalPetRideTargetAttachment = carti467
            carti459.CFrame = carti465.WorldCFrame * carti466
            carti154.nativeLocalPetRideFollowConnection = carti4.RenderStepped:Connect(function()
                if carti465.Parent and carti459.Parent then
                    local carti468 = carti465.WorldCFrame * carti466
                    if carti154.nativeLocalPetMountStateId == 'PetBeingFlown' then
                        local carti469 = carti457 and carti457.Parent
                            and Vector3.new(carti457.CFrame.LookVector.X, 0, carti457.CFrame.LookVector.Z)
                            or Vector3.new(carti468.LookVector.X, 0, carti468.LookVector.Z)
                        if carti469.Magnitude > 0.001 then
                            carti459.CFrame = CFrame.lookAt(carti468.Position, carti468.Position + carti469)
                        else
                            carti459.CFrame = CFrame.new(carti468.Position)
                        end
                    else
                        local carti469 = carti459.CFrame - carti459.Position
                        carti459.CFrame = CFrame.new(carti468.Position) * carti469
                    end
                end
            end)
        else
            local carti467 = math.max(1.65, carti455:GetExtentsSize().Y * 0.42)
            carti459.CFrame = carti457.CFrame * CFrame.new(0, carti467, 0)
            local carti468 = Instance.new('Motor6D')
            carti468.Name = 'CartiHubLocalPetRideMountMotor6D'
            carti468.Part0 = carti459
            carti468.Part1 = carti457
            carti468.C0 = CFrame.new(0, -carti467, 0)
            carti468.Parent = carti459
            carti154.nativeLocalPetRideWeld = carti468
        end

        local carti469 = carti458:FindFirstChildOfClass('Humanoid')
        local carti470 = carti469 and carti469:FindFirstChildOfClass('Animator')
        if carti470 then
            pcall(function()
                local carti471 = Instance.new('Animation')
                carti471.AnimationId = 'rbxassetid://3342979102'
                local carti473 = carti470:LoadAnimation(carti471)
                carti473.Priority = Enum.AnimationPriority.Action
                carti473.Looped = true
                carti473:Play(0.1, 1, 1)
                carti154.nativeLocalPetRideAnimation = carti473
            end)
        end
        if carti468 then
            carti468.Sit = false
        end
        return true
    end

    carti154.refreshNativeLocalPetPresentation = function()
        local carti454 = carti154.nativeLocalPetModel
        local carti455 = carti154.nativeLocalPetWrapper
        if not carti454 or not carti454.Parent or not carti455 then
            return false
        end

        local carti456 = carti26.pets and carti26.pets[carti455.pet_id]
        if not carti456 then
            return false
        end

        -- The native entity caches the wrapper name when it is created. Rebuild only
        -- that presentation layer so the name changes immediately without re-equipping.
        local carti457 = pcall(function()
            carti154.petEntityManager.remove_pet_entity_by_char(carti454)
            carti154.petEntityManager.create_pet_entity(carti454, carti456)
        end)
        return carti457
    end

    carti154.renameNativeLocalPet = function(carti454)
        carti454 = tostring(carti454 or ''):gsub('^%s+', ''):gsub('%s+$', '')
        if carti454 == '' or not carti154.nativeLocalPetModel or not carti154.nativeLocalPetWrapper then
            return false
        end
        local carti458 = carti154.nativeLocalPetModel
        carti458.Name = carti454
        carti154.nativeLocalPetWrapper.rp_name = carti454
        carti161('pet_char_wrappers', function(carti455)
            for _, carti456 in ipairs(carti455) do
                if carti456.char == carti458 then
                    carti456.rp_name = carti454
                end
            end
            return carti455
        end)
        carti154.refreshNativeLocalPetPresentation()
        return true
    end

    carti154.clearLocalPetEquipState = function()
        local carti454 = false
        local carti455 = carti23.get('equip_manager')
        for _, carti456 in ipairs(carti455 and carti455.pets or {}) do
            if carti456.carti_hub_local_pet then
                carti454 = true
                break
            end
        end

        if not carti454 then
            return false
        end

        carti154.clearNativeLocalPetEntity()
        carti161('equip_manager', function(carti457)
            carti457.pets = carti457.pets or {}
            for carti458 = #carti457.pets, 1, -1 do
                if carti457.pets[carti458].carti_hub_local_pet then
                    table.remove(carti457.pets, carti458)
                end
            end
            return carti457
        end)
        return carti454
    end

    carti154.spawnNativeLocalPetEntity = function(carti454)
        carti154.clearNativeLocalPetEntity()

        local carti455 = carti2.LocalPlayer.Character
        local carti456 = carti455 and carti455:FindFirstChild('HumanoidRootPart')
        if not carti456 then return end

        local carti457 = carti42(carti454.kind)
        if not carti457 then return end

        local carti458 = carti457:FindFirstChild('HumanoidRootPart')
        if not carti458 then
            carti457:Destroy()
            return
        end

        carti457.Name = (carti26.pets and carti26.pets[carti454.kind] and carti26.pets[carti454.kind].name)
            or tostring(carti454.kind)
        carti457:SetAttribute('CartiHubLocalPet', true)
        carti457.Parent = workspace
        carti457:PivotTo(carti456.CFrame * CFrame.new(3.4, -1.75, 0.75))

        local carti459 = Instance.new('Attachment')
        carti459.Name = 'CartiHubPetFollowAttachment'
        carti459.Position = Vector3.new(3.4, -1.75, 0.75)
        carti459.Parent = carti456
        local carti460 = Instance.new('Attachment')
        carti460.Name = 'CartiHubPetRootAttachment'
        carti460.Parent = carti458
        local carti461 = Instance.new('AlignPosition')
        carti461.Name = 'CartiHubPetFollowPosition'
        carti461.Attachment0 = carti460
        carti461.Attachment1 = carti459
        carti461.MaxForce = math.huge
        carti461.MaxVelocity = math.huge
        carti461.Responsiveness = 100
        carti461.RigidityEnabled = true
        carti461.Parent = carti458
        local carti462 = Instance.new('AlignOrientation')
        carti462.Name = 'CartiHubPetFollowOrientation'
        carti462.Attachment0 = carti460
        carti462.Attachment1 = carti459
        carti462.MaxTorque = math.huge
        carti462.MaxAngularVelocity = math.huge
        carti462.Responsiveness = 100
        carti462.RigidityEnabled = true
        carti462.Parent = carti458

        local carti481 = nil
        local carti482 = workspace:FindFirstChild('Pets')
        if carti482 then
            for _, carti483 in ipairs(carti482:GetChildren()) do
                local carti484 = carti154.charWrapperClient.get(carti483)
                if carti484 and carti484.is_pet then
                    carti481 = table.clone(carti484)
                    break
                end
            end
        end

        if not carti481 then
            carti481 = {
                is_pet = true,
                index = 1,
                unique = 0,
                transform_mode = 1,
                location = {},
                are_colors_sealed = false,
            }
        end

        if carti481 then
            carti481.char = carti457
            carti481.player = carti2.LocalPlayer
            carti481.controller = carti2.LocalPlayer
            carti481.entity_controller = carti2.LocalPlayer
            carti481.pet_unique = carti454.unique
            carti481.pet_id = carti454.kind
            carti481.unique = -math.floor(os.clock() * 1000000)
            carti481.index = 1
            carti481.rp_name = ''
            carti481.location = {
                full_destination_id = 'housing',
                destination_id = 'housing',
                house_owner = carti2.LocalPlayer,
            }
            carti481.neon = carti454.properties and carti454.properties.neon == true
            carti481.mega_neon = carti454.properties and carti454.properties.mega_neon == true
            carti481.pet_progression = {
                age = (carti454.properties and carti454.properties.age) or 1,
                xp = (carti454.properties and carti454.properties.xp) or 0,
                friendship_level = (carti454.properties and carti454.properties.friendship_level) or 0,
            }
            carti154.charWrapperClient.register_debug_wrapper(carti457, carti481)
        end

        local carti485, carti486 = pcall(function()
            return carti154.petEntityManager.create_pet_entity(carti457, carti26.pets and carti26.pets[carti454.kind])
        end)
        if not carti485 then
            pcall(function()
                carti154.charWrapperClient.register_debug_wrapper(carti457, nil)
            end)
            carti459:Destroy()
            carti457:Destroy()
            return
        end

        if carti454.properties and carti454.properties.neon == true then
            pcall(function()
                carti20('PetNeonHelper').apply_neon(
                    carti457.PetModel,
                    carti26.pets[carti454.kind].neon_parts
                )
            end)
        end

        carti154.nativeLocalPetModel = carti457
        carti154.nativeLocalPetUnique = carti454.unique
        carti154.nativeLocalPetFollowAttachment = carti459
        carti154.nativeLocalPetFollowPosition = carti461
        carti154.nativeLocalPetFollowOrientation = carti462
        carti154.nativeLocalPetWrapper = carti481
        if carti481 then
            carti154.nativeLocalPetState = {
                char = carti457,
                player = carti2.LocalPlayer,
                store_key = 'pet_state_managers',
                is_sitting = false,
                chars_connected_to_me = {},
                states = {},
            }
            carti161('pet_state_managers', function(carti487)
                table.insert(carti487, carti154.nativeLocalPetState)
                return carti487
            end)
            carti161('pet_char_wrappers', function(carti487)
                table.insert(carti487, carti481)
                return carti487
            end)
        end

        local carti474 = carti457:FindFirstChildOfClass('Humanoid')
        if carti474 then
            carti474.AutoRotate = false
        end
        carti154.nativeLocalPetMotionConnection = carti4.Heartbeat:Connect(function()
            if not carti457.Parent or not carti458.Parent or not carti456.Parent then return end
            local carti475 = carti154.petEntityManager.get_pet_entity(carti457)
            if not carti475 then return end
            if carti154.nativeLocalPetState
                and carti154.nativeLocalPetState.states
                and carti154.nativeLocalPetState.states[1]
                and (carti154.nativeLocalPetState.states[1].id == 'PetBeingRidden'
                    or carti154.nativeLocalPetState.states[1].id == 'PetBeingFlown') then
                return
            end
            if carti154.nativeLocalPetHeld then
                carti475.move_state.is_moving = false
                carti475.speed_state.calculated_speed = 0
                return
            end
            local carti476 = carti456.AssemblyLinearVelocity.Magnitude > 1.1
            carti475.move_state.is_moving = carti476
            carti475.speed_state.calculated_speed = carti476 and math.max(carti456.AssemblyLinearVelocity.Magnitude, 16) or 0
        end)
    end

    carti154.clientToolManager.equip = function(carti454, carti455)
        if not (carti454 and carti454.carti_hub_local_pet) then
            carti154.clearLocalPetEquipState()
            return carti154.originalClientToolEquip(carti454, carti455)
        end

        for _, carti456 in ipairs(carti154.clientToolManager.get_equipped_by_category('pets')) do
            if not carti456.carti_hub_local_pet then
                pcall(function()
                    carti154.originalClientToolUnequip(carti456, { suppress_fail_message = true })
                end)
            end
        end

        carti161('equip_manager', function(carti457)
            carti457.pets = carti457.pets or {}
            for carti458 = #carti457.pets, 1, -1 do
                if carti457.pets[carti458] then
                    table.remove(carti457.pets, carti458)
                end
            end
            table.insert(carti457.pets, 1, carti454)
            return carti457
        end)
        task.spawn(carti154.spawnNativeLocalPetEntity, carti454)
        return true
    end

    carti154.clientToolManager.unequip = function(carti454, carti455)
        if not (carti454 and carti454.carti_hub_local_pet) then
            return carti154.originalClientToolUnequip(carti454, carti455)
        end

        carti161('equip_manager', function(carti456)
            carti456.pets = carti456.pets or {}
            for carti457 = #carti456.pets, 1, -1 do
                if carti456.pets[carti457].unique == carti454.unique then
                    table.remove(carti456.pets, carti457)
                end
            end
            return carti456
        end)
        carti154.clearNativeLocalPetEntity()
        return true
    end

    carti154.clientToolManager.backpack_equip = function(carti454, carti455)
        if carti454 and carti454.category == 'pets' and not carti454.carti_hub_local_pet then
            if carti154.clearLocalPetEquipState() then
                task.wait()
            end
        end
        return carti154.originalClientToolBackpackEquip(carti454, carti455)
    end

    local carti462 = carti20('PetActions')
    carti462.cartiHubOriginalRidePet = carti462.cartiHubOriginalRidePet or carti462.ride_pet
    carti462.ride_pet = function(carti463, ...)
        if carti463
            and carti463.char == carti154.nativeLocalPetModel
            and carti463.pet_unique == carti154.nativeLocalPetUnique then
            local carti464 = carti23.get('inventory')
            local carti465 = carti464 and carti464.pets and carti464.pets[carti463.pet_unique]
            if carti465 and carti465.properties and carti465.properties.rideable then
                pcall(function()
                    carti22.apps.FocusPetApp:release_focus()
                end)
                return carti154.setNativeLocalPetRiding(true, 'PetBeingRidden')
            end
        end
        return carti462.cartiHubOriginalRidePet(carti463, ...)
    end

    carti462.cartiHubOriginalFlyPet = carti462.cartiHubOriginalFlyPet or carti462.fly_pet
    carti462.fly_pet = function(carti463, ...)
        if carti463
            and carti463.char == carti154.nativeLocalPetModel
            and carti463.pet_unique == carti154.nativeLocalPetUnique then
            local carti464 = carti23.get('inventory')
            local carti465 = carti464 and carti464.pets and carti464.pets[carti463.pet_unique]
            if carti465 and carti465.properties and carti465.properties.flyable then
                pcall(function()
                    carti22.apps.FocusPetApp:release_focus()
                end)
                return carti154.setNativeLocalPetRiding(true, 'PetBeingFlown')
            end
        end
        return carti462.cartiHubOriginalFlyPet(carti463, ...)
    end

    carti462.cartiHubOriginalPickUpPet = carti462.cartiHubOriginalPickUpPet or carti462.pick_up
    carti462.pick_up = function(carti463, ...)
        if carti463
            and carti463.char == carti154.nativeLocalPetModel
            and carti463.pet_unique == carti154.nativeLocalPetUnique then
            pcall(function()
                carti22.apps.FocusPetApp:release_focus()
            end)
            return carti154.setNativeLocalPetHeld(not carti154.nativeLocalPetHeld)
        end
        return carti462.cartiHubOriginalPickUpPet(carti463, ...)
    end

    carti453.CartiHubAdoptMeLocalPetHooks = {
        manager = carti154.clientToolManager,
        equip = carti154.originalClientToolEquip,
        unequip = carti154.originalClientToolUnequip,
        backpackEquip = carti154.originalClientToolBackpackEquip,
        clear = carti154.clearLocalPetEquipState,
        stopMountButton = carti154.nativeLocalPetStopMountButton,
    }
end