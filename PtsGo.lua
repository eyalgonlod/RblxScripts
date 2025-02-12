-- Create the ScreenGui and parent it to CoreGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")

-- Create a black frame to hold all buttons
local GuiFrame = Instance.new("Frame")
GuiFrame.Parent = ScreenGui
GuiFrame.Size = UDim2.new(0, 200, 0, 360)  -- Set the size of the frame
GuiFrame.Position = UDim2.new(1, -210, 0.1, 0)  -- Position the frame on the right side
GuiFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Black background color

-- Function to create buttons
local function createButton(name, position, text)
    local button = Instance.new("TextButton")
    button.Parent = GuiFrame
    button.Size = UDim2.new(0, 150, 0, 40)  -- Set the button size
    button.Position = UDim2.new(0, 25, position, 0)  -- Set the button position inside the frame
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(255, 140, 0)  -- Set the button color to orange
    button.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Set the text color to white
    button.Name = name
    return button
end

-- Create all the buttons
local buttons = {
    BoostBundle = createButton("BoostBundle", 0.1, "Boost Bundle"),
    Eggs = createButton("Eggs", 0.2, "Roll Eggs"),
    Valentine = createButton("Valentine", 0.3, "Valentine Event")
}

-- Function to dynamically retrieve the Boost ID
local function getBoostBundleId()
    local networkService = game:GetService("ReplicatedStorage").Network
    local boostFolder = networkService:FindFirstChild("BoostBundles")  -- Replace with the correct location if necessary
    if boostFolder then
        local boostId = boostFolder:FindFirstChild("CurrentBoostId")
        if boostId then
            return boostId.Value  -- Dynamically return the current Boost ID
        end
    end
    return "defaultBoostId"  -- Fallback if ID is not found
end

-- Boost Bundle button function
buttons.BoostBundle.MouseButton1Click:Connect(function()
    local runningBoost = true
    buttons.BoostBundle.Text = "Stop Boost Bundle"
    buttons.BoostBundle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

    task.spawn(function()
        while runningBoost do
            local boostId = getBoostBundleId()  -- Fetch the dynamic Boost ID
            local args5 = {
                [1] = boostId,  -- Use dynamic Boost ID
                [2] = 50  -- Amount
            }
            game:GetService("ReplicatedStorage").Network:FindFirstChild("Lootbox: Open"):InvokeServer(unpack(args5))
            task.wait(0.01)
        end
    end)

    -- Stop Boost Bundle on second click
    buttons.BoostBundle.MouseButton1Click:Connect(function()
        runningBoost = false
        buttons.BoostBundle.Text = "Boost Bundle"
        buttons.BoostBundle.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    end)
end)

-- Eggs button function
buttons.Eggs.MouseButton1Click:Connect(function()
    local runningEggs = true
    buttons.Eggs.Text = "Stop Rolling Eggs"
    buttons.Eggs.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

    task.spawn(function()
        while runningEggs do
            game:GetService("ReplicatedStorage").Network.Eggs_Roll:InvokeServer()
            task.wait(0.2)
        end
    end)

    -- Stop Eggs on second click
    buttons.Eggs.MouseButton1Click:Connect(function()
        runningEggs = false
        buttons.Eggs.Text = "Roll Eggs"
        buttons.Eggs.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    end)
end)

-- Valentine button function
buttons.Valentine.MouseButton1Click:Connect(function()
    local runningValentine = true
    buttons.Valentine.Text = "Stop Valentine Event"
    buttons.Valentine.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

    task.spawn(function()
        while runningValentine do
            game:GetService("ReplicatedStorage").Network.Board_Roll:InvokeServer("Valentines")
            task.wait(0.2)
        end
    end)

    -- Stop Valentine event on second click
    buttons.Valentine.MouseButton1Click:Connect(function()
        runningValentine = false
        buttons.Valentine.Text = "Valentine Event"
        buttons.Valentine.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    end)
end)

print("GUI with Boost Bundle functionality should now work.")
