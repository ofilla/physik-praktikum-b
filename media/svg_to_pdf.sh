#!/bin/bash

for svg in "$@"
do
	pdf="${svg%svg}pdf"
	echo "converting $svg to $pdf"
	inkscape --export-filename="$pdf" "$svg" || exit $?
done
