FROM registry.fedoraproject.org/fedora-minimal:38

RUN rm /etc/yum.repos.d/{fedora-cisco-openh264,fedora-rawhide-modular}.repo

RUN dnf install --assumeyes --nodocs --setopt install_weak_deps=0 \
    bc clang diffutils lld gcc llvm make ncurses-devel
ENV CARGO_HOME=/usr/local
RUN curl https://raw.githubusercontent.com/Rust-for-Linux/linux/rust/scripts/min-tool-version.sh \
    -o min-tool-version.sh
RUN chmod +x min-tool-version.sh

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
    sh -s -- --default-toolchain=$(./min-tool-version.sh rustc) --profile=minimal --component rust-src,rustfmt,clippy -y

RUN cargo install --locked --version $(./min-tool-version.sh bindgen) bindgen

RUN rm -rf min-tool-version.sh /usr/local/registry /var/*/{yum,dnf}/*

WORKDIR /work
