# Miscellaneous

- intellicode
    ```json
    {
        "vsintellicode.modify.editor.suggestSelection": "automaticallyOverrodeDefaultValue",
    }
    ```

- rewrap: <https://github.com/stkb/Rewrap>
    ```json
    {
        "rewrap.wrappingColumn": 100,
    }
    ```
    - used to wrap long lines

- indent rainbow: <https://github.com/oderwat/vscode-indent-rainbow>
    ```json
    {
        "indentRainbow.errorColor": "rgba(141,143,148,0.0)", 
    }
    ```
    - color intdentation with different colors
    - useful for programming which support strucutres with indent

- prettier: <https://github.com/prettier/prettier-vscode>
    ```json
    {
        "prettier.printWidth": 100,
        // set it for css oly
        "[css]": {
            "editor.defaultFormatter": "esbenp.prettier-vscode"
        },
    }
    ```