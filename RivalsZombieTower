local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
local Camera = workspace.CurrentCamera

pcall(function()
    if not (hookfunction and newcclosure and getcallingscript) then return end
    local oldMeta
    oldMeta = hookfunction(setmetatable, newcclosure(function(t, mt)
        if type(mt) == "table" and rawget(mt, "__mode") == "kv" then
            local caller = getcallingscript()
            if caller and caller.Name == "MiscellaneousController" then
                return oldMeta(t, {})
            end
        end
        return oldMeta(t, mt)
    end))
    local oldLen
    oldLen = hookfunction(rawlen, newcclosure(function(t)
        if type(t) == "table" then
            local caller = getcallingscript()
            if caller and caller.Name == "MiscellaneousController" then
                return 3
            end
        end
        return oldLen(t)
    end))
end)

pcall(function()
    if not (hookmetamethod and getrawmetatable and setreadonly and getnamecallmethod) then return end
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod and getnamecallmethod()
        if method == "Kick" and self == LocalPlayer then
            return
        end
        if method == "FireServer" or method == "InvokeServer" then
            local name = tostring(self.Name):lower()
            if name:find("exploit") or name:find("cheat") or name:find("detect") or name:find("ban") or name:find("flag") or name:find("validate") or name:find("integrity") or name:find("security") or name:find("anticheat") then
                return
            end
        end
        return oldNamecall(self, ...)
    end)
    local oldIndex
    oldIndex = hookmetamethod(game, "__index", function(self, key)
        if checkcaller and checkcaller() and key == "Kick" and self == LocalPlayer then
            return function() end
        end
        return oldIndex(self, key)
    end)
    setreadonly(mt, true)
end)

local Config = {
    Ragebot = true,
    FastAttack = true,
    AutoCollect = true,
    UndergroundDepth = 2.4,
    Fly = false,
    FlySpeed = 55,
    Noclip = false,
    InfiniteJump = false,
    ZombieESP = true,
    ShootAttempts = 2,
    MaxDistance = 3500,
    UIVisible = true
}

local function SafeRequire(moduleInstance)
    if not moduleInstance then return nil end
    local ok, res = pcall(require, moduleInstance)
    return (ok and res) or nil
end

local Modules = ReplicatedStorage:WaitForChild("Modules", 10)
local Utility = Modules and SafeRequire(Modules:WaitForChild("Utility", 5))
local EnumLibrary = Modules and SafeRequire(Modules:WaitForChild("EnumLibrary", 5))
local ItemLibrary = Modules and SafeRequire(Modules:WaitForChild("ItemLibrary", 5))
local UseItemRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Replication"):WaitForChild("Fighter"):WaitForChild("UseItem")

local OriginalItemData = {}
local function ApplyFastAttack(enable)
    pcall(function()
        if not ItemLibrary or not ItemLibrary.Items then return end
        local Items = ItemLibrary.Items

        local gunExceptions = {
            ["Sniper"] = false,
            ["Crossbow"] = false,
            ["Bow"] = false,
            ["RPG"] = false,
        }

        if enable then
            for name, data in pairs(Items) do
                if typeof(data) == "table" then
                    if not OriginalItemData[name] then
                        OriginalItemData[name] = {
                            ShootSpread = data.ShootSpread,
                            ShootAccuracy = data.ShootAccuracy,
                            ShootRecoil = data.ShootRecoil,
                            ShootCooldown = data.ShootCooldown,
                            ShootBurstCooldown = data.ShootBurstCooldown,
                            AttackCooldown = data.AttackCooldown,
                            SwingCooldown = data.SwingCooldown,
                            MeleeCooldown = data.MeleeCooldown,
                            Cooldown = data.Cooldown,
                            RecoveryTime = data.RecoveryTime,
                            ResetTime = data.ResetTime
                        }
                    end

                    if not gunExceptions[name] then
                        if data.ShootSpread ~= nil then data.ShootSpread = 0 end
                        if data.ShootAccuracy ~= nil then data.ShootAccuracy = 0 end
                        if data.ShootRecoil ~= nil then data.ShootRecoil = 0 end
                        if data.ShootCooldown ~= nil then data.ShootCooldown = 0.001 end
                        if data.ShootBurstCooldown ~= nil then data.ShootBurstCooldown = 0.001 end
                    end

                    if data.AttackCooldown ~= nil then data.AttackCooldown = 0.001 end
                    if data.SwingCooldown ~= nil then data.SwingCooldown = 0.001 end
                    if data.MeleeCooldown ~= nil then data.MeleeCooldown = 0.001 end
                    if data.Cooldown ~= nil then data.Cooldown = 0.001 end
                    if data.RecoveryTime ~= nil then data.RecoveryTime = 0.001 end
                    if data.ResetTime ~= nil then data.ResetTime = 0.001 end
                end
            end
        else
            for name, data in pairs(Items) do
                local orig = OriginalItemData[name]
                if orig and typeof(data) == "table" then
                    for prop, val in pairs(orig) do
                        data[prop] = val
                    end
                end
            end
        end
    end)
