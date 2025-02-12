local ScreenGui = Instance.new("ScreenGui")
local ToggleLootButton = Instance.new("TextButton")
local ToggleEggsButton = Instance.new("TextButton")
local ToggleValentineButton = Instance.new("TextButton")
local RunningLoot = false
local RunningEggs = false
local RunningValentine = false

ScreenGui.Parent = game:GetService("CoreGui")

ToggleLootButton.Parent = ScreenGui
ToggleLootButton.Size = UDim2.new(0, 150, 0, 40) -- Smaller button
ToggleLootButton.Position = UDim2.new(0, 10, 0.1, 0) -- Left side
ToggleLootButton.Text = "Start Loot Boxes"
ToggleLootButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

ToggleEggsButton.Parent = ScreenGui
ToggleEggsButton.Size = UDim2.new(0, 150, 0, 40)
ToggleEggsButton.Position = UDim2.new(0, 10, 0.2, 0)
ToggleEggsButton.Text = "Start Rolling Eggs"
ToggleEggsButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

ToggleValentineButton.Parent = ScreenGui
ToggleValentineButton.Size = UDim2.new(0, 150, 0, 40)
ToggleValentineButton.Position = UDim2.new(0, 10, 0.3, 0)
ToggleValentineButton.Text = "Start Valentines Event"
ToggleValentineButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

local function openLootboxes()
    while RunningLoot do
        local argsList = {
            {"d2f11dcd329c4512a1963d9e016b255e", 1},
            {"0fed0d87569b48058effcc67f49e4447", 1},
            {"edb8b4dfd9a347669c5072c12e65df1a", 1},
            {"dd0ad0cfe5524a62bbb1eed27208d1e3", 50},
            {"a136a7ba64bb4395bb99a6de8fe20c99", 50}
        }
        
        for _, args in ipairs(argsList) do
            game:GetService("ReplicatedStorage").Network:FindFirstChild("Lootbox: Open"):InvokeServer(unpack(args))
            task.wait(0.01)
        end
    end
end

local function rollEggs()
    while RunningEggs do
        game:GetService("ReplicatedStorage").Network.Eggs_Roll:InvokeServer()
        task.wait(0.02)
    end
end

local function rollValentine()
    while RunningValentine do
        local argsValentine = {"Valentines"}
        game:GetService("ReplicatedStorage").Network.Board_Roll:InvokeServer(unpack(argsValentine))
        task.wait(0.2)
    end
end

ToggleLootButton.MouseButton1Click:Connect(function()
    RunningLoot = not RunningLoot
    ToggleLootButton.Text = RunningLoot and "Stop Loot Boxes" or "Start Loot Boxes"
    ToggleLootButton.BackgroundColor3 = RunningLoot and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
    
    if RunningLoot then
        task.spawn(openLootboxes)
    end
end)

ToggleEggsButton.MouseButton1Click:Connect(function()
    RunningEggs = not RunningEggs
    ToggleEggsButton.Text = RunningEggs and "Stop Rolling Eggs" or "Start Rolling Eggs"
    ToggleEggsButton.BackgroundColor3 = RunningEggs and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
    
    if RunningEggs then
        task.spawn(rollEggs)
    end
end)

ToggleValentineButton.MouseButton1Click:Connect(function()
    RunningValentine = not RunningValentine
    ToggleValentineButton.Text = RunningValentine and "Stop Valentines Event" or "Start Valentines Event"
    ToggleValentineButton.BackgroundColor3 = RunningValentine and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
    
    if RunningValentine then
        task.spawn(rollValentine)
    end
end)
