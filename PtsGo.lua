local ScreenGui = Instance.new("ScreenGui")
local ToggleBundlesButton = Instance.new("TextButton")
local RunningBundles = false

ScreenGui.Parent = game:GetService("CoreGui")

ToggleBundlesButton.Parent = ScreenGui
ToggleBundlesButton.Size = UDim2.new(0, 150, 0, 40)
ToggleBundlesButton.Position = UDim2.new(0, 10, 0.1, 0)
ToggleBundlesButton.Text = "◀ Bundles Off"
ToggleBundlesButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
ToggleBundlesButton.TextColor3 = Color3.fromRGB(0, 0, 0)

local function openBundles()
    while RunningBundles do
        local argsList = {
            {"dd0ad0cfe5524a62bbb1eed27208d1e3", 50}, -- Bundle of Scrolls
            {"a136a7ba64bb4395bb99a6de8fe20c99", 50}  -- Bundle of Boosts
        }
        
        for _, args in ipairs(argsList) do
            game:GetService("ReplicatedStorage").Network:FindFirstChild("Lootbox: Open"):InvokeServer(unpack(args))
            task.wait(0.01)
        end
    end
end

ToggleBundlesButton.MouseButton1Click:Connect(function()
    RunningBundles = not RunningBundles
    ToggleBundlesButton.Text = RunningBundles and "▶ Bundles On" or "◀ Bundles Off"
    ToggleBundlesButton.BackgroundColor3 = RunningBundles and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 165, 0)
    
    if RunningBundles then
        task.spawn(openBundles)
    end
end)

-- Make GUI movable
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    ScreenGui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

ScreenGui.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ScreenGui.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

ScreenGui.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateInput(input)
    end
end)
