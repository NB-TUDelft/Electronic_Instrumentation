Version 4
SymbolType CELL
LINE Normal -32 -32 32 0
LINE Normal -32 32 32 0
LINE Normal -32 -32 -32 32
LINE Normal -28 -16 -20 -16
LINE Normal -28 16 -20 16
LINE Normal -24 20 -24 12
LINE Normal 0 -32 0 -16
LINE Normal 0 32 0 16
LINE Normal 4 -20 12 -20
LINE Normal 8 -24 8 -16
LINE Normal 4 20 12 20
WINDOW 0 16 -32 Left 2
SYMATTR SpiceModel level2
SYMATTR Prefix X
SYMATTR Description TL072 JFET-input op amp. LTspice UniversalOpAmp2 with TL072 datasheet typical values (25 C): Avol 200k (106 dB), GBW 3 MHz, slew rate 13 V/us, short-circuit current 40 mA, output swing to 1.5 V from each supply rail. Offset, bias current and noise are not modelled. Needs UniversalOpAmp2.lib, which ships with LTspice.
SYMATTR Value2 Avol=200k GBW=3Meg Slew=13Meg
SYMATTR SpiceLine Ilimit=40m Rail=1.5 Vos=0
SYMATTR SpiceLine2 En=0 Enk=0 In=0 Ink=0 Rin=1T
SYMATTR ModelFile UniversalOpAmp2.lib
PIN -32 16 NONE 0
PINATTR PinName In+
PINATTR SpiceOrder 1
PIN -32 -16 NONE 0
PINATTR PinName In-
PINATTR SpiceOrder 2
PIN 0 -32 NONE 0
PINATTR PinName V+
PINATTR SpiceOrder 3
PIN 0 32 NONE 0
PINATTR PinName V-
PINATTR SpiceOrder 4
PIN 32 0 NONE 0
PINATTR PinName OUT
PINATTR SpiceOrder 5
