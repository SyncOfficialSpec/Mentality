local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/SyncOfficialSpec/Mentality/refs/heads/main/source/library.lua"))()

-- Icon bootstrap: pull the lucide PNGs shipped in the repo, cache them to disk and
-- resolve to getcustomasset paths so every tab / section gets its own glyph.
local ASSET_BASE = "https://raw.githubusercontent.com/SyncOfficialSpec/Mentality/refs/heads/main/assets/icons/"

Library.Folders = {
    Directory = "Mentality",
    Configs = "Mentality/Configs",
    Assets = "Mentality/Assets",
}

for _, Folder in pairs(Library.Folders) do
    if not isfolder(Folder) then
        makefolder(Folder)
    end
end

local IconNames = {
    "car-front", "eye", "languages", "users", "radar", "globe", "wand-sparkles", "bomb",
    "crosshair", "target", "settings", "brush", "sparkles", "gem", "palette", "pipette",
    "sliders-horizontal", "gauge", "zap", "shield", "flame", "cpu", "swords", "map",
}

local Icons = {}
for _, Name in ipairs(IconNames) do
    local Path = Library.Folders.Assets .. "/" .. Name .. ".png"
    local Ok = pcall(function()
        if not isfile(Path) then
            writefile(Path, game:HttpGet(ASSET_BASE .. Name .. ".png"))
        end
    end)
    Icons[Name] = (Ok and isfile(Path)) and getcustomasset(Path) or ""
end

-- Theme: warm accent head fading into deep red (matches the reference build).
Library.Theme.Accent = Color3.fromRGB(230, 131, 90)
Library.Theme.AccentGradient = Color3.fromRGB(200, 50, 50)

local Window = Library:Window({
    Name = "MENTALITY v2",
    SubName = "Fine-tuning for sure wins",
    Logo = Icons["gem"],
    MenuKeybind = Enum.KeyCode.RightShift,
})

Library:Watermark({
    "MENTALITY v2",
    "Fine-tuning for sure wins",
    Icons["gem"],
})

-- Categories only surface when the tab strip is dragged to a side (sidebar mode).
Window:Category("Environment & Transport")
local CarPage = Window:Page({ Name = "Car", Icon = Icons["car-front"] })
local ESPPage = Window:Page({ Name = "ESP", Icon = Icons["eye"] })
local LangPage = Window:Page({ Name = "Lang", Icon = Icons["languages"] })

Window:Category("Players & Vision")
local PlayersPage = Window:Page({ Name = "Players", Icon = Icons["users"] })
local RadarPage = Window:Page({ Name = "Radar", Icon = Icons["radar"] })
local WorldPage = Window:Page({ Name = "World", Icon = Icons["globe"] })

Window:Category("Utilities & Settings")
local MiscPage = Window:Page({ Name = "Misc", Icon = Icons["wand-sparkles"] })
local ExploitsPage = Window:Page({ Name = "Exploits", Icon = Icons["bomb"] })

-- Car : left column ---------------------------------------------------------
local Aimbot = CarPage:Section({
    Name = "Aimbot",
    Description = "This description for child",
    Icon = Icons["crosshair"],
    Side = 1,
    EnableToggle = true,
})

local TargetPrediction = Aimbot:Toggle({ Name = "Target Prediction", Default = true })
local TargetPredictionSettings = TargetPrediction:Settings()
TargetPredictionSettings:Slider({ Name = "Prediction Amount", Min = 0, Max = 100, Default = 50, Suffix = "%" })

Aimbot:Slider({ Name = "Radar Range", Min = 0, Max = 500, Default = 208 })
Aimbot:Dropdown({ Name = "Radar Mode", Items = { "Off", "2D", "3D" }, Default = "Off" })
Aimbot:Toggle({ Name = "Footprints", Default = true })
Aimbot:Dropdown({ Name = "Footprint Type", Items = { "Allies", "Enemies", "All" }, Default = "Allies" })
Aimbot:Label("Tracer Color"):Colorpicker({ Name = "Tracer Color", Default = Color3.fromRGB(0, 127, 255) })

local Menu = CarPage:Section({
    Name = "Menu settings",
    Description = "This description for child",
    Icon = Icons["settings"],
    Side = 1,
    EnableToggle = true,
})

