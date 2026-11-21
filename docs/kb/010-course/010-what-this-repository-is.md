---
summary: >-
  The source for the NB2420 Electronic Instrumentation practicum manuals,
  published as a Jupyter Book (TeachBook); course goals in priority order,
  transferable lab skills first, then electronics fluency, then
  problem-solving based work; the audience of second-year Nanobiology
  students. AGENTS.md section 1 before the split.
always_read: true
---

# What this repository is

This is the source for the practicum manuals of **NB2420 Electronic Instrumentation**, a second-year course in the **Nanobiology BSc programme** (TU Delft and Erasmus MC). The published artefact is a Jupyter Book ("TeachBook") that students read online and, when they need ALPACA hardware access, also run as notebooks on their laptops.

The book is built into HTML and served from the `book/` folder. Everything you write must build cleanly with `jupyter-book build book/` and render correctly in both light and dark theme.

## Course goals, in priority order

1. **Transferable problem-solving and lab skills.** Predict before you measure. Reconcile prediction with simulation with measurement. Read a datasheet. Pick the test condition that isolates the parameter you want. Document numbers and reasoning so a future you (or a teammate) can follow them. These skills are the primary outcome.

2. **Basic electronics fluency.** Ohm's law, Kirchhoff, voltage and current dividers, RC and RL circuits, Bode plots, opamp configurations, non-idealities, sensors, microcontrollers, noise. The electronics is the vehicle, not the destination.

3. **Problem-solving based.** Every cell either asks a question, sets up a measurement, or scaffolds a comparison. The book is not a concept dump.

When you make a pedagogical trade-off, the priority order above breaks the tie: a transferable skill survives a content cut before a "nice to know" fact does.

## Audience

* Second-year Nanobiology students. Most have no prior electronics background.
* Working in pairs at the bench, in groups of four around a table for the comparison phase, and individually for homework.
* Evaluated by Teaching Assistants via a Scientific Graphical Organizer (SGO) on BrightSpace.
