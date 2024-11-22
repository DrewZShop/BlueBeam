local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Dungeon RNG Auto Play " .. Fluent.Version,
    SubTitle = "By Drew",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "crown" })
}

local Options = Fluent.Options

-- Adding AutoRoll Toggle to the Main Tab
local AutoRollToggle = Tabs.Main:AddToggle("AutoRollToggle", {
    Title = "AutoRoll",
    Default = false -- Default state of the toggle
})

-- OnChanged event for the AutoRoll toggle
AutoRollToggle:OnChanged(function()
    local state = AutoRollToggle.Value

    -- Arguments for the SaveSetting function
    local args = {
        [1] = "AutoRoll",
        [2] = state
    }

    -- Invoke the SaveSetting function
    game:GetService("ReplicatedStorage").Knit.Services.SettingService.RF.SaveSetting:InvokeServer(unpack(args))

    -- Notify the user
    if state then
        Fluent:Notify({
            Title = "AutoRoll Enabled",
            Content = "AutoRoll is now ON.",
            Duration = 5
        })
    else
        Fluent:Notify({
            Title = "AutoRoll Disabled",
            Content = "AutoRoll is now OFF.",
            Duration = 5
        })
    end

    print("AutoRoll state changed:", state) -- Debugging output
end)

-- Adding Fast Roll toggle to the Main tab
local FastRollToggle = Tabs.Main:AddToggle("FastRollToggle", {
    Title = "Fast Roll",
    Default = false -- Default state for the toggle
})

-- OnChanged event for the Fast Roll toggle
FastRollToggle:OnChanged(function()
    local state = FastRollToggle.Value

    -- Arguments for the SaveSetting function
    local args = {
        [1] = "FastRoll",
        [2] = state
    }

    -- Invoke the SaveSetting function
    game:GetService("ReplicatedStorage").Knit.Services.SettingService.RF.SaveSetting:InvokeServer(unpack(args))

    -- Notify the user
    if state then
        Fluent:Notify({
            Title = "Fast Roll Enabled",
            Content = "Fast Roll is now ON.",
            Duration = 5
        })
    else
        Fluent:Notify({
            Title = "Fast Roll Disabled",
            Content = "Fast Roll is now OFF.",
            Duration = 5
        })
    end

    print("Fast Roll state changed:", state) -- Debugging output
end)

-- Adding Auto Attack toggle to the Main tab
local AutoAttackToggle = Tabs.Main:AddToggle("AutoAttackToggle", {
    Title = "Auto Attack",
    Default = false -- Default state for the toggle
})

-- OnChanged event for the Auto Attack toggle
AutoAttackToggle:OnChanged(function()
    local state = AutoAttackToggle.Value

    -- Arguments for the SaveSetting function
    local args = {
        [1] = "AutoAttack",
        [2] = state
    }

    -- Invoke the SaveSetting function
    game:GetService("ReplicatedStorage").Knit.Services.SettingService.RF.SaveSetting:InvokeServer(unpack(args))

    -- Notify the user
    if state then
        Fluent:Notify({
            Title = "Auto Attack Enabled",
            Content = "Auto Attack is now ON.",
            Duration = 5
        })
    else
        Fluent:Notify({
            Title = "Auto Attack Disabled",
            Content = "Auto Attack is now OFF.",
            Duration = 5
        })
    end

    print("Auto Attack state changed:", state) -- Debugging output
end)

-- Add Auto King's Sword Toggle to the Main Tab
local AutoKingsSwordToggle = Tabs.Main:AddToggle("AutoKingsSwordToggle", {
    Title = "Auto King's Sword",
    Default = false
})

-- CFrame location for the King's Sword
local kingsSwordCFrame = CFrame.new(34.0200005, 8.83500004, 52.1819992, 0.651681662, 0, 0.758492708, 0, 1, 0, -0.758492708, 0, 0.651681662)

