start() {
  mkdir -p /var/run/xl2tpd
  sudo touch /var/run/xl2tpd/l2tp-control
  if [ $(systemctl is-active strongswan) != "active" ]; then
    systemctl start strongswan
    systemctl start xl2tpd
  fi
  sudo ipsec up myvpn
  sudo sh -c 'echo "c myvpn" > /var/run/xl2tpd/l2tp-control'
  sleep 3
  sudo ip r add 10.0.0.0/8 dev ppp0 scope link
}

stop() {
  sudo sh -c 'echo "d myvpn" > /var/run/xl2tpd/l2tp-control'
  sudo ipsec down myvpn
  if [ $(systemctl is-active strongswan) == "active" ]; then
    systemctl stop strongswan xl2tpd
  fi
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
