# dotfiles

## 1. Installation

1. Install required packages:

    - Arch Linux:

        ```sh
        sudo pacman --noconfirm --sync --refresh --needed git stow
        ```

2. Clone this repository:

    ```sh
    git clone https://github.com/Nikolai2038/dotfiles.git
    ```

3. `cd` to it:

    ```sh
    cd ./dotfiles
    ```

4. Apply configs:

    ```sh
    stow --target="${HOME}" --stow bash
    ```

## 2. Uninstallation

1. `cd` to cloned repository:

    ```sh
    cd ./dotfiles
    ```

2. Delete configs:

    ```sh
    stow --target="${HOME}" --delete bash
    ```
