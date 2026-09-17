#import "../logbook_common.typ": *

#show: logbook.with(
  title: "Log Book Entry 1.2",
  subtitle: "NB2420 Electronic Instruments " + sym.dot.c + " Manual 1.2 " + sym.dot.c + " Oscilloscope and filters",
)

#preparation(
  question: [How do coupling mode, trigger settings and an RC network change what you see?],
  theory: [State what AC coupling removes from a signal, and what an RC network does to a sine as frequency rises.],
  theory_height: 96pt,
  materials: (
    [Oscilloscope], [Function generator], [ALPACA board],
    [Breadboard and jumper wires], [BNC cables and T-splitter],
    [100 k#sym.Omega resistor], [47 nF capacitor (small blue)],
  ),
)

#pagebreak()
#section("COUPLING AND TRIGGERING", note: "Tasks A1, A2, I1, I2")
#prompt[Square wave, 4 $U_"pp"$, 25 Hz, with a $-2$ V DC offset. Predict each average as homework, then measure it at the bench.]
#v(4pt)

#let dut(id, d) = (
  d, line_field(id + "_avg_pred"), line_field(id + "_avg_meas"),
  line_field(id + "_dc"), line_field(id + "_ac"),
)
#table(
  columns: (auto, 1fr, 1fr, 1.3fr, 1.3fr), align: horizon,
  table.header(
    [*Duty cycle*],
    [*$U_"avg"$ predicted* \ #text(size: 7pt, weight: "regular")[A1]],
    [*$U_"avg"$ measured* \ #text(size: 7pt, weight: "regular")[I1]],
    [*DC coupling shows*], [*AC coupling shows*],
  ),
  ..dut("d50", [50 %]), ..dut("d75", [75 %]), ..dut("d25", [25 %]),
)

#v(6pt)
*Triggering* #h(6pt) #hint[Tasks A2 and I2]
#v(3pt)
#table(
  columns: (1.5fr, 1.5fr, 1.5fr), align: horizon,
  table.header([*Trigger setting*], [*Predicted display*], [*Observed display*]),
  [Level inside the signal range], line_field("tr_in_pred"), line_field("tr_in_obs"),
  [Level above the signal peak], line_field("tr_out_pred"), line_field("tr_out_obs"),
  [Slope changed rising to falling], line_field("tr_slope_pred"), line_field("tr_slope_obs"),
)
#v(3pt)
#prompt[Which channel did you use as the trigger source, and why that one?]
#line_field("tr_source")

#v(6pt)
*C1 Coupling* #h(6pt) #prompt[What does AC coupling do to the signal, what does DC coupling do, and which suits a very low frequency signal?]
#area("c1", height: 54pt)

#v(4pt)
*C2 Triggering* #h(6pt) #prompt[What happens when the trigger condition is never met? Is a signal you are actively adjusting a good trigger source? What changes when the slope goes from rising to falling?]
#area("c2", height: 54pt)

#pagebreak()
#section("RC FILTER AND CONCLUSIONS", note: "Tasks A3, S, I3, C1 to C3")

*Filter behaviour* #h(6pt) #hint[Task C3: 100 k#sym.Omega with 47 nF]
#v(3pt)
#table(
  columns: (1.4fr, 1fr, 1fr, 1fr), align: horizon,
  table.header([], [*Predicted*], [*Simulated*], [*Measured*]),
  [Behaviour (low or high pass)], line_field("beh_pred"), line_field("beh_sim"), line_field("beh_meas"),
  [$-3$ dB point], line_field("f3_pred"), line_field("f3_sim"), line_field("f3_meas"),
)
#v(3pt)
#prompt[Frequencies you swept, and the amplitude ratio at each:]
#line_field("sweep_notes")

#v(6pt)

#closing(
  graph_prompt: [Plot the measured amplitude ratio against frequency and mark the $-3$ dB point.],
  graph_height: 120pt,
  analysis: [Compare predicted, simulated and measured filter behaviour (C3). Where do they diverge, and why?],
  conclusion: [Answer your research question, covering coupling, triggering and the filter.],
)
