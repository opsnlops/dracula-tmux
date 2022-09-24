#!/usr/bin/env bash

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source $current_dir/utils.sh

get_data()
{
    power=$(curl -s -H "Authorization: Bearer ${HA_TOKEN}" https://${HA_HOSTNAME}/api/states/sensor.aprils_nest_energy_monitor_electric_consumption_w | jq -r .state)
    wind=$(curl -s -H "Authorization: Bearer ${HA_TOKEN}" https://${HA_HOSTNAME}/api/states/sensor.wind_speed_avg | jq -r .state)
    temperature=$(curl -s -H "Authorization: Bearer ${HA_TOKEN}" https://${HA_HOSTNAME}/api/states/sensor.outside_temperature  | jq -r .state)
    printf "%.1f°F %.1fmph %.1fw" "$temperature" "$wind" "$power"
}


main() {
    # storing the refresh rate in the variable RATE, default is 5
    RATE=$(get_tmux_option "@dracula-refresh-rate" 5)
    echo $(get_data)
    sleep $RATE
}

# run main driver
main