end

local cachedFighter = nil
local function GetLocalFighter()
    if cachedFighter and cachedFighter.IsAlive and cachedFighter:IsAlive() then
        return cachedFighter
    end
    pcall(function()
        local ps = LocalPlayer:FindFirstChild("PlayerScripts")
        local ctrl = ps and ps:FindFirstChild("Controllers")
        local fcModule = ctrl and ctrl:FindFirstChild("FighterController")
        if fcModule then
            local fc = SafeRequire(fcModule)
            cachedFighter = fc and fc.LocalFighter
        end
    end)
    return cachedFighter
end

local function GetWeaponInfo(item)
    if not item then return "", false, false end
    local info = item.Info
    local name = (info and info.Name) or (item.Get and item:Get("Name")) or ""
    local itype = (info and info.Type) or (item.Get and item:Get("Type")) or ""
    local isRaycast = info and (info.IsRaycast == true)
    local isMelee = (itype == "Melee") or (info and info.AttackReach ~= nil and info.MaxAmmo == nil and not isRaycast) or (name == "Knife") or (name == "Fists")
    local isKnife = (name == "Knife")
    return name, isMelee, isKnife
end

local function GetActiveItem(lf)
    if not lf then return nil end
    local item = lf.EquippedItem
    if not item and lf.EquipItem then
        pcall(function() lf:EquipItem(2) end)
        item = lf.EquippedItem
        if not item then
            pcall(function() lf:EquipItem(3) end)
            item = lf.EquippedItem
        end
    end
    return item
end

local function CollectPickup(obj)
    if not Config.AutoCollect then return end
    if not obj or not obj:IsA("BasePart") then return end
    local myChar = LocalPlayer.Character
    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end

    if firetouchinterest then
        firetouchinterest(myHRP, obj, 0)
        firetouchinterest(myHRP, obj, 1)
    end
    pcall(function()
        if not obj.Anchored then
            obj.CFrame = myHRP.CFrame
        end
    end)
end

local function HookPickupFolder(folder)
    if not folder then return end
    for _, child in ipairs(folder:GetChildren()) do
        CollectPickup(child)
    end
    folder.ChildAdded:Connect(function(child)
        task.defer(function()
            CollectPickup(child)
        end)
    end)
end

local function InitPickups()
    local zt = workspace:FindFirstChild("Zombie Tower")
    if zt then
        local important = zt:FindFirstChild("Important")
        if important then
            HookPickupFolder(important)
        end
        local floors = zt:FindFirstChild("Floors")
        if floors then
            for _, fl in ipairs(floors:GetChildren()) do
                local mg = fl:FindFirstChild("MobGroups")
                if mg then
                    for _, g in ipairs(mg:GetChildren()) do
                        local imp = g:FindFirstChild("Important")
                        if imp then
                            HookPickupFolder(imp)
                        end
                    end
                end
            end
        end
    end
