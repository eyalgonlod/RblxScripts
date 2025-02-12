local ScreenGui = Instance.new("ScreenGui")
local ToggleBasicChestButton = Instance.new("TextButton")
local ToggleRareChestButton = Instance.new("TextButton")
local ToggleEpicChestButton = Instance.new("TextButton")
local ToggleBoostBundleButton = Instance.new("TextButton")
local ToggleEggsButton = Instance.new("TextButton")
local ToggleValentineButton = Instance.new("TextButton")
local RunningBasicChest = false
local RunningRareChest = false
local RunningEpicChest = false
local RunningBoostBundle = false
local RunningEggs = false
local RunningValentine = false

ScreenGui.Parent = game:GetService("CoreGui")

local function createButton(button, position, text)
    button.Parent = ScreenGui
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Position = UDim2.new(0.5, -100, position, 0)
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
end

createButton(ToggleBasicChestButton, 0.1, "Start Basic Chest")
createButton(ToggleRareChestButton, 0.2, "Start Rare Chest")
createButton(ToggleEpicChestButton, 0.3, "Start Epic Chest")
createButton(ToggleBoostBundleButton, 0.4, "Start Boost Bundle")
createButton(ToggleEggsButton, 0.5, "Start Rolling Eggs")
createButton(ToggleValentineButton, 0.6, "Start Valentines Event")

local function openChest(itemId, runningFlag)
    while _G[runningFlag] do
        game:GetService("ReplicatedStorage").Network:FindFirstChild("Lootbox: Open"):InvokeServer(itemId, 1)
        task.wait(0.01)
    end
end

local function toggleFunction(button, runningFlag, functionToRun, itemId)
    button.MouseButton1Click:Connect(function()
        _G[runningFlag] = not _G[runningFlag]
        button.Text = _G[runningFlag] and "Stop " .. button.Text:sub(7) or "Start " .. button.Text:sub(7)
        button.BackgroundColor3 = _G[runningFlag] and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
        if _G[runningFlag] then
            task.spawn(functionToRun, itemId, runningFlag)
        end
    end)
end

toggleFunction(ToggleBasicChestButton, "RunningBasicChest", openChest, "d2f11dcd329c4512a1963d9e016b255e")
toggleFunction(ToggleRareChestButton, "RunningRareChest", openChest, "0fed0d87569b48058effcc67f49e4447")
toggleFunction(ToggleEpicChestButton, "RunningEpicChest", openChest, "edb8b4dfd9a347669c5072c12e65df1a")
toggleFunction(ToggleBoostBundleButton, "RunningBoostBundle", openChest, "a136a7ba64bb4395bb99a6de8fe20c99")

toggleFunction(ToggleEggsButton, "RunningEggs", function()
    while RunningEggs do
        game:GetService("ReplicatedStorage").Network.Eggs_Roll:InvokeServer()
        task.wait(0.02)
    end
end, nil)

toggleFunction(ToggleValentineButton, "RunningValentine", function()
    while RunningValentine do
        local argsValentine = {"Valentines"}
        game:GetService("ReplicatedStorage").Network.Board_Roll:InvokeServer(unpack(argsValentine))
        task.wait(0.2)
    end
end, nil)
