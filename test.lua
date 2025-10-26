-- ================= INSTANT FISHING SYSTEM =================

local InstantFishingActive = false
local InstantFishingStats = {
    TotalCatches = 0,
    StartTime = 0,
    PerfectRate = 100, -- 100% success rate
    LastCatchTime = 0
}

-- ULTRA INSTANT FISHING FUNCTION
local function ExecuteInstantFishing()
    local successCount = 0
    
    pcall(function()
        -- STEP 1: AUTO EQUIP FISHING ROD
        if EquipTool then
            EquipTool:FireServer(1) -- Equip fishing rod slot 1
        end
        task.wait(0.05)
        
        -- STEP 2: INSTANT CHARGE - NO DELAY
        if ChargeRod then
            ChargeRod:InvokeServer(tick()) -- Instant charge
        end
        task.wait(0.05)
        
        -- STEP 3: PERFECT MINIGAME - ALWAYS PERFECT SCORE
        if StartMini then
            -- Perfect coordinates for instant success
            StartMini:InvokeServer(-1.233184814453125, 0.9945034885633273)
        end
        task.wait(0.05)
        
        -- STEP 4: INSTANT COMPLETE FISHING
        if FinishFish then
            FinishFish:FireServer() -- Complete fishing instantly
        end
        task.wait(0.05)
        
        -- STEP 5: FORCE FISH CAUGHT WITH HIGH RARITY
        if FishCaught then
            -- Always catch high-tier fish
            local fishTier = math.random(5, 7) -- Legendary to Secret
            local fishRarity = "LEGENDARY"
            if fishTier == 6 then fishRarity = "MYTHIC"
            elseif fishTier == 7 then fishRarity = "SECRET" end
            
            FishCaught:FireServer({
                Name = "⚡ INSTANT FISH",
                Tier = fishTier,
                SellPrice = math.random(20000, 50000),
                Rarity = fishRarity,
                Weight = math.random(3, 8) + math.random()
            })
            successCount = 1
            
            -- SEND TELEGRAM NOTIFICATION IF ENABLED
            if TelegramConfig.Enabled and ShouldSendByRarity(fishRarity) then
                local fishInfo = {
                    Name = "INSTANT FISH",
                    Tier = fishTier,
                    SellPrice = math.random(20000, 50000),
                    Rarity = fishRarity,
                    Weight = math.random(3, 8) + math.random()
                }
                local message = BuildTelegramMessage(fishInfo, math.random(1000, 9999), fishRarity, fishInfo.Weight)
                spawn(function() SendTelegram(message) end)
            end
        end
        
        -- STEP 6: EXTRA CATCHES FOR MAXIMUM EFFICIENCY
        if Config.MaxPerformance and FishCaught then
            for i = 1, 2 do -- Extra 2 fish per cycle
                local extraTier = math.random(6, 7) -- Mythic or Secret
                local extraRarity = extraTier == 6 and "MYTHIC" or "SECRET"
                
                FishCaught:FireServer({
                    Name = "🚀 ULTRA FISH",
                    Tier = extraTier,
                    SellPrice = math.random(25000, 60000),
                    Rarity = extraRarity,
                    Weight = math.random(4, 10) + math.random()
                })
                successCount = successCount + 1
                
                -- SEND TELEGRAM FOR EXTRA CATCHES
                if TelegramConfig.Enabled and ShouldSendByRarity(extraRarity) then
                    local fishInfo = {
                        Name = "ULTRA FISH",
                        Tier = extraTier,
                        SellPrice = math.random(25000, 60000),
                        Rarity = extraRarity,
                        Weight = math.random(4, 10) + math.random()
                    }
                    local message = BuildTelegramMessage(fishInfo, math.random(1000, 9999), extraRarity, fishInfo.Weight)
                    spawn(function() SendTelegram(message) end)
                end
            end
        end
    end)
    
    return successCount
end

-- MAIN INSTANT FISHING LOOP
local function StartInstantFishing()
    if InstantFishingActive then return end
    
    print("🚀 ACTIVATING INSTANT FISHING - 100% SUCCESS RATE!")
    
    InstantFishingActive = true
    InstantFishingStats.TotalCatches = 0
    InstantFishingStats.StartTime = tick()
    InstantFishingStats.LastCatchTime = tick()
    
    -- MAIN FISHING LOOP
    task.spawn(function()
        while InstantFishingActive do
            local cycleStart = tick()
            
            -- EXECUTE INSTANT FISHING CYCLE
            local catchesThisCycle = ExecuteInstantFishing()
            InstantFishingStats.TotalCatches = InstantFishingStats.TotalCatches + catchesThisCycle
            InstantFishingStats.LastCatchTime = tick()
            
            -- ULTRA FAST CYCLE TIMING
            local cycleTime = tick() - cycleStart
            local waitTime = math.max(Config.CycleSpeed - cycleTime, 0.01)
            
            task.wait(waitTime)
        end
    end)
    
    -- REAL-TIME STATS MONITOR
    task.spawn(function()
        while InstantFishingActive do
            local elapsed = tick() - InstantFishingStats.StartTime
            local currentRate = math.floor(InstantFishingStats.TotalCatches / math.max(elapsed, 1))
            local totalTime = tick() - InstantFishingStats.StartTime
            
            -- UPDATE WINDOW TITLE WITH LIVE STATS
            pcall(function()
                Window:SetWindowName(string.format("WAKWIK INSTANT | %d FISH/SEC | TOTAL: %d", currentRate, InstantFishingStats.TotalCatches))
            end)
            
            -- AUTO SELL IF ENABLED
            if Config.AutoSell and InstantFishingStats.TotalCatches % 50 == 0 then
                pcall(function() SellRemote:InvokeServer() end)
            end
            
            task.wait(0.5)
        end
    end)
    
    Rayfield:Notify({
        Title = "🚀 INSTANT FISHING ACTIVATED",
        Content = "100% Success Rate! Speed: " .. Config.CycleSpeed .. "s",
        Duration = 5
    })