end
InitPickups()

workspace.ChildAdded:Connect(function(c)
    if c.Name == "Zombie Tower" then
        task.wait(1)
        InitPickups()
    end
end)

local lastPickupSweep = 0
local function PeriodicPickupCheck()
    if not Config.AutoCollect then return end
    local now = tick()
    if now - lastPickupSweep < 0.25 then return end
    lastPickupSweep = now

    local zt = workspace:FindFirstChild("Zombie Tower")
    local important = zt and zt:FindFirstChild("Important")
    if important then
        for _, c in ipairs(important:GetChildren()) do
            CollectPickup(c)
        end
    end
    for _, c in ipairs(workspace:GetChildren()) do
        if c:IsA("BasePart") then
            local n = c.Name:lower()
            if n:find("pickup") or n:find("health") or n:find("ammo") then
                CollectPickup(c)
            end
        end
    end
end

local function GetRageZombieTarget()
    local myChar = LocalPlayer.Character
    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return nil, nil, nil end

    local myPos = myHRP.Position
    local bestModel = nil
    local bestHead = nil
    local bestRoot = nil
    local bestDist = Config.MaxDistance

    local containers = {}
    local zt = workspace:FindFirstChild("Zombie Tower")
    if zt and zt:FindFirstChild("Entities") then
        table.insert(containers, zt.Entities)
    end
    local sr = workspace:FindFirstChild("ShootingRangeEntities")
    if sr then
        table.insert(containers, sr)
    end

    local function evaluateModel(m)
        if not m:IsA("Model") or Players:GetPlayerFromCharacter(m) then return end

        local hum = m:FindFirstChild("EnemyHumanoid") or m:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health > 0 then
            local root = m:FindFirstChild("HumanoidRootPart") or m.PrimaryPart
            local head = m:FindFirstChild("Head") or m:FindFirstChild("HitboxHead") or root
            if root and head then
                local dist = (root.Position - myPos).Magnitude
                if dist < bestDist then
                    bestDist = dist
                    bestModel = m
                    bestHead = head
                    bestRoot = root
                end
            end
        end
    end

    for _, folder in ipairs(containers) do
        for _, child in ipairs(folder:GetChildren()) do
            evaluateModel(child)
        end
    end

    if not bestModel and zt then
        for _, m in ipairs(zt:GetChildren()) do
            if m.Name ~= "Important" and m.Name ~= "Floors" and m.Name ~= "Barriers" then
                evaluateModel(m)
            end
        end
    end

    return bestModel, bestHead, bestRoot
end

