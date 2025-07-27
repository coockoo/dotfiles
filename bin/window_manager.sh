# TODO: rewrite this to use native swift instead of osascript

function window_manager() {
  local action="$1"
  # echo "action: $action"

  if [ -z "$action" ]; then
    echo "Usage: window_manager <action>"
    echo "Actions:"
    echo "  full-screen: set window to full screen"
    echo "  split-west: set window to west split (80%)"
    echo "  split-east: set window to east split (80%)"
    return 1
  fi

  local screen_size=$(system_profiler SPDisplaysDataType | awk '/Resolution/{print $2, $4}')
  if [ -z "$screen_size" ]; then
    echo "Error: unable to retrieve screen size." >&2
    return 1
  fi

  local bar_size=38
  local screen_width=$(echo "$screen_size" | awk '{print $1}')
  screen_width=$((screen_width / 2))
  local screen_height=$(echo "$screen_size" | awk '{print $2}')
  screen_height=$((screen_height / 2 - bar_size - 86)) # adjust for menu bar and dock
  # echo "screen: $screen_width x $screen_height"

  # get current window size on macos
  local window_size=$(osascript -e '
  tell application "System Events" to tell (process 1 where frontmost is true)
    set ws to the size of window 1
    set wp to the position of window 1
    return ws & wp
  end tell' | tr -d ',')
  if [ -z "$window_size" ]; then
    echo "Error: unable to retrieve current window size." >&2
    return 1
  fi

  local width=$(echo "$window_size" | awk '{print $1}')
  local height=$(echo "$window_size" | awk '{print $2}')
  local x=$(echo "$window_size" | awk '{print $3}')
  local y=$(echo "$window_size" | awk '{print $4}')
  # echo "wh: $width x $height"
  # echo "xy: $x x $y"

  if [ "$action" == "full-screen" ]; then
    osascript -e "
    tell application \"System Events\" to tell (process 1 where frontmost is true)
      set position of window 1 to {0, $bar_size}
      set size of window 1 to {$screen_width, $screen_height}
    end tell"
    return 0
  fi

  if [ "$action" == "split-east" ]; then
    local new_width=$((screen_width * 8 / 10))
    local new_x=$((screen_width - new_width))
    osascript -e "
    tell application \"System Events\" to tell (process 1 where frontmost is true)
      set position of window 1 to {$new_x, $bar_size}
      set size of window 1 to {$new_width, $screen_height}
    end tell"
    return 0
  fi

  if [ "$action" == "split-west" ]; then
    local new_width=$((screen_width * 8 / 10))
    osascript -e "
    tell application \"System Events\" to tell (process 1 where frontmost is true)
      set position of window 1 to {0, $bar_size}
      set size of window 1 to {$new_width, $screen_height}
    end tell"
    return 0
  fi

  echo "Unknown action: $action" >&2
  return 1
}

window_manager "$@"
