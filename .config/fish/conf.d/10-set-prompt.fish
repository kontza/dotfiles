function fish_prompt
    set -g __fish_git_prompt_show_informative_status 1
    set -g __fish_git_prompt_showcolorhints 1
    set -g __fish_git_prompt_showdirtystate 1
    set -g __fish_git_prompt_showuntrackedfiles 1
    set -g __fish_git_prompt_describe_style branch

    set -g __fish_git_prompt_showupstream informative
    set -g __fish_git_prompt_char_upstream_ahead "↑"
    set -g __fish_git_prompt_char_upstream_behind "↓"
    set -g __fish_git_prompt_char_upstream_prefix ""

    set -g __fish_git_prompt_char_stagedstate "●"
    set -g __fish_git_prompt_char_dirtystate "✚"
    set -g __fish_git_prompt_char_untrackedfiles "…"
    set -g __fish_git_prompt_char_conflictedstate "✖"
    set -g __fish_git_prompt_char_cleanstate "✔"

    printf "%s:" (prompt_login)
    set_color bryellow
    echo -n (prompt_pwd -d2 -D2)
    set_color normal
    echo -n (fish_git_prompt)
    if test -d .git
        set MASTER_NAME (git branch -r|rg origin/ma|tail -1|tr '/' '\n'|tail -1)
        set SYSTEM_PROMPT (fish_git_prompt)
        string match -eq $MASTER_NAME $SYSTEM_PROMPT
        if test $status -eq 0
            echo -n '' (git describe --tags 2> /dev/null)
        end
    end
    echo -e "\n❯ "
end
