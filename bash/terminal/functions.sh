#!/usr/bin/bash
CONFIG_FILE="$(dirname "$0")/task.conf"
# shellcheck disable=SC1090
source "$CONFIG_FILE"
list_processes() {
    ps aux 
}

get_process_info() {
    echo "Enter the process ID: "
    read -r pid
    ps -p "$pid"
}


kill_process() {
    echo "Enter the process ID: "
    read -r pid
    kill "$pid"
}

Process_stats() {
    echo "Enter the process ID: "
    read -r pid
    ps -p "$pid" -o pid,ppid,cmd,%mem,%cpu --sort=-%mem
}

Realtime_monitor() {
    while true; do
    echo "press q to quit"
    ps aux
     # Read single character with timeout
    read -t "$UPDATE_INTERVAL" -n 1 key
    
    # Check if 'q' was pressed
    if [[ $key == "q" ]]; then
        echo "Exiting monitor..."
        break
    fi
    sleep "$UPDATE_INTERVAL"
    
    done
}
    
Search_process() {
    echo "Enter the process name: "
    read -r pname
    ps aux | grep "$pname"
}    


Log_process_info() {
    echo "Enter the process ID: "
    read -r pid
    LOG_FILE="$(dirname "$0")/process.log"
    ps -p "$pid" -o pid,ppid,cmd,%mem,%cpu --sort=-%mem >> "$LOG_FILE"
}

Set_Memory_CPU_Limits() {
    echo "Monitoring processes (CPU threshold: ${CPU_ALERT_THRESHOLD}%, Memory threshold: ${MEMORY_ALERT_THRESHOLD}%)"
    echo "Press Ctrl+C to stop monitoring"
    
    while true; do
        # Check CPU usage
        ps aux | awk -v cpu_thresh="$CPU_ALERT_THRESHOLD" '
        NR>1 && $3 > cpu_thresh {
            printf "⚠️ High CPU: Process %s (PID: %s) using %.1f%% CPU\n", $11, $2, $3
        }'
        
        # Check Memory usage
        ps aux | awk -v mem_thresh="$MEMORY_ALERT_THRESHOLD" '
        NR>1 && $4 > mem_thresh {
            printf "⚠️ High Memory: Process %s (PID: %s) using %.1f%% Memory\n", $11, $2, $4
        }'
        
        sleep 5  # Wait 5 seconds before next check
    done
    
}



# Export functions to make them available
export -f list_processes
export -f get_process_info
export -f kill_process
export -f Process_stats
export -f Realtime_monitor
export -f Search_process
export -f Log_process_info
export -f Set_Memory_CPU_Limits
