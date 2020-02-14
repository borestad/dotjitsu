memoize() {
    local _ cache key exists timecheck
    cache="${XDG_CACHE_HOME:-$HOME/.cache}/memoize"
    if [ ! -d "${cache}" ]; then
        mkdir -p "${cache}"
    fi

    while [ -n "$1" ]; do
        case "$1" in
            "-d")
                shift
                echo -n "$*" | sha1sum | read key _
                rm -f "${cache}/${key}".{rc,out,err}
                return 0
                ;;
            "-t")
                shift
                timecheck="$1"
                shift
                break
                ;;
            *)
                break
                ;;
        esac
    done

    echo -n "$*" | sha1sum | read key _
    local base="${cache}/${key}"

    if [ -f "${base}.rc" ]; then
        if [[ "$timecheck" ]]; then
            if find "${base}.rc" -mmin "-$timecheck" | grep . >&/dev/null; then
                exists=1
            else
                exists=
            fi
        else
            exists=1
        fi
    fi

    if [[ $exists ]]; then
        # replay

        # The reason for forking these off is the (somewhat odd) case where
        # stdout and stderr are consumed in synchrony. It might otherwise
        # block when the reader won't read more from stdout because it expects
        # something on stderr or vice versa.
        ( [ -f "${base}.out" ] && cat "${base}.out" & )
        ( [ -f "${base}.err" ] && cat "${base}.err" 1>&2 & )
        rc=$(cat "${base}.rc")
        return $rc
    else
        # capture
        $* \
             2> >(tee "${base}.err" 1>&2) \
             1> >(tee "${base}.out")

        rc="$?"
        echo "$rc" > "${base}.rc"
        return $rc
    fi
}

# Local Variables:
# mode: shell-script
# sh-shell: zsh
# End:
