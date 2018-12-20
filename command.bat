#!/bin/sh
#WEBROOT INSTALLER for macOS: build 8b/SEAGULL
echo "Webroot SecureAnywhere for macOS Installer"
echo "=========================================="

#verify licence code
if [ ${#webroot_keycode} -ne 24 ]
then 
	echo "ERROR: Key supplied is not applicable for this product."
	echo "Webroot SecureAnywhere keys are twenty characters long, connected by four dashes."
	echo "Please re-run this component with a valid licence key."
	exit 1
fi

#verify reboot prompt
if [ $usrConfirmReboot = 'true' ]
then
	echo "- Permission has been granted for the software to reboot the Endpoint if necessary."
	echo "Installing..."
else
	echo "ERROR: Permission has not been granted for the installer to reboot the system."
	echo "As the installation process may involve rebooting the Endpoint, permission is required before execution"
	echo "in case such a scenario should occur."
	echo "Please re-run with the usrConfirmReboot variable set to TRUE to continue."
	exit 1
fi

#copy app from DMG to /applications (if absent)
if [ ! -d "/Applications/Webroot SecureAnywhere.app" ]
then
	EPOCHTIME=$(date +%s)
	MOUNTPOINT=/Volumes/$EPOCHTIME
	shopt -s nullglob
	CSDMGName=$(ls *.dmg)
	hdiutil attach "$CSDMGName" -mountpoint $MOUNTPOINT -quiet -nobrowse -noverify -noautoopen
	cd /
	cd $MOUNTPOINT
	CSAppName=$(ls -d *.app)
	cp -fR "$MOUNTPOINT/$CSAppName" /Applications/
else
	echo "ERROR: Webroot SecureAnywhere is already installed."
	echo "Please remove it first before continuing."
	exit 1
fi

#issue the installation instruction (if confirmed)
echo "- Webroot SecureAnywhere installer output:"
"/Applications/Webroot SecureAnywhere.app/Contents/MacOS/Webroot SecureAnywhere" install -keycode=$webroot_keycode -silent

#unmount the disk image
sleep 20
hdiutil detach $MOUNTPOINT

echo "- Webroot SecureAnywhere installed successfully."
echo "However, the Endpoint may be required to permit the Webroot software to run in macOS System Preferences."
exit