ESX = exports["es_extended"]:getSharedObject()

Config = {}

Config.Props = {      
    {model = -206690185},
    {model = 682791951},
    {model = 666561306},
    {model = -468629664},
    {model = -5943724},
    {model = 1437508529},
    {model = 234941195},
    {model = 1380691550},
    {model = -1830793175},
    {model = 1748268526},
    {model = -1830793175},
    {model = -329415894},
    {model = -1426008804},
    {model = -341442425},
    {model = 1143474856},
    {model = -93819890},
    {model = -317177646},
    {model = -1096777189},
    {model = 437765445},
    {model = -130812911},
    {model = 1614656839},
    {model = 122303831},
    {model = 1437508529},
    {model = -5943724},
    {model = -468629664},
    {model = -58485588},
    {model = 413198204},
    {model = -2096124444},
    {model = 998415499},
    {model = 1329570871},
    {model = -228596739},
    {model = 682791951},
    {model = 218085040},
    {model = -206690185}
}

Config.General = {
    Locales = "FR", -- [Traduction] FR/EN (English is not finished) 

    -- Distance pour pouvoir fouiller une poubelle
    Distance_Recherche = 1.5,
    -- Combien de temps faut-il pour rechercher dans les ordures
    Temps_De_Recherche = 10 * 1000, -- 5 seconds
    -- Combien de temps avant que le joueur ne puisse chercher à nouveau
    SearchCooldown = 30 * 1000, -- 20 secondes
    -- Le temps où les poubelles se remplissent et peuvent être de nouvequ disponible pour la fouille
    Recharge_Poubelle = 40 * 1000 -- 40 secondes
}

Config.Gains = {
    -- Chance d'obtenir une récompense en % (0-100)
    Chance = 75,
    -- Money
    Argent = {
        Chance = 25, -- Chance d'obtenir de l'argent au lieu d'un item en % (0-100)
        Min = 1,
        Max = 100
    },
    -- Nombre minimal d'items qui peuvent être trouvés
    Min_Nb_Items = 1,
    -- Nombre maximal d'items qui peuvent être trouvés
    Max_Nb_Items = 5,

    -- Mettez les items que vous voulez ici
    ItemList = {
        "water", "bread", "weed", "weed_pochon"
    }
}

Config.Animations = {
    AnimationDictionary = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
    -- Animation
    Animation = "weed_crouch_checkingleaves_idle_01_inspector"
}

Lang = Config.General.Locales