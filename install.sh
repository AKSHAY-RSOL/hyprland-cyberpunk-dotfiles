#!/bin/bash

#  ██████╗██╗   ██╗██████╗ ███████╗██████╗ ██████╗ ██╗   ██╗███╗   ██╗██╗  ██╗
# ██╔════╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔══██╗██║   ██║████╗  ██║██║ ██╔╝
# ██║      ╚████╔╝ ██████╔╝█████╗  ██████╔╝██████╔╝██║   ██║██╔██╗ ██║█████╔╝ 
# ██║       ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗██╔═══╝ ██║   ██║██║╚██╗██║██╔═██╗ 
# ╚██████╗   ██║   ██████╔╝███████╗██║  ██║██║     ╚██████╔╝██║ ╚████║██║  ██╗
#  ╚═════╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝
#
# Hyprland Cyberpunk Dotfiles Installer
# https://github.com/AKSHAY-RSOL/hyprland-cyberpunk-dotfiles

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_banner() {
    echo -e "${CYAN}"
    echo "╔═══════════════════════════════════════════════════════════════╗"
    echo "║     🌆 HYPRLAND CYBERPUNK DOTFILES INSTALLER 🌆              ║"
    echo "║                                                               ║"
    echo "║  Neon Dreams • Glass Aesthetics • Futuristic Vibes           ║"
    echo "╚═══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_step() { echo -e "${MAGENTA}[*]${NC} $1"; }
print_success() { echo -e "${GREEN}[✓]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[!]${NC} $1"; }
print_error() { echo -e "${RED}[✗]${NC} $1"; }

# Detect package manager
detect_package_manager() {
    if command -v pacman &> /dev/null; then
        PKG_MANAGER="pacman"
        PKG_INSTALL="sudo pacman -S --noconfirm --needed"
    elif command -v apt &> /dev/null; then
        PKG_MANAGER="apt"
        PKG_INSTALL="sudo apt install -y"
    elif command -v dnf &> /dev/null; then
        PKG_MANAGER="dnf"
        PKG_INSTALL="sudo dnf install -y"
    else
        print_error "No supported package manager found!"
        exit 1
    fi
    print_success "Detected: $PKG_MANAGER"
}

# Install dependencies
install_dependencies() {
    print_step "Installing dependencies..."
    
    case $PKG_MANAGER in
        pacman)
            $PKG_INSTALL hyprland hyprlock hypridle xdg-desktop-portal-hyprland \
                waybar rofi dunst kitty brightnessctl playerctl grim slurp wl-clipboard jq \
                network-manager-applet blueman polkit-kde-agent \
                ttf-jetbrains-mono-nerd papirus-icon-theme qt5ct
            
            # Check for AUR helper
            if command -v yay &> /dev/null; then
                print_step "Installing AUR packages..."
                yay -S --noconfirm --needed mpvpaper swww bibata-cursor-theme 2>/dev/null || true
            elif command -v paru &> /dev/null; then
                print_step "Installing AUR packages..."
                paru -S --noconfirm --needed mpvpaper swww bibata-cursor-theme 2>/dev/null || true
            else
                print_warning "No AUR helper found. Install yay/paru for video wallpaper support."
            fi
            ;;
        apt)
            print_warning "Hyprland may require manual installation on Debian/Ubuntu"
            $PKG_INSTALL waybar rofi dunst kitty brightnessctl playerctl grim slurp wl-clipboard jq \
                network-manager-gnome blueman fonts-jetbrains-mono papirus-icon-theme || true
            ;;
        dnf)
            $PKG_INSTALL hyprland hyprlock hypridle xdg-desktop-portal-hyprland \
                waybar rofi dunst kitty brightnessctl playerctl grim slurp wl-clipboard jq \
                network-manager-applet blueman jetbrains-mono-fonts papirus-icon-theme || true
            ;;
    esac
    
    print_success "Dependencies installed!"
}

