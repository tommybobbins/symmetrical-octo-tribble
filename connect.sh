#!/bin/bash
ENDPOINT=$(cat server_endpoint.txt)
ENDPOINT_PUBKEY=$(cat server_public.key)
INTERFACE="eno1"
ip link del wg0 
ip link add wg0 type wireguard
ip addr add 10.23.23.2/24 dev wg0
wg set wg0 listen-port 54321 private-key ./client_private.key
wg
wg set wg0 peer ${ENDPOINT_PUBKEY} allowed-ips 0.0.0.0/0 endpoint ${ENDPOINT}:54321
wg set wg0 listen-port 54321 private-key ./client_private.key
ip link set wg0 up
ip route del default
ip route add default dev wg0
ip route add 192.168.1.0/24 dev ${INTERFACE}
ip route add ${ENDPOINT}/32 via 192.168.1.254 dev ${INTERFACE}
wg
