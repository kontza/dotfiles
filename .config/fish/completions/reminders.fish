for LINE in (reminders -h|awk '/^SUBCOMMANDS/{flag=1;next}/^ *$/{flag=0}flag')
    set -l COMMAND (echo $LINE|cut -w -f2)
    set -l DESCR (echo $LINE|cut -w -f3-)
    complete -c reminders -a $COMMAND -d "$DESCR"
end
set -l REMINDER_COMMANDS (reminders -h|awk 'BEGIN {ORS=" "}/^SUBCOMMANDS/{flag=1;next}/^ *$/{flag=0}flag{print $1}'|xargs)
set -l REMINDER_LISTS (reminders show-lists|sed -e 's:^:":' -e 's:$:":')
complete -c reminders -n "__fish_seen_subcommand_from $REMINDER_COMMANDS" -a "$REMINDER_LISTS"
