cls

del 1pushpop.tap

@bas2tap -a10 -sloader loader.bas basloader.tap

pasmo -v --tap pushpop.asm pushpop.tap LUT.sym

copy /b basloader.tap + pushpop.tap  1pushpop.tap

del pushpop.tap
del basloader.tap

@rem for Auto Running / testing of your compile
@rem https://fms.komkon.org/Speccy/
@rem path=C:\zx emulator\speccy
@rem Speccy -48 -nosound 1LDI_2.tap

path=C:\zx emulator\inkspec
InkSpector64 \z88dk199c\games\russian_vertical\andy_test\pushpop1\1pushpop.tap


