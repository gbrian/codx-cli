sudo apt update
export PASSWORD=$(openssl rand -base64 12)
# Listen on port 9080
export CODER_HTTP_ADDRESS=0.0.0.0:${PORT:-9080}

curl -fsSL https://coder.com/install.sh | sh

sudo systemctl enable --now coder
journalctl -u coder.service -b
