#!/bin/bash
# Script 3: Disk and Permission Auditor
# Author: Student | Course: Open Source Software
# Purpose: Loops through key system directories and reports their
#          disk usage, owner, and permissions. Also checks for
#          the Linux kernel's configuration directory.

# --- Define the list of directories to audit ---
# These are the most important directories in a Linux filesystem
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/boot" "/usr/lib")

echo "========================================================"
echo "       DISK AND PERMISSION AUDITOR                     "
echo "========================================================"
echo ""
echo "  Scanning system directories..."
echo ""
printf "  %-20s %-25s %-10s\n" "DIRECTORY" "PERMISSIONS (type user group)" "SIZE"
printf "  %-20s %-25s %-10s\n" "---------" "-----------------------------" "----"
echo ""

# --- For loop: iterate through each directory in the list ---
for DIR in "${DIRS[@]}"; do

    # Check if the directory actually exists before trying to inspect it
    if [ -d "$DIR" ]; then

        # Extract permissions, owner user and group using awk
        # ls -ld gives: drwxr-xr-x 1 root root 4096 date dirname
        # awk prints fields 1 (permissions), 3 (user), 4 (group)
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')

        # du -sh gives human-readable size; cut -f1 takes only the size column
        # 2>/dev/null silences permission-denied errors
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # Print the result in formatted columns
        printf "  %-20s %-25s %-10s\n" "$DIR" "$PERMS" "${SIZE:-N/A}"

    else
        # Directory does not exist on this system
        printf "  %-20s %s\n" "$DIR" "[ does not exist on this system ]"
    fi

done

echo ""
echo "========================================================"
echo "  LINUX KERNEL CONFIG DIRECTORY CHECK"
echo "========================================================"
echo ""

# --- Extra section: Check for the Linux kernel's configuration directory ---
# The kernel stores boot configuration in /boot and module configs in /etc/modprobe.d
KERNEL_DIRS=("/boot" "/etc/modprobe.d" "/lib/modules" "/proc/sys/kernel")

for KDIR in "${KERNEL_DIRS[@]}"; do
    if [ -d "$KDIR" ]; then
        # Get full permission details for kernel-related directories
        KPERMS=$(ls -ld "$KDIR" | awk '{print $1, $3, $4}')
        KSIZE=$(du -sh "$KDIR" 2>/dev/null | cut -f1)
        echo "  Found : $KDIR"
        echo "  Perms : $KPERMS | Size: ${KSIZE:-N/A}"
        echo ""
    else
        echo "  Not found : $KDIR"
        echo ""
    fi
done

# --- Security note about permissions ---
echo "========================================================"
echo "  PERMISSION SECURITY NOTES"
echo "========================================================"
echo ""
echo "  In Linux, file permissions follow the pattern:"
echo "  [type][owner][group][others] — e.g. drwxr-xr-x"
echo ""
echo "  d = directory, r = read, w = write, x = execute, - = no permission"
echo ""
echo "  Why this matters for open source software:"
echo "  - /etc is readable by all but only writable by root (security)"
echo "  - /usr/bin executables are owned by root (prevents tampering)"
echo "  - /tmp is world-writable so any program can use it temporarily"
echo "  - /boot is restricted — modifying it could break the kernel"
echo ""
echo "========================================================"