-- Function to teleport the player and press 'E'
local function teleportAndPressE()
    local player = game.Players.LocalPlayer
    if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        Fluent:Notify({
            Title = "Action Failed",
            Content = "Unable to find the player or their character.",
            Duration = 5
        })
        return
    end

    local humanoidRootPart = player.Character.HumanoidRootPart

    -- Teleport the player to the King's Sword
    humanoidRootPart.CFrame = kingsSwordCFrame
    print("Teleported to King's Sword.")

    -- Wait for 2 seconds after teleporting
    task.wait(2)

    -- Simulate pressing the 'E' key
    local VirtualInputManager = game:GetService("VirtualInputManager")
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, nil)
    task.wait(0.1) -- Small delay for the key press
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, nil)
    print("Pressed 'E' on the King's Sword.")
end

-- Auto King's Sword Logic
AutoKingsSwordToggle:OnChanged(function()
    local enabled = AutoKingsSwordToggle.Value
    if enabled then
        Fluent:Notify({
            Title = "Auto King's Sword Enabled",
            Content = "The bot will now automatically teleport to the King's Sword and press 'E' every 5 minutes.",
            Duration = 5
        })
        print("Auto King's Sword Enabled")
        while AutoKingsSwordToggle.Value do
            teleportAndPressE()
            print("Waiting for 5 minutes before the next teleport...")
            task.wait(300) -- Wait for 5 minutes (300 seconds) before repeating
        end
    else
        Fluent:Notify({
            Title = "Auto King's Sword Disabled",
            Content = "The bot has stopped teleporting to the King's Sword.",
            Duration = 5
        })
        print("Auto King's Sword Disabled")
    end
end)




-- Adding a button to redeem all codes in the Main Tab
Tabs.Main:AddButton({
    Title = "Redeem All Codes",
    Description = "Click to redeem all available codes.",
    Callback = function()
        -- List of codes to redeem
        local codes = {
            "CosmicUpdate",
            "ThirtyFourMillionVisits",
            "ServerRestart",
            "Update15",
            "ThirtyTwoMillionVisits",
            "ThirtyMillionVisits",
            "TrickOrTreat",
            "TwentyEightMillionVisits",
            "Halloween",
            "TwentyFiveMillionVisits"
        }

        -- Redeem each code
        for _, code in ipairs(codes) do
            local args = {
                [1] = code
            }
            game:GetService("ReplicatedStorage").Knit.Services.RedeemCodeService.RF.RedeemCode:InvokeServer(unpack(args))
            print("Redeemed code:", code) -- Debug output
        end

        -- Notify the user
        Fluent:Notify({
            Title = "Codes Redeemed",
            Content = "All codes have been redeemed!",
            Duration = 5
        })
    end
})

-- Add a new Potions tab
local PotionsTab = Window:AddTab({ Title = "Potions", Icon = "flask-round" }) -- "flask-round" is an optional icon

-- Adding Auto Collect Potions Toggle
local AutoCollectPotionsToggle = PotionsTab:AddToggle("AutoCollectPotionsToggle", {
    Title = "Auto Collect Potions",
    Default = false
})

-- Function to collect potions
local function collectPotions()
    local potionsFolder = game:GetService("Workspace"):FindFirstChild("Runtime") and game:GetService("Workspace").Runtime:FindFirstChild("Potions")
    if not potionsFolder then
        Fluent:Notify({
            Title = "Potions Not Found",
            Content = "Unable to locate the potions folder in the workspace.",
            Duration = 5
        })
        return
    end

    local player = game.Players.LocalPlayer
    if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        Fluent:Notify({
            Title = "Teleport Failed",
            Content = "Unable to find the player or their character.",
            Duration = 5
        })
        return
    end

    local humanoidRootPart = player.Character.HumanoidRootPart

    -- Iterate over all potions and teleport to their CFrame
    for _, potion in pairs(potionsFolder:GetChildren()) do
        if potion:IsA("BasePart") then -- Ensure it's a part
            humanoidRootPart.CFrame = potion.CFrame
            task.wait(0.5) -- Short delay between teleports to prevent issues
        end
    end
