#!/bin/bash -e

file="$1"
out_dir="${2:-$(dirname "$file")}"

tmpfile="$(mktemp --suffix=.md)"
tex="${file%.md}.tex"

if [[ "$(grep -n '^# Literatur$' "$file")" ]]; then
  # only lines before
  lines=$(grep -n '^# Literatur$' "$file" | awk -F: '{print $1 - 1}')
  head -n$lines "$file" > "$tmpfile"
else
  cp -f "$file" "$tmpfile"
fi

# fix references
for tag in $(grep -oP '\\tag{[0-9a-zA-ZäöüÄÖÜ:()=-]+}' "$file" | sed -e 's/^\\tag{//g' -e 's/}$//g')
do
  sed -e "s/\\\\tag{$tag}/\\\\label{$tag}/g" \
      -e "s/(\\\\text{$tag})/\\\\eqref{$tag}/g" \
      -e "s/($tag)/\\\\eqref{$tag}/g" \
      -e "s/\\\\tag{\\\\mathrm{$tag}}/\\\\label{$tag}/g" \
      -e "s/(\\\\text{\\\\mathrm{$tag}})/\\\\eqref{$tag}/g" \
      -e "s/(\\\\mathrm{$tag})/\\\\eqref{$tag}/g" \
      -i "$tmpfile"
done

# fix svg images
sed -i 's/.svg/.pdf/g' "$tmpfile"
sed -i "s/braket/expval/g" "$tmpfile" # Obsidian braket is physics expval
sed -i 's/\([a-zA-Z$]\)-\([a-zA-Z]\)/\1--\2/g' "$tmpfile"

pandoc --template .templates/template_uni_koeln.tex --strip-comments -o "$tex" "$tmpfile"
sed -i -e '/^\\\[$/d' -e '/^\\\]$/d' -e 's/\\[()]/$/g' "$tex"

tex="$(basename "$tex")"
(cd "$out_dir" && pdflatex "$tex" && pdflatex "$tex")

rm -rf "$tmpfile"
