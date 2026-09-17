#import "../logbook_common.typ": *

#show: logbook.with(
  title: "Log Book Entry 1.1",
  subtitle: "NB2420 Electronic Instruments " + sym.dot.c + " Manual 1.1 " + sym.dot.c + " Voltage divider",
)

#preparation(
  question: [What relationship between resistance, output voltage and current are you testing?],
  theory: [State the divider relation you will test and what you expect current to do as the resistances rise.],
  theory_height: 112pt,
  materials: (
    [Breadboard and jumper wires], [ALPACA board], [Bench power supply],
    [Digital multimeter], [Function generator], [Resistor set],
    [BNC cables, T-splitter, adapters],
  ),
)

#pagebreak()
#section("PREDICT, SIMULATE, MEASURE", note: "Tasks A1, A2, S1, I1, I2")
#prompt[Supply is 5 V. Fill the predicted columns as homework, the simulated column after LTspice, and the measured columns at the bench. Leave a cell blank rather than guessing, then say why in the analysis.]
#v(4pt)

#let row(id, r1, r2) = (
  r1, r2,
  line_field(id + "_u_pred"), line_field(id + "_i_pred"),
  line_field(id + "_u_sim"), line_field(id + "_u_meas"), line_field(id + "_i_meas"),
)

#table(
  columns: (auto, auto, 1fr, 1fr, 1fr, 1fr, 1fr), align: horizon,
  table.header(
    [*$R_1$*], [*$R_2$*],
    [*$U_"out"$ pred.* \ #text(size: 7pt, weight: "regular")[A1]],
    [*$I$ pred.* \ #text(size: 7pt, weight: "regular")[A2]],
    [*$U_"out"$ sim.* \ #text(size: 7pt, weight: "regular")[S1]],
    [*$U_"out"$ meas.* \ #text(size: 7pt, weight: "regular")[I1]],
    [*$I$ meas.* \ #text(size: 7pt, weight: "regular")[I2]],
  ),
  ..row("p1", [100 #sym.Omega], [100 #sym.Omega]),
  ..row("p2", [1 k#sym.Omega], [1 k#sym.Omega]),
  ..row("p3", [100 k#sym.Omega], [100 k#sym.Omega]),
  ..row("p4", [10 M#sym.Omega], [10 M#sym.Omega]),
  ..row("p5", [1 k#sym.Omega], [220 #sym.Omega]),
)

#v(3pt)
#prompt[Where in the circuit did you break it to measure current, and why there?]
#line_field("i2_where")

#v(8pt)
*Combined dividers* #h(6pt) #hint[Tasks I4 and I5]
#v(3pt)
#table(
  columns: (2.2fr, 1fr, 1fr, 1fr), align: horizon,
  table.header([*Configuration*], [*$U_"out"$ predicted*], [*$U_"out"$ simulated*], [*$U_"out"$ measured*]),
  [Two dividers, outputs connected (I4)], line_field("i4_pred"), line_field("i4_sim"), line_field("i4_meas"),
  [Dividers stacked in series (I5)], line_field("i5_pred"), line_field("i5_sim"), line_field("i5_meas"),
)

#v(8pt)
*Setup* #h(6pt) #prompt[Sketch the circuit you built and label the nodes you probed, or name a photo you hand in beside this entry.]
#v(3pt)
#sketchbox("setup", height: 210pt)

#pagebreak()
#section("PRACTICUM", note: "Tasks I6, I7, C1 to C4")

*Function generator and loading* #h(6pt) #hint[Tasks I6 and I7]
#v(3pt)
#field_row(
  [Generator setting ($U_"rms"$, $f$):], line_field("fgen_set"),
  [DMM reading:], line_field("fgen_dmm"),
)
#v(4pt)
#table(
  columns: (1.4fr, 1fr, 1fr, 1.6fr), align: horizon,
  table.header([*Load*], [*$U_"out"$ expected*], [*$U_"out"$ measured*], [*Why they differ*]),
  [High impedance (open)], line_field("load_hi_exp"), line_field("load_hi_meas"), line_field("load_hi_note"),
  [50 #sym.Omega], line_field("load_50_exp"), line_field("load_50_meas"), line_field("load_50_note"),
  [Other: #text_field("load_x_name", width: 78pt, height: 14pt)],
    line_field("load_x_exp"), line_field("load_x_meas"), line_field("load_x_note"),
)

#closing(
  graph_prompt: [Plot measured $U_"out"$ or $I$ against resistance. Label both axes with a unit.],
  graph_height: 140pt,
  analysis: [Compare predicted, simulated and measured (C1, C2). Where do they diverge, and what does the size of the divergence tell you?],
  conclusion: [Answer your research question. Address loading and combined dividers (C3, C4).],
)
