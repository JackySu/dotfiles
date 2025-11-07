# dotfiles

back up your own neovim/tmux configs by

```bash
cp -r ~/.local/share/nvim ~/.local/share/nvim.bak
cp -r ~/.local/state/nvim ~/.local/share/nvim.bak
cp -r ~/.config/nvim ~/.config/nvim.bak
cp -r ~/.config/tmux ~/.config/tmux.bak
```

and copy the new ones

```bash
cp -r dotfiles/* ~/.config
```

