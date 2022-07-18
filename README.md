# ZX_back_buffer
Various methods for filling a screen on a ZX Spectrum using a linear back buffer


display image must be 208 pixels wide
which is 26 character spaces wide.

Image is converted using SevenuP
;;;;;;;;;;;;
in SevenuP
import PNG file
then
File > Output options
GFX only

Sort Priority
X char
Char line
Y char

interleave = Sprite
no other options checked

then
File > Export Data
export as girl.BIN
