#!/usr/bin/env bash

# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

get_temperature()
{
    temperature=$(curl -s -H "Authorization: Bearer ${HA_TOKEN}" https://${HA_HOSTNAME}/api/states/sensor.outside_temperature  | jq -r .state)
    printf "%.1f°F" "$temperature"
}


main() {
    # storing the refresh rate in the variable RATE, default is 5
    RATE=$(get_tmux_option "@dracula-refresh-rate" 5)
    echo $(get_temperature)
    sleep $RATE
}

# run main driver
main
