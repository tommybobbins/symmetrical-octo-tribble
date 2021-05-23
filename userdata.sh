#!/bin/sh
sudo curl -Lo /etc/yum.repos.d/wireguard.repo https://copr.fedorainfracloud.org/coprs/jdoss/wireguard/repo/epel-7/jdoss-wireguard-epel-7.repo
sudo amazon-linux-extras install epel
sudo yum update -y 
sudo yum install -y stress zip unzip jq
sudo yum -y install wireguard-dkms wireguard-tools
sudo mkdir /etc/wireguard && cd /etc/wireguard
sudo bash -c 'umask 077; touch wg0.conf
sudo wg genkey > /etc/wireguard/private.key
sudo wg pubkey < /etc/wireguard/private.key > /etc/wireguard/public.key
