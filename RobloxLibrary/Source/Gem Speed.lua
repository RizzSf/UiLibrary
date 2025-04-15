local RobloxLib = {
    Color = {
        Main = Color3.fromRGB(111, 111, 111),
        Text = Color3.fromRGB(0, 0, 0),
    },
    LibraryConfig = {
        Theme = {
            Black = { Main = Color3.fromRGB(111, 111, 111), Text = Color3.fromRGB(0, 0, 0) },
            Red = { Main = Color3.fromRGB(111, 111, 111), Text = Color3.fromRGB(55, 55, 55) },
        },
        SelectTheme = "Black",
        version = "v1",
        Image = { ["User"] = "rbxassetid://4841508676", ["Check"] = "rbxassetid://4841508257" },
        Made = { LibraryBy = "LunaPhs", CodeEditor = "VSCode" }
    }
}

-- Apply the selected theme
function RobloxLib:ApplyTheme(themeName)
    local theme = self.LibraryConfig.Theme[themeName]
    if not theme then
        warn("Theme not found: " .. tostring(themeName))
        return
    end

    -- Update theme color settings
    self.Color.Main = theme.Main
    self.Color.Text = theme.Text
    self.LibraryConfig.SelectTheme = themeName

    local gui = game.Players.LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("RobloxLib")
    if gui then
        -- Recursively update colors in the UI
        local function updateColors(object)
            if object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox") then
                object.TextColor3 = self.Color.Text
            end
            if object:IsA("Frame") or object:IsA("ScrollingFrame") or object:IsA("TextBox") then
                object.BackgroundColor3 = self.Color.Main
            end
            for _, child in ipairs(object:GetChildren()) do
                updateColors(child)
            end
        end
        updateColors(gui)
    end
end

-- Create window UI
function RobloxLib:MakeWindow(settings)
    settings = settings or {}
    local RobloxLibGui = Instance.new("ScreenGui")
    local RobFrame = Instance.new("Frame")
    local TitleLib = Instance.new("TextLabel")
    local X = Instance.new("TextButton")
    local IntroTextLabel = Instance.new("TextLabel")

    RobloxLibGui.Name = "RobloxLib"
    RobloxLibGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    RobloxLibGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    RobFrame.Name = "RobFrame"
    RobFrame.Parent = RobloxLibGui
    RobFrame.BackgroundColor3 = Color3.new(0.435294, 0.435294, 0.435294)
    RobFrame.BorderColor3 = Color3.new(0, 0, 0)
    RobFrame.Position = UDim2.new(0.202692598, 0, 0.241730273, 0)
    RobFrame.Size = UDim2.new(0, 585, 0, 291)

    TitleLib.Name = "TitleLib"
    TitleLib.Parent = RobFrame
    TitleLib.Size = UDim2.new(0, 536, 0, 30)
    TitleLib.Font = Enum.Font.SourceSans
    TitleLib.Text = settings.Title or "Rbx Lib"
    TitleLib.TextColor3 = RobloxLib.Color.Text
    TitleLib.TextScaled = true
    TitleLib.TextSize = 14

    -- Close button functionalit
    X.Name = "X"
    X.Parent = RobFrame
    X.BackgroundColor3 = Color3.new(1, 1, 1)
    X.BackgroundTransparency = 0.550000011920929
    X.Position = UDim2.new(0.948717952, 0, 0, 0)
    X.Size = UDim2.new(0, 30, 0, 30)
    X.Text = "X"
    X.TextColor3 = Color3.new(0, 0, 0)

    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    X.MouseButton1Click:Connect(function()
        local fadeOutTween = tweenService:Create(RobFrame, tweenInfo, {BackgroundTransparency = 1})
        fadeOutTween:Play()

        fadeOutTween.Completed:Connect(function()
            RobloxLibGui:Destroy()
        end)
    end)

    if settings.Intro then
        IntroTextLabel.Parent = RobloxLibGui
        IntroTextLabel.BackgroundTransparency = 1
        IntroTextLabel.Text = settings.IntroText or "Welcome!"
        IntroTextLabel.TextColor3 = Color3.new(1, 1, 1)
        IntroTextLabel.Font = Enum.Font.SourceSans
        IntroTextLabel.TextScaled = true
        IntroTextLabel.TextWrapped = true
    end
