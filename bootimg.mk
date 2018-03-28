LZMA_BIN := $(shell which lzma)
ODIN_TAR_OUT ?= $(PRODUCT_OUT)/recovery.tar

$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) $(recovery_ramdisk) $(recovery_kernel)
	@echo ----- Compressing recovery ramdisk with lzma ------
	rm -f $(recovery_uncompressed_ramdisk).lzma
	$(LZMA_BIN) $(recovery_uncompressed_ramdisk)
	$(hide) cp $(recovery_uncompressed_ramdisk).lzma $(recovery_ramdisk)
	@echo ----- Making recovery image ------
	$(MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	@echo ----- Made recovery image -------- $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)
	$(hide) tar -C $(PRODUCT_OUT) -H ustar -c recovery.img > $(ODIN_TAR_OUT)
	@echo ----- Made Odin flashable recovery tar: ${ODIN_TAR_OUT} -----
