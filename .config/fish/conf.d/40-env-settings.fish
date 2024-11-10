# Misc env settings.
set -x GIT_PAGER ""
set -x HOSTALIASES $HOME/.hosts
fish_add_path -pP /opt/homebrew/bin
if test (uname -s|rg Linux)
    if test "$hostname" = otsonkolo
        set -x GOPATH "/opt/$USER/gopath"
    else
        set -x GOPATH "$HOME/gopath"
    end
    set -x EDITOR (which nvim)
    fish_add_path --global --move --path /snap/bin
else
    if test (uname -s|rg Darwin)
        set -x GOPATH "$HOME/go"
    end
end
fish_add_path --global --move --path \
    (python3 -c 'import sysconfig;import os;print(sysconfig.get_path("scripts", f"{os.name}_user"))') \
    $HOME/bin \
    $HOME/go/bin \
    $HOME/.local/bin
set -x LC_ALL en_GB.UTF-8
set -x NCURSES_NO_UTF8_ACS 1
