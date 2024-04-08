#!/bin/bash -e
#

file="$1"
out_dir="${2:-$(dirname "$file")}"

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
for tag in $(grep -oP '\\tag{[0-9a-zA-ZäöüÄÖÜ()=-]+}' "$file" | sed -e 's/^\\tag{//g' -e 's/}$//g')
do
  sed -e "s/\\\\tag{$tag}/\\\\label{$tag}/g" \
      -e "s/(\\\\text{$tag})/\\\\eqref{$tag}/g" \
      -e "s/($tag)/\\\\eqref{$tag}/g" \
      -e "s/\\\\tag{\\\\mathrm{$tag}}/\\\\label{$tag}/g" \
      -e "s/(\\\\text{\\\\mathrm{$tag}})/\\\\eqref{$tag}/g" \
      -e "s/(\\\\mathrm{$tag})/\\\\eqref{$tag}/g" \
      -i "$tmp/$filename"
done

# fix svg images
for pic in $(grep -P '^!.*(svg|jpg|png)' "$file" | awk -F'(' '{print $2}' | sed 's/)$//g')
do
  pdf_="${pic/svg/pdf}"
  pdf_="${pdf_/jpg/pdf}"
  pdf_file="$(basename "$pdf_")"
  sed -e "s!$pic!$pdf_file!g" -i "$tmp/$filename"
  cp "$(dirname "$file")/$pdf_" "$tmp/$pdf_file"
done

sed -ie "s/braket/expval/g" "$tmp/$filename" # Obsidian braket is physics expval
sed -ie 's/\([a-zA-Z$]\)-\([a-zA-Z]\)/\1--\2/g' "$tmp/$filename"
pandoc --template .templates/template_uni_koeln.tex --strip-comments -o "$tex" "$tmp/$filename"
cp "$tex" "$out_dir"
cp .templates/uni.jpg $tmp/

(cd $tmp && pdflatex "$tex" && pdflatex "$tex")

mv "$tmp/$pdf" "$out_dir/$pdf"
rm -rf "$tmp"
