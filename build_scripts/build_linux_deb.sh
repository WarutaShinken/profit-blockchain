#!/bin/bash

APP_BUNDLEID="net.profit.blockchain"
APP_NAME="profit-blockchain"

if [ ! "$1" ]; then
  echo "This script requires either amd64 of arm64 as an argument"
	exit 1
elif [ "$1" = "amd64" ]; then
	PLATFORM="$1"
	DIR_NAME="$APP_NAME-linux-x64"
else
	PLATFORM="$1"
	DIR_NAME="$APP_NAME-linux-arm64"
fi

pip install setuptools_scm
# The environment variable PROFIT_INSTALLER_VERSION needs to be defined
# If the env variable NOTARIZE and the username and password variables are
# set, this will attempt to Notarize the signed DMG
PROFIT_INSTALLER_VERSION=$(python installer-version.py)

if [ ! "$PROFIT_INSTALLER_VERSION" ]; then
	echo "WARNING: No environment variable PROFIT_INSTALLER_VERSION set. Using 0.0.0."
	PROFIT_INSTALLER_VERSION="0.0.0"
fi
echo "Profit Installer Version is: $PROFIT_INSTALLER_VERSION"
DEB_NAME="$APP_NAME-$PROFIT_INSTALLER_VERSION"

echo "Installing npm and electron packagers"
npm install electron-packager -g
npm install electron-installer-debian -g

echo "Create dist/"
rm -rf dist
mkdir dist

echo "Create executables with pyinstaller"
pip install pyinstaller==4.5
SPEC_FILE=$(python -c 'import profit; print(profit.PYINSTALLER_SPEC_PATH)')
pyinstaller --log-level=INFO "$SPEC_FILE"
LAST_EXIT_CODE=$?
if [ "$LAST_EXIT_CODE" -ne 0 ]; then
	echo >&2 "pyinstaller failed!"
	exit $LAST_EXIT_CODE
fi

cp -r dist/daemon ../profit-blockchain-gui
cd .. || exit
cd profit-blockchain-gui || exit

echo "npm build"
npm install
npm audit fix
npm run build
LAST_EXIT_CODE=$?
if [ "$LAST_EXIT_CODE" -ne 0 ]; then
	echo >&2 "npm run build failed!"
	exit $LAST_EXIT_CODE
fi

# sets the version for profit-blockchain in package.json
cp package.json package.json.orig
jq --arg VER "$PROFIT_INSTALLER_VERSION" '.version=$VER' package.json > temp.json && mv temp.json package.json

electron-packager . $APP_NAME --asar.unpack="**/daemon/**" --platform=linux \
--icon=src/assets/img/Profit.icns --overwrite --app-bundle-id=$APP_BUNDLEID \
--appVersion=$PROFIT_INSTALLER_VERSION
LAST_EXIT_CODE=$?

# reset the package.json to the original
mv package.json.orig package.json

if [ "$LAST_EXIT_CODE" -ne 0 ]; then
	echo >&2 "electron-packager failed!"
	exit $LAST_EXIT_CODE
fi

mv $DIR_NAME ../build_scripts/dist/
cd ../build_scripts || exit

echo "Create $DEB_NAME.deb"
rm -rf final_installer
mkdir final_installer
electron-installer-debian --src dist/$DIR_NAME/ --dest final_installer/ \
--arch "$PLATFORM" --options.version $PROFIT_INSTALLER_VERSION
LAST_EXIT_CODE=$?
if [ "$LAST_EXIT_CODE" -ne 0 ]; then
	echo >&2 "electron-installer-debian failed!"
	exit $LAST_EXIT_CODE
fi

ls final_installer/
