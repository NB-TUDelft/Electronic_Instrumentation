---
summary: >-
  The ALPACA board and bench instruments; legacy test boards are phased out;
  schematics, not breadboard layouts; MicroPython, Belay, and LTspice; extra
  components go in a plan Bill of Materials. AGENTS.md section 4 before the
  split.
---

# Hardware platform

* The teaching hardware is **ALPACA**, a custom RPi Pico based board with an on-board breadboard, decoupling, attenuation front-end, DAC, and ADC. A new revision is currently in development.
* Bench instruments around the ALPACA: dual-rail bench supply ($\pm 12\,\mathrm{V}$ typical), function generator, bench oscilloscope, $5\,\mathrm{1/2}$ digit DMM.
* The legacy **test boards** are being phased out. New manuals build circuits from scratch on the ALPACA breadboard. Reuse of the legacy testboard Fritzing diagrams is therefore not appropriate.
* Provide circuit schematics and conceptual diagrams, not proposed breadboard layouts. Students should translate the schematic to the ALPACA breadboard as part of problem-based e-learning. Only include breadboard photos when they document fixed hardware orientation or safety-critical pin locations, not as step-by-step layouts.
* Software for student-side automation: **MicroPython** on the Pico. Where a manual needs to ship a tight sampling loop or a long automated sweep on the device, the [Belay](https://belay.readthedocs.io/) Python library is the recommended host-to-Pico bridge (see [helpers/belay/voltammetry/](../../../helpers/belay/voltammetry/) for a working example). LTspice is the simulator.
* If a manual needs an extra bulk component (an opamp, a photodiode, a special capacitor), add it to a Bill of Materials section in the manual's plan document; the user will order it.
