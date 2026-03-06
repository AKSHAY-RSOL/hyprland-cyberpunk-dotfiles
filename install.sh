#!/bin/bash

#  ██████╗██╗   ██╗██████╗ ███████╗██████╗ ██████╗ ██╗   ██╗███╗   ██╗██╗  ██╗
# ██╔════╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔══██╗██║   ██║████╗  ██║██║ ██╔╝
# ██║      ╚████╔╝ ██████╔╝█████╗  ██████╔╝██████╔╝██║   ██║██╔██╗ ██║█████╔╝ 
# ██║       ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗██╔═══╝ ██║   ██║██║╚██╗██║██╔═██╗ 
# ╚██████╗   ██║   ██████╔╝███████╗██║  ██║██║     ╚██████╔╝██║ ╚████║██║  ██╗
#  ╚═════╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝
#
# Hyprland Cyberpunk Dotfiles Installer
# https://github.com/akshaygb/hyprland-cyberpunk-dotfiles

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_banner() {
    echo -e "${CYAN}"
    echo "╔═══════════════════════════════════════════════════════════════╗"
    echo "║     🌆 HYPRLAND CYBERPUNK DOTFILES INSTALLER 🌆              ║"
    echo "║                                                               ║"
    echo "║  Neon Dreams • Glass Aesthetics • Futuristic Vibes           ║"
    echo "╚═══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_step() {
    echo -e "${MAGENTA}[*]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

# Detect package manager
detect_package_manager() {
    if command -v pacman &> /dev/null; then
        PKG_MANAGER="pacman"
        PKG_INSTALL="sudo pacman -S --noconfirm --needed"
        AUR_HELPER=""
        if command -v yay &> /dev/null; then
            AUR_HELPER="yay"
        elif command -v paru &> /dev/null; then
            AUR_HELPER="paru"
        fi
    elif command -v apt &> /dev/null; then
        PKG_MANAGER="apt"
        PKG_INSTALL="sudo apt install -y"
    elif command -v dnf &> /dev/null; then
        PKG_MANAGER="dnf"
        PKG_INSTALL="sudo dnf install -y"
    elif command -v zypper &> /dev/null; then
        PKG_MANAGER="zypper"
        PKG_INSTALL="sudo zypper install -y"
    else
        print_error "No supported package manager found!"
        exit 1
    fi
    print_success "Detected package manager: $PKG_MANAGER"
}

# Install dependencies based on distro
install_dependencies() {
    print_step "Installing dependencies..."
    
    # Common packages (names may vary by distro)
    COMMON_PKGS="kitty waybar rofi dunst brightnessctl playerctl grim slurp wl-clipboard"
    
    case $PKG_MANAGER in
        pacman)
            # Arch Linux / Manjaro
            PKGS="hyprland hyprlock hypridle hyprpaper xdg-desktop-portal-hyprland"
            PKGS="$PKGS $COMMON_PKGS"
            PKGS="$PKGS polkit-kde-agent network-manager-applet blueman"
            PKGS="$PKGS ttf-jetbrains-mono-nerd papirus-icon-theme"
            PKGS="$PKGS qt5ct libva-intel-driver"
            
            $PKG_INSTALL $PKGS
            
            # AUR packages (optional)
            if [ -n "$AUR_HELPER" ]; then
                print_step "Installing AUR packages..."
                $AUR_HELPER -S --noconfirm --needed mpvpaper swww bibata-cursor-theme 2>/dev/null || true
            else
                print_warning "No AUR helper found. Install yay/paru for mpvpaper, swww, bibata-cursor"
            fi
            ;;
        apt)
            # Debian / Ubuntu (Hyprland may need external repo)
            print_warning "Hyprland on Debian/Ubuntu requires manual installation or external repos"
            print_warning "See: https://wiki.hyprland.org/Getting-Started/Installation/"
            PKGS="$COMMON_PKGS"
            PKGS="$PKGS polkit-kde-agent-1 network-manager-gnome blueman"
            PKGS="$PKGS fonts-jetbrains-mono papirus-icon-theme"
            
            sudo apt update
            $PKG_INSTALL $PKGS || true
            ;;
        dnf)
            # Fedora
            PKGS="hyprland hyprlock hypridle xdg-desktop-portal-hyprland"
            PKGS="$PKGS $COMMON_PKGS"
            PKGS="$PKGS polkit-kde network-manager-applet blueman"
            PKGS="$PKGS jetbrains-mono-fonts papirus-icon-theme"
            
            $PKG_INSTALL $PKGS || true
            ;;
        zypper)
            # openSUSE
            print_warning "Hyprland on openSUSE may need OBS repos"
            PKGS="$COMMON_PKGS"
            $PKG_INSTALL $PKGS || true
            ;;
    esac
    
    print_success "Dependencies installed!"
}

# Backup existing configs
backup_configs() {
    print_step "Backing up existing configurations..."
    
    BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    for dir in hypr waybar rofi kitty dunst; do
        if [ -d "$HOME/.config/$dir" ]; then
            cp -r "$HOME/.config/$dir" "$BACKUP_DIR/"
            print_success "Backed up $dir to $BACKUP_DIR"
        fi
    done
}

