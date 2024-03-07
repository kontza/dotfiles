# Misc env settings.
set -x GIT_PAGER ""
set -x HOSTALIASES $HOME/.hosts
if test (uname -s|rg Linux)
    if test "$hostname" = "otsonkolo"
        set -x GOPATH "/opt/$USER/gopath"
    else
        set -x GOPATH "$HOME/gopath"
    end
    fish_add_path /snap/bin
    fish_add_path $HOME/.local/bin
else
    if test (uname -s|rg Darwin)
        set -x GOPATH "$HOME/Desktop/omat/gopath"
    end
end
set -x LC_ALL en_GB.UTF-8
set -x NCURSES_NO_UTF8_ACS 1
# Workaround for slow tab completion in Catalina.
if test (uname -s) = "Darwinx"
    set -l darwin_version (uname -r | string split .)
    # macOS 11 (Big Sur) is Darwin 20
    switch (uname -r)
        # Add here a case for the Darwin version where this tweak is not needed anymore.
        # For now, macOS 11.1, Darwin 20.2 this is still required.
        case '*'
            set nullify_command 1
    end
    if test $nullify_command -eq 1
        function __fish_describe_command; end
    end
end
