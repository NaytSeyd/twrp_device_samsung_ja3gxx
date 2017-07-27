## TWRP device tree for Galaxy S4 (Exynos)

Add to `.repo/local_manifests/ja3gxx.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
	<project path="device/samsung/ja3gxx" name="android_device_samsung_ja3gxx" remote="antorya" />
</manifest>
```

Then run `repo sync` to check it out.

To build:

```sh
. build/envsetup.sh
lunch omni_ja3gxx-eng or lunch omni_ja3gxx-userdebug
make -j4 recoveryimage
```

Kernel sources are available at: https://github.com/antorya/kernel_samsung_exynos5410