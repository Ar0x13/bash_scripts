#!/bin/bash 
###############################################################################
#Script Name    : sitemap_gen.sh                      
#Description    : Script for sitemap.xml generation with dynamic values and options                                                                     
#How to use     : Enter URL and check sitemap_options file for restrictions
#Author         : Andrey Ruban       
################################################################################
set -euxo pipefail

# Url configuration
URL="https://example.com/"

# Priority value
PRIORITY="1.0"

# Values: always hourly daily weekly monthly yearly never
FREQ="weekly"

# Begin new sitemap
exec 1> sitemap.xml

# print head
echo '<?xml version="1.0" encoding="UTF-8"?>'
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'

# print urls
IFS=$'\r\n' GLOBIGNORE='*' command eval "OPTIONS=($(cat $1))"
find . -type f "${OPTIONS[@]}" -printf "%TY-%Tm-%Td%p\n" | \
while read -r line; do
  DATE=${line:0:10}
  FILE=${line:12}
  FILE=${FILE%/*}
  DEEP_COUNT=$( echo ${FILE} | awk -F"/" 'NF > max {max = NF} END {print max}')
  DEEP_COUNT=0.$DEEP_COUNT

  if [[ $FILE == 'index.html' ]]; then
      DIR_PRIOR_VALUE="1.0"
    else
      DIR_PRIOR_VALUE=$(awk "BEGIN {print ($PRIORITY - $DEEP_COUNT)}")
  fi

  echo "<url>"
  if [[ $FILE == 'index.html' ]]; then
      echo " <loc>${URL}</loc>"
    else
      echo " <loc>${URL}${FILE}</loc>"
  fi
  echo " <lastmod>$DATE</lastmod>"
  echo " <changefreq>$FREQ</changefreq>"
  echo " <priority>$DIR_PRIOR_VALUE</priority>"
  echo "</url>"
done

# print foot
echo "</urlset>"
