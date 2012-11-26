# Overview
This repository contains necessary files for building a Cydia app containing an upgraded port of `network-cmds` for iOS. 

Added features are

* complete support of IPv6 in `ifconfig` and `route` command,
* promsic (promiscuous) mode support in `ifconfig`,
* added `radvdump` (and, `radvd`, as a bounus :), as a workaround for the iOS PPP IPv6 auto-configuration bug.

# Prerequisites

The supplied Makefile will automatically download corresponding source tarballs. But in order to build the source on Mac for iOS, you'll need to follow the steps here. The instructions here are tested under Mac OSX 10.8.2. Can't get hold of a Mac? Try search for a Mac virtual machine, e.g. http://www.souldevteam.net/blog/downloads. 

* Install XCode. The latest version at the time of writing is 4.5.2, which bundles the iOS 6.0 SDK. In order to support older iOS device, you need to manually install older SDK. You can either download older version of XCode, say 4.4.1, from developer.apple.com, extract from the `dmg` file and copy out `Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.1.sdk/` into `/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/`. 

* Install XCode command line tools. Start XCode, and go to menu _XCode_ -> _Preferences_ -> _Download_. Install _Command Line Tools_. 

* Now open a terminal window, and run `xcodebuild -license`, and accept the license. Then repeat the same under root, `sudo xcodebuild -license`.

* Download and install [iOSOpenDev](http://iosopendev.com/download/), which enable command line tools product type for iOS. See [here](https://github.com/kokoabim/iOSOpenDev/wiki/Setup-Explained) for details on exactly what they did for the tweak.

* I am not sure, but iOSOpenDev probably only tweaks the latest iOS SDK found on your Mac. So you may need to manually disable code signing for SDK 5.1. Edit file `/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.1.sdk/SDKSettings.plist`, and set the following properties
    * `CODE_SIGNING_REQUIRED` to `NO`.
    * `ENTITLEMENTS_REQUIRED` to `NO`.
    * `AD_HOC_CODE_SIGNING_ALLOWED` to `YES`.

* Finally, you'll need to collect various so called _prviate_ headers in order to build those low level system tools. You can clone the headers I used from https://github.com/realthunder/mac-headers. Either clone directly into `/System/Library/Frameworks/System.framework/PrivateHeaders`, or create a sym link. This path will be refered in the `network_cmds` project file.

# Build

Everything is ready. `cd` to this source root, invoke `make`, and you'll get the binaries in `dist` directory. 

A few more details about the Makefiles,

* `make package` will build the Debain package ready for submit to Cydia
* `make dist` will build the binary first and then package.
* `make network_cmds` for building `network_cmds` alone.
* `make radvd` for bulding `radvd` and `radvdump` alone.
* `make clean` clean the intermediate build output.
* `make cleanall` will remove the extracted source directories in `build` directory, but leave the donwloaded tarballs at `dl` directory.
* Similar to [buildroot](http://buildroot.uclibc.org/), the `Makefile` creates `.<name>.downloaded`, `.<name>.patched` and `.<name>.configed` files in the extracted source directory to track the build process. So manually delete the corresponding files if you want to redo certain steps.


