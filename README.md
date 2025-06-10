# dotfiles

Dotfiles for my Arch Linux environment.

## 1. Description

In work...

## 2. Installation

1. Install required packages:

    - Arch Linux:

        - Basic:

            ```sh
            sudo pacman --noconfirm --sync --refresh --needed git stow
            ```

        - Hyprland environment:

            ```sh
            sudo pacman --noconfirm --sync --refresh --needed hyprland hyprpolkitagent qt5-wayland qt6-wayland waybar ttf-font-awesome blueman network-manager-applet gsimplecal copyq wl-clip-persist dunst zenity jq hyprpaper archlinux-xdg-menu power-profiles-daemon pavucontrol playerctl brightnessctl touchegg && \
            sudo systemctl enable --now power-profiles-daemon.service touchegg.service
            ```

            - `hyprland`: Wayland compositor;
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
            - `touchegg`: Configure touchpad gestures.

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
        stow --no-folding  --target="${HOME}" --stow bash
        ```

    - Hyprland environment:

        ```sh
        stow --no-folding --target="${HOME}" --stow hyprland && \
        stow --no-folding --target="${HOME}" --stow waybar && \
        stow --no-folding --target="${HOME}" --stow copyq && \
        stow --no-folding --target="${HOME}" --stow dunst && \
        stow --no-folding --target="${HOME}" --stow gsimplecal && \
        stow --no-folding --target="${HOME}" --stow touchegg
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
        stow --no-folding --target="${HOME}" --delete hyprland && \
        stow --no-folding --target="${HOME}" --delete waybar && \
        stow --no-folding --target="${HOME}" --delete copyq && \
        stow --no-folding --target="${HOME}" --delete dunst && \
        stow --no-folding --target="${HOME}" --delete gsimplecal && \
        stow --no-folding --target="${HOME}" --delete touchegg

3. Remove cloned repository.
