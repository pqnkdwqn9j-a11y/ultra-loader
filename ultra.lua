-- Ultra Script Compact
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Source.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Ultra Script", SubTitle = "Universal",
    TabWidth = 160, Size = UDim2.fromOffset(600, 480),
    Acrylic = false, Theme = "Dark", MinimizeKey = Enum.KeyCode.RightControl
})

local KeySystem = Window:AddKeySystem({
    Key = {"ULTRA-ROST-2026","FREE-KEY-TEST","ULTRA-UNI-2026"},
    AcceptKeyInfo = "Введите ключ", SaveKey = true, FileName = "UltraScript_Key"
})
if not KeySystem then return end

getgenv().Ultra = {
    Silent = {Enabled = false, Fov = 90, HitPart = "Head"},
    Hitbox = {Enabled = false, Size = 10},
    ESP = {Box = false, Name = false},
    Movement = {WalkSpeed = false, Speed = 21, InfJump = false}
}

local Combat = Window:AddTab({Title = "Combat"})
local Visuals = Window:AddTab({Title = "Visuals"})
local Misc = Window:AddTab({Title = "Misc"})

Combat:AddToggle("SilentEnable", {Title = "Silent Aim", Callback = function(v) getgenv().Ultra.Silent.Enabled = v end})
Combat:AddSlider("SilentFov", {Title = "Fov", Min = 10, Max = 500, Default = 90, Callback = function(v) getgenv().Ultra.Silent.Fov = v end})
Combat:AddToggle("HitboxEnable", {Title = "Hitbox", Callback = function(v) getgenv().Ultra.Hitbox.Enabled = v end})
Combat:AddSlider("HitboxSize", {Title = "Size", Min = 2, Max = 30, Default = 10, Callback = function(v) getgenv().Ultra.Hitbox.Size = v end})

Visuals:AddToggle("ESPBox", {Title = "Box ESP", Callback = function(v) getgenv().Ultra.ESP.Box = v end})
Visuals:AddToggle("ESPName", {Title = "Name ESP", Callback = function(v) getgenv().Ultra.ESP.Name = v end})

Misc:AddToggle("WalkSpeed", {Title = "WalkSpeed", Callback = function(v) getgenv().Ultra.Movement.WalkSpeed = v end})
Misc:AddSlider("Speed", {Title = "Speed", Min = 16, Max = 120, Default = 21, Callback = function(v) getgenv().Ultra.Movement.Speed = v end})
Misc:AddToggle("InfJump", {Title = "InfJump", Callback = function(v) getgenv().Ultra.Movement.InfJump = v end})

game:GetService("RunService").RenderStepped:Connect(function()
    if getgenv().Ultra.Movement.WalkSpeed and LocalPlayer.Character then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = getgenv().Ultra.Movement.Speed
    end
    if getgenv().Ultra.Hitbox.Enabled then
        for _,v in pairs(game.Players:GetPlayers()) do if v.Character then
            for _,p in pairs(v.Character:GetChildren()) do if p:IsA("BasePart") then
                p.Size = Vector3.new(getgenv().Ultra.Hitbox.Size,getgenv().Ultra.Hitbox.Size,getgenv().Ultra.Hitbox.Size)
            end end
        end end
    end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if getgenv().Ultra.Movement.InfJump and LocalPlayer.Character then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

Window:SelectTab(1)
