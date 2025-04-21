-- Delta Mobile - Blox Fruits Auto-Farm + Fruit Finder (No Server Hop)

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

function tpTo(pos)
    if character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(pos)
    end
end

function autoFarm()
    while true do
        wait(0.5)
        local enemies = workspace.Enemies:GetChildren()
        local closest = nil
        local shortest = math.huge

        for _, enemy in pairs(enemies) do
            if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                local dist = (enemy.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
                if dist < shortest then
                    shortest = dist
                    closest = enemy
                end
            end
        end

        if closest then
            tpTo(closest.HumanoidRootPart.Position + Vector3.new(0, 3, -3))
            -- Simulate click/tap instead of pressing "Z"
            mouse1click()
        end
    end
end

function findFruit()
    for _, item in pairs(workspace:GetDescendants()) do
        if item:IsA("Tool") and item:FindFirstChild("Handle") then
            tpTo(item.Handle.Position)
            print("Found fruit: " .. item.Name)
            break
        end
    end
end

-- Run the loops
task.spawn(autoFarm)
task.spawn(findFruit)
