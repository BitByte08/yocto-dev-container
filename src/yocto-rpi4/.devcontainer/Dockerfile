FROM ubuntu:${templateOption:ubuntuVersion}

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages for Yocto Project and Raspberry Pi 4 development
RUN apt-get update && apt-get install -y \
    gawk \
    wget \
    git \
    diffstat \
    unzip \
    texinfo \
    gcc \
    build-essential \
    chrpath \
    socat \
    cpio \
    python3 \
    python3-pip \
    python3-pexpect \
    xz-utils \
    debianutils \
    iputils-ping \
    python3-git \
    python3-jinja2 \
    libegl1-mesa \
    libsdl1.2-dev \
    pylint \
    xterm \
    python3-subunit \
    mesa-common-dev \
    zstd \
    liblz4-tool \
    locales \
    sudo \
    file \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Set locale to UTF-8
RUN locale-gen en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Create a non-root user for Yocto builds
ARG USERNAME=yocto
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Configure git for the user
RUN mkdir -p /home/$USERNAME/.config/git && \
    echo "[user]\n\tname = Yocto Developer\n\temail = yocto@developer.com\n[color]\n\tui = auto" > /home/$USERNAME/.gitconfig && \
    chown -R $USERNAME:$USERNAME /home/$USERNAME

# Set working directory
WORKDIR /workspaces

# Switch to non-root user
USER $USERNAME

# Set default shell to bash
SHELL ["/bin/bash", "-c"]
