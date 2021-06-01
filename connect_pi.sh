#!/bin/bash
ENDPOINT=$(cat server_endpoint.txt)
ENDPOINT_PUBKEY=$(cat server_public.key)
INTERFACE="eth0"
sudo ip link del wg0 
sudo ip link add wg0 type wireguard
sudo ip addr add 10.23.23.2/24 dev wg0
sudo wg set wg0 listen-port 54321 private-key ./client_private.key
sudo wg
sudo wg set wg0 peer ${ENDPOINT_PUBKEY} allowed-ips 0.0.0.0/0 endpoint ${ENDPOINT}:54321
sudo ip link set wg0 up
sudo ip route del default
sudo ip route add default dev wg0
sudo ip route add 192.168.1.0/24 dev ${INTERFACE}
sudo ip route add ${ENDPOINT}/32 via 192.168.1.254 dev ${INTERFACE}
