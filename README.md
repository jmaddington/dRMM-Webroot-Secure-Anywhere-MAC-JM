# Overview #
Fork of a component provided by Stan Lee of Datto RMM to install Webroot on a macOS endopint.

# Usage #
## Variables
* webroot_keycode: If you set this at the site level you can use this as part of a universal job or monitor response. Otherwise, you'll have to set it everytime you set the script.
* usrConfirmReboot: Set to true to allow Webroot to reboot automatically if needed. _The script will exist if this is not set to true_

# Building #
Download or fork, run repackage.bat and upload aem-component.cpt to dRMM. You can also download the aem-component.cpt straight from this repository and install in your dRMM instance.

# Bonus #
You'll find a basic toolchain for creating and editing dRMM compononts in the bin, build and initialize directories. Feel free to use it.

You can find the latest version of that toolchain at https://github.com/jmaddington/AEM-AEM-Template-PS (the repackage.bat file has been modified in this repo to support the command as a batch file instead of PowerShell)