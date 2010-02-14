#/usr/bin/env bash

OS=`uname -v`

case "$OS" in

    *Ubuntu*)

        apt-get install -y subversion build-essential binutils flex bison autoconf gettext
        apt-get install -y texinfo sharutils subversion ncurses-dev zlib1g-dev
        apt-get install -y rsync gawk unzip screen mc rsync tcpdump net-tools tftpd
    ;;

    *Debian*)

        apt-get install -y subversion build-essential binutils flex bison autoconf gettext
        apt-get install -y texinfo sharutils subversion libncurses5-dev zlib1g-dev
        apt-get install -y rsync gawk unzip screen mc rsync tcpdump net-tools tftpd

    ;;

    *)

        echo "Unknown OS: ${OS}"
        exit 1;

    ;;

esac

get_openwrt
build_openwrt

function get_openwrt {
    mkdir /tmp/openwrt
    cd /tmp/openwrt
    svn co svn://svn.openwrt.org/openwrt/trunk
    cd trunk
}

function build_openwrt {
    make menuconfig
    make

    cp feeds.conf.default feeds.conf
    scripts/feeds update

    make package/symlinks

    make menuconfig

    make
}