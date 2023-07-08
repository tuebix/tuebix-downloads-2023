#!/usr/bin/env bash

set -o errexit
set -o nounset

cd $(dirname $0)

echo -e "# Index\n" > index.md

echo -e "## Folien\n" >> index.md

find -type f ! -empty | xargs git ls-files -z | tr '\0' '\n' | \
  grep -vE "README.md|index.md" | grep -E "\.(pdf|html|md|txt)$" | \
  sed -E "s/(.*)/- [\1](\1)/" >> index.md

echo -e "\n## Downloads\n" >> index.md
# Section for everything that a web browser cannot display natively

find -type f ! -empty | xargs git ls-files -z | tr '\0' '\n' | \
  grep -E "\.(cast|tar.gz|zip)$" | \
  sed -E "s/(.*)/- [\1](\1)/" >> index.md

cat <<EOF >> index.md
## Sonstiges

### 📹 Videoaufzeichnungen (externe Links)

- [15-prozedurales-3d-design-mit-openscad-und-python-sdf.pdf](https://odysee.com/@nobodyinperson:6/T%C3%BCbix2023-Yann-B%C3%BCchau-OpenSCAD-vs-PythonSDF:d?r=GXVknJ4DWx4cnQVgFgfF4CoDfZ9puyUR)
- [5-git-annex-dateien-synchronisieren-sichern-und-verwalten-fr-poweruser.pdf](https://odysee.com/@nobodyinperson:6/T%C3%BCbix2023-Yann-B%C3%BCchau-git-annex:6?r=GXVknJ4DWx4cnQVgFgfF4CoDfZ9puyUR)
EOF