local function ExecuteMsHubRageCombat(targetModel, targetHead, targetRoot)
    if not targetModel or not targetHead or not targetRoot then return end
    local lf = GetLocalFighter()
    if not lf then return end

    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    local item = GetActiveItem(lf)
    if not item then return end

    local objId = nil
    if item.Get then
        pcall(function()
            objId = item:Get("ObjectID") or item:Get("NetworkID") or item:Get("ID")
        end)
    end
    if not objId then
        objId = item.ObjectID or item._object_id or item.ID or 2
    end

    local name, isMelee, isKnife = GetWeaponInfo(item)

    if not isMelee and item.Get then
        local curAmmo = item:Get("CurrentAmmo") or item:Get("Ammo") or 0
        local maxAmmo = item:Get("MaxAmmo") or 0
        if curAmmo == 0 and maxAmmo > 0 and lf.EquipItem then
            pcall(function() lf:EquipItem(2) end)
            item = lf.EquippedItem or item
            name, isMelee, isKnife = GetWeaponInfo(item)
            if item.Get then
                objId = item:Get("ObjectID") or objId
            end
        end
    end

    local standPos, shootCF

    if isKnife or isMelee then
        local depth = Config.UndergroundDepth or 2.4
        standPos = targetRoot.Position + Vector3.new(0, -depth, 0)
        shootCF = CFrame.lookAt(standPos, targetHead.Position)

        local _, ty = targetRoot.CFrame:ToOrientation()
        pcall(function()
            if Utility and Utility.EncodeCameraRotation then
                local encRot = Utility:EncodeCameraRotation(Vector2.new(0, ty))
                ReplicatedStorage.Remotes.Replication.Fighter.UpdateCameraRotation:FireServer(encRot, nil)
            end
        end)

        local oCF = myRoot.CFrame
        local oV = myRoot.AssemblyLinearVelocity
        local oRV = myRoot.AssemblyAngularVelocity

        myRoot.CFrame = shootCF
        myRoot.AssemblyLinearVelocity = Vector3.zero
        myRoot.AssemblyAngularVelocity = Vector3.zero

        RunService:BindToRenderStep("__m4rsTeleportRestore", 101, function()
            if myRoot and myRoot.Parent then
                myRoot.CFrame = oCF
                myRoot.AssemblyLinearVelocity = oV
                myRoot.AssemblyAngularVelocity = oRV
            end
            RunService:UnbindFromRenderStep("__m4rsTeleportRestore")
        end)
    else
        standPos = myRoot.Position
        shootCF = myRoot.CFrame
    end

    local originPos = isMelee and shootCF.Position or myRoot.Position
    local aimPoint = targetHead.Position
    local startCF, endCF, hitCF

    if isMelee then
        local eye = originPos + Vector3.new(0, 1.75, 0)
        local look = (aimPoint - eye).Magnitude > 1e-3 and CFrame.lookAt(eye, aimPoint) or CFrame.new(eye)
        startCF = look
        endCF = look + look.LookVector * 0.1
        hitCF = CFrame.Angles(0, math.pi / 2, 0)
    else
        local aim = CFrame.new(originPos, aimPoint)
        startCF, endCF = aim, aim
        hitCF = CFrame.new(0.43, 0.25, 0.42)
    end

    local encStart = startCF
    local encEnd = endCF
    local encHit = hitCF

    if Utility and Utility.EncodeCFrame then
        pcall(function()
            encStart = Utility:EncodeCFrame(startCF)
            encEnd = Utility:EncodeCFrame(endCF)
            encHit = Utility:EncodeCFrame(hitCF)
        end)
    end

    local shotData = {
        [utf8.char(0)] = encStart,
        [utf8.char(1)] = encEnd,
        [utf8.char(2)] = targetHead,
        [utf8.char(3)] = encHit
    }

    local actionEnum = (isKnife and "StartAiming") or "StartShooting"
    if EnumLibrary and EnumLibrary.ToEnum then
        pcall(function()
            actionEnum = EnumLibrary:ToEnum(actionEnum)
        end)
    end

    local payload
    if isMelee then
        payload = { [utf8.char(1)] = shotData }
    else
        payload = { [utf8.char(1)] = shotData, [utf8.char(2)] = true }
    end

    _G.__M4rsRageFiring = true
    for _ = 1, Config.ShootAttempts do
        pcall(function()
            UseItemRemote:FireServer(objId, actionEnum, payload, nil)
        end)
    end
    _G.__M4rsRageFiring = false

    if lf.Input then
        pcall(function()
            lf:Input("StartShooting")
        end)
    end
end

