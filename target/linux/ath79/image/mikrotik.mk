define Device/mikrotik
  PROFILES := Default
  DEVICE_PACKAGES := kmod-usb-core kmod-usb-ohci kmod-usb2 kmod-usb-ledtrig-usbport rbextract
  KERNEL_INITRAMFS := kernel-bin | append-dtb|lzma|loader-kernel
  LOADER_TYPE := elf
  KERNEL := kernel-bin | append-dtb|lzma|loader-kernel|kernel2minor -s 2048 -e -c 
  FILESYSTEMS := squashfs
  IMAGES := sysupgrade.bin
  IMAGE/sysupgrade.bin := sysupgrade-tar
endef

define Device/rb750p-pbr2
  $(Device/mikrotik)
  ATH_SOC := qca9533
  DEVICE_TITLE := Mikrotik RouterBOARD RB750P-PBr2 (Powerbox)
  SUPPORTED_DEVICES := mikrotik,rb750p-pbr2 rb750p-pbr2
endef
TARGET_DEVICES += rb750p-pbr2
