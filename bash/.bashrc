# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# "my-shell-environment" - see "https://github.com/Nikolai2038/my-shell-environment" for more details
if [ -f /usr/local/lib/my-shell-environment/n2038_my_shell_environment.sh ]; then
    source /usr/local/lib/my-shell-environment/n2038_my_shell_environment.sh && n2038_my_shell_environment activate
fi

# Command not found handler on Arch Linux
if which pkgfile &> /dev/null; then
    command_not_found_handle() {
        echo "Command \"$1\" not found." >&2
        if [[ -x /usr/bin/pkgfile ]]; then
            result=$(pkgfile -v "$1")
            if [[ -n "${result}" ]]; then
                echo "Command \"$1\" was found in the following packages:" >&2
                echo "${result}" >&2
            else
                echo "Command \"$1\" was not found in any packages." >&2
            fi
        else
            echo "pkgfile is not installed." >&2
        fi
        return 1
    }

    # Make sure the function is used for command not found
    export -f command_not_found_handle
fi

# For "uv"
export PATH="/home/nikolai/.local/bin:$PATH"
