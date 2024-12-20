#!/usr/bin/bash


UTILS_FILE="$(dirname "$0")/functions.sh"


# shellcheck disable=SC1090
source "$UTILS_FILE"




# Main script execution
while true; do
    echo "Process Information Viewer"
    echo "1. List processes"
    echo "2. Get process info"
    echo "3. Kill a process"
    echo "4. Process stats"
    echo "5. Realtime monitor"
    echo "6. Search process by user"
    echo "7. Log process info"
    echo "8. Set Memory Limit and CPU Limit"
    echo "9. Exit"
    echo "Choose an option: "
    read -r choice

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
        6) Search_process
            ;;       
        7) Log_process_info
            ;;
        8)  Set_Memory_CPU_Limits
            ;;
           
        9)
            echo "Exiting."
            break
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
done
