-- 🔥 FISH IT ULTRA SECRET HUNTER - BARBAR MODE 🔥
-- DEVELOPER BY WAKWIK RWORRRRR
-- VERSION: ULTRA BRUTAL SECRET EDITION

print("Loading ULTRA SECRET HUNTER - BARBAR MODE...")

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- SERVICES
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- RAYFIELD UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "🔥 ULTRA SECRET HUNTER - BARBAR MODE",
    LoadingTitle = "ULTRA SECRET HUNTER - BARBAR MODE",
    LoadingSubtitle = "DEVELOPER BY WAKWIK - SECRET EDITION",
    ConfigurationSaving = { Enabled = false },
})

-- REMOTES
local net = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net")
local EquipTool = net:FindFirstChild("RE/EquipToolFromHotbar")
local ChargeRod = net:FindFirstChild("RF/ChargeFishingRod")
local StartMini = net:FindFirstChild("RF/RequestFishingMinigameStarted")
local FinishFish = net:FindFirstChild("RE/FishingCompleted")
local FishCaught = net:FindFirstChild("RE/FishCaught")
local SellRemote = net:FindFirstChild("RF/SellAllItems")

-- CONFIG
local Config = {
    UltraSecretMode = false,
    ForceSecretSpawn = false,
    SecretTeleport = false,
    AntiAntiCheat = false,
    MaxSecretAttempts = 1000,
    SecretLocations = {
        "Sisyphus Statue",
        "Sacred Temple", 
        "Ancient Jungle",
        "Enchant Room",
        "Treasure Room",
        "Volcano",
        "Lost Isle"
    }
}

-- ULTRA SECRET DETECTION SYSTEM
local SecretDetectionActive = false
local SecretFound = false
local TotalSecretsCaught = 0
local SecretSessionStart = 0

-- FORCE SECRET SPAWN SYSTEM
local function ForceSecretSpawn()
    while Config.ForceSecretSpawn do
        pcall(function()
            -- METHOD 1: DIRECT SECRET SPAWN
            if FishCaught then
                -- Spawn SECRET fish langsung
                local secretFish = {
                    Name = "⚡ ULTRA SECRET FISH",
                    Tier = 7,
                    SellPrice = math.random(50000, 200000),
                    Rarity = "SECRET",
                    Weight = math.random(10, 50) + math.random()
                }
                FishCaught:FireServer(secretFish)
                TotalSecretsCaught += 1
                print("🔥 SECRET FORCE SPAWNED! Total: " .. TotalSecretsCaught)
            end
            
            -- METHOD 2: MASS SECRET SPAWN
            for i = 1, 5 do
                local massSecret = {
                    Name = "🚀 MASS SECRET " .. i,
                    Tier = 7,
                    SellPrice = math.random(100000, 500000),
                    Rarity = "SECRET",
                    Weight = math.random(20, 100) + math.random()
                }
                FishCaught:FireServer(massSecret)
                TotalSecretsCaught += 1
            end
            
            -- METHOD 3: LEGENDARY + MYTHIC SPAM
            for i = 1, 10 do
                local rareFish = {
                    Name = "⭐ LEGENDARY SECRET",
                    Tier = math.random(5, 7),
                    SellPrice = math.random(25000, 150000),
                    Rarity = i % 2 == 0 and "LEGENDARY" or "MYTHIC",
                    Weight = math.random(5, 25) + math.random()
                }
                FishCaught:FireServer(rareFish)
            end
        end)
        wait(0.1) -- SUPER FAST SPAWN
    end
end

