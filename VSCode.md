# Visual Studio Code

- config
    - on linux `~/.config/Code`
    - on windows `~/AppData/Roaming/Code/`

- `User` directory contains the config

## Extensions List

- C/C++ (Microsoft)
- Python (Microsoft)

### tex

- Latex Workshop
    - <https://github.com/James-Yu/LaTeX-Workshop>

### Shell Scripting

- ShellCheck
    - <https://github.com/vscode-shellcheck/vscode-shellcheck>
- ShellMan
    - <https://github.com/yousefvand/shellman>

### Formatters

- Prettier
- shell-format
    - <https://github.com/foxundermoon/vs-shell-format>

### Themes UI

- indent rainbow
    - <https://github.com/oderwat/vscode-indent-rainbow>

### Markdown

- <https://github.com/markmap/markmap-vscode>
- <https://github.com/DavidAnson/vscode-markdownlint>
- <https://github.com/telesoho/vscode-markdown-paste-image>
- <https://github.com/yzhang-gh/vscode-markdown.git>

- you can style the headings individually using these

```json
"editor.tokenColorCustomizations": {
"textMateRules": [
    {
        "scope": "heading.1.markdown entity.name.section.markdown, heading.1.markdown punctuation.definition.heading.markdown",
        "settings": {
            "foreground": "#de6a73",
            "fontStyle": "bold"
        }
    },
    {
        "scope": "heading.2.markdown entity.name.section.markdown, heading.2.markdown punctuation.definition.heading.markdown",
        "settings": {
            "foreground": "#c678dd",
            "fontStyle": "bold"
        }
    },
    {
        "scope": "heading.3.markdown entity.name.section.markdown, heading.3.markdown punctuation.definition.heading.markdown",
        "settings": {
            "foreground": "#98c379",
            "fontStyle": "bold"
        }
    },
    {
        "scope": "heading.4.markdown entity.name.section.markdown, heading.4.markdown punctuation.definition.heading.markdown",
        "settings": {
            "foreground": "#e5c07a",
            "fontStyle": "bold"
        }
    }
]
```