end

-- Auto Collect Potions logic
AutoCollectPotionsToggle:OnChanged(function()
    local enabled = AutoCollectPotionsToggle.Value
    if enabled then
        Fluent:Notify({
            Title = "Auto Collect Enabled",
            Content = "The bot will now automatically collect potions every 5 minutes.",
            Duration = 5
        })
        print("Auto Collect Potions Enabled")
        while AutoCollectPotionsToggle.Value do
            collectPotions()
            task.wait(120) -- Wait for 5 minutes (300 seconds) before collecting again
        end
    else
        Fluent:Notify({
            Title = "Auto Collect Disabled",
            Content = "The bot has stopped collecting potions.",
            Duration = 5
        })
        print("Auto Collect Potions Disabled")
    end
end)

-- Adding a button to consume 1 Magic Potion
PotionsTab:AddButton({
    Title = "Magic Potions",
    Description = "Consumes 1 magic potion.",
    Callback = function()
        local numberToDrink = 1 -- Fixed to consume only 1 potion

        -- Consume the specified number of potions
        for i = 1, numberToDrink do
            local args = {
                [1] = "Magic", -- Potion type
                [2] = 3 -- Replace with appropriate potion level if needed
            }
            game:GetService("ReplicatedStorage").Knit.Services.PotionInventoryService.RF.ConsumePotion:InvokeServer(unpack(args))
            print("Consumed potion", i, "of", numberToDrink) -- Debug output
        end

        -- Notify the user
        Fluent:Notify({
            Title = "Potion Consumed",
            Content = "You have consumed 1 Magic potion.",
            Duration = 5
        })
    end
})



-- Adding a new Relics tab
local RelicsTab = Window:AddTab({ Title = "Relics", Icon = "gem" }) -- "gem" is an optional icon

-- List of all relics
local relics = {
    "DevilsTooth", "Odyssey", "Heaven", "ChainedGod", "PiercingLight",
    "Skeleton", "DeathNote", "Reaper", "Galaxy", "Majesty", "DarkAngel",
    "BloodMoon", "SilentBrute", "WorldStone", "LuckyCharm", "GoldenWing",
    "DarkSummon", "SoulStone", "ScaredFruit", "BoldSacrifice", "MoonSpirit",
    "SeeThrough", "DarkNight", "DeathAwaits", "TheWatcher", "EtheralVisage",
    "RegalEmblem", "MysticVision", "ArcticGuardian", "AncientSeer", "SolarFlare",
    "SeaSerpent", "VerdantVortex", "SolarEye", "CelestialWeb", "CelticEmbrace",
    "CelticRadiance", "FloralGleam", "Stormbringer", "GoldenOrb", "ForestSpirit",
    "Bloodstone", "Inferno", "Lavaheart", "Battlemark", "Droplet", "Glimmsight",
    "Verdance", "Stoneforge", "Soulbind"
}

-- Add dropdown for selecting a relic
local RelicDropdown = RelicsTab:AddDropdown("RelicDropdown", {
    Title = "Select Relic to Craft",
    Values = relics,
    Default = 1, -- Default selection (index in the relics table)
    Multi = false -- Single selection
})

-- Add a button to craft the selected relic
RelicsTab:AddButton({
    Title = "Craft Selected Relic",
    Description = "Craft the relic selected from the dropdown.",
    Callback = function()
        local selectedRelic = RelicDropdown.Value -- Get the selected relic from the dropdown

        if not selectedRelic or selectedRelic == "" then
            Fluent:Notify({
                Title = "No Relic Selected",
                Content = "Please select a relic to craft.",
                Duration = 5
            })
            return
        end

        -- Arguments for crafting the relic
        local args = {
            [1] = selectedRelic
        }

        -- Invoke the server function to craft the relic
        game:GetService("ReplicatedStorage").Knit.Services.RelicService.RF.CraftRelic:InvokeServer(unpack(args))

        -- Notify the user
        Fluent:Notify({
            Title = "Relic Crafted",
            Content = "You have successfully crafted the relic: " .. selectedRelic,
            Duration = 5
        })

        print("Crafted relic:", selectedRelic) -- Debugging output
    end
})