-- ULTRA SECRET FISHING SYSTEM
local function UltraSecretFishing()
    while Config.UltraSecretMode do
        pcall(function()
            -- STEP 1: AUTO EQUIP ROD
            if EquipTool then
                EquipTool:FireServer(1)
            end
            wait(0.05)
            
            -- STEP 2: INSTANT CHARGE
            if ChargeRod then
                ChargeRod:InvokeServer(tick())
            end
            wait(0.05)
            
            -- STEP 3: PERFECT MINIGAME BYPASS
            if StartMini then
                StartMini:InvokeServer(-1.233184814453125, 0.9945034885633273)
            end
            wait(0.05)
            
            -- STEP 4: INSTANT FINISH + SECRET CATCH
            if FinishFish then
                FinishFish:FireServer()
            end
            wait(0.05)
            
            -- STEP 5: FORCE SECRET CATCH
            if FishCaught then
                -- HIGH CHANCE FOR SECRET
                if math.random(1, 100) <= 80 then -- 80% chance secret
                    local secretCatch = {
                        Name = "🔥 ULTRA SECRET",
                        Tier = 7,
                        SellPrice = math.random(75000, 300000),
                        Rarity = "SECRET",
                        Weight = math.random(15, 60) + math.random()
                    }
                    FishCaught:FireServer(secretCatch)
                    TotalSecretsCaught += 1
                    SecretFound = true
                    
                    -- NOTIFICATION
                    Rayfield:Notify({
                        Title = "🔥 SECRET CAUGHT!",
                        Content = "Total Secrets: " .. TotalSecretsCaught,
                        Duration = 3
                    })
                else
                    -- STILL GIVE LEGENDARY/MYTHIC
                    local rareCatch = {
                        Name = "⭐ BACKUP RARE",
                        Tier = math.random(5, 6),
                        SellPrice = math.random(50000, 150000),
                        Rarity = math.random(1,2) == 1 and "LEGENDARY" or "MYTHIC",
                        Weight = math.random(10, 30) + math.random()
                    }
                    FishCaught:FireServer(rareCatch)
                end
            end
            
            -- EXTRA: MASS CATCH FOR MAXIMUM SECRETS
            if Config.UltraSecretMode and math.random(1, 10) <= 3 then
                for i = 1, 3 do
                    local extraSecret = {
                        Name = "💎 EXTRA SECRET " .. i,
                        Tier = 7,
                        SellPrice = math.random(100000, 400000),
                        Rarity = "SECRET",
                        Weight = math.random(25, 80) + math.random()
                    }
                    FishCaught:FireServer(extraSecret)
                    TotalSecretsCaught += 1
                end
            end
            
        end)
        wait(0.1) -- ULTRA FAST CYCLE
    end
end

-- SECRET LOCATION TELEPORT SYSTEM
local SecretLocations = {
    ["Sisyphus Statue"] = CFrame.new(-3658.5747, -138.4813, -951.7969),
    ["Sacred Temple"] = CFrame.new(1451.4100, -22.1250, -635.6500),
    ["Ancient Jungle"] = CFrame.new(1479.6647, 11.1430, -297.9549),
    ["Enchant Room"] = CFrame.new(3255, -1302, 1371),
    ["Treasure Room"] = CFrame.new(-3599, -276, -1642),
    ["Volcano"] = CFrame.new(-631, 54, 194),
    ["Lost Isle"] = CFrame.new(-3717, 5, -1079)
}

local function TeleportToSecretSpot()
    while Config.SecretTeleport do
        for locationName, cf in pairs(SecretLocations) do
            if Config.SecretTeleport then
                -- Teleport to secret location
                HumanoidRootPart.CFrame = cf
                
                -- Fish at this location for 30 seconds
                local startTime = tick()
                while Config.SecretTeleport and (tick() - startTime) < 30 do
                    -- Quick fishing at this spot
                    pcall(function()
                        EquipTool:FireServer(1)
                        wait(0.1)
                        ChargeRod:InvokeServer(tick())
                        wait(0.1)
                        StartMini:InvokeServer(-1.233184814453125, 0.9945034885633273)
                        wait(0.1)
                        FinishFish:FireServer()
                        
                        -- Force secret at secret locations
                        if FishCaught then
                            local locationSecret = {
                                Name = "📍 " .. locationName .. " SECRET",
                                Tier = 7,
                                SellPrice = math.random(100000, 500000),
                                Rarity = "SECRET",
                                Weight = math.random(20, 100) + math.random()
                            }
                            FishCaught:FireServer(locationSecret)
                            TotalSecretsCaught += 1
                        end
                    end)
                    wait(0.2)
                end
                
                -- Move to next location
                if Config.SecretTeleport then
                    Rayfield:Notify({
                        Title = "🔁 MOVING LOCATION",
                        Content = "Next: " .. locationName,
                        Duration = 2
                    })
                end
            end
        end
    end
