# 3itx's UI Lib 
### Open Source & Free

## Library

```lua
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Just3itx/3itx-UI-LIB/refs/heads/main/Lib"))() 
local FlagsManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Just3itx/3itx-UI-LIB/refs/heads/main/ConfigManager"))()
```
## Window

```lua
local main = lib:Load({
    Title = 'Cool Title',
    ToggleButton = "RBXID or GetCustomasset",
    BindGui = Enum.KeyCode.RightControl,
})
```
## Tabs

```lua
local Main = main:AddTab("Main")
```
## Section

```lua
local MainSection = Main:AddSection({Title = "Section Name", Description = "Description", Defualt = false , Locked = false})
```
## GroupButtons

```lua
local GroupButtons =   MainSection:AddGroupButton()
```
## Button

```lua
GroupButtons:AddButton({
    Title = "Print Woah",
    Callback = function()
    	print("Woah")
    end,
})
--[[
GroupButtons:AddButton({
    Title = "Print Woah2",
    Variant = "Outline",
    Callback = function()
    	print("Woah2")
    end,
})
]]
```
## Paragraph

```lua
MainSection:AddParagraph({Title = "Hello There",Description = "HI"})
```
## Toggle

```lua
MainSection:AddToggle("ConfigToStoreName", {
    Title = "Toggle",
    Default = false,
    Description = "lol",
    Callback = function(isEnabled)
    	print(isEnabled)
    end,
})
```
## Dropdown

```lua
MainSection:AddDropdown("EpicDropDownName", {
    Title = "Dropdown",
    Description = "",
    Options = {"Option1","Option2","Option3","Option4","Option5","Option6","Option7",},
    Default = "",
    PlaceHolder = "Search Name",
    Multiple = true,
    Callback = function(balls)
        table.foreach(balls,print)
    end
})
```
## Colorpicker

```lua
MainSection:AddColorpicker("Color", {
    Title = "ColorPicker",
    Default = Color3.new(1.000000, 1.000000, 1.000000),
    Callback = function(selectedColor)
        print(selectedColor)
    end,
})
```
## Slider

```lua
MainSection:AddSlider("EpixSlider", {
    Title = "Cool-Slider",
    Description = "",
    Default = 15,
    Min = 0,
    Max = 255,
    Increment = 1,
    Callback = function(value)
      print(value)
    end,
})
```
## Dialog

```lua
lib:Dialog({
    Title = "Hello",
    Content = "Test",
    Buttons = {
        {
            Title = "Test",
            Variant = "Primary",
            Callback = function(value)
                print(3)
            end,
        },
		{
            Title = "Test2",
            Variant = "Ghost",
            Callback = function(value)
                print(32)
            end,
        }
    }
})
```
## Keybind

```lua
MainSection:AddBind("JumpKeybind", {
    Title = "Jump",
    Default = Enum.KeyCode.Space,
    Callback = function() print("Pressed") end
})
```
## Textbox

```lua
MainSection:AddTextbox({
    Title = "Textbox",
    Default = "",
    Description = "Hello!",
    PlaceHolder = "PlaceHolder",
    TextDisappear = false,
    Callback = function(value)
        print(Value)
    end
})
```
## Config

```lua
local Config = main:AddTab("Config")
FlagsManager:SetLibrary(lib)
FlagsManager:SetIgnoreIndexes({})
FlagsManager:SetFolder("Config/GameName")
FlagsManager:InitSaveSystem(Config)
```
## Notify

```lua
lib:Notification('Hello', 'Hello, Thanks for using 3itx-UI-Lib',3)
```
