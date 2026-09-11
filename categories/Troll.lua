return {
    Id = "Troll",
    Label = "Troll",
    Icon = "fire",
    Bookmarked = false,
    RuntimeModule = "runtime/Troll.lua",
    Sections = {
        {
            Title = "Fling",
            Icon = "fire",
            Controls = {
                {
                    Kind = "Dropdown",
                    Setting = "SelectedPlayer",
                    OptionsSource = "Players",
                    UseList = true,
                    Id = "troll_target_player",
                    Label = "Target Player",
                    Default = "Select a player",
                },
                {
                    Kind = "Button",
                    Setting = "FlingSelected",
                    Id = "fling_selected",
                    Label = "Fling Target",
                    Description = "Arremessa o jogador selecionado para fora do mapa e retorna você à posição inicial.",
                    ButtonText = "Fling",
                },
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