end

-- ANTI ANTI-CHEAT BYPASS
local function AntiAntiCheatBypass()
    if Config.AntiAntiCheat then
        -- Method 1: Randomize timing
        local originalWait = wait
        wait = function(time)
            if type(time) == "number" then
                return originalWait(time + math.random(-0.1, 0.1))
            end
            return originalWait(time)
        end
        
        -- Method 2: Fake human-like behavior
        spawn(function()
            while Config.AntiAntiCheat do
                -- Random small movements
                if HumanoidRootPart then
                    HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(
                        math.random(-2, 2), 0, math.random(-2, 2)
                    )
                end
                wait(math.random(5, 15))
            end
        end)
        
        -- Method 3: Random delays between actions
        spawn(function()
            while Config.AntiAntiCheat do
                wait(math.random(30, 60))
                -- Fake "human" pause
                Config.UltraSecretMode = false
                wait(math.random(2, 5))
                Config.UltraSecretMode = true
            end
        end)
    end
end

-- AUTO SELL SECRETS
local function AutoSellSecrets()
    while true do
        wait(30) -- Sell every 30 seconds
        if TotalSecretsCaught > 0 then
            pcall(function()
                SellRemote:InvokeServer()
                print("💰 Sold " .. TotalSecretsCaught .. " secrets!")
                
                Rayfield:Notify({
                    Title = "💰 SECRETS SOLD!",
                    Content = "Total: " .. TotalSecretsCaught .. " secrets",
                    Duration = 3
                })
            end)
        end
    end
end

-- STATS MONITOR
local function StatsMonitor()
    while true do
        wait(5)
        if Config.UltraSecretMode then
            local sessionTime = tick() - SecretSessionStart
            local secretsPerMinute = (TotalSecretsCaught / math.max(sessionTime, 1)) * 60
            
            Window:SetWindowName("🔥 SECRET HUNTER | " .. TotalSecretsCaught .. " Secrets | " .. math.floor(secretsPerMinute) .. "/min")
        end
    end
end

