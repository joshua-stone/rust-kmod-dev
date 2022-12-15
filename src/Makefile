# Select headers based on the installed kernel version or running kernel
KERNEL_VERSION ?= $(shell rpm -q kernel-core --queryformat='%{VERSION}-%{RELEASE}.%{ARCH}' 2> /dev/null || uname -r)
KDIR := /lib/modules/$(KERNEL_VERSION)/build

BUILDDIR ?= $(PWD)

.PHONY: default
default:
	$(MAKE) -C $(KDIR) M=$(BUILDDIR)
clean:
	$(MAKE) -C $(KDIR) M=$(BUILDDIR) clean
