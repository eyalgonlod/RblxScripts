-- Ensure the script is executed in the player's environment
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui and parent it directly to CoreGui for better visibility in exploits
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")  -- Parent it directly to CoreGui

-- Create a frame for the GUI panel (no draggable functionality)
local GuiFrame = Instance.new("Frame")
GuiFrame.Parent = ScreenGui
GuiFrame.Size = UDim2.new(0, 250, 0, 200)  -- Mid size of the frame
GuiFrame.Position = UDim2.new(0, -260, 0.1, 0)  -- Position on the right side of the screen
GuiFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Black color

-- Create Buttons inside the frame
local ToggleBundleButton = Instance.new("TextButton")
local ToggleEggsButton = Instance.new("TextButton")
local ToggleValentineButton = Instance.new("TextButton")

-- Initialize button states
local RunningBundle = false
local RunningEggs = false
local RunningValentine = false

-- Set up the buttons
ToggleBundleButton.Parent = GuiFrame
ToggleBundleButton.Size = UDim2.new(0, 200, 0, 40)
ToggleBundleButton.Position = UDim2.new(0, 25, 0.1, 0)
ToggleBundleButton.Text = "Start Bundle Openings"
ToggleBundleButton.BackgroundColor3 = Color3.fromRGB(255, 140, 0)  -- Orange color
ToggleBundleButton.TextColor3 = Color3.fromRGB(255, 255, 255)

ToggleEggsButton.Parent = GuiFrame
ToggleEggsButton.Size = UDim2.new(0, 200, 0, 40)
ToggleEggsButton.Position = UDim2.new(0, 25, 0.2, 0)
ToggleEggsButton.Text = "Start Rolling Eggs"
ToggleEggsButton.BackgroundColor3 = Color3.fromRGB(255, 140, 0)  -- Orange color
ToggleEggsButton.TextColor3 = Color3.fromRGB(255, 255, 255)

ToggleValentineButton.Parent = GuiFrame
ToggleValentineButton.Size = UDim2.new(0, 200, 0, 40)
ToggleValentineButton.Position = UDim2.new(0, 25, 0.3, 0)
ToggleValentineButton.Text = "Start Valentines Event"
ToggleValentineButton.BackgroundColor3 = Color3.fromRGB(255, 140, 0)  -- Orange color
ToggleValentineButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Bundle opening function
local function openBundles()
    while RunningBundle do
        -- Bundle of scrolls
        local args4 = {
            [1] = "dd0ad0cfe5524a62bbb1eed27208d1e3",
            [2] = 50
        }
        game:GetService("ReplicatedStorage").Network:FindFirstChild("Lootbox: Open"):InvokeServer(unpack(args4))
        wait(0.01)

        -- Bundle of boosts
        local args5 = {
            [1] = "a136a7ba64bb4395bb99a6de8fe20c99",
            [2] = 50
        }
        game:GetService("ReplicatedStorage").Network:FindFirstChild("Lootbox: Open"):InvokeServer(unpack(args5))
        wait(0.01)
    end
end

-- Egg rolling function
local function rollEggs()
    while RunningEggs do
        game:GetService("ReplicatedStorage").Network.Eggs_Roll:InvokeServer()
        wait(0.02)
    end
end

-- Valentine event function
local function rollValentine()
    while RunningValentine do
        local argsValentine = {"Valentines"}
        game:GetService("ReplicatedStorage").Network.Board_Roll:InvokeServer(unpack(argsValentine))
        wait(0.2)
    end
end

-- Button connections
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
print("GUI script loaded successfully.")
