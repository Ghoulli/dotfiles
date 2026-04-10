#!/bin/bash
sudo cp nftables.conf /etc/nftables.conf
sudo systemctl enable --now nftables
echo "nftables configured."
