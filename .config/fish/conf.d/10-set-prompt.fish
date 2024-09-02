set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color_branch magenta
set -g __fish_git_prompt_showupstream informative
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate green

function fish_prompt
    set VTAG ""
    if test -d .git
        set MASTER_NAME (git branch -r|rg origin/ma|tail -1|tr '/' '\n'|tail -1)
        set SYSTEM_PROMPT (fish_git_prompt)
        string match -eq $MASTER_NAME $SYSTEM_PROMPT
        if test $status -eq 0
            set VTAG (git describe --tags)
        end
    end
    printf "%s:%s%s %s\n❯ " \
        (prompt_login) \
        (prompt_pwd -d1 -D2) \
        (fish_git_prompt) \
        $VTAG
end
