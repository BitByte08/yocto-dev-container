#!/bin/bash
cd $(dirname "$0")
source test-utils.sh

# Template specific tests
check "user" [ "$(whoami)" = "yocto" ]
check "git" git --version
check "python3" python3 --version
check "bitbake" which bitbake || echo "bitbake will be available after sourcing oe-init-build-env"
check "required-tools" which gawk wget diffstat unzip chrpath socat cpio
check "locale" [ "$LANG" = "en_US.UTF-8" ]

# Report result
reportResults
