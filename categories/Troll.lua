return {
    Id = "Troll",
    Label = "Troll",
    Icon = "smile",
    Bookmarked = false,
    RuntimeModule = "runtime/Troll.lua",
    Sections = {
        {
            Title = "Fling",
            Icon = "target",
            Controls = {
                {
                    Kind = "Toggle",
                    Setting = "TouchFling",
                    Id = "touch_fling",
                    Label = "Fling ao Encostar",
                    Description = "Arremessa para fora do mapa qualquer jogador em quem você encostar.",
                    Default = false,
                },
            },
        },
    },
}
