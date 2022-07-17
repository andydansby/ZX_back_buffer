cls

del 2pushpop.tap

@bas2tap -a10 -sloader loader.bas basloader.tap

pasmo -v --tap pushpop.asm pushpop.tap pushpop.sym

copy /b basloader.tap + pushpop.tap  2pushpop.tap

del pushpop.tap
del basloader.tap

@rem for Auto Running / testing of your compile
@rem https://fms.komkon.org/Speccy/
@rem path=C:\zx emulator\speccy
@rem Speccy -48 -nosound 1LDI_2.tap

path=C:\zx emulator\inkspec
InkSpector64 \z88dk199c\games\russian_vertical\andy_test\pushpop2\2pushpop.tap


