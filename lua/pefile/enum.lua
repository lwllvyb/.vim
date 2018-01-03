
return {
    SUBSYSTEM = {
        [0] = 'UNKNOWN', [1] = 'NATIVE',
        [2] = 'WINDOWS_GUI', [3] = 'WINDOWS_CUI',
        [5] = 'OS2_CUI', [7] = 'POSIX_CUI',
        [8] = 'NATIVE_WINDOWS', [9] = 'WINDOWS_CE_GUI',
        [10] = 'EFI_APPLICATION', [11] = 'EFI_BOOT_SERVICE_DRIVER',
        [12] = 'EFI_RUNTIME_DRIVER', [13] = 'EFI_ROM',
        [14] = 'XBOX', [16] = 'WINDOWS_BOOT_APPLICATION',
        [17] = 'XBOX_CODE_CATALOG'
    },
    MACHINE = {
        [0] = 'UNKNOWN',
        [0x0001] = 'TARGET_HOST', [0x014c] = 'I386', [0x0162] = 'R3000',
        [0x0166] = 'R4000', [0x0168] = 'R10000', [0x0169] = 'WCEMIPSV2',
        [0x0184] = 'ALPHA', [0x01a2] = 'SH3', [0x01a3] = 'SH3DSP',
        [0x01a4] = 'SH3E', [0x01a6] = 'SH4', [0x01a8] = 'SH5', [0x01c0] = 'ARM',
        [0x01c2] = 'THUMB', [0x01c4] = 'ARMNT', [0x01d3] = 'AM33',
        [0x01F0] = 'POWERPC', [0x01f1] = 'POWERPCFP', [0x0200] = 'IA64',
        [0x0266] = 'MIPS16', [0x0284] = 'ALPHA64', [0x0366] = 'MIPSFPU',
        [0x0466] = 'MIPSFPU16', [0x0520] = 'TRICORE', [0x0CEF] = 'CEF',
        [0x0EBC] = 'EBC', [0x8664] = 'AMD64', [0x9041] = 'M32R',
        [0xAA64] = 'ARM64', [0xC0EE] = 'CEE'
    }
}
