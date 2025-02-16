#!/bin/sh

PKG_URL="https://raw.githubusercontent.com/ever-iot/docs/refs/heads/main/packages"
OPENWRT_PKG="iot4b_openwrt.ipk"
KEENETIC_PKG="iot4b_keenetic.ipk"
LIBNDM_PKG="libndm_1.8.0-1_mipsel-3.4_kn.ipk"
NDMQ_PKG="ndmq_1.0.2-7_mipsel-3.4_kn.ipk"

if [ -f /etc/openwrt_release ]; then
    echo "Detected OpenWRT."
    echo "Downloading package..."
    wget -O /tmp/$OPENWRT_PKG "$PKG_URL/$OPENWRT_PKG" || { echo "Failed to download iot4b_openwrt"; exit 1; }
    echo "Installing package..."
    opkg install /tmp/$OPENWRT_PKG
    echo "Cleaning up..."
    rm -f /tmp/$OPENWRT_PKG
elif grep -qi "NDMS" /proc/version; then
    echo "Detected Keenetic."
    echo "Downloading packages..."
    wget -O /tmp/$LIBNDM_PKG "$PKG_URL/$LIBNDM_PKG" || { echo "Failed to download libndm"; exit 1; }
    wget -O /tmp/$NDMQ_PKG "$PKG_URL/$NDMQ_PKG" || { echo "Failed to download ndmq"; exit 1; }
    wget -O /tmp/$KEENETIC_PKG "$PKG_URL/$KEENETIC_PKG" || { echo "Failed to download iot4b_keenetic"; exit 1; }
    echo "Installing packages..."
    opkg install /tmp/$LIBNDM_PKG
    opkg install /tmp/$NDMQ_PKG
    opkg install /tmp/$KEENETIC_PKG
    echo "Cleaning up..."
    rm -f /tmp/$LIBNDM_PKG
    rm -f /tmp/$NDMQ_PKG
    rm -f /tmp/$KEENETIC_PKG
fi
