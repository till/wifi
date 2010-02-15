#!/bin/bash

#
# Eine "Anleitung" von Ulf Kypke um Kamikaze images mit Luci-Weboberflaeche zu
# basteln.
#
# Hinweis:
# Wir legen in Verzeichnis $HOME/tmp/openwrt an in dem alles gebaut werden kann
# ohne das root benoetigt wird. Ggf. sollte $BUILDDIR angepasst werden.
#
# Die dependencies fuer Ubuntu/Debian werden mit sudo installiert.
#

source ./functions

BUILDDIR=~/tmp/openwrt
OS=`uname -v`

case "$OS" in

    *Ubuntu*)
        #apt-get update
        ubuntu_deps
    ;;

    *Debian*)
        #apt-get update
        debian_deps
    ;;

    *)
        echo "Unknown OS: ${OS}"
        exit 1;
    ;;

esac

get_openwrt
build_openwrt
show_result
