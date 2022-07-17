cls

del 1longLDI.tap


@rem copy /b table_top.bin + table_bottom.bin  table_7.bin

@bas2tap -a10 -sloader loader.bas basloader.tap


pasmo -v --tap longLDI.asm longLDI.tap longLDI.sym


@copy /b basloader.tap + longLDI.tap  1longLDI.tap


del longLDI.tap
del basloader.tap

@rem for Auto Running / testing of your compile
@rem https://fms.komkon.org/Speccy/
@rem path=C:\zx emulator\speccy
@rem Speccy -48 -nosound 1output.tap

@rem path=C:\zx emulator\inkspec
@rem incli --machine 48k --load 1output.tap
path=C:\zx emulator\inkspec
InkSpector64 \z88dk199c\games\russian_vertical\andy_test\long_LDI_26wide\1longLDI.tap