# Set 'aliases', functions in Fish.
if command -q eza
    function d
        eza -laFag $argv
    end
else
    function d
        ls -la $argv
    end
end

function ne --description 'Find a file with fzf and open it in Neovim'
    if count $argv >/dev/null
        set -l PATTERN (string join ' ' $argv)
        eval "nvim (fzf -1 -q '$PATTERN')"
    else
        echo "Gimme some files to find and open"
    end
end

function pud
    pushd $argv
end

function x
    if test (uname|rg Darwin)
        open $argv
    else
        xdg-open $argv
    end
end

function jwt-show
    jwt decode -j $argv[1]
end

function dotdate
    echo (date '+%y').(math (date '+%m')).(math (date +%e))
end

function swagger-to-typescript --description 'Converts the given JSON to TypeScript.'
    if test (count $argv) -lt 1
        echo "Usage:
    swagger-to-typescript somefile.json"
    else
        if test -d src/generated
            if test -f $argv[1]
                set json_base (basename $argv[1] .json)
                npx swagger-typescript-api --axios \
                    -p $argv[1] \
                    -o src/generated \
                    -n "$json_base.ts"
            else
                echo "'$argv[1]' not found!"
            end
        else
            echo "Directory 'src/generated' not found. Are you in the right place?"
        end
    end
end

function ray --description 'Runs operations on a Liferay bundle. Args: 1. A Liferay bundle dir. 2. The operation to run.'
    if test (count $argv) -lt 2
        echo "Usage:
    ray [Liferay bundle path] [(a|start)|(o|stop)|(k|kill)|(w|watch)|(c|wipelog)|(l|lnav)|(e|clean-start)]"
    else
        function liferay_start
            eval $argv[1]/tomcat/bin/startup.sh
        end
        function liferay_stop
            eval $argv[1]/tomcat/bin/shutdown.sh
        end
        function liferay_kill
            kill -KILL (pgrep -lf java|awk "/$agv[1]/{print $1}")
        end
        function liferay_watch
            watch "pgrep -lf java|rg $argv[1]"
        end
        function liferay_wipelog
            echo z >$argv[1]/tomcat/logs/catalina.out
        end
        function liferay_lnav
            lnav $argv[1]/tomcat/logs/catalina.out
        end
        switch "$argv[2]"
            case start a
                liferay_start "$argv[1]"
            case stop o
                liferay_stop "$argv[1]"
            case kill k
                liferay_kill "$argv[1]"
            case watch w
                liferay_watch "$argv[1]"
            case wipelog c
                liferay_wipelog "$argv[1]"
            case lnav l
                liferay_lnav "$argv[1]"
            case clean-start e
                liferay_wipelog "$argv[1]"
                liferay_start "$argv[1]"
                liferay_lnav "$argv[1]"
            case '*'
                echo "Unknown command: $argv[2]"
        end
    end
end

function get_kc_access_token
    argparse --name=get_kc_access_token 't/target_url=' 'u/username=' 'p/password=' 'c/client_id=' -- $argv
    or return
    http --verify no --ignore-stdin --form --follow -b POST "$_flag_t/auth/realms/vnk/protocol/openid-connect/token" \
        'username'=$_flag_u \
        'password'=$_flag_p \
        'client_id'=$_flag_c \
        'grant_type'='password' \
        Content-Type:'application/x-www-form-urlencoded' | jq -r '.access_token'
end

function mov2gif --description 'Converts a given MOV to a 10 FPS GIF.'
    if test (count $argv) -lt 1
        for line in "Usage:  mov2gif MOV-file" \
            "" \
            "Options:" \
            "   -h/--help   Show this usage"
            echo $line
        end
    else
        set _input_file $argv[1]
        set _output_file (string split -r -m1 . $argv[1])[1]".gif"
        ffmpeg -i "$_input_file" -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 >"$_output_file"
    end
end

function newrole --description 'Create a new role'
    mkdir -p roles/$argv[1]/tasks
    touch roles/$argv[1]/tasks/main.yml
end

function bfg --description 'Run BFG'
    java -jar /usr/local/bin/bfg*.jar $argv
end

function wiki
    pushd $HOME/wiki
    nvim index.md
    popd
end

function echr
    printf %"$COLUMNS"s | tr " " "$argv[1]"
end
