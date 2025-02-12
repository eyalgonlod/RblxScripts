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
    BasicChest = createButton("BasicChest", 0.1, "Basic Chest"),
    RareChest = createButton("RareChest", 0.2, "Rare Chest"),
    EpicChest = createButton("EpicChest", 0.3, "Epic Chest"),
    BoostBundle = createButton("BoostBundle", 0.4, "Boost Bundle"),
    Eggs = createButton("Eggs", 0.5, "Roll Eggs"),
    Valentine = createButton("Valentine", 0.6, "Valentine Event")
}

-- Set up the function to toggle the buttons
local running = {}

local function toggleFunction(button, id, amount)
    running[id] = not running[id]
    button.Text = running[id] and "Stop " .. button.Text or button.Text:gsub("Stop ", "")
    button.BackgroundColor3 = running[id] and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 140, 0)

    if running[id] then
        task.spawn(function()
            while running[id] do
                -- Call the ReplicatedStorage API to perform the action
                game:GetService("ReplicatedStorage").Network:FindFirstChild("Lootbox: Open"):InvokeServer(id, amount)
                task.wait(0.1)
            end
        end)
    end
end

-- Modify Boost Bundle button behavior
buttons.BoostBundle.MouseButton1Click:Connect(function()
    running["BoostBundle"] = not running["BoostBundle"]
    buttons.BoostBundle.Text = running["BoostBundle"] and "Stop Boost Bundle" or "Boost Bundle"
    buttons.BoostBundle.BackgroundColor3 = running["BoostBundle"] and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 140, 0)
    
    if running["BoostBundle"] then
        task.spawn(function()
            while running["BoostBundle"] do
                -- Execute the Boost Bundle action repeatedly
                local args5 = {
                    [1] = "a136a7ba64bb4395bb99a6de8fe20c99", -- Bundle for boosts
                    [2] = 50  -- Amount
                }
                game:GetService("ReplicatedStorage").Network:FindFirstChild("Lootbox: Open"):InvokeServer(unpack(args5))
                task.wait(0.01)
            end
        end)
    end
end)

-- Add button click events to handle the toggles
buttons.BasicChest.MouseButton1Click:Connect(function() toggleFunction(buttons.BasicChest, "d2f11dcd329c4512a1963d9e016b255e", 1) end)
buttons.RareChest.MouseButton1Click:Connect(function() toggleFunction(buttons.RareChest, "0fed0d87569b48058effcc67f49e4447", 1) end)
buttons.EpicChest.MouseButton1Click:Connect(function() toggleFunction(buttons.EpicChest, "edb8b4dfd9a347669c5072c12e65df1a", 1) end)

-- Add events for Eggs and Valentine buttons
buttons.Eggs.MouseButton1Click:Connect(function()
    running["Eggs"] = not running["Eggs"]
    buttons.Eggs.Text = running["Eggs"] and "Stop Rolling Eggs" or "Roll Eggs"
    buttons.Eggs.BackgroundColor3 = running["Eggs"] and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 140, 0)

    if running["Eggs"] then
        task.spawn(function()
            while running["Eggs"] do
                game:GetService("ReplicatedStorage").Network.Eggs_Roll:InvokeServer()
                task.wait(0.2)
            end
        end)
    end
end)

buttons.Valentine.MouseButton1Click:Connect(function()
    running["Valentine"] = not running["Valentine"]
    buttons.Valentine.Text = running["Valentine"] and "Stop Valentine Event" or "Valentine Event"
    buttons.Valentine.BackgroundColor3 = running["Valentine"] and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 140, 0)

    if running["Valentine"] then
        task.spawn(function()
            while running["Valentine"] do
                game:GetService("ReplicatedStorage").Network.Board_Roll:InvokeServer("Valentines")
                task.wait(0.2)
            end
        end)
    end
end)

print("GUI with Boost Bundle functionality should now work.")
