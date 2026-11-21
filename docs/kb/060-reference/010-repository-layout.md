---
summary: >-
  The book, manuals, and helpers tree; folder responsibilities; and the
  high-value items inside helpers/ to reuse before drawing or writing
  anything new, including the textbook source and the Belay voltammetry rig.
  AGENTS.md section 3 before the split.
always_read: true
---

# Repository layout

```text
book/                              # Jupyter Book source; this is what gets published
  _config.yml                      # build configuration
  _toc.yml                         # publication order; every new manual must be listed
  static/                          # global CSS, JS, icons, downloads
    global.css                     # custom admonition colours and other overrides
  manuals/
    intros/                        # equipment and tooling intros (alpaca, breadboard, scope, ...)
    week1/                         # week-specific manuals + local images/
      _summary.ipynb               # short landing page for the week
      1.1_voltage_divider.ipynb
      1.2_intro_to_oscilloscope_and_filters.ipynb
      _plan_*.md                   # internal plan notes; gitignored, never published
      images/
    week2/                         # ... same pattern
    ...
    week8/
  miscellaneous/
    intro.md                       # book landing page (root of the TOC)
    admonitions.md                 # gallery of admonition types in use
    appendix/                      # cross-week reference material (e.g., resistance.ipynb)
old/                               # legacy manuals (12A, 13A, ...) kept for reference, do not edit
.venv/                             # local virtualenv created by the user
README.md
AGENTS.md                          # this file
```

## Folder responsibilities

