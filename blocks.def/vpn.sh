#!/bin/sh

wg

if [ $? == 1 ] ; then # VPN inactive
    printf "VPN"
else # VPN active
    printf "no VPN"
fi

