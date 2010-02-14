#/usr/bin/env bash

#
# Eine "Anleitung" von Ulf Kypke um Kamikaze images mit Luci-Weboberflaeche zu
# basteln.
#

BUILDDIR=/tmp/openwrt
OS=`uname -v`

case "$OS" in

    *Ubuntu*)

        apt-get update
        apt-get install -y subversion build-essential binutils flex bison autoconf gettext
        apt-get install -y texinfo sharutils subversion ncurses-dev zlib1g-dev
        apt-get install -y rsync gawk unzip screen mc rsync tcpdump net-tools tftpd
    ;;

    *Debian*)

        apt-get update
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
show

function get_openwrt {
    mkdir -p ${BUILDDIR}
    cd ${BUILDDIR}
    svn co svn://svn.openwrt.org/openwrt/trunk
    cd ${BUILDDIR}/trunk
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

function show {
    ls -l ${BUILDDIR}/bin/
    ls -l ${BUILDDIR}/bin/packages/
}