# Install dotfiles
install_dotfiles() {
    print_step "Installing dotfiles..."
    
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Create config directories
    mkdir -p "$HOME/.config/hypr/scripts"
    mkdir -p "$HOME/.config/hypr/wallpapers"
    mkdir -p "$HOME/.config/waybar/scripts"
    mkdir -p "$HOME/.config/rofi"
    mkdir -p "$HOME/.config/kitty"
    mkdir -p "$HOME/.config/dunst"
    
    # Copy configurations
    cp -r "$SCRIPT_DIR/config/hypr/"* "$HOME/.config/hypr/"
    cp -r "$SCRIPT_DIR/config/waybar/"* "$HOME/.config/waybar/"
    cp -r "$SCRIPT_DIR/config/rofi/"* "$HOME/.config/rofi/"
    cp -r "$SCRIPT_DIR/config/kitty/"* "$HOME/.config/kitty/"
    
    # Make scripts executable
    chmod +x "$HOME/.config/hypr/scripts/"*.sh 2>/dev/null || true
    chmod +x "$HOME/.config/waybar/scripts/"*.sh 2>/dev/null || true
    chmod +x "$HOME/.config/waybar/scripts/"*.py 2>/dev/null || true
    
    print_success "Dotfiles installed!"
}

# Post-install setup
post_install() {
    print_step "Running post-install setup..."
    
    # Set cursor theme
    if command -v gsettings &> /dev/null; then
        gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice' 2>/dev/null || true
        gsettings set org.gnome.desktop.interface cursor-size 24 2>/dev/null || true
    fi
    
    # Create default dunst config if not exists
    if [ ! -f "$HOME/.config/dunst/dunstrc" ]; then
        mkdir -p "$HOME/.config/dunst"
        cat > "$HOME/.config/dunst/dunstrc" << 'EOF'
[global]
    monitor = 0
    follow = mouse
    width = 300
    height = 300
    origin = top-right
    offset = 10x50
    scale = 0
    notification_limit = 5
    progress_bar = true
    indicate_hidden = yes
    transparency = 20
    separator_height = 2
    padding = 15
    horizontal_padding = 15
    text_icon_padding = 0
    frame_width = 2
    frame_color = "#00f3ff"
    separator_color = frame
    sort = yes
    idle_threshold = 120
    font = JetBrainsMono Nerd Font 10
    line_height = 0
    markup = full
    format = "<b>%s</b>\n%b"
    alignment = left
    vertical_alignment = center
    show_age_threshold = 60
    ellipsize = middle
    ignore_newline = no
    stack_duplicates = true
    hide_duplicate_count = false
    show_indicators = yes
    icon_position = left
    min_icon_size = 0
    max_icon_size = 64
    sticky_history = yes
    history_length = 20
    always_run_script = true
    corner_radius = 12
    ignore_dbusclose = false
    mouse_left_click = close_current
    mouse_middle_click = do_action, close_current
    mouse_right_click = close_all

[urgency_low]
    background = "#050a0e"
    foreground = "#00f3ff"
    timeout = 5

[urgency_normal]
    background = "#050a0e"
    foreground = "#ffffff"
    frame_color = "#00f3ff"
    timeout = 10

[urgency_critical]
    background = "#050a0e"
    foreground = "#ff5555"
    frame_color = "#ff00ff"
    timeout = 0
EOF
        print_success "Created dunst config"
    fi
    
    print_success "Post-install setup complete!"
}

# Print final instructions
print_instructions() {
    echo ""
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                    🎉 INSTALLATION COMPLETE! 🎉               ║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${MAGENTA}📝 NEXT STEPS:${NC}"
    echo ""
    echo -e "  ${GREEN}1.${NC} Add wallpapers to ${CYAN}~/.config/hypr/wallpapers/${NC}"
    echo -e "     Required: ${YELLOW}6.mp4${NC} (video wallpaper)"
    echo -e "               ${YELLOW}lockvideo.mp4${NC} (lock transition)"
    echo -e "               ${YELLOW}lock_wallpaper.png${NC} (lock background)"
    echo ""
    echo -e "  ${GREEN}2.${NC} For ${CYAN}video wallpaper${NC}, install mpvpaper:"
    echo -e "     Arch: ${YELLOW}yay -S mpvpaper${NC}"
    echo ""
    echo -e "  ${GREEN}3.${NC} For ${CYAN}static wallpaper${NC}, edit hyprland.conf:"
    echo -e "     Comment mpvpaper line, uncomment swww lines"
    echo ""
    echo -e "  ${GREEN}4.${NC} ${CYAN}Log out${NC} and select ${MAGENTA}Hyprland${NC} from your display manager"
    echo ""
    echo -e "${MAGENTA}⌨️  KEY BINDINGS:${NC}"
    echo -e "  ${CYAN}SUPER + Q${NC}       → Terminal (Kitty)"
    echo -e "  ${CYAN}SUPER + D${NC}       → App Launcher (Rofi)"
    echo -e "  ${CYAN}SUPER + C${NC}       → Close Window"
    echo -e "  ${CYAN}SUPER + L${NC}       → Lock Screen"
    echo -e "  ${CYAN}SUPER + E${NC}       → File Manager"
    echo -e "  ${CYAN}SUPER + 1-0${NC}     → Switch Workspaces"
    echo -e "  ${CYAN}SUPER+SHIFT+S${NC}   → Screenshot"
    echo ""
    echo -e "${YELLOW}⚠️  If temperature module shows errors, run:${NC}"
    echo -e "  ${CYAN}ls /sys/class/hwmon/*/temp1_input${NC}"
    echo -e "  Then update the path in ${CYAN}~/.config/waybar/config${NC}"
    echo ""
    echo -e "${GREEN}Enjoy your Cyberpunk desktop! 🌆${NC}"
    echo ""
}

# Main installation flow
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
    post_install
    print_instructions
}

# Run with --help flag
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Usage: ./install.sh [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --help, -h     Show this help message"
    echo "  --no-deps      Skip dependency installation"
    echo "  --no-backup    Skip backing up existing configs"
    echo ""
    exit 0
fi

main "$@"
