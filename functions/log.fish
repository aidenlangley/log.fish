function log --description 'Log messages (Levels: ERR, INF, WARN, DEBUG, OK, QUESTION)'
    set __name (string split '.' (basename (status -f)))[1]
    set __version '0.1.4'
    set __description 'Print a styled string then reset'

    set opts (fish_opt --short h --long help)
    set opts $opts (fish_opt --short l --long level --required-val)
    set opts $opts (fish_opt --short t --long timestamp)

    argparse $opts -- $argv

    if set --query _flag_h || not argparse --min-args=1 -- $argv &>/dev/null
        set TAB '  '
        set FLAG_DELIM ', '

        set name (set_color --bold green)$__name(set_color --reset)
        set desc (set_color --italic)$__description(set_color --reset)
        echo (printf '%s %s - %s.' $name $__version $desc)

        function _usage --inherit-variable __name --argument-names args
            echo (set_color --bold cyan)$__name(set_color --reset) $args
        end

        function _desc --argument-names desc
            echo (set_color --dim brwhite)$desc(set_color --reset)
        end

        function _option --argument-names args
            echo (set_color --bold cyan)$args(set_color --reset)
        end

        echo
        echo (set_color --bold green)'Usage:'(set_color --reset)
        echo $TAB(_usage '[OPTIONS] ...')
        echo $TAB(_usage '-l/--level ERR ...') (_desc 'Log an error message.')
        echo $TAB(_usage '-t/--timestamp ...') (_desc 'Log a message with timestamp.')
        echo $TAB(_usage '-t/--timestamp -l/--level d ...') (_desc 'Log a debug message with timestamp.')

        echo
        echo (set_color --bold green)'Options:'(set_color --reset)
        echo $TAB(_option (string join -- $FLAG_DELIM -l --level) '<LEVEL>')
        echo $TAB$TAB'Log level: DBG, INF, WARN, ERR, OK, QUESTION.'
        echo $TAB(_option (string join -- $FLAG_DELIM -t --timestamp) '<COLOR>')
        echo $TAB$TAB'Include timestamp in log message.'

        return
    end

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
