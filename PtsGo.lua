-- This should be a LocalScript under StarterPlayerScripts or StarterCharacterScripts

local ScreenGui = Instance.new("ScreenGui")
local ToggleBundleButton = Instance.new("TextButton")
local ToggleEggsButton = Instance.new("TextButton")
local ToggleValentineButton = Instance.new("TextButton")
local RunningBundle = false
local RunningEggs = false
local RunningValentine = false

-- Ensure the script is running under PlayerGui
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

ScreenGui.Parent = playerGui
ScreenGui.Visible = true  -- Make sure the GUI is visible

-- Make the GUI movable
ScreenGui.Draggable = true

ToggleBundleButton.Parent = ScreenGui
ToggleBundleButton.Size = UDim2.new(0, 150, 0, 40) -- Smaller button
ToggleBundleButton.Position = UDim2.new(0, 10, 0.1, 0) -- Left side
ToggleBundleButton.Text = "Start Bundle Openings"
ToggleBundleButton.BackgroundColor3 = Color3.fromRGB(255, 140, 0) -- Orange color
ToggleBundleButton.TextColor3 = Color3.fromRGB(255, 255, 255)

ToggleEggsButton.Parent = ScreenGui
ToggleEggsButton.Size = UDim2.new(0, 150, 0, 40)
ToggleEggsButton.Position = UDim2.new(0, 10, 0.2, 0)
ToggleEggsButton.Text = "Start Rolling Eggs"
ToggleEggsButton.BackgroundColor3 = Color3.fromRGB(255, 140, 0) -- Orange color
ToggleEggsButton.TextColor3 = Color3.fromRGB(255, 255, 255)

ToggleValentineButton.Parent = ScreenGui
ToggleValentineButton.Size = UDim2.new(0, 150, 0, 40)
ToggleValentineButton.Position = UDim2.new(0, 10, 0.3, 0)
ToggleValentineButton.Text = "Start Valentines Event"
ToggleValentineButton.BackgroundColor3 = Color3.fromRGB(255, 140, 0) -- Orange color
ToggleValentineButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local function openBundles()
    while RunningBundle do
        -- Bundle of scrolls
        local args4 = {
            [1] = "dd0ad0cfe5524a62bbb1eed27208d1e3",
            [2] = 50
        }
        game:GetService("ReplicatedStorage").Network:FindFirstChild("Lootbox: Open"):InvokeServer(unpack(args4))
        task.wait(0.01)

        -- Bundle of boosts
        local args5 = {
            [1] = "a136a7ba64bb4395bb99a6de8fe20c99",
            [2] = 50
        }
        game:GetService("ReplicatedStorage").Network:FindFirstChild("Lootbox: Open"):InvokeServer(unpack(args5))
        task.wait(0.01)
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

ToggleBundleButton.MouseButton1Click:Connect(function()
    RunningBundle = not RunningBundle
    ToggleBundleButton.Text = RunningBundle and "Stop Bundle Openings" or "Start Bundle Openings"
    ToggleBundleButton.BackgroundColor3 = RunningBundle and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 140, 0)
    
    if RunningBundle then
        task.spawn(openBundles)
    end
end)

ToggleEggsButton.MouseButton1Click:Connect(function()
    RunningEggs = not RunningEggs
    ToggleEggsButton.Text = RunningEggs and "Stop Rolling Eggs" or "Start Rolling Eggs"
    ToggleEggsButton.BackgroundColor3 = RunningEggs and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 140, 0)
    
    if RunningEggs then
        task.spawn(rollEggs)
    end
end)

ToggleValentineButton.MouseButton1Click:Connect(function()
    RunningValentine = not RunningValentine
    ToggleValentineButton.Text = RunningValentine and "Stop Valentines Event" or "Start Valentines Event"
    ToggleValentineButton.BackgroundColor3 = RunningValentine and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 140, 0)
    
    if RunningValentine then
        task.spawn(rollValentine)
    end
end)

-- Debugging
print("Script loaded successfully.")
