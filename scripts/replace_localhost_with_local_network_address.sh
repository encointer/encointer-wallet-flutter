#!bin/sh
set -exuo pipefail

# 'value': 'ws://127.0.0.1:9944',
# 192.168.43.52

# ifconfig | grep inet

# echo '$msg1' two three

LOCAL_IP=$(ifconfig | awk '/inet /&&!/127.0.0.1/{print $2;exit}')

# ls

# printf "some data for the file\nAnd a new line">> consts.dart
sed -i '' 's/10.0.2.2/LOCAL_IP/' lib/config/consts.dart

# echo LOCAL_IP
