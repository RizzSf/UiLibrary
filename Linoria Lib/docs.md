# LinoriaLib Roblox UI Library Documentation

This document provides a step-by-step guide on how to use the LinoriaLib Roblox UI library for creating interactive UI menus, toggles, buttons, sliders, dropdowns, and more.

---

## 1. Setup & Initialization

```lua
local repo = 'https://raw.githubusercontent.com/RizzSf/UiLibrary/refs/heads/main/Linoria%20Lib/source/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'Addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'Addons/SaveManager.lua'))()
```

* **Library**: The main UI library.
* **ThemeManager**: Manages UI themes.
* **SaveManager**: Handles configuration saving/loading.

---

## 2. Creating a Window

```lua
local Window = Library:CreateWindow({
    Title = 'Example menu',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})
```

**Options:**

* `Title` (string): Window title.
* `Center` (bool): Center the window on screen.
* `AutoShow` (bool): Show window immediately on creation.
* `TabPadding` (number): Padding between tabs.
* `MenuFadeTime` (number): Animation duration for fade-in/out.

---

## 3. Tabs & Groupboxes

### Adding Tabs

```lua
local Tabs = {
    Main = Window:AddTab('Main'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}
```

### Adding Groupboxes (sections inside tabs)

```lua
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Groupbox')
```

```lua
local RightGroupBox = Tabs.Main:AddRightGroupbox('Groupbox')
```

You can add groupboxes on the left or right side of a tab.

---

## 4. UI Elements

### Toggles

```lua
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'This is a toggle',
    Default = true,
    Tooltip = 'This is a tooltip',
    Callback = function(Value)
        print('Toggle changed:', Value)
    end
})
```

* Access toggle value: `Toggles.MyToggle.Value`
* Use `.OnChanged(function)` to respond to changes.

---

### Buttons

```lua
local MyButton = LeftGroupBox:AddButton({
    Text = 'Button',
    Func = function()
        print('Button clicked!')
    end,
    DoubleClick = false,
    Tooltip = 'This is the main button'
})

MyButton:AddButton({
    Text = 'Sub button',
    Func = function()
        print('Sub button clicked!')
    end,
    DoubleClick = true,
    Tooltip = 'Double-click me!'
})
```

Supports nested sub-buttons.

---

### Labels

```lua
LeftGroupBox:AddLabel('This is a label')
LeftGroupBox:AddLabel('This label\nwraps text!', true)
```

Pass `true` to enable wrapping.

---

### Dividers

```lua
LeftGroupBox:AddDivider()
```

Adds a visual separator.

---

### Sliders

```lua
LeftGroupBox:AddSlider('MySlider', {
    Text = 'Slider',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        print('Slider changed:', Value)
    end
})
```

* Access value: `Options.MySlider.Value`
* Supports precision and optional suffix.

---

### Text Inputs

```lua
LeftGroupBox:AddInput('MyTextbox', {
    Default = 'Text',
    Numeric = false,
    Finished = false,
    Text = 'Textbox label',
    Tooltip = 'Tooltip text',
    Placeholder = 'Placeholder',
    Callback = function(Value)
        print('Input changed:', Value)
    end
})
```

---

### Dropdowns

```lua
LeftGroupBox:AddDropdown('MyDropdown', {
    Values = { 'Option1', 'Option2' },
    Default = 1,
    Multi = false,
    Text = 'Dropdown label',
    Tooltip = 'Tooltip',
    Callback = function(Value)
        print('Dropdown changed:', Value)
    end
})
```

* Supports single and multiple selections (`Multi = true`).
* Special dropdown type for players: `SpecialType = 'Player'`.

---

### Color Pickers

```lua
LeftGroupBox:AddLabel('Color'):AddColorPicker('ColorPicker', {
    Default = Color3.new(0, 1, 0),
    Title = 'Pick a color',
    Transparency = 0,
    Callback = function(Value)
        print('Color changed:', Value)
    end
})
```

---

### Keybind Pickers

```lua
LeftGroupBox:AddLabel('Keybind'):AddKeyPicker('KeyPicker', {
    Default = 'MB2',
    SyncToggleState = false,
    Mode = 'Toggle', -- 'Always', 'Toggle', or 'Hold'
    Text = 'Keybind label',
    NoUI = false,
    Callback = function(Value)
        print('Keybind pressed:', Value)
    end,
    ChangedCallback = function(New)
        print('Keybind changed:', New)
    end
})
```

Check if keybind is held:

```lua
if Options.KeyPicker:GetState() then
    print('Keybind is being held down')
end
```

---

## 5. Dependency Boxes (Conditional UI)

Dependency boxes show/hide elements based on toggle states.

```lua
local RightGroupbox = Tabs.Main:AddRightGroupbox('Groupbox #3')
RightGroupbox:AddToggle('ControlToggle', { Text = 'Enable features' })

local Depbox = RightGroupbox:AddDependencyBox()
Depbox:AddToggle('DepboxToggle', { Text = 'Sub toggle' })

Depbox:SetupDependencies({
    { Toggles.ControlToggle, true }
})
```

You can nest dependency boxes for multi-level control.

---

## 6. Watermark & Other Library Functions

Show or hide a watermark on the UI:

```lua
Library:SetWatermarkVisibility(true)
Library:SetWatermark('Custom Watermark Text')
```

Handle unloading the UI safely:

```lua
Library:OnUnload(function()
    print('UI unloaded!')
    Library.Unloaded = true
end)
```

---

## 7. UI Settings & Config Management

Create a settings tab with save/load config:

```lua
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true })

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')

SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])

SaveManager:LoadAutoloadConfig()
```

---
