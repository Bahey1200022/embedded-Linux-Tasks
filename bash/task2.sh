#!/usr/bin/bash


source ./task.conf

#!/bin/bash

# Function to display detailed information about a specific process
get_process_info() {
    echo "Enter the PID of the process: "
    read pid

    # Check if the PID exists
    if ! ps -p "$pid" > /dev/null 2>&1; then
        echo "Process with PID $pid does not exist."
        return
    fi

    # Get process details
    echo "Details for process with PID $pid:"
    ps -p "$pid" -o pid,ppid,user,%cpu,%mem,etime,comm

    echo "Additional Information:"
    cat /proc/$pid/status 2>/dev/null | grep -E "^Name|^State|^VmSize|^VmRSS|^Threads"
}

# Main script execution
while true; do
    echo "Process Information Viewer"
    echo "1. List processes"
    echo "2. Get process info"
    echo "3. Kill a process"
    echo "4. Process stats"
    echo "2. Exit"
    echo "Choose an option: "
    read choice

    case $choice in
        1)
            list_processes
            ;;
        2)
            get_process_info
            ;;
        3)  kill_process
            ;;
        4)  Process_stats
            ;;        
        5) Realtime_monitor
            ;;
        6)        
        10)
            echo "Exiting."
            break
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
done
