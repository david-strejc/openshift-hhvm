#!/bin/sh

STAMP=$(date)

echo "[${STAMP}] Starting daemon..."
# run hhvm server daemon
hhvm --mode=server
