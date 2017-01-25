#!/usr/local/bin/bash

# Willy Romão 
# willyr.goncalves at gmail.com
# https://github.com/willyrgf/update_sysresccd_area31

# Globals
URL="$1"
URLLOCAL="http://willyromao.com/area31/"
DIRDEST="/usr/local/www/willyromao/area31/"
WGET="/usr/local/bin/wget"

# Checks
[[ -z ${URL} ]] && exit 1

cd $DIRDEST

rm -f *.iso
rm -f *.md5

${WGET} -c ${URL} ${URL/.iso/.md5}

fiso=`ls *.iso`
fmd5=`ls *.md5`

grep -q `md5 -q ${fiso}` ${fmd5}

if [[ $? -ne 0 ]]; then
  echo "Checksum failed."
  exit 1
fi

${WGET} -q --spider ${URLLOCAL}/${fiso} ${URLLOCAL}/${fmd5}

if [[ $? -eq 0 ]]; then
  echo "${URLLOCAL}/${fiso}"
  echo "${URLLOCAL}/${fmd5}"
else
  echo "Test URL local is failed."
fi
