<div align="center">

# 🌆 Hyprland Cyberpunk Dotfiles

[![Hyprland](https://img.shields.io/badge/Hyprland-0.40+-00f3ff?style=for-the-badge&logo=linux&logoColor=white)](https://hyprland.org/)
[![License](https://img.shields.io/badge/License-MIT-ff00ff?style=for-the-badge)](LICENSE)
[![Arch](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)](https://archlinux.org/)

**A futuristic, neon-themed Hyprland rice with glassmorphism effects**

*Neon Dreams • Glass Aesthetics • Futuristic Vibes*

</div>

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🎨 **Cyberpunk Theme** | Cyan (#00f3ff) and Magenta (#ff00ff) neon colors |
| 🪟 **Glassmorphism** | Blur, transparency, and rounded corners everywhere |
| 🎬 **Video Wallpaper** | Optional animated desktop using mpvpaper |
| 🔒 **Styled Lock Screen** | Custom hyprlock with neon styling |
| 📊 **Info Bar** | Feature-rich Waybar with system stats |
| 🚀 **App Launcher** | Cyberpunk-themed Rofi |
| 🖥️ **Terminal** | Kitty with matching neon colors |
| 🔔 **Notifications** | Dunst with cyberpunk styling |
| 📸 **Screenshots** | Region, window, and fullscreen capture |

---

## 📦 Components

| Component | Config File | Description |
|-----------|-------------|-------------|
| **Hyprland** | `hyprland.conf` | Window manager with animations |
| **Hyprlock** | `hyprlock.conf` | Neon lock screen |
| **Hypridle** | `hypridle.conf` | Auto-lock and suspend |
| **Waybar** | `config`, `style.css` | Status bar |
| **Rofi** | `launcher.rasi` | Application launcher |
| **Kitty** | `kitty.conf` | Terminal emulator |
| **Dunst** | `dunstrc` | Notifications |

---

## 🚀 Installation

### Quick Install (Recommended)

```bash
git clone https://github.com/AKSHAY-RSOL/hyprland-cyberpunk-dotfiles.git
cd hyprland-cyberpunk-dotfiles
chmod +x install.sh
./install.sh
```

### Manual Installation

<details>
<summary><b>1. Install Dependencies</b></summary>

#### Arch Linux / EndeavourOS / Manjaro

```bash
# Core
sudo pacman -S hyprland hyprlock hypridle xdg-desktop-portal-hyprland

# Bar, launcher, notifications
sudo pacman -S waybar rofi dunst

# Terminal and utilities
sudo pacman -S kitty brightnessctl playerctl grim slurp wl-clipboard jq

# System tray apps
sudo pacman -S network-manager-applet blueman polkit-kde-agent

# Fonts and themes
sudo pacman -S ttf-jetbrains-mono-nerd papirus-icon-theme qt5ct

# AUR packages (optional, for video wallpaper)
yay -S mpvpaper swww bibata-cursor-theme
```

#### Fedora

```bash
sudo dnf install hyprland hyprlock hypridle xdg-desktop-portal-hyprland \
    waybar rofi dunst kitty brightnessctl playerctl grim slurp wl-clipboard \
    network-manager-applet blueman polkit jetbrains-mono-fonts papirus-icon-theme
```

</details>

<details>
<summary><b>2. Copy Configuration Files</b></summary>

```bash
# Backup existing configs
mkdir -p ~/.config-backup
cp -r ~/.config/hypr ~/.config-backup/ 2>/dev/null

# Clone and copy
git clone https://github.com/AKSHAY-RSOL/hyprland-cyberpunk-dotfiles.git
cd hyprland-cyberpunk-dotfiles
cp -r config/* ~/.config/

# Make scripts executable
chmod +x ~/.config/hypr/scripts/*.sh
```

</details>

<details>
<summary><b>3. Add Wallpapers</b></summary>

Add your wallpapers to `~/.config/hypr/wallpapers/`:

| File | Purpose | Required |
|------|---------|----------|
| `video.mp4` | Desktop video wallpaper | Optional |
| `wallpaper.png` | Static wallpaper fallback | Yes |
| `lock_wallpaper.png` | Lock screen background | Yes |
| `lockvideo.mp4` | Lock transition video | Optional |

**Wallpaper Sources:**
- [Wallhaven](https://wallhaven.cc/search?q=cyberpunk)
- [r/wallpapers](https://reddit.com/r/wallpapers)

</details>

---

## ⌨️ Keybindings

### Essential

| Key | Action |
|-----|--------|
| `SUPER + Q` | Open Terminal |
| `SUPER + D` | App Launcher |
| `SUPER + C` | Close Window |
| `SUPER + M` | Exit Hyprland |
| `SUPER + L` | Lock Screen |
| `SUPER + E` | File Manager |

### Windows

| Key | Action |
|-----|--------|
| `SUPER + V` | Toggle Floating |
| `SUPER + F` | Fullscreen |
| `SUPER + Arrow` | Move Focus |
| `SUPER + SHIFT + Arrow` | Move Window |
| `SUPER + CTRL + Arrow` | Resize Window |

### Workspaces

| Key | Action |
|-----|--------|
| `SUPER + 1-0` | Switch Workspace |
| `SUPER + SHIFT + 1-0` | Move to Workspace |
| `SUPER + H` | Special Workspace |
| `SUPER + Scroll` | Cycle Workspaces |

### Screenshots

| Key | Action |
|-----|--------|
| `Print` | Full Screen |
| `SUPER + Print` | Active Window |
| `SUPER + SHIFT + S` | Select Region |

### Media

| Key | Action |
|-----|--------|
| `XF86AudioRaiseVolume` | Volume Up |
| `XF86AudioLowerVolume` | Volume Down |
| `XF86AudioMute` | Toggle Mute |
| `XF86AudioPlay` | Play/Pause |
| `XF86MonBrightness*` | Brightness |

---

## 🎨 Color Palette

| Color | Hex | Usage |
|-------|-----|-------|
| 🔵 Cyan | `#00f3ff` | Primary, borders, highlights |
| 🟣 Magenta | `#ff00ff` | Secondary, accents |
| 🔴 Red | `#ff5555` | Errors, critical |
| 🟢 Green | `#50fa7b` | Success, battery |
| 🟣 Purple | `#bd93f9` | Memory, accents |
| ⚫ Background | `#050a0e` | Dark base |

---

## 📁 File Structure

```
~/.config/
├── hypr/
│   ├── hyprland.conf         # Main config
│   ├── hyprlock.conf         # Lock screen
│   ├── hypridle.conf         # Idle management
│   ├── scripts/
│   │   ├── screenshot.sh     # Screenshot utility
│   │   ├── lock.sh           # Lock with video
│   │   ├── wallpaper.sh      # Random wallpaper
│   │   └── tablet_mode.sh    # External display
│   └── wallpapers/           # Your wallpapers
├── waybar/
│   ├── config                # Modules config
│   └── style.css             # Styling
├── rofi/
│   └── launcher.rasi         # App launcher theme
├── kitty/
│   └── kitty.conf            # Terminal config
└── dunst/
    └── dunstrc               # Notifications
```

---

## 🔧 Customization

### Switch to Static Wallpaper

Edit `~/.config/hypr/hyprland.conf`:

```bash
# Comment video wallpaper:
# exec-once = mpvpaper -o "loop" eDP-1 ~/.config/hypr/wallpapers/video.mp4

# Uncomment static wallpaper:
exec-once = swww init
exec-once = sleep 1 && swww img ~/.config/hypr/wallpapers/wallpaper.png
```

### Adjust Transparency

In `~/.config/hypr/hyprland.conf`:

```bash
decoration {
    active_opacity = 0.90    # 1.0 = fully opaque
    inactive_opacity = 0.80
}
```

### Change Blur Intensity

```bash
blur {
    size = 10      # Increase for more blur
    passes = 4     # More passes = smoother
}
```

---

## ❓ Troubleshooting

<details>
<summary><b>Waybar not showing</b></summary>

```bash
killall waybar
waybar &

# Check for errors
waybar 2>&1 | head -20
```
</details>

<details>
<summary><b>Video wallpaper not working</b></summary>

1. Install mpvpaper: `yay -S mpvpaper`
2. Check video exists: `ls ~/.config/hypr/wallpapers/video.mp4`
3. Test manually: `mpvpaper -o "loop" eDP-1 ~/.config/hypr/wallpapers/video.mp4`
</details>

<details>
<summary><b>Screenshots not saving</b></summary>

```bash
# Check dependencies
which grim slurp wl-copy

# Create screenshot directory
mkdir -p ~/Pictures/Screenshots

# Test manually
grim ~/test.png
```
</details>

<details>
<summary><b>Cursor not visible</b></summary>

```bash
# Install cursor theme
yay -S bibata-cursor-theme

# Set cursor
hyprctl setcursor Bibata-Modern-Ice 24
```
</details>

---

## 🙏 Credits

- [Hyprland](https://hyprland.org/) - The amazing Wayland compositor
- [JetBrains Mono](https://www.jetbrains.com/lp/mono/) - Beautiful font
- [Papirus Icons](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
- [Dracula Theme](https://draculatheme.com/) - Color inspiration

---

## 📄 License

MIT License - See [LICENSE](LICENSE)

---

<div align="center">

**Made with 💜 by [AKSHAY-RSOL](https://github.com/AKSHAY-RSOL)**

*If you like this rice, give it a ⭐!*

</div>
