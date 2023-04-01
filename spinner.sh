#!/bin/bash

spinner="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
message="$2"

echo -ne "$message "

# Run the command in the background
eval "$1" > /dev/null 2>&1 &
pid=$!

# Animate the spinner while the command is running
while kill -0 $pid 2> /dev/null; do
    for i in $(seq 0 ${#spinner})-1; do
        echo -ne "\r${spinner:$i:1} $message"
        echo -ne "\b"
        sleep 0.1
    done
done

# Check if the command succeeded or failed
if [ ${PIPESTATUS[@]} -eq 0 ]; then
    echo -e "\r\033[32m✔\033[0m $message"
else
    echo -e "\r\033[31m✘\033[0m $message"
fi

# Return the exit code of the command
wait $pid
exit ${PIPESTATUS[@]}
