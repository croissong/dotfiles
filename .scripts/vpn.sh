start() {
    mkdir -p /var/run/xl2tpd
    sudo touch /var/run/xl2tpd/l2tp-control
    if [ $(systemctl is-active strongswan) != "active" ]; then
        systemctl start strongswan
    fi
    if [ $(systemctl is-active strongswan) != "active" ]; then
        systemctl start xl2tpd
    fi
    sudo ipsec up myvpn
    sudo sh -c 'echo "c myvpn" > /var/run/xl2tpd/l2tp-control'
    sudo ip route replace 46.101.139.198 via 192.168.0.1
    echo 'creating adapter...'
    sleep 3
    sudo ip route replace default dev ppp0
}

stop() {
    sudo sh -c 'echo "d myvpn" > /var/run/xl2tpd/l2tp-control'
    sudo ipsec down myvpn
    sudo ip route replace default via 192.168.0.1 dev enp5s0
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    *)
        echo "Usage: $0 {start|stop}" >&2
        exit 1
        ;;
esac
