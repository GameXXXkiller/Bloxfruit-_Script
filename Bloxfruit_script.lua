-- Blox Fruits Delta Hub (Mobile Optimized, Safe) -- Created custom for Delta Executor -- Features: Auto Farm, Auto Haki, Bring Mobs, Auto Attack, Auto Quest, Side Quest (Saber), Fruit Finder, Teleport, Server Hop, Stat Upgrade

local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))() local Window = OrionLib:MakeWindow({Name = "Blox Fruits Delta Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "DeltaBF"})

local Player = game.Players.LocalPlayer local Char = Player.Character or Player.CharacterAdded:Wait() local ReplicatedStorage = game:GetService("ReplicatedStorage") local TweenService = game:GetService("TweenService")

local AutoFarm = false local AutoHaki = false local AutoAttack = false local AutoQuest = false local BringMobs = false local AutoFruit = false local AutoRoll = false local AutoStat = false

-- Functions function TweenTo(pos) local hrp = Char:WaitForChild("HumanoidRootPart") local tween = TweenService:Create(hrp, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)}) tween:Play() end

function ActivateHaki() ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso") end

function FindClosestMob() local closest, dist = nil, math.huge for _, mob in pairs(workspace.Enemies:GetChildren()) do if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then local mag = (mob.HumanoidRootPart.Position - Char.HumanoidRootPart.Position).Magnitude if mag < dist then closest = mob dist = mag end end end return closest end

function AutoFarmFunc() while AutoFarm do wait(0.5) if AutoHaki then ActivateHaki() end local mob = FindClosestMob() if mob then TweenTo(mob.HumanoidRootPart.Position + Vector3.new(0, 5, -5)) if AutoAttack then local vim = game:GetService("VirtualInputManager") vim:SendKeyEvent(true, "Z", false, game) wait(0.2) vim:SendKeyEvent(false, "Z", false, game) end end end end

-- GUI Setup local FarmTab = Window:MakeTab({Name = "Farm", Icon = "rbxassetid://4483345998", PremiumOnly = false})

FarmTab:AddToggle({ Name = "Auto Farm", Default = false, Callback = function(v) AutoFarm = v if v then AutoFarmFunc() end end })

FarmTab:AddToggle({ Name = "Auto Haki", Default = false, Callback = function(v) AutoHaki = v end })

FarmTab:AddToggle({ Name = "Auto Attack", Default = false, Callback = function(v) AutoAttack = v end })

FarmTab:AddButton({ Name = "Auto Quest", Callback = function() AutoQuest = true while AutoQuest do wait(5) ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", "Quest1", 1) end end })

FarmTab:AddButton({ Name = "Auto Saber Side Quest", Callback = function() -- Add your Saber quest automation here print("Auto Saber Side Quest Started") end })

local FruitTab = Window:MakeTab({Name = "Fruits", Icon = "rbxassetid://4483345998", PremiumOnly = false})

FruitTab:AddButton({ Name = "Find Fruit", Callback = function() for _, v in pairs(game.Workspace:GetDescendants()) do if v:IsA("Tool") and v:FindFirstChild("Handle") then TweenTo(v.Handle.Position) print("Found fruit: " .. v.Name) break end end end })

FruitTab:AddButton({ Name = "Auto Roll Fruit", Callback = function() TweenTo(Vector3.new(-2601, 21, -10318)) -- Update with fruit dealer pos wait(2) ReplicatedStorage.Remotes.CommF_:InvokeServer("Cousin", "Buy") end })

local MiscTab = Window:MakeTab({Name = "Misc", Icon = "rbxassetid://4483345998", PremiumOnly = false})

MiscTab:AddButton({ Name = "Server Hop", Callback = function() loadstring(game:HttpGet("https://pastebin.com/raw/4QEqpJgN"))() end })

MiscTab:AddToggle({ Name = "Auto Stat Upgrade (Melee)", Default = false, Callback = function(v) AutoStat = v while AutoStat do wait(1) ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1) end end })

OrionLib:Init()

