#!/bin/bash

set -e

scripts/config  --disable CONFIG_INFINIBAND \
                  --disable CONFIG_DRM_NOUVEAU \
                  --disable CONFIG_DRM_RADEON \
                  --disable CONFIG_IIO \
                  --disable CONFIG_CAN_DEV \
                  --disable CONFIG_PCMCIA_WL3501 \
                  --disable CONFIG_PCMCIA_RAYCS \
                  --disable CONFIG_IWL3945 \
                  --disable CONFIG_IWL4965 \
                  --disable CONFIG_IPW2200 \
                  --disable CONFIG_IPW2100 \
                  --disable CONFIG_FB_NVIDIA \
                  --disable CONFIG_SENSORS_ASUS_EC \
                  --disable CONFIG_SENSORS_ASUS_WMI_EC

# select slightly more sane block device driver options; NVMe really should be built in
scripts/config  --disable CONFIG_RAPIDIO \
                  --module CONFIG_CDROM \
                  --disable CONFIG_PARIDE \

# bake in s0ix debugging parameters so we get useful problem reports re: suspend
scripts/config  --enable CONFIG_CMDLINE_BOOL \
                  --set-str CONFIG_CMDLINE "makepkgplaceholderyolo" \
                  --disable CMDLINE_OVERRIDE

# enable back EFI_HANDOVER_PROTOCOL and EFI_STUB
scripts/config  --enable CONFIG_EFI_HANDOVER_PROTOCOL \
                  --enable CONFIG_EFI_STUB

# try to fix stuttering on some ROG laptops
scripts/config --disable CONFIG_HW_RANDOM_TPM

# enable SCHED_CLASS_EXT
scripts/config --enable CONFIG_SCHED_CLASS_EXT
