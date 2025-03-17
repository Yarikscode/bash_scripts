#!/bin/bash

send_telegram() {
    local message="$1"
    curl -s -X POST "https://api.telegram.org/bot<YOUR_TOKEN>/sendMessage" \
         -d chat_id="<CHAT_ID>" \
         -d text="$message"
}

writelog() {
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    local level="$1"
    local message="$2"
    echo "$timestamp $level $message in $HOSTNAME" >> /home/yaroslav/script_dockerimagecheck/findimages.log
}

for i in "$@"; do
  timestamp=$(date "+%Y-%m-%d %H:%M:%S")

  old_meta=$(docker images --quiet "$i")

  if [ "test$old_meta" == "test" ]; then
          writelog "INFO" "$i not found ... downloading"
          old_meta="empty"
  fi

  docker pull "$i"
  new_meta=$(docker images --quiet "$i")
        if [ $old_meta != $new_meta ]; then
                writelog "INFO" "New version of $i found"
                send_telegram "$timestamp INFO New version of $i found in $HOSTNAME"
        else
                writelog "INFO" "New version of $i is not found"
        fi
done