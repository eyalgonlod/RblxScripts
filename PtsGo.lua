-- Ensure the script is executed in the player's environment
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui and parent it directly to PlayerGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = playerGui  -- Parent it to PlayerGui

-- Create a frame for the GUI panel
local GuiFrame = Instance.new("Frame")
GuiFrame.Parent = ScreenGui
GuiFrame.Size = UDim2.new(0, 250, 0, 300)  -- Mid size of the frame
GuiFrame.Position = UDim2.new(0, 0, 0.1, 0)  -- Position on the screen
GuiFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Black color

-- Create Buttons inside the frame
local ToggleButton1 = Instance.new("TextButton")
local ToggleButton2 = Instance.new("TextButton")
local ToggleButton3 = Instance.new("TextButton")

-- Initialize button states
local Button1State = false
local Button2State = false
local Button3State = false

-- Set up the buttons
ToggleButton1.Parent = GuiFrame
ToggleButton1.Size = UDim2.new(0, 200, 0, 40)
ToggleButton1.Position = UDim2.new(0, 25, 0.1, 0)
ToggleButton1.Text = "Button 1: OFF"
ToggleButton1.BackgroundColor3 = Color3.fromRGB(255, 140, 0)  -- Orange color
ToggleButton1.TextColor3 = Color3.fromRGB(255, 255, 255)

ToggleButton2.Parent = GuiFrame
ToggleButton2.Size = UDim2.new(0, 200, 0, 40)
ToggleButton2.Position = UDim2.new(0, 25, 0.2, 0)
ToggleButton2.Text = "Button 2: OFF"
ToggleButton2.BackgroundColor3 = Color3.fromRGB(255, 140, 0)  -- Orange color
ToggleButton2.TextColor3 = Color3.fromRGB(255, 255, 255)

ToggleButton3.Parent = GuiFrame
ToggleButton3.Size = UDim2.new(0, 200, 0, 40)
ToggleButton3.Position = UDim2.new(0, 25, 0.3, 0)
ToggleButton3.Text = "Button 3: OFF"
ToggleButton3.BackgroundColor3 = Color3.fromRGB(255, 140, 0)  -- Orange color
ToggleButton3.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Toggle function for buttons
local function toggleButton(Button, state)
    if state then
        Button.Text = Button.Text:sub(1, Button.Text:find(":") - 1) .. ": ON"
        Button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  -- Green color when ON
    else
        Button.Text = Button.Text:sub(1, Button.Text:find(":") - 1) .. ": OFF"
        Button.BackgroundColor3 = Color3.fromRGB(255, 140, 0)  -- Orange color when OFF
    end
end

-- Button 1 click event
ToggleButton1.MouseButton1Click:Connect(function()
    Button1State = not Button1State
    toggleButton(ToggleButton1, Button1State)
end)

-- Button 2 click event
ToggleButton2.MouseButton1Click:Connect(function()
    Button2State = not Button2State
    toggleButton(ToggleButton2, Button2State)
end)

-- Button 3 click event
ToggleButton3.MouseButton1Click:Connect(function()
    Button3State = not Button3State
    toggleButton(ToggleButton3, Button3State)
end)

-- Debugging
print("GUI with buttons loaded successfully.")
