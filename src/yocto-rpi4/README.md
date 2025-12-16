# Yocto + Raspberry Pi 4 Development Environment

This template provides a complete development environment for building custom Linux distributions for Raspberry Pi 4 using the Yocto Project.

## Features

- **Pre-configured Yocto Build Environment**: All required dependencies and tools for Yocto Project development
- **Raspberry Pi 4 Support**: Optimized for building images for Raspberry Pi 4
- **Non-root User**: Builds run as a non-root user (yocto) for security
- **Persistent Caches**: Shared volumes for downloads and sstate-cache to speed up builds
- **Git Integration**: Pre-configured git settings for repository management

## Getting Started

### 1. Clone the Raspberry Pi Yocto BSP

After the container starts, you can clone the Raspberry Pi BSP layers:

```bash
git clone -b kirkstone https://git.yoctoproject.org/poky.git
cd poky
git clone -b kirkstone https://github.com/agherzan/meta-raspberrypi.git
```

### 2. Initialize the Build Environment

```bash
source oe-init-build-env build-rpi4
```

### 3. Configure for Raspberry Pi 4

Edit `conf/local.conf` to set the machine:

```bash
echo 'MACHINE = "raspberrypi4-64"' >> conf/local.conf
```

Edit `conf/bblayers.conf` to add the Raspberry Pi layer:

```bash
bitbake-layers add-layer ../meta-raspberrypi
```

### 4. Build an Image

Build a minimal image for Raspberry Pi 4:

```bash
bitbake core-image-minimal
```

Or build a more complete image:

```bash
bitbake core-image-base
```

### 5. Flash the Image

After the build completes, the image will be in:

```
tmp/deploy/images/raspberrypi4-64/
```

Flash it to an SD card using (replace `/dev/sdX` with your actual SD card device, e.g., `/dev/sdb`):

**⚠️ WARNING: The dd command will erase all data on the target device. Double-check the device path before running!**

```bash
# First, identify your SD card device with lsblk or fdisk -l
lsblk

# Then flash the image (replace /dev/sdX with your SD card device)
sudo dd if=tmp/deploy/images/raspberrypi4-64/core-image-minimal-raspberrypi4-64.wic of=/dev/sdX bs=4M status=progress && sync
```

## Yocto Releases

This template is compatible with various Yocto Project releases. The recommended version is **Kirkstone (LTS)**.

| Release Name | Branch | Ubuntu Version |
|--------------|--------|----------------|
| Kirkstone    | kirkstone | 22.04 |
| Honister    | honister | 20.04 |
| Hardknott   | hardknott | 20.04 |

## Advanced Configuration

### Enable Additional Features

Add to `conf/local.conf`:

```bash
# Enable UART console
ENABLE_UART = "1"

# Add extra packages
IMAGE_INSTALL:append = " python3 i2c-tools"

# Set root password (for development only)
EXTRA_IMAGE_FEATURES += "debug-tweaks"
```

### Optimize Build Performance

```bash
# Use multiple CPU cores (adjust based on your system)
BB_NUMBER_THREADS = "8"
PARALLEL_MAKE = "-j 8"

# Shared state cache and downloads are already configured via volumes
```

## Troubleshooting

### Build Fails with "out of disk space"

Yocto builds require significant disk space (50GB+ recommended). Check available space:

```bash
df -h
```

### Permission Issues

If you encounter permission issues, ensure you're running as the `yocto` user:

```bash
whoami  # should output: yocto
```

## Resources

- [Yocto Project Documentation](https://docs.yoctoproject.org/)
- [Raspberry Pi BSP Layer](https://github.com/agherzan/meta-raspberrypi)
- [Yocto Quick Start Guide](https://docs.yoctoproject.org/brief-yoctoprojectqs/index.html)

## License

This template is provided under the same license as the repository.
