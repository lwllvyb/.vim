
import pefile

file = vim.eval('g:pefile#file')
pe = pefile.PE(file)
buf = vim.current.buffer

indent_level = 0
INDENT = ' ' * int(vim.eval('&sw'))
MACHINE = {
    0x0000: 'UNKNOWN', 0x0001: 'TARGET_HOST', 0x014c: 'I386', 0x0162: 'R3000', 0x0166: 'R4000', 0x0168: 'R10000',
    0x0169: 'WCEMIPSV2', 0x0184: 'ALPHA', 0x01a2: 'SH3', 0x01a3: 'SH3DSP', 0x01a4: 'SH3E', 0x01a6: 'SH4', 0x01a8: 'SH5',
    0x01c0: 'ARM', 0x01c2: 'THUMB', 0x01c4: 'ARMNT', 0x01d3: 'AM33', 0x01F0: 'POWERPC', 0x01f1: 'POWERPCFP', 0x0200: 'IA64',
    0x0266: 'MIPS16', 0x0284: 'ALPHA64', 0x0366: 'MIPSFPU', 0x0466: 'MIPSFPU16', 0x0520: 'TRICORE', 0x0CEF: 'CEF',
    0x0EBC: 'EBC', 0x8664: 'AMD64', 0x9041: 'M32R', 0xAA64: 'ARM64', 0xC0EE: 'CEE' }

SUBSYSTEM = {
    0: 'UNKNOWN', 1: 'NATIVE', 2: 'WINDOWS_GUI', 3: 'WINDOWS_CUI', 5: 'OS2_CUI', 7: 'POSIX_CUI',
    8: 'NATIVE_WINDOWS', 9: 'WINDOWS_CE_GUI', 10: 'EFI_APPLICATION', 11: 'EFI_BOOT_SERVICE_DRIVER',
    12: 'EFI_RUNTIME_DRIVER', 13: 'EFI_ROM', 14: 'XBOX', 16: 'WINDOWS_BOOT_APPLICATION', 17: 'XBOX_CODE_CATALOG' }

# Append text to buffer tail
def buf_append(text = None):
    if text:
        text = INDENT * indent_level + text
        buf.append(text)
    else:
        buf.append('')

def bits_parse(bits, value):
    n = len(bits)
    i = 0
    ret = [v[0] for v in bits if v[1] & value]
    return ' | '.join(ret)
    
buf_append('[Overview]')

indent_level += 1
opt = pe.OPTIONAL_HEADER
buf_append('EntryPoint: 0x%08x' % opt.AddressOfEntryPoint)
buf_append(' Subsystem: 0x%08x %s' % (
        opt.Subsystem, SUBSYSTEM.get(opt.Subsystem, '<INVALID>')
    )
)
buf_append('   Machine: 0x%08x %s' % (
        pe.FILE_HEADER.Machine,
        MACHINE.get(pe.FILE_HEADER.Machine, '<INVALID>')
    )
)
buf_append('DllCharacteristics: 0x%08x %s' % (
        opt.DllCharacteristics, bits_parse([
            ('DYNAMIC_BASE(ALSR)', 0x40),
            ('NX_COMPAT(DEP)', 0x100)
        ], opt.DllCharacteristics)
    )
)
indent_level -= 1

buf_append()
buf_append('[Sections]')

indent_level += 1
for sec in pe.sections:
    name = sec.Name.decode().strip('\x00')
    addr = sec.VirtualAddress
    buf_append('%x %s' % (addr, name))
indent_level -= 1

if hasattr(pe, 'DIRECTORY_ENTRY_IMPORT'):
    buf_append()
    buf_append('[Imports]')
    indent_level += 1
    for d in pe.DIRECTORY_ENTRY_IMPORT:
        buf_append(d.dll.decode() + ':')

        indent_level += 1
        for i in d.imports:
            buf_append('%x\t %s' %
                    (i.address, i.name.decode() if i.name else i.name))
        indent_level -= 1
        buf_append('')
    indent_level -= 1

if hasattr(pe, 'DIRECTORY_ENTRY_EXPORT'):
    buf_append()
    buf_append('[Exports]')

    indent_level += 1
    for e in pe.DIRECTORY_ENTRY_EXPORT.symbols:
        buf_append('%x\t %s' %
                (e.address, e.name.decode() if e.name else e.name))
    indent_level -= 1
