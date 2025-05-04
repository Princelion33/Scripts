-- LocalScript sous StarterGui > ScreenGui

-- Charger Orion (nouveau loadstring)
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()

-- Créer la fenêtre principale
local Window = OrionLib:MakeWindow({
    Name = "Trade Scammer",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "TradeScammer",
    IntroText = "Trade Scammer GUI V1",
})

-- Créer un onglet Trade
local Tab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Variables par défaut
local petBaseName = "Diamond Triple Dominus_"
local startIndex = 1
local endIndex = 10
local waitTime = 0.0
local confirm = true

-- Champ pour le nom de base du pet
Tab:AddTextbox({
    Name = "Préfixe du Pet",
    Default = petBaseName,
    TextDisappear = false,
    Callback = function(value)
        petBaseName = value
    end
})

-- Slider pour l’index de début
Tab:AddSlider({
    Name = "Index Début",
    Min = 1,
    Max = 300,
    Default = startIndex,
    Increment = 1,
    ValueName = "Début",
    Callback = function(value)
        startIndex = value
    end
})

-- Slider pour l’index de fin
Tab:AddSlider({
    Name = "Index Fin",
    Min = 1,
    Max = 300,
    Default = endIndex,
    Increment = 1,
    ValueName = "Fin",
    Callback = function(value)
        endIndex = value
    end
})

-- Slider pour le délai entre envois
Tab:AddSlider({
    Name = "Délai (s)",
    Min = 0,
    Max = 5,
    Default = waitTime,
    Increment = 0.1,
    ValueName = "Wait Time",
    Callback = function(value)
        waitTime = value
    end
})

-- Toggle pour true/false
Tab:AddToggle({
    Name = "Confirm Boolean",
    Default = confirm,
    Callback = function(value)
        confirm = value
    end
})

-- Bouton pour lancer l’envoi
Tab:AddButton({
    Name = "Envoyer les Pets",
    Callback = function()
        -- Validation
        if startIndex > endIndex then
            OrionLib:MakeNotification({
                Name = "Erreur",
                Content = "L’index de début doit être ≤ index de fin.",
                Image = "rbxassetid://3926305904",
                Time = 3
            })
            return
        end

        -- Boucle d’envoi
        for i = startIndex, endIndex do
            local petName = petBaseName .. i
            local args = { petName, confirm }
            game:GetService("ReplicatedStorage")
                :WaitForChild("TradeRemotes")
                :WaitForChild("TradeOfferEvent")
                :FireServer(unpack(args))
            wait(waitTime)
        end

        OrionLib:MakeNotification({
            Name = "Succès",
            Content = ("Envoyé %d pets de %s à %s!"):format(endIndex - startIndex + 1, petBaseName..startIndex, petBaseName..endIndex),
            Image = "rbxassetid://3926305904",
            Time = 4
        })
    end
})

-- Afficher la fenêtre
OrionLib:Init()
