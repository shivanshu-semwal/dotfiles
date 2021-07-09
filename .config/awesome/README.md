# awesome-wm dotfiles

- [rc.lua](./rc.lua) - main config file
- [themes/default/theme.lua](./themes/default/theme.lua) - theme I use
- [configuration/autostart.lua](./configuration/autostart.lua) - programs to autostart
- [configuration/keys.lua](./configuration/keys.lua) - keybindings
- [configuration/menus.lua](./configuration/menus.lua) - menu configuration
- [rc.old.lua](./rc.old.lua) - for backup purposes, default config

## System Info

- **OS** - `Ubuntu 20.04.2 LTS x86_64`
- **awesome-wm** - latest git [release](https://github.com/awesomeWM/awesome/releases/tag/v4.3) `v4.3`
- **picom** - build from [github](https://github.com/yshui/picom)

## How I installed `awesome-wm`

```
wget https://github.com/awesomeWM/awesome/releases/download/v4.3/awesome-4.3.tar.bz2
tar xjf awesome-4.3.tar.bz2
sudo apt build-dep awesome
cd awesome-4.3
make package
cd build
sudo apt install *.deb
```