# HMenu Roblox

Interface modular em Luau com sistema de acesso, categorias independentes, runtimes com ciclo de vida controlado e bundle de distribuição.

## Carregamento

Use o bootstrap resiliente abaixo:

```lua
local sources = {
    "https://raw.githubusercontent.com/Manoel2k67/hmenu_roblox/main/KeySystem.lua?v=1.1.2",
    "https://cdn.jsdelivr.net/gh/Manoel2k67/hmenu_roblox@main/KeySystem.lua?v=1.1.2",
}
local lastError = "falha de rede"
for attempt = 1, 4 do
    for _, url in ipairs(sources) do
        local ok, source = pcall(function() return game:HttpGet(url, true) end)
        if ok and type(source) == "string" and source:match("^%s*(.)") ~= "<" then
            local chunk, compileError = loadstring(source, "@HMenu/KeySystem.lua")
            if chunk then return chunk() end
            lastError = compileError
        else
            lastError = tostring(source)
        end
    end
    if attempt < 4 then task.wait(0.75 * (2 ^ (attempt - 1))) end
end
error("Não foi possível carregar o HMenu: " .. tostring(lastError))
```

Não substitua a versão por `os.time()`. Uma URL diferente em cada execução impede o cache do CDN e aumenta muito a chance de respostas `503`. A versão deve ser alterada somente quando uma nova release for publicada.

O carregador baixa apenas `dist/HMenu.bundle.lua`. Ele valida a resposta, rejeita HTML, compila antes de executar, alterna entre duas fontes e faz até quatro tentativas com espera progressiva. O menu só é exibido quando todas as categorias e runtimes obrigatórios estão válidos; não existe carregamento parcial silencioso.

## Controles

- Digite qualquer chave não vazia e clique em **Validar e abrir** ou pressione Enter.
- Use **RightShift** para ocultar e mostrar o menu.
- Arraste a barra superior para mover a janela.
- Os botões `-` e `X` ocultam o menu; RightShift o mostra novamente.
- Clique na bandeira de uma categoria para fixá-la no topo.

## Arquitetura

```text
KeySystem.lua              entrada pública, retry e validação do download
HMenu.lua                  janela, componentes, validação e ciclo de vida
HMenuConfig.lua            versão, tema, tamanho, atalhos e categorias
HMenuSchema.lua            contratos e validação das definições
categories/                descrição declarativa das páginas e controles
runtime/                   comportamento e limpeza das funções ativas
theme/wallpapers/          assets opcionais dos temas
dist/HMenu.bundle.lua      artefato gerado usado pelos jogadores
tools/Build-Bundle.ps1     gerador determinístico do bundle
tools/Test-Project.ps1     verificações de release e sintaxe
tests/                     suporte aos testes de contrato executados pelo build
```

Os fontes continuam separados para facilitar manutenção. O bundle reúne esses módulos em um único download e não deve ser editado manualmente.

## Desenvolvimento

Para criar uma categoria:

1. Adicione um arquivo em `categories/`.
2. Inclua o caminho em `Config.CategoryModules`, dentro de `HMenuConfig.lua`.
3. Se houver comportamento, crie um módulo em `runtime/` que exponha `Create`, `Set` e `Destroy`.
4. Execute as verificações e gere novamente o bundle.

Controles disponíveis: `Toggle`, `Slider`, `Dropdown`, `Button` e `Paragraph`. IDs de categorias e controles interativos devem ser únicos. Sliders precisam de `Min < Max` e `Step` positivo; dropdowns precisam de `Options` ou `OptionsSource`.

Exemplo:

```lua
{
    Kind = "Toggle",
    Id = "my_option",
    Setting = "MyOption",
    Label = "Minha opção",
    Default = false,
}
```

## Build e validação

Depois de qualquer alteração nos módulos:

```powershell
.\tools\Build-Bundle.ps1
.\tools\Test-Project.ps1 -LuauCompiler "C:\caminho\para\luau-compile.exe"
```

Sem o argumento `LuauCompiler`, as verificações de estrutura, encoding, assets, versões e bundle continuam sendo executadas; apenas o parser oficial do Luau é ignorado.

Antes de publicar uma release:

1. Atualize `RELEASE_VERSION` em `KeySystem.lua` e `Config.Version` em `HMenuConfig.lua` com o mesmo número.
2. Atualize a versão das duas URLs do bootstrap neste README.
3. Execute `Build-Bundle.ps1`.
4. Execute `Test-Project.ps1` com `luau-compile`.
5. Versione também `dist/HMenu.bundle.lua`.

O build falha se as versões divergirem ou se o bundle estiver desatualizado. Todos os textos devem permanecer em UTF-8 sem BOM.

O workflow `.github/workflows/validate.yml` executa essas validações automaticamente em pushes e pull requests.

## Chaves e segurança

O modo atual aceita qualquer chave não vazia porque `ACCEPT_ANY_NON_EMPTY_KEY` está como `true` em `KeySystem.lua`. Isso é adequado apenas para demonstração.

Defina `GET_KEY_URL` com uma URL HTTPS válida para exibir o botão **Obter chave / comunidade**. Enquanto esse valor estiver vazio, o botão permanece oculto e nenhum link fictício é mostrado ao usuário.

Uma chave validada inteiramente no cliente pode ser lida ou alterada. Para controle de acesso real, use uma API HTTPS sob seu controle, aplique expiração e limitação de tentativas no servidor e nunca inclua segredos no script ou no repositório.