* **`book/`** is the only directory that ships. Anything outside `book/` is either author-facing reference (`helpers/`, `old/`) or build infrastructure.
* **`book/manuals/intros/`** is for tooling and equipment intros that are reused across weeks (DMM, scope, ALPACA, breadboard, LTspice, ...). Reference these from week manuals via the "Preparation" admonition, do not re-explain the equipment in every week.
* **`book/manuals/weekX/`** holds one folder per teaching week. Each week folder contains a `_summary.ipynb`, the numbered manuals (`X.1_*.ipynb`, `X.2_*.ipynb`), and an `images/` subfolder for assets that belong to that week only.
* **`helpers/theory_part/`** is the **textbook source**. Treat it as the canonical theory reference. Lab manuals should refer the student back to it for derivations and proofs, and should not duplicate them. When the textbook covers a concept that students nevertheless trip on (virtual ground, the "+1" in non-inverting gain, dB and decade, BW = GBW / (1 + closed-loop gain) for non-inverting amps), re-explain it briefly in the manual where it is used, and link to the textbook for the full version. Three chapters are still **stubs** (`6_transistor.md`, `9_sensors.md`, `11_noise_interference.md`); if a manual depends on those topics, the manual itself has to carry the theory until the textbook catches up.
* **`helpers/ei_helpers/`** is legacy bench-side reference: vendor textbooks, schematics for the old test boards, Multisim files, scanned photographs. Use it to understand what the legacy lab looked like; **do not** copy testboard schematics directly into a new manual since the test boards are being phased out.
* **`helpers/belay/voltammetry/`** is **Krzysztof's' Belay-based voltammetry rig** for an Electronic Instrumentation report on the ALPACA platform. **Belay** ([belay.readthedocs.io](https://belay.readthedocs.io/)) is a third-party Python library by Brian Pugh that lets host code transparently run slices on a MicroPython device via decorators (`@device.setup`, `@device.task`, `@device.teardown`). It is **not** custom firmware and **not** part of the standard ALPACA toolchain. The folder contains a working 3-electrode potentiostat (MCP4822 DAC over SPI1, three Pico ADCs, two TL072 op-amps with transimpedance feedback), a single `voltammetry.py` driver, and a 600-line `CLAUDE.md` documenting hardware pinout, Belay gotchas, and a diagnostic playbook (binary I-V jump = OPAMP1 feedback open; pinned ADC currents = saturation, with formulas; >18 mV DAC-B sag = fault indicator). **Read this when authoring future complex-systems / colorimeter / voltammetry manuals (textbook chapter 10).** The ALPACA standard student stack is just MicroPython on the Pico; Belay is only used when an experiment needs to ship on-device task code from the host.
* **`old/`** holds legacy manuals (e.g., `EI_manuals/12A_*.ipynb`) used as source material when authoring the new ones. Do not edit; treat as read-only reference.

## High-value items inside `helpers/` worth knowing about

The `helpers/` catalogue may be unavailable in some users' local checkouts. Check that a referenced path exists before relying on it. If it is unavailable, continue with the sources that are present and tell the user which helper reference you could not consult. Do not treat the missing catalogue as a repository error or invent its contents.

When a manual needs a schematic, a worked example, a photograph, an exercise idea, or an original explanation, look here before drawing or writing anything new.

* **`helpers/theory_part/images/standard_symbols/`** is the canonical schematic-symbol library for this book: battery, ideal voltage / current source, AC source, ammeter, voltmeter, resistor, capacitor (polarised and not), inductor, diode, LED, LDR, multiple GND symbols, switches, coax, crossings, junction dots. **Reuse these SVGs in new manuals** instead of drawing new symbols. The list of symbols and the conventions around them (V vs U, lowercase vs uppercase, European vs American conventions) is documented in [helpers/theory_part/0_symbols_and_conventions.md](../../../helpers/theory_part/0_symbols_and_conventions.md).
* **`helpers/theory_part/textbook layout.txt`** is the canonical author-side TOC for the whole textbook, in mixed Dutch and English. Each chapter is structured as A (natuurkunde / physics), B (elektronica theoretisch), C (praktisch / lab and instrument), D (examples / context), E (exercises). When you write a manual for chapter N, this file tells you which sub-section the textbook is meant to cover and which is left to the lab manual.
* **`helpers/theory_part/2_resistor.ipynb`** and **`helpers/theory_part/3_capacitor.ipynb`** are interactive companions to chapters 2 and 3. If a homework task needs an interactive plot (RC step response, Bode plot, Thevenin equivalent calculator), check here first; the notebook code is reusable.
* **`helpers/theory_part/template-chapter.md`** and **`template-subchapter.md`** are the boilerplate for new textbook chapters and include working examples of `note`, `tip`, `warning`, and `exercise` admonitions. Use them as a reference when you need to add a new theory section, not when writing a lab manual (the lab template lives in [book/manuals/week1/1.1_voltage_divider.ipynb](../../../book/manuals/week1/1.1_voltage_divider.ipynb)).
* **`helpers/theory_part/images/images_<N>/Reference/`** holds the raw drawings and scanned exercises that the chapter authors used. Several chapters (especially 4, 5, 7, 10) include hand-drawn working examples and scanned exercise sheets that the manual authors sometimes want to redraw or reuse. Chapter 7 has 55 reference images; chapter 5 has 41.
* **`helpers/ei_helpers/Practical Electronics for Inventors.pdf`** is Scherz's full reference. Useful when a manual needs a worked example or a piece of practical advice (decoupling, scope hygiene, soldering) that the in-house textbook does not cover.
* **`helpers/ei_helpers/Zbiór zadań z elektrotechniki ... pdf`** is a 290 MB Polish problem-set book. If the user asks for "a few extra exercises" on a topic, this is the source mine.
* **`helpers/ei_helpers/EI testboards/schemas/`** has the schematics for legacy test boards 1, 2, 3, 4, 5, 7, 15. If a legacy old/EI_manuals notebook references "test board 4", the schematic is here. Do **not** include these in new manuals; the boards are going away.
* **`helpers/ei_helpers/Alpaca + Cria pictures.pdf`** has the only existing photographic record of the legacy ALPACA + CRIA combo. Use it when a new manual mentions ALPACA pinout that has not changed across revisions.
* **`helpers/belay/voltammetry/CLAUDE.md`** has the only diagnostic playbook anywhere in the repository for the 3-electrode potentiostat circuit. The numbers (`I_min_uA = -V_WE_v / Rf * 1e6`, `I_max_uA = (3 / gain - V_WE_v) / Rf * 1e6`, `f_c = 1 / (2 pi Rf C) ~ 219 Hz` for default values) and failure-mode signatures (binary jumps, ADC clipping, DAC-B sag) are directly applicable to any future voltammetry / colorimetry manual.
