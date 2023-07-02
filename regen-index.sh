#!/usr/bin/env bash

set -o errexit
set -o nounset

cd $(dirname $0)

echo -e "# Index\n" > index.md

echo -e "## Folien\n" >> index.md

find -type f ! -empty | xargs git ls-files -z | tr '\0' '\n' | \
  grep -vE "README.md|index.md" | grep -E "\.(pdf|html|md|txt)$" | \
  sed -E "s/tuebix-2023-(.*)/- [\1](tuebix-2023-\1)/" >> index.md

echo -e "\n## Downloads\n" >> index.md
# Section for everything that a web browser cannot display natively

find -type f ! -empty | xargs git ls-files -z | tr '\0' '\n' | \
  grep -E "\.(cast|tar.gz|zip)$" | \
  sed -E "s/tuebix-2023-(.*)/- [\1](tuebix-2023-\1)/" >> index.md
