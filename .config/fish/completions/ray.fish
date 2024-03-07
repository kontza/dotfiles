for RAY_CMD in start stop kill watch wipelog lnav
    complete -c ray -a $RAY_CMD
end