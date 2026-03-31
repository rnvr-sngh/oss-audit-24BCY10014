#!/bin/bash
# Script 5: Open Source Manifesto Generator
# Author: Student | Course: Open Source Software
# Purpose: Interactively asks the user 3 questions and generates a
#          personalised open source philosophy statement, saved to a .txt file

# --- Alias concept demonstrated ---
# In a real shell session you might define: alias today='date +%d-%B-%Y'
# Aliases let users create shortcuts for commonly used commands.
# They are defined in ~/.bashrc for persistence across sessions.
# Here we use a function to demonstrate the same concept within a script:
todays_date() {
    date '+%d %B %Y'   # Custom date format function — acts like an alias
}

echo "========================================================"
echo "       OPEN SOURCE MANIFESTO GENERATOR                 "
echo "========================================================"
echo ""
echo "  Answer three questions to generate your personal"
echo "  open source philosophy manifesto."
echo ""
echo "========================================================"
echo ""

# --- Read user input interactively with read -p ---
# -p displays the prompt on the same line as input

read -p "  1. Name one open-source tool you use every day: " TOOL
echo ""

read -p "  2. In one word, what does 'freedom' mean to you?: " FREEDOM
echo ""

read -p "  3. Name one thing you would build and share freely: " BUILD
echo ""

# --- Validate inputs — make sure the user actually typed something ---
if [ -z "$TOOL" ] || [ -z "$FREEDOM" ] || [ -z "$BUILD" ]; then
    echo "  ERROR: All three questions must be answered."
    echo "  Please run the script again and provide all answers."
    exit 1
fi

# --- Get today's date using our function ---
DATE=$(todays_date)

# --- Set the output filename using the current user's name ---
# String concatenation: combine "manifesto_" + username + ".txt"
OUTPUT="manifesto_$(whoami).txt"

# --- Generate the manifesto by writing to the file with > and >> ---

# First write (>) creates/overwrites the file with the header
echo "========================================================" > "$OUTPUT"
echo "  MY OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "  Generated on: $DATE" >> "$OUTPUT"
echo "  By: $(whoami)" >> "$OUTPUT"
echo "========================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Build the personalised paragraph using string concatenation with the user's answers
echo "  I believe in the power of open source software because every" >> "$OUTPUT"
echo "  day I rely on $TOOL — a tool built not for profit, but for" >> "$OUTPUT"
echo "  people. To me, freedom in software means $FREEDOM: the right" >> "$OUTPUT"
echo "  to use, study, change, and share the tools that shape our" >> "$OUTPUT"
echo "  digital lives." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  The Linux Kernel, which powers everything from smartphones to" >> "$OUTPUT"
echo "  supercomputers, is the greatest proof that when people build" >> "$OUTPUT"
echo "  together without barriers, they create something no single" >> "$OUTPUT"
echo "  company ever could. Linus Torvalds started it as a student" >> "$OUTPUT"
echo "  project in 1991 with a simple post: 'I'm doing a (free)" >> "$OUTPUT"
echo "  operating system.' Thousands of contributors turned that" >> "$OUTPUT"
echo "  into the foundation of modern computing." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  I commit to carrying that spirit forward. One day I will" >> "$OUTPUT"
echo "  build $BUILD and release it freely — because the knowledge" >> "$OUTPUT"
echo "  and tools I have today came from people who chose to share." >> "$OUTPUT"
echo "  That debt is paid forward, not back." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  Open source is not just a license. It is a philosophy:" >> "$OUTPUT"
echo "  software is knowledge, and knowledge belongs to everyone." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "========================================================" >> "$OUTPUT"
echo "  Signed: $(whoami) | $DATE" >> "$OUTPUT"
echo "========================================================" >> "$OUTPUT"

# --- Confirmation message ---
echo "========================================================"
echo "  Manifesto saved to: $OUTPUT"
echo "========================================================"
echo ""

# --- Display the manifesto content using cat ---
cat "$OUTPUT"
