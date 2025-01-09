set PROG sch

function __fish_sch_needs_host
    set -l cmd (commandline -opc)
    if [ (count $cmd) -eq 1 -a $cmd[1] = $PROG ]
        return 0
    end
    return 1
end

complete -c $PROG -f -n __fish_sch_needs_host -a "(__fish_print_hostnames)"
