IP_LOOKUP="$(ip route get 8.8.8.8 | awk '{ print $NF; exit }')"  # May not work for VPN / tun0
IPv6_LOOKUP="$(ip -6 route get 2001:4860:4860::8888 | awk '{for(i=1;i<=NF;i++) if ($i=="src") print $(i+1)}')"  # May not work for VPN / tun0
IP="${IP:-$IP_LOOKUP}"  # use $IP, if set, otherwise IP_LOOKUP
IPv6="${IPv6:-$IPv6_LOOKUP}"  # use $IPv6, if set, otherwise IP_LOOKUP
DOCKER_CONFIGS="$(pwd)"  # Default of directory you run this from, update to where ever.

echo "### Make sure your IPs are correct, hard code ServerIP ENV VARs if necessary"
echo "IP: ${IP}"
echo "IPv6: ${IPv6}"
docker run -d --name pihole -p 53:53/tcp -p 53:53/udp -p 67:67/udp -p 80:80 -p 443:443 -v "/opt/pihole:/etc/pihole/" -v "/opt/pihole/dnsmasq:/etc/dnsmasq.d/" -e ServerIP="${IP}" -e ServerIPv6="${IPv6}" --restart=unless-stopped --cap-add=NET_ADMIN pihole/pihole:v4.0_armhf

echo -n "Your password for https://${IP}/admin/ is "
docker logs pihole 2> /dev/null | grep 'password:'