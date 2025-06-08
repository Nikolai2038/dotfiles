# dotfiles

Dotfiles for my Arch Linux environment.

## 1. Installation

1. Install required packages:

    - Arch Linux:

        - Basic:

            ```sh
            sudo pacman --noconfirm --sync --refresh --needed git stow
            ```

        - Hyprland environment:

            ```sh
            sudo pacman --noconfirm --sync --refresh --needed hyprland hyprpolkitagent qt5-wayland qt6-wayland waybar ttf-font-awesome blueman network-manager-applet gsimplecal copyq wl-clip-persist
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
            - `wl-clip-persist`: To [persist clipboard after program was closed](https://wiki.hyprland.org/Useful-Utilities/Clipboard-Managers/).

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
        stow --no-folding --target="${HOME}" --stow copyq
        ```

## 2. Uninstallation

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
        stow --no-folding --target="${HOME}" --delete copyq

3. Remove cloned repository.
