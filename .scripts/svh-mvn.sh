#!/bin/sh

enable() {
    if [ -f $HOME/.m2/settings.xml ]; then
        echo "Already enabled"
    else
        cp $HOME/code/svh/meta/m2_settings.xml $HOME/.m2/settings.xml
        cp $HOME/code/svh/meta/m2_settings-security.xml $HOME/.m2/settings-security.xml
        cp $HOME/code/svh/meta/m2_mavenrc $HOME/.mavenrc
    fi
}

disable() {
    if [ -f $HOME/.m2/disabled_settings.xml ]; then
        echo "Already disabled"
    else
        rm $HOME/.m2/settings.xml
        rm $HOME/.m2/settings-security.xml
        rm $HOME/.mavenrc
    fi
}

case "$1" in
    enable)
        enable
        ;;
    disable)
        disable
        ;;
    *)
        echo "Usage: $0 {enable|disable}" >&2
        exit 1
        ;;
esac