end

-- Create notification function
function RobloxLib:CreateNotification(settings)
    settings = settings or {}
    game.StarterGui:SetCore("SendNotification", {
        Title = settings.Title or "Roblox Lib",
        Text = settings.Contents or "Made by LunaPhs!",
        Duration = settings.Duration or 5
    })
end

function RobloxLib:MakeScroll(settings)
local RbSc = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

RbSc.Name = "RbSc"
RbSc.Parent = game.StarterGui.RobloxLib.RobFrame
RbSc.Active = true
RbSc.BackgroundColor3 = Color3.new(0.345098, 0.345098, 0.345098)
RbSc.BorderColor3 = Color3.new(0, 0, 0)
RbSc.BorderSizePixel = 0
RbSc.Position = UDim2.new(0.0153846154, 0, 0.103092782, 0)
RbSc.Size = UDim2.new(0, 566, 0, 254)
RbSc.CanvasSize = settings.Size or UDim2.new(0, 0, 6, 0)
RbSc.ScrollBarThickness = settings.Barsize or 8

UIListLayout.Parent = RbSc
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
end

function RobloxLib:AddButton(settings)
    local TextButton = Instance.new("TextButton")

    TextButton.Parent = game.StarterGui.RobloxLib.RobFrame.RbSc
    TextButton.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
    TextButton.BorderColor3 = Color3.new(0, 0, 0)
    TextButton.BorderSizePixel = 0
    TextButton.Size = UDim2.new(0, 566, 0, 50)
    TextButton.Font = Enum.Font.SourceSans
    TextButton.TextColor3 = RobloxLib.Color.Text
    TextButton.TextSize = settings.TextSize or 23
    TextButton.Text = settings.Text or "Button"
    TextButton.TextWrapped = true
    TextButton.TextXAlignment = Enum.TextXAlignment.Left

    if settings.Callback then
        TextButton.MouseButton1Click:Connect(function()
            settings.Callback()
        end)
    end
end

function RobloxLib:AddToggle(settings)
    local TextToggle = Instance.new("TextButton")
    local EnableFrame = Instance.new("Frame")
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    local UICorner = Instance.new("UICorner")
    local CHECK = Instance.new("ImageLabel")
    local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")

    TextToggle.Name = "TextToggle"
    TextToggle.Parent = game.StarterGui.RobloxLib.RobFrame.RbSc
    TextToggle.BackgroundColor3 = Color3.new(0.278, 0.278, 0.278)
    TextToggle.BorderSizePixel = 0
    TextToggle.Size = UDim2.new(0, 566, 0, 50)
    TextToggle.Font = Enum.Font.SourceSans
    TextToggle.TextColor3 = RobloxLib.Color.Text
    TextToggle.TextSize = settings.TextSize or 23
    TextToggle.TextWrapped = true
    TextToggle.TextXAlignment = Enum.TextXAlignment.Left
    TextToggle.Text = settings.Text or "Toggle"

    EnableFrame.Name = "EnableFrame"
    EnableFrame.Parent = TextToggle
    EnableFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    EnableFrame.BorderSizePixel = 0
    EnableFrame.Position = UDim2.new(0.920, 0, 0.18, 0)
    EnableFrame.Size = UDim2.new(0, 40, 0, 32)

    UIAspectRatioConstraint.Parent = EnableFrame
    UICorner.Parent = EnableFrame

    CHECK.Name = "CHECK"
    CHECK.Parent = TextToggle
    CHECK.BackgroundTransparency = 1
    CHECK.Position = EnableFrame.Position
    CHECK.Size = EnableFrame.Size
    CHECK.Image = settings.CheckImage or "rbxassetid://10709790644"
    CHECK.ImageTransparency = 1
    UIAspectRatioConstraint_2.Parent = CHECK

    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    local toggled = false

    TextToggle.MouseButton1Click:Connect(function(input)
        toggled = not toggled
        local targetColor = toggled and Color3.fromRGB(52, 177, 255) or Color3.fromRGB(255, 0, 0)
        local targetTransparency = toggled and 0 or 1

        local colorTween = tweenService:Create(EnableFrame, tweenInfo, {BackgroundColor3 = targetColor})
        local transparencyTween = tweenService:Create(CHECK, tweenInfo, {ImageTransparency = targetTransparency})
        colorTween:Play()
        transparencyTween:Play()

        local effect = Instance.new("Frame")
        effect.Size = UDim2.new(0, 0, 0, 0)
        effect.Position = UDim2.new(0, input.Position.X - TextToggle.AbsolutePosition.X, 0, input.Position.Y - TextToggle.AbsolutePosition.Y)
        effect.AnchorPoint = Vector2.new(0.5, 0.5)
        effect.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        effect.BackgroundTransparency = 0.5
        effect.BorderSizePixel = 0
        effect.ZIndex = 10
        effect.ClipsDescendants = true
        effect.Parent = TextToggle

        local expandTween = tweenService:Create(effect, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1
        })

        expandTween:Play()
        expandTween.Completed:Connect(function()
            effect:Destroy()
        end)

        if settings.Callback then
            settings.Callback(toggled)
        end
    end)
