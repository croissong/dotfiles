shopt -s expand_aliases
source ~/.my/.shell/alias.sh
oathtool --totp --base32 $1 | tr -d '\n' | clip
