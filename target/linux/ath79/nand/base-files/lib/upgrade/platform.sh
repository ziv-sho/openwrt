# Copyright (C) 2011 OpenWrt.org

PART_NAME=firmware

REQUIRE_IMAGE_METADATA=1
platform_check_image() {
	return 0
}

platform_do_upgrade_mikrotik_rb() {
	CI_KERNPART=none
	local fw_mtd=$(find_mtd_part kernel)
	fw_mtd="${fw_mtd/block/}"
	[ -n "$fw_mtd" ] || return
	mtd erase kernel
	tar xf "$1" sysupgrade-mikrotik_basebox-2/kernel -O | nandwrite -o "$fw_mtd" -

	nand_do_upgrade "$1"
}

RAMFS_COPY_BIN='fw_printenv fw_setenv'
RAMFS_COPY_DATA='/etc/fw_env.config /var/lock/fw_printenv.lock'

platform_do_upgrade() {
	local board=$(board_name)

	case "$board" in
	glinet,gl-ar300m-nand|\
	glinet,gl-ar300m-nor)
		glinet_nand_nor_do_upgrade "$1"
		;;
	glinet,gl-ar750s-nor|\
	glinet,gl-ar750s-nor-nand)
		nand_nor_do_upgrade "$1"
		;;
	mikrotik,basebox-2)
		platform_do_upgrade_mikrotik_rb "$1"
		;;
	*)
		nand_do_upgrade "$1"
		;;
	esac
}
