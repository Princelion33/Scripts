
local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local PhantomForcesWindow = Library:NewWindow("Item Spawner")


local N=game:GetService("VirtualInputManager")

Selection = nil
Amount1 = 1000
local a1 = PhantomForcesWindow:NewSection("Items")








function spawn()
    local Item = selection

local Amount = Amount1

local Plr = game:GetService"Players".LocalPlayer
local Added

Added = game:GetService("Workspace").PlayerModels.ChildAdded:Connect(function(v)
    local Owner, Type = v:WaitForChild"Owner", v:WaitForChild"Type"
    if Owner.Value == Plr and Type.Value == "Blueprint" then
        game:GetService("ReplicatedStorage").PlaceStructure.ClientPlacedStructure:FireServer(Item, Plr.Character.Head.CFrame, Plr, nil, v, true)
    end
end)

for i = 1, Amount do
    game:GetService("ReplicatedStorage").PlaceStructure.ClientPlacedBlueprint:FireServer("Floor1Tiny", Plr.Character.Head.CFrame, Plr)
    task.wait()
end

task.wait(2)

Added:Disconnect()
end


a1:CreateSlider("Amount", 0, 1000, 1000, false, function(value)
    Amount1 = value
end)

-----------------------------------------------------

Axes = {"Select Axe","BasicHatchet","ManyAxe","Axe1","Axe2","Axe3","SilverAxe","AxeBetaTesters","EndTimesAxe","AxeChicken","CandyCaneAxe",
"AxeAmber","GingerBreadAxe","AxeTwitter","RustyAxe"}

a1:CreateDropdown("Spawn Axe", Axes, 1, function(text)
    selection = text
    spawn()
end)

Gifts = {"Select Gift","2016CGift_Ut","2015CGift_Coal","2015CGift_Red","2016CGift_Sweet","2015CGift_Volcano","2015CGift_Wobble","2016CGift_Blue",
"2016CGift_Big","2016CGift_Jingle","2016CGift_Wobble","2018CGift_Wobble","2017CGift_Green",
"2017CGift_GreatTimes","2017CGift_Modern","2017CGift_Wobble","2019CGift_Wobble_","2017CGifts_Gold","2018CGift_Snow","2018CGift_Plate","2018CGift_Cocoa","","",
"2018CGift_Candy","2018CGift_Wobble_","2018CGift_Duck","2018CGift_Cone",
"2018CGift_Sled","2018CGift_GingerAxe","2018CGift_Plum","2019CGift_Yellow_","2019CGift_Bowl","2019CGift_Rusty",
"2019CGift_Cola","2019CGift_Burnt","2020CGift_Teal","2020CGift_Wobble","2020CGift_Cave","2021CGift_Black","2021CGift_Wobble"}

a1:CreateDropdown("Spawn Gifts", Gifts, 1, function(text)
    selection = text
    spawn()
end)


game.StarterGui:SetCore("SendNotification", {
    Title = "HEY !"; -- the title (ofc)
    Text = "Script Made by Princelion33"; -- what the text says (ofc)
    Icon = ""; -- the image if u want. 
    Duration = 5; -- how long the notification should in secounds
    })
