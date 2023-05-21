#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 path/to/your/animated/gif"
    exit 1
fi

if [ ! -f "$1" ] || [ "${1##*.}" != "gif" ]; then
    echo "Error: Please provide a valid GIF file."
    exit 1
fi

declare -A osInfo;
osInfo[/etc/debian_version]="apt-get install -y"
osInfo[/etc/centos-release]="yum install -y"
osInfo[/etc/fedora-release]="dnf install -y"
osInfo[/etc/arch-release]="pacman -Sy"
osInfo[/etc/opensuse-version]="zypper install -y"

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
        install_command=${osInfo[$f]}
    fi
done

if ! command -v ffmpeg >/dev/null 2>&1; then
    echo "ffmpeg is not installed. Do you wish to install it? [Y/n]"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        sudo $install_command ffmpeg
    fi
fi

if ! command -v mpv >/dev/null 2>&1; then
    echo "mpv is not installed. Do you wish to install it? [Y/n]"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        sudo $install_command mpv
    fi
fi

if ! command -v xwinwrap >/dev/null 2>&1; then
    echo "xwinwrap is not installed. Do you wish to install it? [Y/n]"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        git clone https://github.com/ujjwal96/xwinwrap.git
        cd xwinwrap
        make
        sudo make install
        cd ..
        rm -rf xwinwrap
    fi
fi

gif_path="$1"
video_path="${1%.*}.mp4"
ffmpeg -i "$gif_path" -y -loglevel error "$video_path"

xwinwrap -ov -ni -fs -s -st -sp -b -nf -- mpv --wid=%WID --loop=inf --no-audio --no-osc --no-osd-bar -quiet --panscan=1.0 "$video_path" &
