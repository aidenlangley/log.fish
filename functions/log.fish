function log --description 'Log messages (Levels: ERR, INF, WARN, DEBUG, OK, QUESTION)'
    # Nice date format if we want to use it.
    # printf '[%s]' (date --iso-8601=seconds)
    # printf '[%s]' (date +'%H:%M:%S.%N')
    # $argv[2..-1]

    set opts (fish_opt --short d --long debug)
    set opts $opts (fish_opt --short l --long level --required-val)
    set opts $opts (fish_opt --short t --long timestamp)

    argparse $opts -- $argv

    set --query _flag_d && set debug $_flag_d

    set msg
    if set --query _flag_t
        set msg (set_color -d)(printf '[%s]' (date +'%H:%M:%S.%N'))(set_color --reset)
    end

    set --query _flag_l && set level $_flag_l
    switch $level
        case dbg debug DBG DEBUG
            set msg $msg (set_color -o cyan)DBG(set_color --reset) $argv
        case inf info INF INFO
            set msg $msg (set_color --bold --dim white)INF(set_color --reset) $argv
        case wrn warn WRN WARN
            set msg $msg (set_color -o yellow)WARN(set_color --reset) $argv
        case err error ERR ERROR
            set msg $msg (set_color -o red)ERR(set_color --reset) $argv
        case ok OK
            set msg $msg (set_color -o green)OK(set_color --reset) $argv
        case question QUESTION
            set msg $msg (set_color -o cyan)'???'(set_color --reset) $argv
        case '*'
            set msg $msg $argv
    end

    echo $msg
end
