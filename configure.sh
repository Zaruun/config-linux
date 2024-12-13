#!/bin/bash

# Function to display an error message and exit the script
die() {
    echo "[ERROR] $1" >&2
    exit 1
}

# GitHub configuration urls
wslUbuntuRepoUrl="https://raw.githubusercontent.com/Zaruun/config-wsl-ubuntu/refs/heads/main/run.sh"

# Function to initialize the system (update and install git)
init() {
    local os=$1
    case "$os" in
        ubuntu)
            echo "[INFO] Initializing Ubuntu system..."
            sudo apt update || die "Failed to update package repositories on Ubuntu."
            sudo apt upgrade -y || die "Failed to upgrade packages on Ubuntu."
            sudo apt install -y git || die "Failed to install git on Ubuntu."
            ;;
        fedora)
            echo "[INFO] Initializing Fedora system..."
            sudo dnf update -y || die "Failed to update package repositories on Fedora."
            sudo dnf install -y git || die "Failed to install git on Fedora."
            ;;
        *)
            die "Unsupported system for initialization: $os"
            ;;
    esac
}

# Get operating system information
osVersion=$(uname -a)
echo "[INFO] Detecting operating system..."

# Handle different operating systems
case "$osVersion" in
    *[Ww][Ss][Ll]*)
        echo "[INFO] WSL detected. Determining the underlying distribution..."
        if [[ -f /etc/os-release ]]; then
            source /etc/os-release
            case "$ID" in
                ubuntu)
                    echo "[INFO] Ubuntu detected under WSL."
                    init ubuntu
		    curl -fsSL $wslUbuntuRepoUrl | bash
                    ;;
                fedora)
                    echo "[INFO] Fedora detected under WSL."
                    init fedora
                    ;;
                *)
                    die "Unsupported distribution under WSL: $ID"
                    ;;
            esac
        else
            die "Cannot determine distribution under WSL: /etc/os-release not found."
        fi
        ;;
    *[Uu]buntu*)
        echo "[INFO] Ubuntu detected."
        init ubuntu
        echo "ubuntu config"
        ;;
    *[Ff]edora*)
        echo "[INFO] Fedora detected."
        init fedora
        ;;
    *)
        die "Operating system not supported by this script."
        ;;
esac

# End of script
echo "[INFO] The script completed successfully."
exit 0
