My neovim configuration
====================

Mainly tested on Windows

# Installation

## Windows

### Packages
```powershell
winget install 7zip.7zip Git.Git LLVM.LLVM Microsoft.VisualStudio.2022.BuildTools Microsoft.PowerShell Python.Python.3.10 OpenJS.NodeJS Neovim.Neovim wez.wezterm Alacritty.Alacritty
```

Note : install rustup and rust env first

```powershell
cargo install starship fd-find ripgrep nu --locked
```

### Neovim
npm install nvim
pip install pynvim

### Symlink
see `setup.bat`

## Linux\BSD

### Packages
Os depedent install : python, nodejs, llvm

```sh
cargo install starship fd-find ripgrep nu --locked
```

### Neovim
npm install nvim
pip install pynvim
