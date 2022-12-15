include conf.mk

.PHONY: fetch-source
fetch-source:
	curl -L $(KERNEL_SOURCE_URL) | tar xz

.PHONY: build-container build-rustavailable build-menuconfig build-framework build-kmod
build-container:
	$(BUILDER) build --file $(CONTAINERFILE) $(SQUASH) --tag $(IMAGE)

build-rustavailable:
	$(BUILDER_RUN) $(MAKE) -C $(KERNEL_SOURCE) LLVM=1 rustavailable

build-menuconfig:
	$(BUILDER_RUN_TTY) $(MAKE) -C $(KERNEL_SOURCE) menuconfig

build-kernel:
	$(BUILDER_RUN_TTY) $(MAKE) -C $(KERNEL_SOURCE) $(KERNEL_MAKE_ARGS)

build-kmod:
	$(BUILDER_RUN) sh -c 'cd src && $(MAKE) $(KMOD_MAKE_ARGS)'

.PHONY: clean-kmod clean-source
clean-kmod:
	 $(BUILDER_RUN) sh -c 'cd src && $(MAKE) $(MAKE_ARGS) clean'

clean-kernel:
	rm -rf $(KERNEL_SOURCE)
