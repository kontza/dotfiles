bind escape,backspace backward-kill-word
bind escape,d kill-word
bind escape,f forward-word
bind escape,b backward-word
set -x fish_escape_delay_ms 200
set -g theme_short_path yes
# Disable greeting.
function fish_greeting
end
