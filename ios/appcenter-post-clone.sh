#!/usr/bin/env bash

set -exuo pipefail

CUR_COCOAPODS_VER=`sed -n -e 's/^COCOAPODS: \([0-9.]*\)/\1/p' Podfile.lock`
ENV_COCOAPODS_VER=`pod --version`

# check if not the same version, reinstall cocoapods version to current project's
if [ $CUR_COCOAPODS_VER != $ENV_COCOAPODS_VER ];
then
    echo "Uninstalling all CocoaPods versions"
    sudo gem uninstall cocoapods --all --executables
    echo "Installing CocoaPods version $CUR_COCOAPODS_VER"
    sudo gem install cocoapods -v $CUR_COCOAPODS_VER
else
    echo "CocoaPods version is suitable for the project"
fi;

pod setup

# place this script in project/ios/
cd ..

source ./scripts/app_center_post_clone_setup.sh

./flutterw build ios --release --no-codesign