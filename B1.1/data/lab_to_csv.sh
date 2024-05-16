#!/bin/sh

file="$1"

DELETE_FIRST=${2:-35}
DELETE_LAST=${3:-18}

echo "### file: $file"
echo "### will delete following lines, except the last one"
head -n$DELETE_FIRST "$file"
echo "### file: $file"

echo "### file: $file"
echo "### will delete following lines, except the first one"
tail -n$DELETE_LAST "$file"
echo "### file: $file"

echo "press <return> to continue"
read

out_file="${file%lab}csv"
touch "$out_file"

echo -e "index\tseconds\ttemperature\ttemperature_2\tbeleuchtungsstaerke" > "$out_file"
tail -n+$DELETE_FIRST "$file" | head -n-$((DELETE_LAST-1)) >> "$out_file"
echo "done"
