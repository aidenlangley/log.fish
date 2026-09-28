function log --description 'Log messages (Levels: ERR, INF, WARN, DEBUG, OK, QUESTION)'
    set __name (string split '.' (basename (status -f)))[1]
    set __version '0.1.2'
    set __description 'Print a styled string then reset'

    set opts (fish_opt --short l --long level --required-val)
    set opts $opts (fish_opt --short t --long timestamp)

    argparse $opts -- $argv

    set msg
    if set --query _flag_t
        set msg (set_color -d)(printf '[%s]' (date +'%H:%M:%S.%N'))(set_color --reset)
    end

    set --query _flag_l && set level $_flag_l
    switch $level
        case d dbg debug D DBG DEBUG
            set msg $msg (set_color -o cyan)DBG(set_color --reset) $argv
        case i inf info I INF INFO
            set msg $msg (set_color --bold --dim white)INF(set_color --reset) $argv
        case w wrn warn W WRN WARN
            set msg $msg (set_color -o yellow)WARN(set_color --reset) $argv
        case e err error E ERR ERROR
            set msg $msg (set_color -o red)ERR(set_color --reset) $argv
        case ok OK
            set msg $msg (set_color -o green)OK(set_color --reset) $argv
        case q question Q QUESTION
            set msg $msg (set_color -o cyan)'???'(set_color --reset) $argv
        case '*'
            set msg $msg $argv
    end

    echo $msg
end