# Backup configs
backup_configs() {
    print_step "Backing up existing configs..."
    
    BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    for dir in hypr waybar rofi kitty dunst; do
        if [ -d "$HOME/.config/$dir" ]; then
            cp -r "$HOME/.config/$dir" "$BACKUP_DIR/"
            print_success "Backed up $dir"
        fi
    done
    
    echo -e "  Backup location: ${CYAN}$BACKUP_DIR${NC}"
}

# Install dotfiles
install_dotfiles() {
    print_step "Installing dotfiles..."
    
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Create directories
    mkdir -p "$HOME/.config/hypr/scripts"
    mkdir -p "$HOME/.config/hypr/wallpapers"
    mkdir -p "$HOME/.config/waybar"
    mkdir -p "$HOME/.config/rofi"
    mkdir -p "$HOME/.config/kitty"
    mkdir -p "$HOME/.config/dunst"
    mkdir -p "$HOME/Pictures/Screenshots"
    
    # Copy configs
    cp -r "$SCRIPT_DIR/config/hypr/"* "$HOME/.config/hypr/"
    cp -r "$SCRIPT_DIR/config/waybar/"* "$HOME/.config/waybar/"
    cp -r "$SCRIPT_DIR/config/rofi/"* "$HOME/.config/rofi/"
    cp -r "$SCRIPT_DIR/config/kitty/"* "$HOME/.config/kitty/"
    cp -r "$SCRIPT_DIR/config/dunst/"* "$HOME/.config/dunst/"
    
    # Make scripts executable
    chmod +x "$HOME/.config/hypr/scripts/"*.sh 2>/dev/null || true
    
    print_success "Dotfiles installed!"
}

# Print final instructions
print_instructions() {
    echo ""
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                  🎉 INSTALLATION COMPLETE! 🎉                 ║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${MAGENTA}📝 NEXT STEPS:${NC}"
    echo ""
    echo -e "  ${GREEN}1.${NC} Add wallpapers to ${CYAN}~/.config/hypr/wallpapers/${NC}"
    echo -e "     • ${YELLOW}wallpaper.png${NC} - Static wallpaper"
    echo -e "     • ${YELLOW}lock_wallpaper.png${NC} - Lock screen background"
    echo -e "     • ${YELLOW}video.mp4${NC} - Video wallpaper (optional)"
    echo ""
    echo -e "  ${GREEN}2.${NC} Log out and select ${MAGENTA}Hyprland${NC} from your display manager"
    echo ""
    echo -e "${MAGENTA}⌨️  QUICK KEYS:${NC}"
    echo -e "  ${CYAN}SUPER + Q${NC}       → Terminal"
    echo -e "  ${CYAN}SUPER + D${NC}       → App Launcher"
    echo -e "  ${CYAN}SUPER + C${NC}       → Close Window"
    echo -e "  ${CYAN}SUPER + L${NC}       → Lock Screen"
    echo -e "  ${CYAN}SUPER + SHIFT+S${NC} → Screenshot"
    echo ""
    echo -e "${GREEN}Enjoy your Cyberpunk desktop! 🌆${NC}"
    echo ""
}

# Main
main() {
    print_banner
    
    echo -e "${YELLOW}This will install Hyprland Cyberpunk dotfiles.${NC}"
    echo -e "${YELLOW}Existing configs will be backed up.${NC}"
    echo ""
    read -p "Continue? (y/N): " -n 1 -r
    echo ""
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_error "Installation cancelled."
        exit 1
    fi
    
    detect_package_manager
    
    echo ""
    read -p "Install dependencies? (y/N): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_dependencies
    fi
    
    backup_configs
    install_dotfiles
    print_instructions
}

# Help
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Usage: ./install.sh"
    echo ""
    echo "Installs Hyprland Cyberpunk dotfiles to ~/.config/"
    echo "Existing configs are backed up automatically."
    exit 0
fi

main "$@"
