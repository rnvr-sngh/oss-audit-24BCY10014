#!/bin/bash
# Script 1: System Identity Report
# Author: Student | Course: Open Source Software
# Purpose: Displays a welcome screen with system information
#          and identifies the open-source license of the OS

# --- Variables ---
STUDENT_NAME="Your Name Here"        # Fill in your name before submission
SOFTWARE_CHOICE="Linux Kernel"       # The software being audited

# --- Gather system information using command substitution ---
KERNEL=$(uname -r)                   # Get the running kernel version
USER_NAME=$(whoami)                  # Get the currently logged-in user
UPTIME=$(uptime -p)                  # Human-readable uptime (e.g. up 2 hours)
DISTRO=$(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')  # Distro name
CURRENT_DATE=$(date '+%A, %d %B %Y %H:%M:%S')  # Formatted date and time
HOME_DIR=$HOME                       # Home directory of current user

# --- Determine the OS license ---
# The Linux Kernel is licensed under GPL v2
# Most Linux distributions carry this license for the kernel
OS_LICENSE="GNU General Public License version 2 (GPL v2)"

# --- Display the welcome screen ---
echo "========================================================"
echo "        OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT     "
echo "========================================================"
echo ""
echo "  Student   : $STUDENT_NAME"
echo "  Software  : $SOFTWARE_CHOICE"
echo "========================================================"
echo ""
echo "  SYSTEM INFORMATION"
echo "  ------------------"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  Logged in as : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date/Time    : $CURRENT_DATE"
echo ""
echo "  OS LICENSE"
echo "  ----------"
echo "  $OS_LICENSE"
echo ""
echo "  NOTE: The Linux Kernel itself is released under GPL v2."
echo "  This means you are free to run, study, share, and"
echo "  modify it — but any changes you distribute must also"
echo "  be shared under the same license."
echo ""
echo "========================================================"
echo "  Audit subject: $SOFTWARE_CHOICE"
echo "  This system runs on the very software being studied."
echo "========================================================"
