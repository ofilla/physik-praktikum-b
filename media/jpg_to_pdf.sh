#!/bin/bash

for jpg in "$@"
do
	pdf="${jpg%jpg}pdf"
	echo "converting $jpg to $pdf"
	convert "$jpg" "$pdf" || exit $?
done
