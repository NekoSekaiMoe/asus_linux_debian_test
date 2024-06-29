#!/bin/bash

set -e
if [ !-f scripts/config ]; then
    exit 1
fi

scripts/config --enable CONFIG_PINCTRL_AMD
scripts/config --enable CONFIG_X86_AMD_PSTATE
scripts/config --module CONFIG_AMD_PMC

scripts/config --disable CONFIG_MODULE_COMPRESS_NONE \
               --enable CONFIG_MODULE_COMPRESS_ZSTD

## SET default LRU parameters
scripts/config --enable CONFIG_LRU_GEN
scripts/config --enable CONFIG_LRU_GEN_ENABLED
scripts/config --disable CONFIG_LRU_GEN_STATS
scripts/config --set-val CONFIG_NR_LRU_GENS 7
scripts/config --set-val CONFIG_TIERS_PER_GEN 4

# DISABLE not need modules on ROG laptops
# XXX: I'm going to make an opinionated decision here and save everyone some compilation time
# XXX: on drivers almost no-one is going to use; if you need any of theese turn them on in myconfig
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

# HACK: forcibly fixup CONFIG_CMDLINE here as using scripts/config mangles escaped quotes
sed -i 's#makepkgplaceholderyolo#ibt=off pm_debug_messages amd_pmc.dyndbg=\\"+p\\" acpi.dyndbg=\\"file drivers/acpi/x86/s2idle.c +p\\"#' .config

# Note the double escaped quotes above, sed strips one; the final result in .config needs to contain single slash
# escaped quotes (eg: `CONFIG_CMDLINE="foo.dyndbg=\"+p\""`) to avoid dyndbg parse errors at boot. This is impossible
# with the current kernel config script.
