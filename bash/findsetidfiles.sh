\
\#!/bin/bash
#
# this script generates a report of the files on the system that have the setuid permission bit turned on
# it is for the lab1 exercise
# it uses the find command to find files of the right type and with the right permissions, and an error redirect to
# /dev/null so we do not get errors for inaccessible directories and files
# the identified files are sorted by their owner

echo "Setuid files:"
echo "============="
find / -type f -executable -perm -4000 -ls 2>/dev/null |  sort -k 5 
echo ""
echo "12 Largest Files:"
echo "============"
find / -type f -ls 2>/dev/null | ls -laSh | head -n 12 | tr -s ' ' | cut -d ' ' -f3,5,9
echo ""
