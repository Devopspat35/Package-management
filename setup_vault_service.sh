#!/bin/bash
# Define variables
VAULT_BIN="/usr/local/bin/vault"
VAULT_USER="vault"
VAULT_GROUP="vault"
VAULT_CONFIG="/etc/vault/config.hcl"
VAULT_SERVICE="/etc/systemd/system/vault.service"

# Ensure Vault binary exists
if [[ ! -f "$VAULT_BIN" ]]; then
    echo "Error: Vault binary not found at $VAULT_BIN"
    exit 1
fi

# Create Vault user and group if not exist
if ! id "$VAULT_USER" &>/dev/null; then
    echo "Creating Vault user..."
    sudo useradd --system --home /etc/vault --shell /bin/false "$VAULT_USER"
fi

# Ensure Vault configuration directory exists
sudo mkdir -p /etc/vault
sudo chown -R "$VAULT_USER":"$VAULT_GROUP" /etc/vault
sudo chmod 750 /etc/vault

# Create a sample Vault configuration if not exist
if [[ ! -f "$VAULT_CONFIG" ]]; then
    echo "Creating default Vault configuration..."
    cat <<EOF | sudo tee "$VAULT_CONFIG"
storage "file" {
  path = "/etc/vault/data"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

disable_mlock = true
ui = true
EOF
fi

# Create systemd service file
echo "Creating Vault systemd service file..."
cat <<EOF | sudo tee "$VAULT_SERVICE"
[Unit]
Description=HashiCorp Vault
Requires=network-online.target
After=network-online.target

[Service]
ExecStart=$VAULT_BIN server -config=$VAULT_CONFIG
Restart=always
User=$VAULT_USER
Group=$VAULT_GROUP
Environment="VAULT_ADDR=http://127.0.0.1:8200"
CapabilityBoundingSet=CAP_IPC_LOCK
NoNewPrivileges=true
ProtectSystem=full
ProtectHome=true
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF

# Set permissions and reload systemd
sudo chmod 644 "$VAULT_SERVICE"
sudo systemctl daemon-reload
sudo systemctl enable vault
sudo systemctl start vault

echo "Vault service has been installed and started."
sudo systemctl status vault --no-pager
