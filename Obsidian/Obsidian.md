# Obsidian UI Library
Free Ui library in Roblox

## Booting the Library
```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RizzSf/UiLibrary/refs/heads/main/Obsidian/LibraryMain/Ob.lua"))()
```

## ThemeManager
```lua
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/RizzSf/UiLibrary/refs/heads/main/Obsidian/LibraryMain/ThemeManager.lua"))()
```

## SaveManager
```lua
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/RizzSf/UiLibrary/refs/heads/main/Obsidian/LibraryMain/Savemanager.lua"))()
```

## Creating a Window
```lua
local Window = Library:CreateWindow({
	Title = "mspaint",
	Footer = "version: example",
	Icon = 95816097006870,
	NotifySide = "Right",
	ShowCustomCursor = true,
})

--[[
	Set Center to true if you want the menu to appear in the center
	Set AutoShow to true if you want the menu to appear when it is created
	Set Resizable to true if you want to have in-game resizable Window
	Set MobileButtonsSide to "Left" or "Right" if you want the ui toggle & lock buttons to be on the left or right side of the window
	Set ShowCustomCursor to false if you don't want to use the Linoria cursor
	NotifySide = Changes the side of the notifications (Left, Right) (Default value = Left)
	Position and Size are also valid options here
	but you do not need to define them unless you are changing them :)
]]
```

## Creating a Tab
```lua
local Tabs = {
	Main = Window:AddTab("Main", "user"),
	Key = Window:AddKeyTab("Key System"),
	["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}

--[[
  rbxasstid:// support 
  Icon by https://lucide.dev/
]]
```
