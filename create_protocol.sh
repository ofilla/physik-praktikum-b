#!/bin/bash -e
#

file="$1"
out_dir="${2:-.}"

filename="$(basename "$file")"
tmp=$(mktemp -d)
tex="$tmp/${filename%.md}.tex"
pdf="${filename%.md}.pdf"

if [[ "$(grep -n '^# Referenzen$' "$file")" ]]; then
  # only lines before
  lines=$(grep -n '^# Referenzen$' "$file" | awk -F: '{print $1 - 1}')
else
  # all lines
  lines=$(wc -l "$file" | awk '{print $1}')
fi

head -n$lines "$file" > "$tmp/$filename"

# fix references
for tag in $(grep -oP '\\tag{[0-9a-zA-Z]+}' "$file" | sed -e 's/^\\tag{//g' -e 's/}$//g')
do
  sed -re "s/\\\\tag\{$tag\}/\\\\label{$tag}/g" \
      -e "s/\(\\\\text\{$tag\}\)/\\\\eqref{$tag}/g" \
      -e "s/\($tag\)/\\\\eqref{$tag}/g" \
      -i "$tmp/$filename"
done

# fix svg images
for svg in $(grep svg "$file" | awk -F'(' '{print $2}' | sed 's/)$//g')
do
  png="$(basename "${svg%svg}eps")"
  sed -e "s!$svg!$png!g" -i "$tmp/$filename"
  cp "$(dirname "$file")/${svg%svg}eps" "$tmp/$png"
done

pandoc --template .templates/template_uni_koeln.tex -o "$tex" "$tmp/$filename"
cp .templates/uni.jpg $tmp/

(cd $tmp && pdflatex "$tex" && pdflatex "$tex")

mv "$tmp/$pdf" "$out_dir/$pdf"
rm -rf "$tmp"
