# Misc env settings.
set -x GIT_PAGER ""
set -x HOSTALIASES $HOME/.hosts
if test (uname -s|rg Linux)
    if test "$hostname" = otsonkolo
        set -x GOPATH "/opt/$USER/gopath"
    else
        set -x GOPATH "$HOME/gopath"
    end
    fish_add_path /snap/bin
    fish_add_path $HOME/.local/bin
else
    if test (uname -s|rg Darwin)
        set -x GOPATH "$HOME/go"
    end
end
set -x LC_ALL en_GB.UTF-8
set -x NCURSES_NO_UTF8_ACS 1
