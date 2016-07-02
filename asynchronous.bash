function after {
    condition="$@"
    if [[ -t 0 ]]; then
        action=""
    else
        action=$(tee)
    fi

    nohup bash -c \
        "while :; do
            $condition && break
            sleep 1
         done
         $action" <&- > /dev/null 2>&1 &
}

function daemon {
    if [[ -t 0 ]]; then
        action=""
    else
        action=$(tee)
    fi
    nohup bash -c "$action" <&- > /dev/null 2>&1 &
}

function all {
    collection="$1"
    shift
    condition="$@"
  
    while :; do
        for _ in $collection; do
            if ! eval "$condition" ; then
                 continue 2
            fi
        done
        break
    done
}

