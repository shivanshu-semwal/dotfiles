# Visual Studio Code

- config
    - on linux `~/.config/Code`
    - on windows `~/AppData/Roaming/Code/`

- `User` directory contains the configuration

## Configuration

```json
{
    // Configure glob patterns for excluding files and folders. 
    // For example, the File Explorer decides which files and folders to show or hide based on this setting.
    "files.exclude": {
        "**/.classpath": true,
        "**/.project": true,
        "**/.settings": true,
        "**/.factorypath": true
    },
    // Configure paths or glob patterns to exclude from file watching.
    // Paths can either be relative to the watched folder or absolute.
    "files.watcherExclude": {
        "**/.bloop": true,
        "**/.metals": true,
        "**/.ammonite": true
    },
}
```