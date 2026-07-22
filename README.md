# 💎 "Like Neverlose" UI Library for Roblox

A modern, highly customizable, and optimized UI Library for Roblox scripts. Featuring a clean aesthetic inspired by Neverlose V2, smooth animations, a robust configuration system, and advanced features like DPI scaling and a draggable event logger.

![Lua](https://img.shields.io/badge/Language-Lua-blue) ![Platform](https://img.shields.io/badge/Platform-Roblox-red) ![License](https://img.shields.io/badge/License-MIT-green)

## ✨ Features

*   **Modern Design:** Clean dark theme with customizable accents and gradients.
*   **Smooth Animations:** All interactions are tweened for a premium feel.
*   **DPI Scaling:** Built-in "Menu Scale" support (0.5x to 1.5x) for 4K monitors or small screens.
*   **Advanced Logger:**
    *   Draggable log container with "Smart Snapping" to the center of the screen.
    *   Auto-sizing logs based on text length.
    *   Stacking animations.
*   **Nested Elements:** Support for placing Sliders, Dropdowns, and Keybinds *inside* Toggles.
*   **Config System:** Built-in Save/Load system using `writefile`/`readfile`.
*   **Element Features:**
    *   Multi-select Dropdowns with search.
    *   Colorpickers with Alpha (transparency) support.
    *   Keybinds with Toggle/Hold/Always modes.

## 🚀 Getting Started

### Installation
Load the library into your script using `loadstring`.

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/SyncOfficialSpec/Mentality/refs/heads/main/source/library.lua"))()
```

### Basic Setup
Here is a quick example of how to set up a window, a tab, and a section.

```lua
local Window = Library:Window({
    Name = "Cheat Name",
    SubName = "Best script ever",
    Logo = "123456789", -- Roblox Asset ID
    MenuKeybind = Enum.KeyCode.End
})

local Page = Window:Page({Name = "Ragebot", Icon = "rbxassetid://..."})
local Section = Page:Section({Name = "Main Settings", Side = 1}) -- Side 1 (Left) or 2 (Right)
```

---

## 📚 Documentation & API

### 1. Toggles
Toggles are the core of the library. They support sub-options (nesting).

```lua
local MyToggle = Section:Toggle({
    Name = "Silent Aim",
    Flag = "SilentAim", -- Unique identifier for Configs
    Default = false,
    Callback = function(Value)
        print("Silent Aim is now:", Value)
    end
})
```

#### Nested Elements (Sub-Options)
You can add elements *inside* a toggle. They will appear when the toggle is expanded.

```lua
-- Add a Slider inside the Toggle
MyToggle:Slider({
    Name = "FOV Radius",
    Min = 0, Max = 360, Default = 180
})

-- Add a Dropdown inside the Toggle
MyToggle:Dropdown({
    Name = "Hitbox",
    Items = {"Head", "Torso"},
    Default = "Head"
})
```

### 2. Sliders
Sliders allow selecting a number within a range.

```lua
local MySlider = Section:Slider({
    Name = "Walkspeed",
    Flag = "WS_Slider",
    Min = 16,
    Max = 200,
    Default = 16,
    Decimals = 1, -- 0 for integers, 1 for 0.5, etc.
    Suffix = " studs",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})
```

### 3. Dropdowns
Dropdowns support single and multi-selection, as well as searching.

```lua
local MyDropdown = Section:Dropdown({
    Name = "Target Selection",
    Flag = "Target_Drop",
    Items = {"Player", "NPC", "Boss", "Ally"},
    Default = "Player", -- Use {"Player", "NPC"} for Multi
    Multi = false, -- Set to true for multiple selection
    Callback = function(Value)
        print("Selected:", Value)
    end
})
```

#### Updating Dropdowns
You can update the list of items or the selected value dynamically.

```lua
-- Refresh the list
MyDropdown:Refresh({"New Item 1", "New Item 2"}, "New Item 1")

-- Set a specific value programmatically
MyDropdown:Set("New Item 2")
```

### 4. Colorpickers & Keybinds
These can be added as standalone sections or attached to other elements.

```lua
-- Standalone
Section:Colorpicker({
    Name = "ESP Color",
    Flag = "ESP_Color",
    Default = Color3.fromRGB(255, 0, 0),
    Alpha = 1, -- Transparency (0-1)
    Callback = function(Color, Alpha) ... end
})

Section:Keybind({
    Name = "Triggerbot Key",
    Flag = "Trigger_Bind",
    Default = Enum.KeyCode.E,
    Mode = "Hold", -- "Toggle", "Hold", or "Always"
    Callback = function(State) ... end
})

-- Attached to a Toggle
MyToggle:Colorpicker({ Default = Color3.new(1,1,1) })
MyToggle:Keybind({ Default = Enum.KeyCode.X })
```

---

## 🖥️ Event Logger

The library includes a built-in event logger that appears on the screen. It features a draggable bar that snaps to the center of the screen.

**How to enable:**
You must enable the logger in your script before sending logs.

```lua
Library.LogsEnabled = true -- Required to show the panel
```

**Sending Logs:**
```lua
-- Library:Log(Text, Duration, Color)
Library:Log("Config Loaded", 5, Color3.fromRGB(0, 255, 0))
Library:Log("Target missed", 3, Color3.fromRGB(255, 0, 0))
```

---

## ⚙️ Settings & Configs

To add the built-in Settings page (which includes Menu Scale, Config Manager, Watermark toggle, etc.), simply call:

```lua
Library:CreateSettingsPage(Window)
```

### Menu Scale
The library supports DPI scaling. Users can change this in the Settings page, or you can set it programmatically:

```lua
-- Values: 0.5, 0.75, 1, 1.25, 1.5
Library.CurrentScale = 1.25 
-- You must trigger a refresh on objects if setting manually, 
-- so it is recommended to use the built-in Settings Page dropdown.
```

---

## 🔄 Updating Values Programmatically

If you need to change the state of a UI element from your script (not by user click), use the `:Set()` method on the object returned when you created the element.

**Toggle:**
```lua
local Toggle = Section:Toggle(...)
Toggle:Set(true) -- Turns it on
```

**Slider:**
```lua
local Slider = Section:Slider(...)
Slider:Set(50) -- Sets value to 50
```

**Dropdown:**
```lua
local Dropdown = Section:Dropdown(...)
Dropdown:Set("Option 1") -- Selects Option 1
```

---

## 🛡️ Unloading

To safely unload the UI (hide it and stop connections) without triggering anti-cheats (by avoiding `Destroy` on CoreGui), use:

```lua
Library:Unload()
```

---

## 📝 Full Example Script

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/SyncOfficialSpec/Mentality/refs/heads/main/source/library.lua"))()

-- Enable Logs
Library.LogsEnabled = true

local Window = Library:Window({
    Name = "Project Nova",
    SubName = "Release Build",
    Logo = "123456789",
    MenuKeybind = Enum.KeyCode.RightShift
})

local MainTab = Window:Page({Name = "Combat", Icon = "rbxassetid://123..."})
local MainSection = MainTab:Section({Name = "Aimbot", Side = 1})

local AimToggle = MainSection:Toggle({
    Name = "Enabled",
    Flag = "AimEnabled",
    Default = false,
    Callback = function(v)
        if v then 
            Library:Log("Aimbot Enabled", 3)
        end
    end
})

-- Nested Slider
AimToggle:Slider({
    Name = "FOV",
    Min = 0, Max = 180, Default = 90
})

-- Nested Dropdown
AimToggle:Dropdown({
    Name = "Hitbox",
    Items = {"Head", "Torso", "Legs"},
    Default = "Head"
})

-- Create Settings Page (Configs, Scale, etc.)
Library:CreateSettingsPage(Window)
```