end

local function StopInstantFishing()
    if not InstantFishingActive then return end
    
    InstantFishingActive = false
    
    local totalTime = tick() - InstantFishingStats.StartTime
    local avgRate = math.floor(InstantFishingStats.TotalCatches / math.max(totalTime, 1))
    
    Rayfield:Notify({
        Title = "🛑 INSTANT FISHING STOPPED",
        Content = string.format("Total: %d fish | Avg: %d/sec | Time: %.1fs", 
            InstantFishingStats.TotalCatches, avgRate, totalTime),
        Duration = 5
    })
    
    pcall(function()
        Window:SetWindowName("WAKWIK FISH IT - INSTANT FISHING")
    end)
end

-- ================= ENHANCED PERFECT CATCH =================

local function EnablePerfectCatchPlus()
    -- OVERRIDE MINIGAME FOR PERFECT CATCH
    local mt = getrawmetatable(game)
    if not mt then return end
    
    setreadonly(mt, false)
    local oldNamecall = mt.__namecall
    
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        -- ALWAYS RETURN PERFECT SCORE FOR FISHING MINIGAME
        if method == "InvokeServer" and self == StartMini then
            return oldNamecall(self, -1.233184814453125, 0.9945034885633273)
        end
        
        return oldNamecall(self, ...)
    end)
    
    setreadonly(mt, true)
    
    print("[PERFECT CATCH+] Always perfect minigame enabled!")
end

-- ================= UI FOR INSTANT FISHING =================

-- Tambahkan ini di bagian CreateUI() setelah Tab1:CreateSection("EXTRA SPEED")

-- INSTANT FISHING SECTION
Tab1:CreateSection("INSTANT FISHING 🚀")

Tab1:CreateToggle({
    Name = "ACTIVATE INSTANT FISHING",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            -- Stop other fishing modes
            Config.AutoFishingV1 = false
            Config.AutoFishingV2 = false
            Config.AutoFishingStable = false
            Config.UltraInstantBite = false
            
            StartInstantFishing()
        else
            StopInstantFishing()
        end
    end
})

Tab1:CreateSlider({
    Name = "Instant Fishing Speed",
    Range = {0.01, 0.5},
    Increment = 0.01,
    CurrentValue = 0.05,
    Suffix = "s",
    Callback = function(Value)
        Config.CycleSpeed = Value
    end
})

Tab1:CreateToggle({
    Name = "Always Perfect Catch++",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            EnablePerfectCatchPlus()
            Rayfield:Notify({
                Title = "Perfect Catch++",
                Content = "Always perfect minigame enabled!",
                Duration = 3
            })
        end
    end
})

Tab1:CreateButton({
    Name = "TEST INSTANT CATCH (10x)",
    Callback = function()
        print("🧪 TESTING INSTANT CATCH 10x...")
        local totalCaught = 0
        for i = 1, 10 do
            totalCaught = totalCaught + ExecuteInstantFishing()
            task.wait(0.1)
        end
        Rayfield:Notify({
            Title = "TEST COMPLETE",
            Content = string.format("Caught %d fish instantly!", totalCaught),
            Duration = 3
        })
    end
})

-- ================= AUTO-SETUP INSTANT FISHING =================

-- Otomatis setup instant fishing ketika script mulai
task.spawn(function()
    task.wait(3)
    
    -- Enable perfect catch secara otomatis
    EnablePerfectCatchPlus()
    
    -- Set cycle speed ke paling cepat
    Config.CycleSpeed = 0.05
    
    print("⚡ INSTANT FISHING SYSTEM READY!")
    print("✅ Perfect Catch++ Enabled")
    print("✅ Ultra Fast Cycle: 0.05s")
    print("✅ 100% Success Rate Guaranteed")
    print("✅ High Tier Fish Always")
end)

-- ================= CHARACTER RESPAWN HANDLER =================

-- Pastikan instant fishing tetap berjalan setelah respawn
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
    Humanoid = char:WaitForChild("Humanoid")
    
    task.wait(2)
    
    if InstantFishingActive then
        print("♻️ Restarting Instant Fishing after respawn...")
        task.wait(1)
        StartInstantFishing()
    end
end)
