# Computer playground - Windows

## Desktop Navigation
Stop smart aerosnapping: https://botcrawl.com/when-i-snap-a-window-show-what-i-can-snap-next-to-it-windows-10/

Go to `Settings > System > Multitasking`
![](https://botcrawl.com/wp-content/uploads/2015/07/When-I-snap-a-window-show-what-I-can-snap-next-to-it-Windows-10.png)

## Hyper-V and VMWare/WSL
Linux Sub-system and VMWare need to access the same Hyper-V system, which breaks.
Updating VMWare, or waiting for the new Linux Sub-system release will work.
https://blogs.vmware.com/workstation/2020/01/vmware-workstation-tech-preview-20h1.html (updated March 2020)

### VMWare Tech Preview
[Download link](Direct Download Link) to 20H1 Tech Preview: https://blogs.vmware.com/workstation

![](https://578202.smushcdn.com/777453/wp-content/uploads/2020/01/The-new-Tech-Preview-user-interface.png?lossy=1&strip=1&webp=1)

### Disabling Hyper-V
This will deactivate WSL

```bash
# disabling with admin priveleges
bcdedit /set hypervisorlaunchtype off

# enabling with admin priveleges
bcdedit /set hypervisorlaunchtype auto

# need to restart
```

### Enabling WSL
https://code.visualstudio.com/remote-tutorials/wsl/enable-wsl#_check

_Using Windows Feature Dialog_
![](https://code.visualstudio.com/assets/remote-tutorials/wsl/windows-features.png)

_Using Admin PowerShell_
```bash
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```

![](https://code.visualstudio.com/assets/remote-tutorials/wsl/powershell-output.png)

## Windows Terminal (preview)
Install Windows Terminal: https://github.com/microsoft/terminal
![](https://i0.wp.com/www.onmsft.com/wp-content/uploads/2019/06/Windows-Terminal-Microsoft-Promo.png?fit=1365%2C768&ssl=1)

## Nodejs installation
Install nvm: https://github.com/coreybutler/nvm-windows
![](https://camo.githubusercontent.com/7a297909471d50f1a8afc353ecb5a07f9eb54e83/687474703a2f2f692e696d6775722e636f6d2f424e6c636269342e706e67)

## Unix Commands

### WSL bash
```bash
bash
```

### Cash
Install CASH: https://github.com/dthree/cash

```bash
# get commands
npm install cash -g

# run to get all commands as global
npm install cash-global -g
```

### Cygwin

### MGWWin32

### Github

## Checking Build
```cmd
winver
```

![](https://support.techsmith.com/hc/article_attachments/115002725732/2017-10-11_8-39-12.png)

## Hotkeys
