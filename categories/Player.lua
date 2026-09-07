return {
    Id = "Player",
    Label = "Player",
    Icon = "player",
    Bookmarked = false,
    RuntimeModule = "runtime/Player.lua",
    Sections = {
        {
            Title = "Movement",
            Icon = "player",
            Controls = {
                { Kind = "Slider", Setting = "WalkSpeed", Id = "walk_speed", Label = "Walk Speed", Min = 8, Max = 200, Default = 16, Step = 1 },
                { Kind = "Toggle", Setting = "LockWalkSpeed", Id = "lock_walk_speed", Label = "Lock Walk Speed", Description = "Keeps the selected speed if the game changes it.", Default = false },
                { Kind = "Slider", Setting = "JumpPower", Id = "jump_power", Label = "Jump Power", Min = 25, Max = 200, Default = 50, Step = 1 },
                { Kind = "Toggle", Setting = "LockJumpPower", Id = "lock_jump_power", Label = "Lock Jump Power", Description = "Keeps the selected jump power active.", Default = false },
                { Kind = "Toggle", Setting = "InfiniteJump", Id = "infinite_jump", Label = "Infinite Jump", Description = "Allows jumping while already in the air.", Default = false },
            },
        },
        {
            Title = "Flight",
            Icon = "navigation",
            Controls = {
                { Kind = "Toggle", Setting = "Fly", Id = "fly", Label = "Fly", Description = "WASD to move | Space up | LeftControl down", Default = false },
                { Kind = "Slider", Setting = "FlySpeed", Id = "fly_speed", Label = "Fly Speed", Min = 10, Max = 200, Default = 60, Step = 5 },
            },
        },
        {
            Title = "Protection and Collision",
            Icon = "shield",
            Controls = {
                { Kind = "Toggle", Setting = "Noclip", Id = "noclip", Label = "Noclip", Description = "Disables collision on your character while active.", Default = false },
                { Kind = "Toggle", Setting = "AntiFling", Id = "anti_fling", Label = "Anti Fling", Description = "Returns to the last safe position after extreme velocity.", Default = false },
                { Kind = "Toggle", Setting = "AntiVoid", Id = "anti_void", Label = "Anti Void", Description = "Returns to the last grounded position before falling into the void.", Default = false },
            },
        },
        {
            Title = "Utilities",
            Icon = "settings",
            Controls = {
                { Kind = "Toggle", Setting = "AntiAFK", Id = "anti_afk", Label = "Anti AFK", Description = "Prevents the standard idle disconnect.", Default = false },
                { Kind = "Toggle", Setting = "AntiSit", Id = "anti_sit", Label = "Anti Sit", Description = "Immediately leaves seats and forced sitting states.", Default = false },
            },
        },
    },
}
