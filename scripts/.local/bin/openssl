get() {
    server="$1"
    openssl s_client -showcerts -servername $server -connect $server:443 </dev/null
}

case "$1" in
    get)
        get $2
        ;;
    *)
        echo "Usage: $0 {get}" >&2
        exit 1
        ;;
esac
