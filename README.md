# OSS Capstone Audit — Linux Kernel

**Student Name:** Your Name Here  
**Registration Number:** Your Roll Number Here  
**Course:** Open Source Software (OSS NGMC)  
**Software Audited:** The Linux Kernel  
**Licence of Audited Software:** GNU General Public License v2 (GPL v2)

---

## About This Repository

This repository contains the shell scripts submitted as part of the Open Source Software Capstone Project. The audit subject is the **Linux Kernel** — the open-source operating system kernel first released by Linus Torvalds in 1991 and now maintained by thousands of contributors worldwide under the GPL v2 licence.

---

## Repository Structure

```
oss-audit-[rollnumber]/
├── script1_system_identity.sh        # System Identity Report
├── script2_package_inspector.sh      # FOSS Package Inspector
├── script3_disk_permission_auditor.sh # Disk and Permission Auditor
├── script4_log_analyzer.sh           # Log File Analyzer
├── script5_manifesto_generator.sh    # Open Source Manifesto Generator
└── README.md                         # This file
```

---

## Scripts Overview

### Script 1 — System Identity Report
Displays a formatted welcome screen showing the Linux distribution name, kernel version, logged-in user, home directory, system uptime, current date/time, and the GPL v2 licence that governs the OS.

**Concepts demonstrated:** Variables, command substitution `$()`, `echo`, `uname`, `whoami`, `uptime`, `date`, `/etc/os-release`

---

### Script 2 — FOSS Package Inspector
Checks whether a specified open-source package is installed, displays its version and licence details, and uses a `case` statement to print a philosophical note about the package based on its name. Supports both RPM and dpkg-based systems.

**Concepts demonstrated:** `if-then-else`, `case` statement, `rpm -qi`, `dpkg -s`, `grep` with pipe, `command -v`

---

### Script 3 — Disk and Permission Auditor
Loops through a list of important system directories using a `for` loop and reports permissions, owner, group, and disk usage for each. Also checks Linux Kernel-specific directories (`/boot`, `/lib/modules`, `/proc/sys/kernel`, `/etc/modprobe.d`).

**Concepts demonstrated:** `for` loop, arrays `${DIRS[@]}`, `ls -ld`, `awk`, `du -sh`, `cut`, directory existence test `-d`, `printf` formatting

---

### Script 4 — Log File Analyzer
Reads a log file line by line, counts how many lines contain a specified keyword (default: `error`), and prints a summary with the last 5 matching lines. Includes a fallback mechanism for empty files and adapts its interpretation based on the count.

**Concepts demonstrated:** `while IFS= read -r` loop, command-line arguments `$1` `$2`, default values `${2:-"error"}`, file tests `-f` `-s`, counter variables, `grep -iq`, `tail`, `wc -l`

---

### Script 5 — Open Source Manifesto Generator
Interactively asks the user three questions and composes a personalised open-source philosophy statement using their answers and the Linux Kernel as a central example. Saves output to a `.txt` file named after the current user.

**Concepts demonstrated:** `read -p` for interactive input, input validation with `-z`, shell functions (alias concept), string concatenation, writing to file with `>` and `>>`, `date`, `cat`, `whoami`

---

## How to Run the Scripts on Linux

### Prerequisites
- A Linux system (Ubuntu, Fedora, Debian, CentOS, or any standard distribution)
- Bash shell (version 4.0 or later)
- Basic system utilities: `coreutils`, `procps`, `util-linux` (pre-installed on all standard Linux distributions)
- For Script 2 on RPM systems: `rpm` package manager
- For Script 2 on Debian systems: `dpkg` package manager

### Step 1 — Clone the Repository
```bash
git clone https://github.com/yourusername/oss-audit-[rollnumber].git
cd oss-audit-[rollnumber]
```

### Step 2 — Make All Scripts Executable
```bash
chmod +x *.sh
```

### Step 3 — Run Each Script

**Script 1 — System Identity Report**
```bash
bash script1_system_identity.sh
```

**Script 2 — FOSS Package Inspector**
```bash
bash script2_package_inspector.sh
```
To inspect a different package, open the script and change the `PACKAGE=` variable on line 13.

**Script 3 — Disk and Permission Auditor**
```bash
bash script3_disk_permission_auditor.sh
```
Some directories (like `/var/log`) may require `sudo` for size calculation:
```bash
sudo bash script3_disk_permission_auditor.sh
```

**Script 4 — Log File Analyzer**
```bash
# Basic usage (searches for 'error' by default)
bash script4_log_analyzer.sh /var/log/syslog

# Search for a specific keyword
bash script4_log_analyzer.sh /var/log/syslog WARNING

# On systems using /var/log/messages instead of syslog
bash script4_log_analyzer.sh /var/log/messages error
```

**Script 5 — Open Source Manifesto Generator**
```bash
bash script5_manifesto_generator.sh
```
The script will ask you three questions interactively. Your manifesto will be saved to `manifesto_[yourusername].txt` in the current directory.

---

## Notes on Compatibility

| Script | Ubuntu/Debian | Fedora/RHEL/CentOS | Notes |
|--------|:---:|:---:|-------|
| Script 1 | ✓ | ✓ | Fully compatible |
| Script 2 | ✓ | ✓ | Auto-detects RPM vs dpkg |
| Script 3 | ✓ | ✓ | Some dirs may need sudo |
| Script 4 | ✓ | ✓ | Adjust log path for your distro |
| Script 5 | ✓ | ✓ | Fully compatible |

---

## Licence

The shell scripts in this repository are submitted as academic coursework. The audited software — the Linux Kernel — is licensed under the **GNU General Public License v2 (GPL v2)**. Full licence text: https://www.gnu.org/licenses/old-licenses/gpl-2.0.html
