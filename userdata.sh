#!/bin/sh
sudo curl -Lo /etc/yum.repos.d/wireguard.repo https://copr.fedorainfracloud.org/coprs/jdoss/wireguard/repo/epel-7/jdoss-wireguard-epel-7.repo
sudo amazon-linux-extras install epel
sudo yum update -y 
sudo yum install -y stress zip unzip jq
sudo yum -y install wireguard-dkms wireguard-tools
sudo mkdir /etc/wireguard && cd /etc/wireguard
sudo bash -c 'umask 077; touch wg0.conf'
sudo echo "${server_priv_key}" | tr -d '\n' > /etc/wireguard/private.key
sudo echo "${server_pub_key}" | tr -d '\n' > /etc/wireguard/public.key
sudo echo "net.ipv4.ip_forward=1" >/etc/sysctl.conf
sudo sysctl -p
sudo cat <<'EOF' >> /etc/wireguard/wg0.conf
[Interface]
Address = 10.23.23.1
PrivateKey = ${server_priv_key}
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
#PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
ListenPort = 54321
 
[Peer]
PublicKey = ${client_pub_key}
AllowedIPs = 10.23.23.2/32
EOF
at now + 2 minutes <<EOF
# Sleep here to allow dracut to regenerate the kernel modules post reboot
sleep 120 
sudo systemctl enable wg-quick@wg0  --now
sudo systemctl start wg-quick@wg0
#sudo wg-quick up wg0
EOF
at now + 1 minutes <<EOF
sudo reboot
EOF
