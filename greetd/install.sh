#!/bin/bash
sudo cp config.toml /etc/greetd/config.toml
sudo usermod -aG video greeter
sudo systemctl enable greetd
sudo systemctl disable lightdm
echo "greetd configured."
