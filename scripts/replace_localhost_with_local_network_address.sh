#!bin/sh
set -exuo pipefail

# ifconfig | grep inet

LOCAL_IP=$(ifconfig | awk '/inet /&&!/127.0.0.1/{print $2;exit}')

echo $LOCAL_IP

sed -i '' 's/IOS Local Host/'$LOCAL_IP/ lib/config/consts.dart
