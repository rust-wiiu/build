FROM rust:1.86
LABEL authors="29th-Day"

ARG RUSTC_VERSION="nightly-2025-02-06"

WORKDIR /usr/local/download

RUN apt-get update && \
    apt-get install -y \ 
        wget \
        git \
        ca-certificates \
        clang \
        libclang-dev \
    && \
    rm -rf /var/lib/apt/lists/*

RUN rustup toolchain install ${RUSTC_VERSION} -c rust-src

RUN cargo install --force \
    cargo-make \
    && \
    rm -rf $CARGO_HOME/registry

RUN wget https://apt.devkitpro.org/install-devkitpro-pacman && \
    chmod +x ./install-devkitpro-pacman && \
    yes | ./install-devkitpro-pacman && \
    ln -s /proc/self/mounts /etc/mtab

RUN dkp-pacman -Sy && \
    (printf "\n" && yes) | dkp-pacman -S wiiu-dev

ENV DEVKITPRO=/opt/devkitpro
ENV DEVKITPPC=${DEVKITPRO}/devkitPPC
ENV GH=https://github.com/rust-wiiu

WORKDIR /home/rust-wiiu

CMD ["sleep", "infinity"]
