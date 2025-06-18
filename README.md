# dotfiles

Dotfiles for my Arch Linux environment.

## 1. Description

In work...

## 2. Installation

### 2.1. In work

1. Install required packages:

    - Arch Linux:

        - Basic:

            ```sh
            sudo pacman --noconfirm --sync --refresh --needed git stow
            ```

        - Hyprland environment:

            ```sh
            sudo pacman --noconfirm --sync --refresh --needed hyprland egl-wayland libva-nvidia-driver uwsm libnewt xorg-xwayland wayland-protocols hyprpolkitagent qt5-wayland qt6-wayland waybar ttf-font-awesome network-manager-applet gsimplecal copyq wl-clip-persist dunst zenity jq hyprpaper archlinux-xdg-menu power-profiles-daemon pavucontrol playerctl brightnessctl touchegg rofi-wayland rofi-calc hyprshot hyprpicker pngquant wl-clipboard swappy konsole qt6-multimedia-ffmpeg dolphin ark unrar phonon-qt6-vlc && \
            sudo systemctl enable power-profiles-daemon.service touchegg.service

            # Enable multilib repository
            new_config="$(cat /etc/pacman.conf | tr '\n' '\r' | sed 's|\#\[multilib\]\r\#Include|[multilib]\rInclude|' | tr '\r' '\n')" && \
            echo "${new_config}" | sudo tee /etc/pacman.conf && \
            sudo pacman --sync --refresh

            # Audio
            sudo pacman --noconfirm -Rdd jack2; \
            sudo pacman --noconfirm --sync --refresh --needed pipewire pipewire-audio lib32-pipewire pipewire-docs wireplumber wireplumber-docs pipewire-pulse pipewire-alsa pipewire-jack lib32-pipewire-jack && \
            systemctl --user enable pipewire-pulse.service

            # Bluetooth
            sudo pacman --noconfirm --sync --refresh --needed blueman && \
            sudo systemctl enable bluetooth.service

            # Fonts:
            # - "noto-fonts": For "Noto Sans";
            # - "ttf-firacode-nerd": For "FiraCode Nerd Font Mono";
            # - "font-manager": Font Manager and Font Viewer apps;
            # - "ttf-ms-win11-auto": For Microsoft fonts with icons.
            sudo pacman --noconfirm --sync --refresh --needed noto-fonts ttf-firacode-nerd font-manager && \
            yay --noconfirm --sync --refresh --needed ttf-ms-win11-auto

            # Main Theme
            # - "breeze-gtk": for GTK applications;
            # - "breeze5": Breeze theme Qt applications;
            # - "qt6ct": Qt applications theming.
            sudo pacman --noconfirm --sync --refresh --needed breeze breeze-gtk breeze5 gtk3 gtk4 qt6ct xdg-desktop-portal-hyprland xdg-desktop-portal-gtk && \
            gsettings set org.gnome.desktop.interface color-scheme "prefer-dark" && \
            gsettings set org.gnome.desktop.interface gtk-theme "Breeze" && \
            gsettings set org.gnome.desktop.interface font-name "Noto Sans 10"

            # Icon Theme
            sudo pacman --noconfirm --sync --refresh --needed papirus-icon-theme

            # Cursor Theme
            yay --noconfirm --sync --refresh --needed bibata-cursor-theme-bin

            # Image viewer
            sudo pacman --noconfirm --sync --refresh --needed gwenview kimageformats jxrlib libheif qt6-imageformats
            ```

            - `hyprland`: Wayland compositor;
            - `libva-nvidia-driver`: [VA-API hardware video acceleration](https://wiki.hypr.land/Nvidia/#va-api-hardware-video-acceleration);
            - `uwsm` and `libnewt`: For [uwsm session start](https://wiki.hypr.land/Useful-Utilities/Systemd-start#installation);
            - `xorg-xwayland` and `wayland-protocols`: Fix [flickering in XWayland games](https://wiki.hypr.land/Nvidia/#flickering-in-xwayland-games);
            - `hyprpolkitagent`: Polkit agent;
            - `qt5-wayland`: Qt5 support for Wayland;
            - `qt6-wayland`: Qt6 support for Wayland;
            - `waybar`: Panel;
            - `ttf-font-awesome`: Font with icons;
            - `blueman`: Applet to manage Bluetooth connections;
            - `network-manager-applet`: Applet to manage network connections;
            - `gsimplecal`: Calendar;
            - `copyq`: Clipboard manager;
            - `wl-clip-persist`: To [persist clipboard contents after program was closed](https://wiki.hyprland.org/Useful-Utilities/Clipboard-Managers/);
            - `dunst`: Notification daemon;
            - `zenity`: To show nice message prompts (Yes/No) on some waybar actions (for example, to clear notifications history);
            - `jq`: To parse JSON output from `dunstctl` and get notifications count;
            - `hyprpaper`: Wallpaper engine;
            - `archlinux-xdg-menu`: For fix "Open with" menu in Dolphin;
            - `power-profiles-daemon`: Manage power profiles;
            - `pavucontrol`: Audio management (input and outputs);
            - `playerctl`: Media controls;
            - `brightnessctl`: To control screen brightness;
            - `touchegg`: Configure touchpad gestures;
            - `rofi-wayland`: Application launcher;
            - `rofi-calc`: Calculator inside `rofi`;
            - `hyprshot`: Screenshoter;
            - `hyprpicker`: To be able to freeze screen (for screenshoter). Also is the color picker;
            - `pngquant`: To compress PNG images (for screenshoter);
            - `wl-clipboard`: Copy stdout to clipboard (for screenshoter);
            - `swappy`: Shapes drawer on images (for screenshoter);
            - `konsole`: Terminal;
            - `qt6-multimedia-ffmpeg`: Required dependency for `konsole`;
            - `dolphin`: File browser;
            - `ark`: Archiver for file browser;
            - `unrar`: `.unrar` unarchive support for file browser;
            - `phonon-qt6-vlc`: Required dependency for `dolphin`;
            - `otf-font-awesome`: Default font for waybar with some icons. Also used by `swappy`;
            - `ttf-firacode-nerd`: For `Fira Code Nerd Font Mono` font;

2. Clone this repository:

    ```sh
    git clone https://github.com/Nikolai2038/dotfiles.git
    ```

3. `cd` to it:

    ```sh
    cd ./dotfiles
    ```

4. Apply configs:

    - `bash`:

        ```sh
        stow --adopt --no-folding  --target="${HOME}" --stow bash && \
        git restore .
        ```

    - Hyprland environment:

        ```sh
        stow --adopt --no-folding --target="${HOME}" --stow hyprland && \
        git restore .
        ```

    - Sway environment:

        ```sh
        stow --adopt --no-folding --target="${HOME}" --stow sway &&
        git restore .
        ```

    - Programs:

        ```sh
        stow --adopt --no-folding --target="${HOME}" --stow waybar && \
        stow --adopt --no-folding --target="${HOME}" --stow copyq && \
        stow --adopt --no-folding --target="${HOME}" --stow dunst && \
        stow --adopt --no-folding --target="${HOME}" --stow gsimplecal && \
        stow --adopt --no-folding --target="${HOME}" --stow touchegg && \
        stow --adopt --no-folding --target="${HOME}" --stow rofi && \
        stow --adopt --no-folding --target="${HOME}" --stow dolphin && \
        stow --adopt --no-folding --target="${HOME}" --stow konsole && \
        stow --adopt --no-folding --target="${HOME}" --stow gwenview && \
        git restore .
        ```

5. Reboot.

### 2.2. Fix Xwayland high CPU usage and crash when selecting text by mouse cursor in JetBrains IDEs

[2025-06-18] I encountered very strange issue with WebStorm (happens in other JetBrains IDEs too, and once even in Obsidian): when selecting text by mouse cursor in the terminal or in the commit message editor, the `Hyprland` process will start consuming 100% CPU, and in some cases then crash. The of the `Hyprland` command ends with:

```plaintext
error marshalling arguments for send: dup failed: Too many open files
error in client communication (pid 30820)
file descriptor expected, object (44), message add(huuuuu)
error in client communication (pid 30767)
XWAYLAND: wl_display#1: error 1: invalid arguments for zwp_linux_buffer_params_v1#44.add
(EE) failed to dispatch Wayland events: Invalid argument
```

I was able to fix this by using `xwayland-satellite`, because found related [`invalid arguments for zwp_linux_buffer_params_v1` issue](https://github.com/Supreeeme/xwayland-satellite/issues/144).

```sh
sudo pacman --noconfirm --sync --refresh --needed xwayland-satellite && \
systemctl --user enable --now xwayland-satellite.service
```

## 3. Uninstallation

1. `cd` to cloned repository:

    ```sh
    cd ./dotfiles
    ```

2. Delete configs:

    - `bash`:

        ```sh
        stow --no-folding  --target="${HOME}" --delete bash
        ```

    - Hyprland environment:

        ```sh
        stow --no-folding --target="${HOME}" --delete hyprland
        ```

    - Sway environment:

        ```sh
        stow --no-folding --target="${HOME}" --delete sway
        ```

    - Programs:

        ```sh
        stow --no-folding --target="${HOME}" --delete waybar && \
        stow --no-folding --target="${HOME}" --delete copyq && \
        stow --no-folding --target="${HOME}" --delete dunst && \
        stow --no-folding --target="${HOME}" --delete gsimplecal && \
        stow --no-folding --target="${HOME}" --delete touchegg && \
        stow --no-folding --target="${HOME}" --delete rofi && \
        stow --no-folding --target="${HOME}" --delete dolphin && \
        stow --no-folding --target="${HOME}" --delete konsole && \
        stow --no-folding --target="${HOME}" --delete gwenview
        ```

3. Remove cloned repository.
