#!/bin/bash
# Script 2: FOSS Package Inspector
# Author: Student | Course: Open Source Software
# Purpose: Checks if a FOSS package is installed, shows its version
#          and license, then uses a case statement to describe it philosophically

# --- Set the package to inspect ---
# For the Linux Kernel audit, we inspect the kernel package itself
# On Debian/Ubuntu systems this is 'linux-image-*', on RHEL it is 'kernel'
PACKAGE="bash"   # Using 'bash' as it is universally available on all Linux systems
                 # and is itself a core GPL-licensed open source component

echo "========================================================"
echo "       FOSS PACKAGE INSPECTOR                          "
echo "========================================================"
echo ""

# --- Detect which package manager is available ---
# Different Linux distros use different package managers
if command -v rpm &>/dev/null; then
    PKG_MANAGER="rpm"
elif command -v dpkg &>/dev/null; then
    PKG_MANAGER="dpkg"
else
    echo "No supported package manager found (rpm or dpkg)."
    exit 1
fi

echo "  Package Manager Detected : $PKG_MANAGER"
echo ""

# --- Check if package is installed using if-then-else ---
if [ "$PKG_MANAGER" = "rpm" ]; then
    # RPM-based system (RHEL, CentOS, Fedora)
    if rpm -q $PACKAGE &>/dev/null; then
        echo "  STATUS: $PACKAGE is INSTALLED on this system."
        echo ""
        echo "  PACKAGE DETAILS:"
        echo "  ----------------"
        # Use grep with pipe to extract only the fields we need
        rpm -qi $PACKAGE | grep -E "^(Version|License|Summary|Size)" | \
            while IFS= read -r line; do echo "  $line"; done
    else
        echo "  STATUS: $PACKAGE is NOT installed on this system."
        echo "  To install: sudo yum install $PACKAGE"
    fi

elif [ "$PKG_MANAGER" = "dpkg" ]; then
    # Debian-based system (Ubuntu, Debian, Mint)
    if dpkg -l $PACKAGE 2>/dev/null | grep -q "^ii"; then
        echo "  STATUS: $PACKAGE is INSTALLED on this system."
        echo ""
        echo "  PACKAGE DETAILS:"
        echo "  ----------------"
        # dpkg -s gives full package status; grep the important fields
        dpkg -s $PACKAGE 2>/dev/null | grep -E "^(Version|License|Description|Installed-Size)" | \
            while IFS= read -r line; do echo "  $line"; done
    else
        echo "  STATUS: $PACKAGE is NOT installed on this system."
        echo "  To install: sudo apt install $PACKAGE"
    fi
fi

echo ""
echo "========================================================"
echo "  OPEN SOURCE PHILOSOPHY NOTE"
echo "========================================================"
echo ""

# --- Case statement: print a philosophy note based on the package name ---
# Each case matches a known open-source package and prints its significance
case $PACKAGE in
    bash)
        echo "  GNU Bash: The shell that has been the gateway to Linux"
        echo "  for millions of users. Written by Brian Fox in 1989 for"
        echo "  the GNU Project. Free software that gave everyone a"
        echo "  command line, not just those who could afford proprietary Unix."
        ;;
    httpd|apache2)
        echo "  Apache HTTP Server: The web server that built the open internet."
        echo "  In the late 1990s it powered over 60% of all websites."
        echo "  Proof that community-built software can outperform corporate products."
        ;;
    mysql|mariadb)
        echo "  MySQL/MariaDB: Open source at the heart of millions of apps."
        echo "  Its dual-license model sparked important debates about whether"
        echo "  open source and commercial software can truly coexist."
        ;;
    firefox)
        echo "  Firefox: Mozilla's answer to browser monopoly. A nonprofit"
        echo "  organisation fighting to keep the web open, standards-based,"
        echo "  and free from corporate control. Born from the Netscape source code."
        ;;
    vlc)
        echo "  VLC Media Player: Built by students at a French university"
        echo "  who just wanted to stream video across their campus network."
        echo "  Now plays virtually every media format on every platform — for free."
        ;;
    python3|python)
        echo "  Python: A language shaped entirely by its community."
        echo "  Guido van Rossum designed it to be readable and accessible."
        echo "  The PSF license ensures it remains free for everyone, forever."
        ;;
    git)
        echo "  Git: Linus Torvalds built this in 2005 after a proprietary"
        echo "  version control tool (BitKeeper) revoked the Linux kernel's"
        echo "  free license. Open source created the need; open source filled it."
        ;;
    linux-kernel|kernel)
        echo "  The Linux Kernel: The foundation everything else runs on."
        echo "  Started in 1991 by a Finnish student who just wanted a free OS."
        echo "  Now runs 97% of the world's top supercomputers, most smartphones,"
        echo "  and the majority of web servers on the planet."
        ;;
    *)
        # Default case for any package not in our list
        echo "  $PACKAGE: Every installed package on a Linux system tells"
        echo "  a story of someone who chose to build something and share it"
        echo "  freely with the world. That choice is the foundation of"
        echo "  modern computing."
        ;;
esac

echo ""
echo "========================================================"
