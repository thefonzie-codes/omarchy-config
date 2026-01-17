#!/bin/bash

echo "Installing Tailscale..."
paru -S tailscale
echo "Enabling and starting the Tailscale service..."
sudo systemctl enable --now tailscaled
sudo systemctl status tailscaled
sudo taiscale up
echo "Your Tailscale IPv4 is..."
sudo tailscale ip -4
echo "Tailscale installed."
