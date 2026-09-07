# HMenu Roblox

Interface modular em Luau com sistema de chave, navegação por categorias e dados de demonstração.

## Carregamento

Depois que todos os arquivos estiverem na branch `main`, execute:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Manoel2k67/hmenu_roblox/main/KeySystem.lua"))()
```

O link precisa apontar para o conteúdo **raw** e não deve ter colchetes de Markdown dentro do código. O carregador baixa o menu, a configuração e as categorias automaticamente.

## Controles

- Digite qualquer chave não vazia e clique em **Validar e abrir** ou pressione Enter.
- Use **RightShift** (o Shift abaixo do Enter) para ocultar e mostrar o menu.
- Arraste a barra superior para mover a janela.
- O botão `×` apenas oculta o menu; RightShift abre novamente.

## Estrutura

```text
KeySystem.lua          entrada pública e validação da chave
HMenu.lua              janela, navegação e componentes reutilizáveis
HMenuConfig.lua        tema, tamanho, atalho e lista de categorias
categories/            conteúdo de cada página
  Main.lua
  Visuals.lua
  ...
```

Para criar uma categoria, copie um arquivo em `categories/`, altere seus dados e inclua o caminho em `Config.CategoryModules`, dentro de `HMenuConfig.lua`.

Controles disponíveis: `Toggle`, `Slider`, `Dropdown`, `Button` e `Paragraph`. Cada controle pode receber uma função `Callback`; enquanto não houver lógica conectada, os valores permanecem apenas no estado da interface.

Exemplo:

```lua
{
    Kind = "Toggle",
    Id = "my_option",
    Label = "Minha opção",
    Default = false,
    Callback = function(enabled, state)
        print("Minha opção:", enabled)
    end,
}
```

## Chaves

O modo atual aceita qualquer chave não vazia porque `ACCEPT_ANY_NON_EMPTY_KEY` está como `true` no `KeySystem.lua`. Isso serve apenas para a fase de interface. Uma chave validada inteiramente no cliente pode ser lida ou alterada; para controle de acesso real, use validação em um serviço remoto sob seu controle e nunca coloque segredos no repositório.