-- Add a dropdown for equipping relics
local EquipRelicDropdown = RelicsTab:AddDropdown("EquipRelicDropdown", {
    Title = "Select Relic to Equip",
    Values = relics, -- Reuse the relics list
    Default = 1, -- Default selection (index in the relics table)
    Multi = false -- Single selection
})

-- Add a button to equip the selected relic
RelicsTab:AddButton({
    Title = "Equip Selected Relic",
    Description = "Equip the relic selected from the dropdown.",
    Callback = function()
        local selectedRelic = EquipRelicDropdown.Value -- Get the selected relic from the dropdown

        if not selectedRelic or selectedRelic == "" then
            Fluent:Notify({
                Title = "No Relic Selected",
                Content = "Please select a relic to equip.",
                Duration = 5
            })
            return
        end

        -- Arguments for equipping the relic
        local args = {
            [1] = selectedRelic
        }

        -- Invoke the server function to equip the relic
        game:GetService("ReplicatedStorage").Knit.Services.RelicService.RF.EquipRelic:InvokeServer(unpack(args))

        -- Notify the user
        Fluent:Notify({
            Title = "Relic Equipped",
            Content = "You have successfully equipped the relic: " .. selectedRelic,
            Duration = 5
        })

        print("Equipped relic:", selectedRelic) -- Debugging output
    end
})

-- Add a toggle for continuous relic crafting
local ContinuousCraftToggle = RelicsTab:AddToggle("ContinuousCraftToggle", {
    Title = "Continuous Crafting",
    Default = false -- Default state for the toggle
})

-- OnChanged event for the Continuous Crafting toggle
ContinuousCraftToggle:OnChanged(function()
    local state = ContinuousCraftToggle.Value -- Get the current toggle state

    if state then
        Fluent:Notify({
            Title = "Continuous Crafting Enabled",
            Content = "Relics will now be crafted continuously.",
            Duration = 5
        })

        print("Continuous Crafting is now enabled.") -- Debugging output

        -- Start continuous crafting in a separate thread
        task.spawn(function()
            while ContinuousCraftToggle.Value do -- Recheck the toggle's state in the loop
                -- Get the selected relic from the crafting dropdown
                local selectedRelic = RelicDropdown.Value
                if not selectedRelic or selectedRelic == "" then
                    Fluent:Notify({
                        Title = "No Relic Selected",
                        Content = "Please select a relic to craft.",
                        Duration = 5
                    })
                    break
                end

                -- Arguments for crafting the relic
                local args = { [1] = selectedRelic }

                -- Invoke the server function to craft the relic
                game:GetService("ReplicatedStorage").Knit.Services.RelicService.RF.CraftRelic:InvokeServer(unpack(args))

                -- Notify the user
                print("Crafted relic:", selectedRelic) -- Debugging output

                -- Delay between crafting iterations to prevent server overload
                wait(1) -- Adjust the delay as needed
            end

            -- Notify when crafting stops
            if not ContinuousCraftToggle.Value then
                Fluent:Notify({
                    Title = "Continuous Crafting Disabled",
                    Content = "Relic crafting has been stopped.",
                    Duration = 5
                })
                print("Continuous Crafting has been stopped.") -- Debugging output
            end
        end)
    else
        Fluent:Notify({
            Title = "Continuous Crafting Disabled",
            Content = "Relic crafting has been stopped.",
            Duration = 5
        })
        print("Continuous Crafting is now disabled.") -- Debugging output
    end
end)


-- Add a new Teleport tab
local TeleportTab = Window:AddTab({ Title = "Teleport", Icon = "map" }) -- Optional map icon

