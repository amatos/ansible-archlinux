#!/bin/env bash

# RENEWED_DOMAINS -- contains a space-delimited list of renewed certificate domains (for example, example.com www.example.com)
# RENEWED_LINEAGE -- points to the config live subdirectory (for example, /etc/letsencrypt/live/example.com) containing the new certificates and keys

DEST_DIR=/home/alberth/.local/state/syncthing
DEST_CERT="$DEST_DIR"/https-cert.pem
DEST_KEY="$DEST_DIR"/https-key.pem

if [ ! -e "$DEST_DIR" ]; then
    mkdir -p "$DEST_DIR"
fi

cat "$RENEWED_LINEAGE/cert.pem" "$RENEWED_LINEAGE/fullchain.pem" > "$DEST_CERT"
cp "$RENEWED_LINEAGE/privkey.pem" "$DEST_KEY"

chown alberth:alberth "$DEST_CERT"
chown alberth:alberth "$DEST_KEY"
