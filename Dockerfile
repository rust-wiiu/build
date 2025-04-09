FROM rust:1.86
LABEL authors="29th-Day"

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

RUN rustup toolchain install nightly-x86_64-unknown-linux-gnu && \
    rustup component add rust-src --toolchain nightly-x86_64-unknown-linux-gnu

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

WORKDIR /usr/local/rust-wiiu

CMD ["sleep", "infinity"]
