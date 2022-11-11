egal, Cooldown = false, false

Lang = Config.General.Locales

Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

Citizen.CreateThread(function()
    while true do
        local wait = 1000

        local object, dist = ESX.Game.GetClosestObject()
        local model = GetEntityModel(object)
        local coord = GetEntityCoords(object)

        for i = 1, #Config.Props do
            if model == Config.Props[i].model then
                wait = 5
                if dist <= Config.General.Distance_Recherche then
                    if not Cooldown then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour fouiller la poubelle")
                        DrawMarker(0, coord.x, coord.y, coord.z + 1.5, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.2, 0.2, 0.2, 255, 20, 20, 180, false, true, p19, false)
                        if IsControlJustReleased(0, Keys["E"]) then
                                if not egal then
                                TriggerServerEvent("server:searchTrash", object)
                                egal = false
                                Cooldown = false
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(wait)
    end
end)


RegisterNetEvent('client:searchTrash')
AddEventHandler('client:searchTrash', function(binId)
    exports['progressbar']:Progress({
        name = "processing",
        duration = Config.General.Temps_De_Recherche,
        label = Translations[Lang]["progressbar"]["searching"],
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
        animDict = Config.Animations.AnimationDictionary,
        anim = Config.Animations.Animation,
        }
    }, function(status)
        if not status then
            TriggerServerEvent('server:searchedTrash', binId)
        end
    end)
end)