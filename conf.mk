BUILDER := $(shell command -v podman 2> /dev/null || echo /usr/bin/docker)
CONTAINERFILE := Containerfile
NAME ?= rust-kmod-dev
TAG ?= latest
IMAGE ?= $(NAME):$(TAG)
VOLUME ?= --volume=$(PWD):/work:z
SQUASH ?= --squash
BUILDER_RUN ?= $(BUILDER) run --workdir=/work $(VOLUME) $(IMAGE)
BUILDER_RUN_TTY ?= $(BUILDER) run --interactive --tty --workdir=/work $(VOLUME) $(IMAGE)
KERNEL_SOURCE ?= linux-rust
KERNEL_SOURCE_URL ?= https://github.com/Rust-for-Linux/linux/archive/refs/heads/rust.tar.gz
KERNEL_MAKE_ARGS ?= LLVM=1 -j12
KMOD_MAKE_ARGS ?= KDIR=../$(KERNEL_SOURCE) LLVM=1
