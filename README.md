<div align="center">

# 🌆 Hyprland Cyberpunk Dotfiles

[![Hyprland](https://img.shields.io/badge/Hyprland-0.52+-00f3ff?style=for-the-badge&logo=linux&logoColor=white)](https://hyprland.org/)
[![License](https://img.shields.io/badge/License-MIT-ff00ff?style=for-the-badge)](LICENSE)
[![Stars](https://img.shields.io/github/stars/akshaygb/hyprland-cyberpunk-dotfiles?style=for-the-badge&color=00f3ff)](https://github.com/akshaygb/hyprland-cyberpunk-dotfiles/stargazers)

**A futuristic, neon-themed Hyprland rice with glassmorphism effects**

*Neon Dreams • Glass Aesthetics • Futuristic Vibes*

![Cyberpunk Preview](https://raw.githubusercontent.com/akshaygb/hyprland-cyberpunk-dotfiles/main/preview.png)

</div>

---

## ✨ Features

- 🎨 **Cyberpunk Neon Theme** - Cyan (#00f3ff) and Magenta (#ff00ff) color scheme
- 🪟 **Glassmorphism** - Blur effects, transparency, and rounded corners
- 🎬 **Video Wallpaper** - Animated desktop using mpvpaper
- 🔒 **Styled Lock Screen** - Custom hyprlock with video transition
- 📊 **Info Bar** - Feature-rich Waybar with media controls
- 🚀 **App Launcher** - Cyberpunk-themed Rofi
- 🖥️ **Terminal** - Kitty with matching neon colors
- 🔔 **Notifications** - Dunst with cyberpunk styling

---

## 📦 What's Included

| Component | Description |
|-----------|-------------|
| **Hyprland** | Main compositor config with animations |
| **Hyprlock** | Lock screen with neon styling |
| **Hypridle** | Idle management (auto-suspend) |
| **Waybar** | Status bar with media, system stats |
| **Rofi** | App launcher + music popup |
| **Kitty** | Terminal emulator |
| **Dunst** | Notification daemon |

---

## 🖼️ Screenshots

<details>
<summary>Click to expand screenshots</summary>

### Desktop
![Desktop](https://placehold.co/800x450/050a0e/00f3ff?text=Desktop+Preview)

### App Launcher (Rofi)
![Rofi](https://placehold.co/800x450/050a0e/00f3ff?text=Rofi+Launcher)

### Lock Screen
![Lock](https://placehold.co/800x450/050a0e/00f3ff?text=Lock+Screen)

### Waybar
![Waybar](https://placehold.co/800x100/050a0e/00f3ff?text=Waybar)

</details>

---

## 🚀 Installation

### Quick Install (Arch Linux)

```bash
git clone https://github.com/akshaygb/hyprland-cyberpunk-dotfiles.git
cd hyprland-cyberpunk-dotfiles
chmod +x install.sh
./install.sh
```

### Manual Installation

1. **Install Dependencies**

   <details>
   <summary>Arch Linux / Manjaro</summary>

   ```bash
   # Core packages
   sudo pacman -S hyprland hyprlock hypridle xdg-desktop-portal-hyprland
   
   # Status bar & launcher
   sudo pacman -S waybar rofi dunst
   
   # Terminal & utilities
   sudo pacman -S kitty brightnessctl playerctl grim slurp wl-clipboard
   
   # System tray
   sudo pacman -S network-manager-applet blueman polkit-kde-agent
   
   # Fonts & themes
   sudo pacman -S ttf-jetbrains-mono-nerd papirus-icon-theme qt5ct
   
   # AUR packages (using yay)
   yay -S mpvpaper swww bibata-cursor-theme
   ```

   </details>

   <details>
   <summary>Fedora</summary>

   ```bash
   sudo dnf install hyprland hyprlock hypridle xdg-desktop-portal-hyprland
   sudo dnf install waybar rofi dunst kitty brightnessctl playerctl
   sudo dnf install grim slurp wl-clipboard network-manager-applet blueman
   sudo dnf install jetbrains-mono-fonts papirus-icon-theme
   ```

   </details>

   <details>
   <summary>Debian / Ubuntu</summary>

   > ⚠️ Hyprland requires manual compilation or external repos on Debian/Ubuntu.
   > See [Hyprland Wiki](https://wiki.hyprland.org/Getting-Started/Installation/)

   ```bash
   sudo apt install waybar rofi dunst kitty brightnessctl playerctl
   sudo apt install grim slurp wl-clipboard network-manager-gnome blueman
   sudo apt install fonts-jetbrains-mono papirus-icon-theme
   ```

   </details>

2. **Clone & Copy Configs**

   ```bash
   git clone https://github.com/akshaygb/hyprland-cyberpunk-dotfiles.git
   cd hyprland-cyberpunk-dotfiles
   
   # Backup existing configs
   cp -r ~/.config/hypr ~/.config/hypr.bak
   
   # Copy new configs
   cp -r config/* ~/.config/
   
   # Make scripts executable
   chmod +x ~/.config/hypr/scripts/*.sh
   chmod +x ~/.config/waybar/scripts/*
   ```

3. **Add Wallpapers**

   Place your wallpapers in `~/.config/hypr/wallpapers/`:
   
   | File | Purpose |
   |------|---------|
   | `6.mp4` | Main video wallpaper |
   | `lockvideo.mp4` | Lock transition video |
   | `lock_wallpaper.png` | Lock screen background |

4. **Log Out & Select Hyprland**

---

## ⌨️ Keybindings

| Keybinding | Action |
|------------|--------|
| `SUPER + Q` | Open Terminal (Kitty) |
| `SUPER + D` | App Launcher (Rofi) |
| `SUPER + C` | Close Window |
| `SUPER + M` | Exit Hyprland |
| `SUPER + E` | File Manager |
| `SUPER + V` | Toggle Floating |
| `SUPER + L` | Lock Screen |
| `SUPER + H` | Toggle Special Workspace |
| `SUPER + 1-0` | Switch Workspaces |
| `SUPER + SHIFT + 1-0` | Move Window to Workspace |
| `SUPER + Arrow Keys` | Move Focus |
| `SUPER + SHIFT + Arrow Keys` | Move Window |
| `SUPER + SHIFT + S` | Screenshot (Region) |

### Media Controls
| Key | Action |
|-----|--------|
| `XF86AudioRaiseVolume` | Volume Up |
| `XF86AudioLowerVolume` | Volume Down |
| `XF86AudioMute` | Toggle Mute |
| `XF86MonBrightnessUp` | Brightness Up |
| `XF86MonBrightnessDown` | Brightness Down |
| `XF86AudioPlay` | Play/Pause Media |
| `XF86AudioNext` | Next Track |
| `XF86AudioPrev` | Previous Track |

---

## 🎨 Color Palette

| Color | Hex | Usage |
|-------|-----|-------|
| ![#00f3ff](https://placehold.co/20x20/00f3ff/00f3ff) | `#00f3ff` | Primary (Cyan) |
| ![#ff00ff](https://placehold.co/20x20/ff00ff/ff00ff) | `#ff00ff` | Secondary (Magenta) |
| ![#ff5555](https://placehold.co/20x20/ff5555/ff5555) | `#ff5555` | Error/Critical (Red) |
| ![#50fa7b](https://placehold.co/20x20/50fa7b/50fa7b) | `#50fa7b` | Success (Green) |
| ![#bd93f9](https://placehold.co/20x20/bd93f9/bd93f9) | `#bd93f9` | Accent (Purple) |
| ![#050a0e](https://placehold.co/20x20/050a0e/050a0e) | `#050a0e` | Background |
| ![#595959](https://placehold.co/20x20/595959/595959) | `#595959` | Inactive |

---

## 📁 File Structure

```
~/.config/
├── hypr/
│   ├── hyprland.conf      # Main Hyprland config
│   ├── hyprlock.conf      # Lock screen config
│   ├── hypridle.conf      # Idle daemon config
│   ├── scripts/
│   │   ├── lock_with_video.sh    # Video lock transition
│   │   └── random_wallpaper.sh   # Random wallpaper (swww)
│   └── wallpapers/        # Your wallpapers here
├── waybar/
│   ├── config             # Waybar modules config
│   ├── style.css          # Waybar styling
│   └── scripts/
│       ├── mediaplayer.py
│       └── music_popup.sh
├── rofi/
│   ├── launcher.rasi      # App launcher theme
│   └── music-popup.rasi   # Music popup theme
├── kitty/
│   └── kitty.conf         # Terminal config
└── dunst/
    └── dunstrc            # Notifications config
```

---

## 🔧 Customization

### Switch to Static Wallpaper

Edit `~/.config/hypr/hyprland.conf`:

```bash
# Comment out mpvpaper
# exec-once = mpvpaper -o "loop" eDP-1 $HOME/.config/hypr/wallpapers/6.mp4 &

# Uncomment swww
exec-once = swww init &
exec-once = swww img $HOME/.config/hypr/wallpapers/your_wallpaper.png &
```

### Fix Temperature Module

Find your temperature sensor:
```bash
ls /sys/class/hwmon/*/temp1_input
```

Update `~/.config/waybar/config`:
```json
"temperature": {
    "hwmon-path": "/sys/class/hwmon/hwmon0/temp1_input",
    ...
}
```

### Change Opacity

In `~/.config/hypr/hyprland.conf`:
```bash
decoration {
    active_opacity = 0.85    # Increase for less transparency
    inactive_opacity = 0.75
}
```

---

## ❓ Troubleshooting

<details>
<summary><b>Black screen on startup</b></summary>

- Check if your GPU drivers are installed
- Verify monitor config: `hyprctl monitors`
- Try fallback config: `monitor=,preferred,auto,1`

</details>

<details>
<summary><b>Waybar not showing</b></summary>

```bash
killall waybar
waybar &
```

Check for errors: `waybar 2>&1 | head -20`

</details>

<details>
<summary><b>Video wallpaper not working</b></summary>

- Install mpvpaper: `yay -S mpvpaper`
- Check if video exists: `ls ~/.config/hypr/wallpapers/6.mp4`
- Try manually: `mpvpaper -o "loop" eDP-1 ~/.config/hypr/wallpapers/6.mp4`

</details>

<details>
<summary><b>Cursor not showing</b></summary>

Run in terminal:
```bash
hyprctl setcursor Bibata-Modern-Ice 24
```

Or install a cursor theme:
```bash
yay -S bibata-cursor-theme
```

</details>

---

## 🙏 Credits

- [Hyprland](https://hyprland.org/) - The Wayland compositor
- [Dracula Theme](https://draculatheme.com/) - Color inspiration
- [JetBrains Mono](https://www.jetbrains.com/lp/mono/) - Font
- [Papirus Icons](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file.

---

<div align="center">

**Made with 💜 by [akshaygb](https://github.com/akshaygb)**

*If you like this rice, give it a ⭐!*

</div>
