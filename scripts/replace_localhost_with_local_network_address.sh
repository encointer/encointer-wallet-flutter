#!bin/sh
set -exuo pipefail

# 'value': 'ws://127.0.0.1:9944',
# 192.168.43.52

# ifconfig | grep inet

LOCAL_IP=$(ifconfig | awk '/inet /&&!/127.0.0.1/{print $2;exit}')

echo $LOCAL_IP

sed -i '' 's/IOS Local Host/'$LOCAL_IP/ lib/config/consts.dart

# echo LOCAL_IP