-- List of CFrames for all 60 Dungeons
local dungeons = {
    ["Dungeon 1"] = CFrame.new(-59.5843544, 5, 165.810913, 0.939700544, 0, -0.341998369, 0, 1, 0, 0.341998369, 0, 0.939700544),
    ["Dungeon 2"] = CFrame.new(-112.701645, 5, 135.432251, 0.766061246, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, 0.766061246),
    ["Dungeon 3"] = CFrame.new(-152.225464, 5, 88.7184372, 0.499959469, 0, -0.866048813, 0, 1, 0, 0.866048813, 0, 0.499959469),
    ["Dungeon 4"] = CFrame.new(-173.388641, 5, 31.3038979, 0.173624337, 0, -0.984811902, 0, 1, 0, 0.984811902, 0, 0.173624337),
    ["Dungeon 5"] = CFrame.new(-173.63858, 5, -29.8863754, -0.173624277, 0, -0.984811902, 0, 1, 0, 0.984811902, 0, -0.173624277),
    ["Dungeon 6"] = CFrame.new(-152.94516, 5, -87.4719009, -0.499959469, 0, -0.866048813, 0, 1, 0, 0.866048813, 0, -0.499959469),
    ["Dungeon 7"] = CFrame.new(-113.804283, 5, -134.507019, -0.766061664, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, -0.766061664),
    ["Dungeon 8"] = CFrame.new(-60.9369469, 5, -165.318604, -0.939700961, 0, -0.341998369, 0, 1, 0, 0.341998369, 0, -0.939700961),
    ["Dungeon 9"] = CFrame.new(-0.719677806, 5, -176.190338, -1, 0, 0, 0, 1, 0, 0, 0, -1),
    ["Dungeon 10"] = CFrame.new(59.5843582, 5, -165.810913, -0.939700961, 0, 0.341998369, 0, 1, 0, -0.341998369, 0, -0.939700961),
    ["Dungeon 11"] = CFrame.new(112.701645, 5, -135.432251, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664),
    ["Dungeon 12"] = CFrame.new(152.225464, 5, -88.7184296, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469),
    ["Dungeon 13"] = CFrame.new(173.388641, 5, -31.3038826, -0.173624277, 0, 0.984811902, 0, 1, 0, -0.984811902, 0, -0.173624277),
    ["Dungeon 14"] = CFrame.new(173.63858, 5, 29.8863659, 0.173624337, 0, 0.984811902, 0, 1, 0, -0.984811902, 0, 0.173624337),
    ["Dungeon 15"] = CFrame.new(152.94516, 5, 87.4718781, 0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, 0.499959469),
    ["Dungeon 16"] = CFrame.new(113.804306, 5, 134.506989, 0.766061246, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, 0.766061246),
    ["Dungeon 17"] = CFrame.new(60.9369736, 5, 165.318588, 0.939700544, 0, 0.341998369, 0, 1, 0, -0.341998369, 0, 0.939700544),
    ["Dungeon 18"] = CFrame.new(0.719662368, 5, 176.190338, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    ["Dungeon 19"] = CFrame.new(-59.5843735, -102.061119, 165.810898, 0.939700544, 0, -0.341998369, 0, 1, 0, 0.341998369, 0, 0.939700544),
    ["Dungeon 20"] = CFrame.new(-112.701653, -102.061119, 135.432251, 0.766061246, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, 0.766061246),
    ["Dungeon 21"] = CFrame.new(-152.225464, -102.061119, 88.7184525, 0.499959469, 0, -0.866048813, 0, 1, 0, 0.866048813, 0, 0.499959469),
    ["Dungeon 22"] = CFrame.new(-173.388641, -102.061119, 31.3039093, 0.173624337, 0, -0.984811902, 0, 1, 0, 0.984811902, 0, 0.173624337),
    ["Dungeon 23"] = CFrame.new(-173.63858, -102.061119, -29.886425, -0.173624277, 0, -0.984811902, 0, 1, 0, 0.984811902, 0, -0.173624277),
    ["Dungeon 24"] = CFrame.new(-152.945129, -102.061119, -87.4719238, -0.499959469, 0, -0.866048813, 0, 1, 0, 0.866048813, 0, -0.499959469),
    ["Dungeon 25"] = CFrame.new(-113.804253, -102.061119, -134.507034, -0.766061664, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, -0.766061664),
    ["Dungeon 26"] = CFrame.new(-60.9369202, -102.061119, -165.318619, -0.939700961, 0, -0.341998369, 0, 1, 0, 0.341998369, 0, -0.939700961),
    ["Dungeon 27"] = CFrame.new(-0.719689012, -102.061119, -176.190338, -1, 0, 0, 0, 1, 0, 0, 0, -1),
    ["Dungeon 28"] = CFrame.new(59.5843468, -102.061119, -165.810913, -0.939700961, 0, 0.341998369, 0, 1, 0, -0.341998369, 0, -0.939700961),
    ["Dungeon 29"] = CFrame.new(112.701637, -102.061119, -135.432251, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664),
    ["Dungeon 30"] = CFrame.new(152.225449, -102.061119, -88.7184753, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469),
    ["Dungeon 31"] = CFrame.new(173.388641, -102.061119, -31.303936, -0.173624277, 0, 0.984811902, 0, 1, 0, -0.984811902, 0, -0.173624277),
    ["Dungeon 32"] = CFrame.new(173.63858, -102.061119, 29.8863144, 0.173624337, 0, 0.984811902, 0, 1, 0, -0.984811902, 0, 0.173624337),
    ["Dungeon 33"] = CFrame.new(152.94519, -102.061119, 87.4718323, 0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, 0.499959469),
    ["Dungeon 34"] = CFrame.new(113.804352, -102.061119, 134.506958, 0.766061246, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, 0.766061246),
    ["Dungeon 35"] = CFrame.new(60.9368629, -102.061119, 165.318619, 0.939700544, 0, 0.341998369, 0, 1, 0, -0.341998369, 0, 0.939700544),
    ["Dungeon 36"] = CFrame.new(0.719631553, -102.061119, 176.190338, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    ["Dungeon 37"] = CFrame.new(125.545647, -191.186218, -124.994453, -0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, -0.707134247),
    ["Dungeon 38"] = CFrame.new(176.190384, -191.995529, -0.719570696, 0, 0, 1, 0, 1, 0, -1, 0, 0),
    ["Dungeon 39"] = CFrame.new(125.094429, -191.995529, 124.076408, 0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, 0.707134247),
    ["Dungeon 40"] = CFrame.new(0.719794035, -191.995529, 176.190384, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    ["Dungeon 41"] = CFrame.new(-124.076477, -191.995529, 125.094345, 0.707134247, 0, -0.707079291, 0, 1, 0, 0.707079291, 0, 0.707134247),
    ["Dungeon 42"] = CFrame.new(-176.190384, -191.995529, 0.720017374, 0, 0, -1, 0, 1, 0, 1, 0, 0),
    ["Dungeon 43"] = CFrame.new(-125.094261, -191.995529, -124.076561, -0.707134247, 0, -0.707079291, 0, 1, 0, 0.707079291, 0, -0.707134247),
    ["Dungeon 44"] = CFrame.new(-0.719904661, -191.995529, -176.190384, -1, 0, 0, 0, 1, 0, 0, 0, -1),
    ["Dungeon 45"] = CFrame.new(124.076645, -281.995544, -125.094193, -0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, -0.707134247),
    ["Dungeon 46"] = CFrame.new(176.190384, -281.995544, -0.719791949, 0, 0, 1, 0, 1, 0, -1, 0, 0),
    ["Dungeon 47"] = CFrame.new(125.094109, -281.995544, 124.076721, 0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, 0.707134247),
    ["Dungeon 48"] = CFrame.new(0.719679236, -281.995544, 176.190384, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    ["Dungeon 49"] = CFrame.new(-124.076332, -281.995544, 125.094505, 0.707134247, 0, -0.707079291, 0, 1, 0, 0.707079291, 0, 0.707134247),
    ["Dungeon 50"] = CFrame.new(-176.190384, -281.995544, 0.719566524, 0, 0, -1, 0, 1, 0, 1, 0, 0),
    ["Dungeon 51"] = CFrame.new(-125.094421, -281.995544, -124.076408, -0.707134247, 0, -0.707079291, 0, 1, 0, 0.707079291, 0, -0.707134247),
    ["Dungeon 52"] = CFrame.new(-0.719453812, -281.995544, -176.190384, -1, 0, 0, 0, 1, 0, 0, 0, -1),
    ["Dungeon 53"] = CFrame.new(124.076492, -371.995544, -125.094345, -0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, -0.707134247),
    ["Dungeon 54"] = CFrame.new(176.190384, -371.995544, -0.720013201, 0, 0, 1, 0, 1, 0, -1, 0, 0),
    ["Dungeon 55"] = CFrame.new(125.094261, -371.995544, 124.076561, 0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, 0.707134247),
    ["Dungeon 56"] = CFrame.new(0.719900489, -371.995544, 176.190384, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    ["Dungeon 57"] = CFrame.new(-124.076645, -371.995544, 125.094193, 0.707134247, 0, -0.707079291, 0, 1, 0, 0.707079291, 0, 0.707134247),
    ["Dungeon 58"] = CFrame.new(-176.190384, -371.995544, 0.719787776, 0, 0, -1, 0, 1, 0, 1, 0, 0),
    ["Dungeon 59"] = CFrame.new(-125.094109, -371.995544, -124.076721, -0.707134247, 0, -0.707079291, 0, 1, 0, 0.707079291, 0, -0.707134247),
    ["Dungeon 60"] = CFrame.new(-0.719675064, -371.995544, -176.190384, -1, 0, 0, 0, 1, 0, 0, 0, -1)
}


-- Generate a list of dungeon names for the dropdown
local dungeonNames = {}
for dungeonName, _ in pairs(dungeons) do
    table.insert(dungeonNames, dungeonName)
end

-- Sort dungeon names numerically
table.sort(dungeonNames, function(a, b)
    return tonumber(a:match("%d+")) < tonumber(b:match("%d+"))
end)

-- Add dropdown for all dungeons
local DungeonDropdown = TeleportTab:AddDropdown("DungeonDropdown", {
    Title = "Select Dungeon",
    Values = dungeonNames, -- Sorted dungeon names
    Default = 1, -- Default to the first dungeon
    Multi = false -- Single selection
})

-- Add a teleport button
TeleportTab:AddButton({
    Title = "Teleport",
    Description = "Teleport to the selected dungeon.",
    Callback = function()
        local selectedDungeon = DungeonDropdown.Value -- Get the selected dungeon
        if not selectedDungeon or not dungeons[selectedDungeon] then
            Fluent:Notify({
                Title = "Invalid Selection",
                Content = "Please select a valid dungeon to teleport.",
                Duration = 5
            })
            return
        end

        -- Get the player's character
        local player = game.Players.LocalPlayer
        if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            Fluent:Notify({
                Title = "Teleport Failed",
                Content = "Unable to find the player or their character.",
                Duration = 5
            })
            return
        end

        -- Teleport the player to the selected dungeon
        player.Character.HumanoidRootPart.CFrame = dungeons[selectedDungeon]

        -- Notify the user of success
        Fluent:Notify({
            Title = "Teleported",
            Content = "You have been teleported to " .. selectedDungeon .. ".",
            Duration = 5
        })

        print("Teleported to:", selectedDungeon) -- Debugging output
    end
})


Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })

AutoRollToggle:SetValue(true)
FastRollToggle:SetValue(true)
AutoAttackToggle:SetValue(true)
ContinuousCraftToggle:SetValue(false)
