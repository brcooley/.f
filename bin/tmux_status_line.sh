# A script to fetch a variety of data and display it on a single line. Used for
# tmux status lines.
#
# Usage: tmux_status_line.sh <WEATHER_STATION_ID> <ETH_ACCOUNT>

# Check for valid args, and print out directions if they aren't given.
if [[ "$#" -ne 2 ]]; then
  echo "Invalid args, check your tmux config"
  exit
fi

# Fetch PWS weather data from the station-id given by $1.
pws_id="$1"
weather=$(runcached.py -t 10 \
          "curl -s 'http://api.wunderground.com/weatherstation/WXCurrentObXML.asp?ID=$pws_id' | grep temp_f | cut -d \> -f 2 | cut -d \. -f 1")

# Fetch current ETH price.
eth_json=$(runcached.py -t 10 "curl -L -s https://api.coinmarketcap.com/v1/ticker/ethereum")
eth_price=$(echo "$eth_json" | jq '.[0].price_usd' | cut -d\" -f 2)
eth_change=$(echo "$eth_json" | jq '.[0].percent_change_1h' | cut -d\" -f 2)

# Fetch miner hashrate.
eth_account="$2"
hashrate_json=$(runcached.py -t 30 \
                "curl -s https://api.nanopool.org/v1/eth/avghashrate/$eth_account")
day_hr=$(echo "$hashrate_json" | jq '.data.h24')
hour_hr=$(echo "$hashrate_json" | jq '.data.h1')

# Final format and display.
/usr/bin/printf "${weather}°F | ⚒ %.1f [%.1f] | ETH \$%'.2f [%.2f%%]" "$hour_hr" "$day_hr" "$eth_price" "$eth_change"

