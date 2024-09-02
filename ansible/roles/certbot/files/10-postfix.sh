#!/bin/env bash

# RENEWED_DOMAINS -- contains a space-delimited list of renewed certificate domains (for example, example.com www.example.com)
# RENEWED_LINEAGE -- points to the config live subdirectory (for example, /etc/letsencrypt/live/example.com) containing the new certificates and keys

DEST_DIR=/etc/pki/tls/certs
DEST_CERT="$DEST_DIR"/postfix.pem
DEST_KEY="$DEST_DIR"/postfix.key

if [ ! -e "$DEST_DIR" ]; then
    mkdir -p "$DEST_DIR"
fi

cat "$RENEWED_LINEAGE/cert.pem" "$RENEWED_LINEAGE/fullchain.pem" > "$DEST_CERT"
cp "$RENEWED_LINEAGE/privkey.pem" "$DEST_KEY"