RunService.Stepped:Connect(function()
    if Config.Noclip and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if Config.InfiniteJump and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

local function UpdateFly(dt)
    if not Config.Fly then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero

    local camCF = Camera.CFrame
    local moveDir = Vector3.zero

    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        moveDir = moveDir + camCF.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        moveDir = moveDir - camCF.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        moveDir = moveDir - camCF.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        moveDir = moveDir + camCF.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        moveDir = moveDir + Vector3.new(0, 1, 0)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
        moveDir = moveDir - Vector3.new(0, 1, 0)
    end

    if moveDir.Magnitude > 0 then
        moveDir = moveDir.Unit
        hrp.CFrame = hrp.CFrame + (moveDir * (Config.FlySpeed * dt))
    end
end

local wasFiring = false
RunService.Heartbeat:Connect(function(dt)
    PeriodicPickupCheck()
    UpdateFly(dt)

    if not Config.Ragebot then
        if wasFiring then
            local lf = GetLocalFighter()
            if lf and lf.Input then
                pcall(function() lf:Input("EndShooting") end)
            end
            wasFiring = false
        end
        return
    end

    local targetModel, targetHead, targetRoot = GetRageZombieTarget()
    if targetModel and targetHead and targetRoot then
        wasFiring = true
        ExecuteMsHubRageCombat(targetModel, targetHead, targetRoot)
    else
        if wasFiring then
            local lf = GetLocalFighter()
            if lf and lf.Input then
                pcall(function() lf:Input("EndShooting") end)
            end
            wasFiring = false
        end
    end
end)

local activeHighlights = {}
local function UpdateZombieESP()
    if not Config.ZombieESP then
        for _, hl in pairs(activeHighlights) do
            if hl and hl.Parent then hl:Destroy() end
        end
        table.clear(activeHighlights)
        return
    end

    local zt = workspace:FindFirstChild("Zombie Tower")
    local entitiesFolder = zt and zt:FindFirstChild("Entities")
    local currentSet = {}

    if entitiesFolder then
        for _, m in ipairs(entitiesFolder:GetChildren()) do
            if m:IsA("Model") and Players:GetPlayerFromCharacter(m) == nil then
                local hum = m:FindFirstChild("EnemyHumanoid") or m:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    currentSet[m] = true
                    if not activeHighlights[m] then
                        local hl = Instance.new("Highlight")
                        hl.Name = "_M4rsZombieHL"
                        hl.FillColor = Color3.fromRGB(255, 35, 75)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.FillTransparency = 0.55
                        hl.OutlineTransparency = 0.1
                        hl.Adornee = m
                        hl.Parent = m
                        activeHighlights[m] = hl
                    end
                end
            end
        end
    end

    for m, hl in pairs(activeHighlights) do
        if not currentSet[m] or not m.Parent then
            if hl and hl.Parent then hl:Destroy() end
            activeHighlights[m] = nil
        end
    end
end

task.spawn(function()
    while true do
        task.wait(1)
        UpdateZombieESP()
    end
end)

local function CreateMinimalUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "M4rsZombieRageUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    pcall(function()
        if gethui then
            screenGui.Parent = gethui()
        elseif syn and syn.protect_gui then
            syn.protect_gui(screenGui)
            screenGui.Parent = CoreGui
        else
            screenGui.Parent = CoreGui
        end
    end)
    if not screenGui.Parent then
        screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 280, 0, 310)
    mainFrame.Position = UDim2.new(0.04, 0, 0.25, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(16, 17, 24)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = mainFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(60, 70, 100)
    stroke.Thickness = 1.2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = mainFrame

    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 36)
    titleBar.BackgroundColor3 = Color3.fromRGB(23, 25, 35)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 10)
    titleCorner.Parent = titleBar

    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(1, -45, 1, 0)
    titleText.Position = UDim2.new(0, 12, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = "M4rs.win - Zombie Tower [RightShift]"
    titleText.TextColor3 = Color3.fromRGB(240, 240, 255)
    titleText.Font = Enum.Font.GothamBold
    titleText.TextSize = 12
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = titleBar

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 22, 0, 22)
    closeBtn.Position = UDim2.new(1, -28, 0, 7)
    closeBtn.BackgroundColor3 = Color3.fromRGB(42, 46, 62)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(200, 205, 230)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 11
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = titleBar

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeBtn

    closeBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
        Config.UIVisible = mainFrame.Visible
    end)

    local dragging, dragStart, startPos, dragInput
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local contentArea = Instance.new("Frame")
    contentArea.Size = UDim2.new(1, -16, 1, -44)
    contentArea.Position = UDim2.new(0, 8, 0, 40)
    contentArea.BackgroundTransparency = 1
    contentArea.Parent = mainFrame

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 4)
    listLayout.Parent = contentArea

    local function CreateToggle(title, defaultVal, callback)
        local itemFrame = Instance.new("Frame")
        itemFrame.Size = UDim2.new(1, 0, 0, 32)
        itemFrame.BackgroundColor3 = Color3.fromRGB(25, 28, 40)
        itemFrame.BorderSizePixel = 0
        itemFrame.Parent = contentArea

        local itemCorner = Instance.new("UICorner")
        itemCorner.CornerRadius = UDim.new(0, 7)
        itemCorner.Parent = itemFrame

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -55, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = title
        label.TextColor3 = Color3.fromRGB(225, 230, 245)
        label.Font = Enum.Font.GothamMedium
        label.TextSize = 11
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = itemFrame

        local switchBtn = Instance.new("TextButton")
        switchBtn.Size = UDim2.new(0, 38, 0, 20)
        switchBtn.Position = UDim2.new(1, -46, 0.5, -10)
        switchBtn.BackgroundColor3 = defaultVal and Color3.fromRGB(75, 105, 240) or Color3.fromRGB(45, 50, 70)
        switchBtn.Text = ""
        switchBtn.BorderSizePixel = 0
        switchBtn.Parent = itemFrame

        local switchCorner = Instance.new("UICorner")
        switchCorner.CornerRadius = UDim.new(0, 10)
        switchCorner.Parent = switchBtn

        local circle = Instance.new("Frame")
        circle.Size = UDim2.new(0, 14, 0, 14)
        circle.Position = defaultVal and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
        circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        circle.BorderSizePixel = 0
        circle.Parent = switchBtn

        local circleCorner = Instance.new("UICorner")
        circleCorner.CornerRadius = UDim.new(1, 0)
        circleCorner.Parent = circle

        local state = defaultVal
        switchBtn.MouseButton1Click:Connect(function()
            state = not state
            local targetBg = state and Color3.fromRGB(75, 105, 240) or Color3.fromRGB(45, 50, 70)
            local targetPos = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)

            TweenService:Create(switchBtn, TweenInfo.new(0.18), {BackgroundColor3 = targetBg}):Play()
            TweenService:Create(circle, TweenInfo.new(0.18), {Position = targetPos}):Play()

            callback(state)
        end)
    end

    CreateToggle("Ragebot (MsHub Engine & NPC Target)", Config.Ragebot, function(val)
        Config.Ragebot = val
    end)

    CreateToggle("Fast Attack (Zero Cooldown)", Config.FastAttack, function(val)
        Config.FastAttack = val
        ApplyFastAttack(val)
    end)

    CreateToggle("Auto Collect Drops", Config.AutoCollect, function(val)
        Config.AutoCollect = val
    end)

    CreateToggle("Fly (WASD + Space/Shift)", Config.Fly, function(val)
        Config.Fly = val
    end)

    CreateToggle("Noclip", Config.Noclip, function(val)
        Config.Noclip = val
    end)

    CreateToggle("Infinite Jump", Config.InfiniteJump, function(val)
        Config.InfiniteJump = val
    end)

    CreateToggle("Zombie ESP", Config.ZombieESP, function(val)
        Config.ZombieESP = val
        UpdateZombieESP()
    end)

    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.RightShift then
            mainFrame.Visible = not mainFrame.Visible
            Config.UIVisible = mainFrame.Visible
        end
    end)

    return screenGui
end

ApplyFastAttack(true)
CreateMinimalUI()

print("[M4rs] Zombie Tower Ragebot Loaded. RightShift to toggle GUI.")
