define Build/senao-factory-image
	mkdir -p $@.senao

	touch $@.senao/before-upgrade.sh
	touch $@.senao/FWINFO-$(BOARDNAME)-OpenWrt-v9.9.9-$(REVISION).txt
	$(CP) $(IMAGE_KERNEL) $@.senao/openwrt-senao-$(1)-uImage-lzma.bin
	$(CP) $@ $@.senao/openwrt-senao-$(1)-root.squashfs

	$(TAR) -c \
		--numeric-owner --owner=0 --group=0 --sort=name \
		$(if $(SOURCE_DATE_EPOCH),--mtime="@$(SOURCE_DATE_EPOCH)") \
		-C $@.senao . | gzip -9nc > $@

	rm -rf $@.senao
endef


define Device/engenius_enh1750ext
  ATH_SOC := qca9558
  DEVICE_TITLE := Engenius ENH1750EXT
  DEVICE_PACKAGES := kmod-ath10k ath10k-firmware-qca988x
  BOARDNAME = ENH1750EXT
  IMAGES += factory.bin
  IMAGE/factory.bin := append-rootfs | pad-rootfs | senao-factory-image enh1750ext
  SUPPORTED_DEVICES := engenius,enh1750ext enh1750ext
endef
TARGET_DEVICES += engenius_enh1750ext

define Device/engenius_ews860ap
  ATH_SOC := qca9558
  DEVICE_TITLE := Engenius EWS860AP
  DEVICE_PACKAGES := kmod-ath10k ath10k-firmware-qca988x
  BOARDNAME = EWS860AP
  IMAGES += factory.bin
  IMAGE/factory.bin := append-rootfs | pad-rootfs | senao-factory-image ews860ap
  SUPPORTED_DEVICES := engenius,ews860ap ews860ap
endef
TARGET_DEVICES += engenius_ews860ap