end

function RobloxLib:AddSection(settings)
    local Section = Instance.new("TextLabel")

    Section.Name = "Section"
    Section.Parent = game.StarterGui.RobloxLib.RobFrame.RbSc
    Section.BackgroundColor3 = Color3.new(1, 1, 1)
    Section.BackgroundTransparency = 1
    Section.BorderColor3 = Color3.new(0, 0, 0)
    Section.BorderSizePixel = 0
    Section.Position = UDim2.new(0, 0, 0.44094488, 0)
    Section.Size = UDim2.new(0, 566, 0, 19)
    Section.Font = Enum.Font.SourceSans
    Section.Text = settings.Name or "Section"
    Section.TextColor3 = RobloxLib.Color.Text
    Section.TextSize = 14
    Section.TextWrapped = true
    Section.TextXAlignment = Enum.TextXAlignment.Left
end

function RobloxLib:AddTextbox(settings)
    local TextBox = Instance.new("TextBox")

    TextBox.Parent = game.StarterGui.RobloxLib.RobFrame.RbSc
    TextBox.BackgroundColor3 = RobloxLib.Color.Main
    TextBox.BorderColor3 = Color3.new(0, 0, 0)
    TextBox.BorderSizePixel = 0
    TextBox.Size = UDim2.new(0, 566, 0, 50)
    TextBox.Font = Enum.Font.SourceSans
    TextBox.PlaceholderText = settings.Placeholder or "Enter text..."
    TextBox.Text = settings.DefaultText or ""
    TextBox.TextColor3 = RobloxLib.Color.Text
    TextBox.TextSize = 14
    TextBox.TextXAlignment = Enum.TextXAlignment.Left

    local TweenService = game:GetService("TweenService")
    local defaultSize = UDim2.new(0, 566, 0, 50)
    local focusSize = UDim2.new(0, 566, 0, 60)

    local defaultColor = RobloxLib.Color.Main
    local focusColor = Color3.fromRGB(90, 90, 90)

    local savedText = TextBox.Text

    if settings.Focus ~= false then
        TextBox.Focused:Connect(function()
            if settings.Focus then
                local tween = TweenService:Create(TextBox, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = focusSize,
                    BackgroundColor3 = focusColor
                })
                tween:Play()
            end
        end)

        TextBox.FocusLost:Connect(function()
            if settings.Focus then
                local tween = TweenService:Create(TextBox, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = defaultSize,
                    BackgroundColor3 = defaultColor
                })
                tween:Play()
            end

            if settings.SaveText then
                savedText = TextBox.Text
            end

            if settings.Callback then
                settings.Callback(TextBox.Text)
            end
        end)
    else
        TextBox.FocusLost:Connect(function()
            if settings.SaveText then
                savedText = TextBox.Text
            end

            if settings.Callback then
                settings.Callback(TextBox.Text)
            end
        end)
    end

    if settings.SaveText and savedText ~= "" then
        TextBox.Text = savedText
    end
end

return RobloxLib