Menu:Button({ Name = "Button with icon", Icon = Icons["brush"] })
Menu:Button({ Name = "Change theme" })
Menu:Button({ Name = "Change language" })
Menu:Slider({ Name = "Particle count", Min = 0, Max = 100, Default = 35 })
Menu:Label("First gradient color"):Colorpicker({ Name = "First Gradient", Default = Color3.fromRGB(230, 131, 90) })
Menu:Label("Second gradient color"):Colorpicker({ Name = "Second Gradient", Default = Color3.fromRGB(200, 50, 50) })

-- Car : right column --------------------------------------------------------
local Wallhack = CarPage:Section({
    Name = "Wallhack",
    Description = "This description for child",
    Icon = Icons["target"],
    Side = 2,
    EnableToggle = true,
})

Wallhack:Dropdown({ Name = "Select gun", Items = { "AK-47", "M4A1", "AWP", "Glock", "Deagle" }, Default = "AK-47" })
Wallhack:Toggle({ Name = "Enable Wallhack", Default = false })
Wallhack:Toggle({ Name = "Show Enemies", Default = true })
Wallhack:Toggle({ Name = "Show Health", Default = true })
Wallhack:Toggle({ Name = "Show Armor", Default = false })
Wallhack:Toggle({ Name = "Show Weapons", Default = false })

local ShowVehicles = Wallhack:Toggle({ Name = "Show Vehicles", Default = true })
local ShowVehiclesSettings = ShowVehicles:Settings()
ShowVehiclesSettings:Slider({ Name = "Vehicle Range", Min = 0, Max = 500, Default = 200 })

Wallhack:Toggle({ Name = "Show Grenades", Default = false })
Wallhack:Toggle({ Name = "No Obstacles", Default = false })
Wallhack:Label("Enemy Color"):Colorpicker({ Name = "Enemy Color", Default = Color3.fromRGB(230, 131, 90) })
Wallhack:Label("Item Color"):Colorpicker({ Name = "Item Color", Default = Color3.fromRGB(230, 131, 90) })
Wallhack:Slider({ Name = "Max Distance", Min = 0, Max = 500, Default = 198 })
Wallhack:Toggle({ Name = "Show Teammates", Default = true })
Wallhack:Toggle({ Name = "Show Names", Default = true })
Wallhack:Toggle({ Name = "Show Dead Boxes", Default = false })

-- Token content on the other tabs so switching pages shows something. --------
local EspMain = ESPPage:Section({ Name = "ESP", Description = "This description for child", Icon = Icons["eye"], Side = 1, EnableToggle = true })
EspMain:Toggle({ Name = "Enabled", Default = true })
EspMain:Slider({ Name = "Render Distance", Min = 0, Max = 1000, Default = 400 })
EspMain:Label("Box Color"):Colorpicker({ Name = "Box Color", Default = Color3.fromRGB(230, 131, 90) })

local PlayersMain = PlayersPage:Section({ Name = "Players", Description = "This description for child", Icon = Icons["users"], Side = 1, EnableToggle = true })
PlayersMain:Toggle({ Name = "Show List", Default = true })
PlayersMain:Dropdown({ Name = "Sort By", Items = { "Distance", "Name", "Health" }, Default = "Distance" })

local RadarMain = RadarPage:Section({ Name = "Radar", Description = "This description for child", Icon = Icons["radar"], Side = 1, EnableToggle = true })
RadarMain:Toggle({ Name = "Enabled", Default = true })
RadarMain:Slider({ Name = "Zoom", Min = 1, Max = 10, Default = 4 })

local MiscMain = MiscPage:Section({ Name = "Misc", Description = "This description for child", Icon = Icons["wand-sparkles"], Side = 1, EnableToggle = true })
MiscMain:Toggle({ Name = "Anti AFK", Default = true })
MiscMain:Button({ Name = "Rejoin Server" })
MiscMain:Keybind({ Name = "Panic Key", Default = Enum.KeyCode.Delete })

local ExploitsMain = ExploitsPage:Section({ Name = "Exploits", Description = "This description for child", Icon = Icons["bomb"], Side = 1, EnableToggle = true })
ExploitsMain:Toggle({ Name = "Fly", Default = false })
ExploitsMain:Slider({ Name = "Fly Speed", Min = 1, Max = 100, Default = 50 })

Window:Init()