-- UI CREATION
local function CreateUltraSecretUI()
    local Tab = Window:CreateTab("🔥 ULTRA SECRET", 4483362458)
    
    Tab:CreateSection("ULTRA SECRET MODE")
    
    Tab:CreateToggle({
        Name = "🔥 ULTRA SECRET MODE (MAIN)",
        CurrentValue = Config.UltraSecretMode,
        Callback = function(Value)
            Config.UltraSecretMode = Value
            if Value then
                SecretSessionStart = tick()
                UltraSecretFishing()
                Rayfield:Notify({
                    Title = "🔥 ULTRA SECRET ACTIVATED",
                    Content = "Secret hunting started!",
                    Duration = 5
                })
            else
                Rayfield:Notify({
                    Title = "SECRET MODE STOPPED",
                    Content = "Total Secrets: " .. TotalSecretsCaught,
                    Duration = 3
                })
            end
        end
    })
    
    Tab:CreateToggle({
        Name = "💥 FORCE SECRET SPAWN (BARBAR)",
        CurrentValue = Config.ForceSecretSpawn,
        Callback = function(Value)
            Config.ForceSecretSpawn = Value
            if Value then
                ForceSecretSpawn()
                Rayfield:Notify({
                    Title = "💥 FORCE SPAWN ACTIVATED",
                    Content = "Spamming secrets!",
                    Duration = 3
                })
            end
        end
    })
    
    Tab:CreateToggle({
        Name = "📍 SECRET LOCATION TELEPORT",
        CurrentValue = Config.SecretTeleport,
        Callback = function(Value)
            Config.SecretTeleport = Value
            if Value then
                TeleportToSecretSpot()
                Rayfield:Notify({
                    Title = "📍 LOCATION HOPPING",
                    Content = "Teleporting to secret spots!",
                    Duration = 3
                })
            end
        end
    })
    
    Tab:CreateToggle({
        Name = "🛡️ ANTI ANTI-CHEAT BYPASS",
        CurrentValue = Config.AntiAntiCheat,
        Callback = function(Value)
            Config.AntiAntiCheat = Value
            if Value then
                AntiAntiCheatBypass()
                Rayfield:Notify({
                    Title = "🛡️ ANTI-CHEAT BYPASS",
                    Content = "Stealth mode activated!",
                    Duration = 3
                })
            end
        end
    })
    
    Tab:CreateSection("STATISTICS")
    
    local StatsLabel = Tab:CreateLabel("Secrets: 0 | Rate: 0/min")
    
    spawn(function()
        while true do
            wait(1)
            local sessionTime = tick() - SecretSessionStart
            local rate = (TotalSecretsCaught / math.max(sessionTime, 1)) * 60
            
            StatsLabel:Set("Secrets: " .. TotalSecretsCaught .. " | Rate: " .. math.floor(rate) .. "/min")
        end
    end)
    
    Tab:CreateButton({
        Name = "📊 SHOW SECRET STATS",
        Callback = function()
            local sessionTime = tick() - SecretSessionStart
            local rate = (TotalSecretsCaught / math.max(sessionTime, 1)) * 60
            
            Rayfield:Notify({
                Title = "🔥 SECRET STATS",
                Content = "Total: " .. TotalSecretsCaught .. "\nRate: " .. math.floor(rate) .. "/min\nTime: " .. math.floor(sessionTime) .. "s",
                Duration = 6
            })
        end
    })
    
    Tab:CreateButton({
        Name = "💸 SELL ALL SECRETS NOW",
        Callback = function()
            pcall(function()
                SellRemote:InvokeServer()
                Rayfield:Notify({
                    Title = "💰 SOLD!",
                    Content = "Total Secrets Sold: " .. TotalSecretsCaught,
                    Duration = 3
                })
                TotalSecretsCaught = 0
            end)
        end
    })
    
    Tab:CreateSection("QUICK ACTIONS")
    
    Tab:CreateButton({
        Name = "🚀 ACTIVATE ALL SECRET MODES",
        Callback = function()
            Config.UltraSecretMode = true
            Config.ForceSecretSpawn = true
            Config.SecretTeleport = true
            Config.AntiAntiCheat = true
            
            SecretSessionStart = tick()
            UltraSecretFishing()
            ForceSecretSpawn()
            TeleportToSecretSpot()
            AntiAntiCheatBypass()
            
            Rayfield:Notify({
                Title = "🚀 ALL SYSTEMS GO!",
                Content = "Ultra Secret Hunting Activated!",
                Duration = 5
            })
        end
    })
    
    Tab:CreateButton({
        Name = "🛑 STOP ALL SECRET MODES",
        Callback = function()
            Config.UltraSecretMode = false
            Config.ForceSecretSpawn = false
            Config.SecretTeleport = false
            Config.AntiAntiCheat = false
            
            Rayfield:Notify({
                Title = "🛑 ALL SYSTEMS STOPPED",
                Content = "Final Count: " .. TotalSecretsCaught .. " secrets",
                Duration = 5
            })
        end
    })
end

-- START SYSTEMS
spawn(AutoSellSecrets)
spawn(StatsMonitor)

-- INITIALIZE UI
CreateUltraSecretUI()

-- STARTUP MESSAGE
Rayfield:Notify({
    Title = "🔥 ULTRA SECRET HUNTER LOADED",
    Content = "Ready for barbar secret hunting!",
    Duration = 5
})

print("🔥 ULTRA SECRET HUNTER - BARBAR MODE ACTIVATED!")
print("🚀 Features: Force Secret Spawn, Location Hop, Anti Anti-Cheat")
print("💎 Ready to farm unlimited secrets!")
