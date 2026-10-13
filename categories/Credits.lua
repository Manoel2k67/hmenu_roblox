local releaseVersion = tostring(rawget(_G, "__HMENU_RELEASE_VERSION") or "unknown")

return {
    Id = "Credits", Label = "Credits", Icon = "info", Bookmarked = false,
    Sections = {
        { Title = "About", Icon = "info", Controls = {
            { Kind = "Paragraph", Label = "Menu MM2 v" .. releaseVersion, Description = "Interface modular criada para manutenção simples e expansão por categorias." },
            { Kind = "Paragraph", Label = "Desenvolvimento", Description = "Manoel2k67 / Menu MM2" },
            {
                Kind = "Button",
                Id = "copy_community",
                Label = "Community",
                ButtonText = "Copiar link",
                Callback = function()
                    if type(setclipboard) == "function" then
                        setclipboard("https://m2kscripts-frontend.vercel.app/")
                    end
                end,
            },
        }},
    },
}
