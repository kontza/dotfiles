# Special functions to make video encoding easier.
set -g __default_encode "Playstation 720p30"
set -g __high_quality_encode "HQ 1080p30 Surround"

function pull_the_brake_help
    for line in "Usage:  [options] files..." \
        "Options:" \
        "  -a/--start-at <number>" \
        "    Start encoding at a given offset in seconds." \
        "  -c/--crop <top:bottom:left:right>" \
        "    Set picture cropping in pixels" \
        "    (default: automatically remove black bars)" \
        "  -d/--dry-run" \
        "    Only prints out the command that would be run" \
        "  -f/--output-file <filename>" \
        "    Set the output file's name" \
        "  -o/--stop-at  <number>" \
        "    Stop encoding after a given duration in seconds." \
        "    Duration is relative to --start-at, if specified." \
        "  -q/--high-quality" \
        "    Use '$__high_quality_encode' to encode. NOTE! Useless with DVB-T recordings!" \
        "    Default quality is '$__default_encode'."
        echo "$line"
    end
end

function pull_the_brake
    argparse --name=pull_the_brake 'h/help' 'd/dry-run' 'f/output-file=' 'c/crop=' 'a/start-at=' 'o/stop-at=' 'q/high-quality' -- $argv
    if test -n "$_flag_help"
        pull_the_brake_help
    else
        if count $argv > /dev/null
            set __quality "$__default_encode"
            if test -n "$_flag_q"
                set __quality "$__high_quality_encode"
            end
            if test -n "$_flag_a"
                set _flag_a "--start-at seconds:$_flag_a"
            end
            if test -n "$_flag_o"
                set _flag_o "--stop-at seconds:$_flag_o"
            end
            if test -n "$_flag_c"
                set _flag_c "--crop $_flag_c"
            end
            if test -n "$_flag_f"
                if test 1 -lt (count $argv)
                    echo "Cannot define a single output filename with multiple input files! Using generated names..."
                else
                    set -g OUT "$_flag_f"
                end
            end
            for item in $argv
                if test -e abort.now
                    echo "Abort command detected, breaking out of the iteration."
                    break
                end
                if test -z "$OUT"
                    set -g OUT (string replace -r ".[a-z]+\$" .mp4 $item)
                end
                if test -n "$_flag_d"
                    echo "HandBrakeCLI -Z \"'$__quality'\" $_flag_a $_flag_o $_flag_c -i $item -o $OUT"
                else
                    eval tmux new HandBrakeCLI -Z "'$__quality'" "$_flag_a" "$_flag_o" "$_flag_c" -i $item -o $OUT
                end
                set -g OUT ""
            end
        else
            pull_the_brake_help
        end
    end
end
