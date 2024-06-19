#!/bin/bash

# Default value for ASCII art display
SHOW_ASCII=true

# Check if --no-ascii flag is provided
for arg in "$@"; do
    if [ "$arg" = "--no-ascii" ]; then
        SHOW_ASCII=false
        break
    fi
done

# ASCII Art
ascii_art="\
       _           _   ______   _       _     
      | |         | | |  ____| | |     | |    
      | |_   _ ___| |_| |__ ___| |_ ___| |__  
  _   | | | | / __| __|  __/ _ \ __/ __| '_ \ 
 | |__| | |_| \__ \ |_| | |  __/ || (__| | | |
  \____/ \__,_|___/\__|_|  \___|\__\___|_| |_|
"

# Function to get the operating system and kernel version
get_os_info() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        os_name=$NAME
    else
        os_name=$(uname -o)
    fi
    echo " \033[5;34m➜\033[0m \033[1;34mOperating System:\033[0m $os_name"
    echo " \033[5;34m➜\033[0m \033[1;34mKernel Version:\033[0m $(uname -r)"
}

# Function to get the system uptime
get_uptime() {
    echo " \033[5;32m➜\033[0m \033[1;32mUptime:\033[0m $(uptime -p)"
}

# Function to get memory usage
get_memory_usage() {
    mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    mem_available=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
    echo " \033[5;35m➜\033[0m \033[1;35mMemory Usage:\033[0m $(( (mem_total - mem_available) / 1024 )) MB / $(( mem_total / 1024 )) MB"
}

# Function to get CPU information
get_cpu_info() {
    echo " \033[5;36m➜\033[0m \033[1;36mCPU:\033[0m $(grep 'model name' /proc/cpuinfo | uniq | awk -F': ' '{print $2}')"
}

# Function to get the current date and time
get_time_info() {
    echo " \033[5;33m➜\033[0m \033[1;33mDate & Time:\033[0m $(date)"
}

# Function to get the current user
get_current_user() {
    echo " \033[5;33m➜\033[0m \033[1;33mCurrent User:\033[0m $(whoami)"
}

# Main function to call all other functions
main() {
    if [ "$SHOW_ASCII" = true ]; then
        echo "\033[1;31m$ascii_art"
    fi
    get_os_info
    get_uptime
    get_memory_usage
    get_cpu_info
    get_time_info
    get_current_user
}

# Call the main function
main
