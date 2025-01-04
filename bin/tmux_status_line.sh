# A script to fetch a variety of data and display it on a single line. Used for
# tmux status lines.
#
# Usage: tmux_status_line.sh <ZIP_CODE>

# Fill this out here, or set it in .bash_profile_local
OWM_APIKEY=""

# Check for valid args, and print out directions if they aren't given.
if [[ "$#" -ne 1 ]]; then
  echo "Invalid args, check your tmux config"
  exit
fi

# Fetch PWS weather data from the station-id given by $1.
zip="$1"
weather=$($HOME/bin/runcached.py -t 60 \
          "curl -s 'https://api.openweathermap.org/data/2.5/weather?zip=$zip&appid=$OWM_APIKEY&units=imperial' | jq '.main.temp' | cut -f1 -d'.'")

# Mem usage
total_mem=$(vmstat -sS M | grep "total memory" | sed 's/^[[:space:]]*//' | cut -f1 -d' ')
used_mem=$(vmstat -sS M | grep "used memory" | sed 's/^[[:space:]]*//' | cut -f1 -d' ')
percent_used=$(python3 -c "print(int($used_mem / float($total_mem) * 100))")

# Final format and display.
/usr/bin/printf "${weather}°F | ${used_mem}/${total_mem} [${percent_used}%%]"

