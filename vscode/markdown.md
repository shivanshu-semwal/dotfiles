# Markdown `.md`

- Builtin settings
    <details>
    <summary>Preview</summary>

    ```json
    {
        "markdown.preview.fontFamily": "'Ubuntu', sans-serif",
        "markdown.preview.fontSize": 16,
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
        }
    }
    ```
    </details>
- Markdown Linter <https://github.com/DavidAnson/vscode-markdownlint>
    ```json
    "[markdown]": {
        "editor.defaultFormatter": "DavidAnson.vscode-markdownlint",
    },
    {
        "markdownlint.config": {
            "MD007": {
                "indent": 4
            },
            "MD024": false,
            "MD040": false,
        },
    }
    ```
- Markdown Paste: <https://github.com/telesoho/vscode-markdown-paste-image>
    - paste text in form of markdown
    - paste images
- Markdown all in one: <https://github.com/yzhang-gh/vscode-markdown.git>
    ```json
    {
        "markdown.extension.tableFormatter.normalizeIndentation": true,
        "markdown.extension.math.enabled": false,
    }
    ```
- Markmap: <https://github.com/markmap/markmap-vscode>
    - creates tree from the markdown file
