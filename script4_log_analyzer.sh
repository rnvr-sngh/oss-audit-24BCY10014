#!/bin/bash
# Script 4: Log File Analyzer
# Author: Student | Course: Open Source Software
# Purpose: Reads a log file line by line, counts occurrences of a
#          keyword, prints a summary, and shows the last 5 matching lines.
#
# Usage:
#   ./script4_log_analyzer.sh /var/log/syslog
#   ./script4_log_analyzer.sh /var/log/syslog WARNING
#   ./script4_log_analyzer.sh /var/log/kern.log error

# --- Accept command-line arguments ---
LOGFILE=$1                   # First argument: path to the log file
KEYWORD=${2:-"error"}        # Second argument: keyword to search for (default: "error")

# --- Counter variable to track keyword matches ---
COUNT=0

echo "========================================================"
echo "       LOG FILE ANALYZER                               "
echo "========================================================"
echo ""

# --- Validate that the user provided a file argument ---
if [ -z "$LOGFILE" ]; then
    echo "  ERROR: No log file specified."
    echo "  Usage: $0 <logfile> [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    echo ""
    # Try a default log file if none provided
    if [ -f "/var/log/syslog" ]; then
        LOGFILE="/var/log/syslog"
        echo "  Falling back to default: /var/log/syslog"
    elif [ -f "/var/log/messages" ]; then
        LOGFILE="/var/log/messages"
        echo "  Falling back to default: /var/log/messages"
    elif [ -f "/var/log/kern.log" ]; then
        LOGFILE="/var/log/kern.log"
        echo "  Falling back to default: /var/log/kern.log"
    else
        echo "  No fallback log file found. Exiting."
        exit 1
    fi
fi

# --- Check that the specified file actually exists ---
if [ ! -f "$LOGFILE" ]; then
    echo "  ERROR: File '$LOGFILE' not found."
    echo "  Please provide a valid log file path."
    exit 1
fi

# --- Check that the file is not empty ---
# Do-while style retry: check size, if empty try a fallback log
if [ ! -s "$LOGFILE" ]; then
    echo "  WARNING: '$LOGFILE' is empty. Trying fallback logs..."
    echo ""
    # Try alternative log files in order
    for FALLBACK in /var/log/syslog /var/log/messages /var/log/kern.log /var/log/dmesg; do
        if [ -f "$FALLBACK" ] && [ -s "$FALLBACK" ]; then
            LOGFILE="$FALLBACK"
            echo "  Using fallback log: $LOGFILE"
            break
        fi
    done
    # If still empty after fallback attempts, exit
    if [ ! -s "$LOGFILE" ]; then
        echo "  ERROR: All candidate log files are empty. Cannot analyze."
        exit 1
    fi
fi

echo "  Log File : $LOGFILE"
echo "  Keyword  : '$KEYWORD' (case-insensitive)"
echo ""
echo "  Scanning file line by line..."
echo ""

# --- While-read loop: read the log file one line at a time ---
# IFS= preserves leading/trailing whitespace
# -r prevents backslash interpretation
while IFS= read -r LINE; do

    # If-then: check if this line contains the keyword (case-insensitive with -i)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))    # Increment our counter
    fi

done < "$LOGFILE"     # Feed the file into the while loop via redirection

# --- Print the summary results ---
echo "========================================================"
echo "  ANALYSIS RESULTS"
echo "========================================================"
echo ""
echo "  Keyword '$KEYWORD' found $COUNT time(s) in:"
echo "  $LOGFILE"
echo ""

# --- Show context based on the count ---
if [ "$COUNT" -eq 0 ]; then
    echo "  No matches found. The system log appears clean for this keyword."
elif [ "$COUNT" -lt 10 ]; then
    echo "  Low occurrence count — likely routine or informational."
elif [ "$COUNT" -lt 50 ]; then
    echo "  Moderate occurrences — worth reviewing the entries below."
else
    echo "  HIGH occurrence count — this may indicate a system issue."
fi

echo ""
echo "========================================================"
echo "  LAST 5 MATCHING LINES"
echo "========================================================"
echo ""

# --- Use grep piped into tail to show the last 5 matching lines ---
# grep -i = case-insensitive, then tail -5 = last 5 results
MATCHES=$(grep -i "$KEYWORD" "$LOGFILE" | tail -5)

if [ -n "$MATCHES" ]; then
    # Print each matching line with a line prefix for readability
    echo "$MATCHES" | while IFS= read -r MATCH_LINE; do
        echo "  >> $MATCH_LINE"
    done
else
    echo "  No matching lines to display."
fi

echo ""
echo "========================================================"
echo "  Total lines in file : $(wc -l < "$LOGFILE")"
echo "  Matching '$KEYWORD' : $COUNT"
echo "========================================================"
