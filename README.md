# dotfiles

Personal Arch Linux rice for the ThinkPad P14s Gen 2.
Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Stack

| Layer | Tool |
|---|---|
| Window Manager | [Niri](https://github.com/YaLTeR/niri) |
| Shell | [Fish](https://fishshell.com/) |
| Prompt | [Starship](https://starship.rs/) |
| Terminal | [Alacritty](https://alacritty.org/) |
| Bar | [Waybar](https://github.com/Alexays/Waybar) |
| Launcher | [Fuzzel](https://codeberg.org/dnkl/fuzzel) |
| Notifications | [Mako](https://github.com/emersion/mako) |
| GTK Theme | [Gruvbox-Material](https://github.com/sainnhe/gruvbox-material) |
| Login Screen | [greetd](https://git.sr.ht/~kennylevinsen/greetd) + [tuigreet](https://github.com/apognu/tuigreet) |
| Firewall | [nftables](https://nftables.org/) |
| Font | [JetBrainsMono Nerd Font](https://www.nerdfonts.com/) |
| Color scheme | [Gruvbox Dark](https://github.com/morhetz/gruvbox) |

---

## Prerequisites

### AUR helper

Install `paru` before anything else:

```bash
sudo pacman -S --needed base-devel git
cd /tmp
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

### Packages

Install all required packages in one go:

```bash
# Official repos
sudo pacman -S \
  fish starship alacritty \
  waybar playerctl \
  fuzzel \
  mako libnotify \
  nwg-look gnome-themes-extra gtk4 \
  qt5ct qt6ct kvantum \
  greetd-tuigreet \
  nftables \
  ttf-jetbrains-mono-nerd \
  brightnessctl \
  networkmanager \
  pipewire pipewire-pulse wireplumber \
  stow git

# AUR
paru -S \
  gruvbox-material-gtk-theme-git \
  gruvbox-material-icon-theme-git
```

---

## Installation

### 1. Clone the repo

```bash
git clone git@github.com:ghoulli/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Stow configs

Each folder maps to a package. Stow symlinks them into your home directory:

```bash
stow alacritty
stow fish
stow starship
stow waybar
stow fuzzel
stow mako
stow gtk
stow niri
```

Or all at once:

```bash
stow alacritty fish starship waybar fuzzel mako gtk niri
```

### 3. greetd (login screen)

greetd lives in `/etc` so it can't be stowed. Copy it manually:

```bash
cd ~/dotfiles/greetd
bash install.sh
```

Or manually:

```bash
sudo cp ~/dotfiles/greetd/etc/greetd/config.toml /etc/greetd/config.toml
sudo usermod -aG video greeter
sudo systemctl disable lightdm
sudo systemctl enable greetd
```

### 4. nftables (firewall)

```bash
cd ~/dotfiles/nftables
bash install.sh
```

Or manually:

```bash
sudo cp ~/dotfiles/nftables/etc/nftables.conf /etc/nftables.conf
sudo systemctl enable --now nftables
```

> **Note:** SSH is only allowed from `192.168.2.0/24`. All other incoming traffic is dropped.

### 5. GTK dark mode

Apply GTK settings via gsettings:

```bash
gsettings set org.gnome.desktop.interface gtk-theme 'Gruvbox-Material-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Gruvbox-Material-Dark'
gsettings set org.gnome.desktop.interface font-name 'JetBrainsMono Nerd Font 11'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
gsettings set org.gnome.desktop.interface cursor-size 24
```

### 6. Shell

Set Fish as your login shell:

```bash
echo /usr/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/bin/fish
```

### 7. Audio & brightness

Enable PipeWire session manager:

```bash
systemctl --user enable --now pipewire-pulse wireplumber
```

Add your user to the `video` group for brightness control:

```bash
sudo usermod -aG video $USER
```

Log out and back in for the group change to take effect.

---

## Repository structure

```
dotfiles/
├── alacritty/
│   └── .config/
│       └── alacritty/
│           └── alacritty.toml        # Terminal config, Gruvbox colors, Fish shell
├── fish/
│   └── .config/
│       └── fish/
│           └── config.fish           # Starship init, aliases, Qt env vars
├── starship/
│   └── .config/
│       └── starship.toml             # Prompt config, Gruvbox theme
├── waybar/
│   └── .config/
│       └── waybar/
│           ├── config.jsonc          # Bar layout, modules
│           └── style.css             # Gruvbox styling, transparency, rounded corners
├── fuzzel/
│   └── .config/
│       └── fuzzel/
│           └── fuzzel.ini            # App launcher, Gruvbox colors
├── mako/
│   └── .config/
│       └── mako/
│           └── config                # Notification daemon, Gruvbox colors
├── gtk/
│   └── .config/
│       ├── gtk-3.0/
│       │   └── settings.ini          # GTK3 theme, dark mode
│       └── gtk-4.0/
│           └── settings.ini          # GTK4 theme, dark mode
├── niri/
│   └── .config/
│       └── niri/
│           └── config.kdl            # WM config, keybinds, Gruvbox focus ring
├── greetd/
│   ├── etc/
│   │   └── greetd/
│   │       └── config.toml           # Login screen config (copy manually to /etc)
│   └── install.sh
└── nftables/
    ├── etc/
    │   └── nftables.conf             # Firewall rules (copy manually to /etc)
    └── install.sh
```

---

## Keybinds

| Keybind | Action |
|---|---|
| `Mod+T` | Open terminal (Alacritty) |
| `Mod+D` | Open launcher (Fuzzel) |
| `Mod+Q` | Close window |
| `Mod+H/J/K/L` | Focus left/down/up/right |
| `Mod+Ctrl+H/J/K/L` | Move window left/down/up/right |
| `Mod+1-9` | Switch to workspace |
| `Mod+Ctrl+1-9` | Move window to workspace |
| `Mod+F` | Maximize column |
| `Mod+Shift+F` | Fullscreen window |
| `Mod+V` | Toggle floating |
| `Mod+R` | Cycle column widths |
| `Mod+C` | Center column |
| `Mod+O` | Toggle overview |
| `Mod+Shift+E` | Quit niri |
| `Super+Alt+L` | Lock screen |
| `Print` | Screenshot |
| `Ctrl+Print` | Screenshot screen |
| `Alt+Print` | Screenshot window |

---

## Notes

- Alacritty is configured to launch Fish directly — Bash remains the system shell
- Waybar wifi module opens `nmtui` in Alacritty on click for network switching
- The mpris module in Waybar picks up any MPRIS-compatible player automatically (Spotify, Firefox, etc.)
- greetd replaces LightDM — if something goes wrong at login, switch to TTY2 with `Ctrl+Alt+F2` and re-enable LightDM:

```bash
sudo systemctl disable greetd
sudo systemctl enable lightdm
sudo reboot
```
