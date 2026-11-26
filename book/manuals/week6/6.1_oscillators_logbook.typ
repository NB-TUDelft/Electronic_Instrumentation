#import "../tpl/logbook_common.typ": *

#show: logbook.with(
  title: "Log Book Entry 6.1",
  subtitle: "NB2420 Electronic Instrumentation " + sym.dot.c + " Manual 6.1 " + sym.dot.c + " Relaxation oscillator",
)
#set text(size: 8.5pt)
#set table(inset: 3pt)
#let response(name, height: 30pt) = block(breakable: false, area(name, height: height))
#let values(..pairs) = grid(
  columns: (auto, 1fr) * pairs.pos().len(), column-gutter: 5pt, align: horizon,
  ..pairs.pos().flatten(),
)

#section("BACKGROUND AND PREDICTIONS", note: "B1 to B3, A1 to A3")
#prompt[Use $U_H = +12 V$ and $U_L = -12 V$ for your first predictions. Use your chosen hardware components for B2, A2 and A3. Enter the A3 triangle peak-to-peak prediction directly in the C1 comparison table on the final page.]
#v(3pt)
#field_row(
  [Chosen hardware components:], values(
    ([$R_a$ [k$Omega$]], line_field("component_ra")),
    ([$R_b$ [k$Omega$]], line_field("component_rb")),
    ([$R_c$ [k$Omega$]], line_field("component_rc")),
    ([$C$ [nF]], line_field("component_c")),
  ),
  [B1: input receiving the ground reference:], line_field("b1_reference"),
  [B2: predicted slope [V/ms]:], values(
    ([$+2 V$ input], line_field("b2_slope_pos")),
    ([$-2 V$ input], line_field("b2_slope_neg")),
  ),
  [A2: predicted switching thresholds [V]:], values(
    ([Upper], line_field("a2_ut_up")),
    ([Lower], line_field("a2_ut_down")),
  ),
)
#v(4pt)
#prompt[B1 / A2: does hysteresis remove noise from the input? What else must you know to determine the output inside the hysteresis interval? Explain how zero input can correspond to either output state.]
#response("b1_memory", height: 40pt)
#v(4pt)
#prompt[B2 / B3: name the component that stores energy and the component that sets the input current. What would end a ramp if the comparator never switched?]
#response("b2_b3_principle", height: 35pt)
#v(4pt)
#prompt[A1: predict the output state for positive and negative input, both switching input voltages, and the output frequency. What changes when the input amplitude is halved, and why?]
#response("a1_output_prediction", height: 40pt)
#v(4pt)
#field_row(
  [A3: predicted slope [V/ms]:], values(
    ([$U_q = U_H$], line_field("a3_slope_high")),
    ([$U_q = U_L$], line_field("a3_slope_low")),
  ),
  [A3: threshold ending each ramp [V]:], values(
    ([Falling], line_field("a3_end_fall")),
    ([Rising], line_field("a3_end_rise")),
  ),
  [A3: predicted ramp duration [ms]:], values(
    ([Falling], line_field("a3_fall_time")),
    ([Rising], line_field("a3_rise_time")),
  ),
  [A3: predicted oscillation timing:], values(
    ([$T$ [ms]], line_field("a3_period")),
    ([$f$ [Hz]], line_field("a3_frequency")),
  ),
)
#v(4pt)
#prompt[A3: predicted changes to slope, triangle peak-to-peak voltage, and period.]
#let ch(id, c) = (c, line_field(id + "_slope"), line_field(id + "_tri"), line_field(id + "_period"))
#table(
  columns: (1.2fr, 1fr, 1fr, 1fr), align: horizon,
  table.header([*Change*], [*Slope*], [*Triangle*], [*Period*]),
  ..ch("a3_rc2", [Double $R_c$]),
  ..ch("a3_rahalf", [Halve $R_a$]),
)

#pagebreak()
#section("SIMULATION", note: "S1 and S2")
#prompt[Use the supplied schematic's component values. Enter the S2 baseline rising slope directly in the Simulation column of the C1 comparison table on the final page. Record the other results below.]
#field_row(
  [S1: simulated switching thresholds [V]:], values(
    ([Upper], line_field("s1_ut_up")),
    ([Lower], line_field("s1_ut_down")),
  ),
  [S2: simulated output levels [V]:], values(
    ([$U_H$], line_field("s2_high")),
    ([$U_L$], line_field("s2_low")),
  ),
  [S2: baseline oscillation timing:], values(
    ([$T$ [ms]], line_field("s2_period")),
    ([$f$ [Hz]], line_field("s2_frequency")),
  ),
  [S2: baseline triangle measurements:], values(
    ([Peak-to-peak [V]], line_field("s2_triangle")),
    ([Falling slope [V/ms]], line_field("s2_slope")),
  ),
  [S2: after doubling $R_c$:], values(
    ([$T$ [ms]], line_field("s2_rc2_period")),
    ([Triangle peak-to-peak [V]], line_field("s2_rc2_triangle")),
  ),
)
#v(4pt)
#prompt[S1: record the Schmitt trigger output at rising and falling zero input crossings. Explain why the states differ.]
#response("s1_memory", height: 30pt)
#v(4pt)
#prompt[S1: compare the plain comparator with A1. Why can hysteresis prevent extra switches? Include your disturbed-input observation.]
#response("b1_hysteresis", height: 30pt)
#v(4pt)
#prompt[S2: use the simulated output levels to explain any difference from A3. Compare the predicted and simulated effects of doubling $R_c$.]
#response("s2_comparison", height: 30pt)

#section("SEPARATE BLOCK TESTS", note: "I1 to I3")
#prompt[Record each measured value in its labelled field. Keep the sign of each ramp slope.]
#field_row(
  [I1: chip marking:], line_field("i1_chip_dc"),
  [I1: generator settings:], values(
    ([$f$ [Hz]], line_field("i1_generator_frequency")),
    ([Amplitude [Vpp]], line_field("i1_generator_amplitude")),
    ([Offset [V]], line_field("i1_generator_offset")),
  ),
  [I1: measured output levels [V]:], values(
    ([$U_H$], line_field("i1_high")),
    ([$U_L$], line_field("i1_low")),
  ),
  [I1: input voltage at each switch [V]:], values(
    ([Low to high], line_field("i1_switch_up")),
    ([High to low], line_field("i1_switch_down")),
  ),
  [I1: after halving the input amplitude:], values(
    ([Input [Vpp]], line_field("i1_halved_input")),
    ([Output [Vpp]], line_field("i1_halved_output")),
  ),
  [I2: measured output levels [V]:], values(
    ([$U_H$], line_field("i2_high")),
    ([$U_L$], line_field("i2_low")),
  ),
  [I3: measured input voltage [V]:], values(
    ([Positive level], line_field("i3_input_positive")),
    ([Negative level], line_field("i3_input_negative")),
  ),
  [I3: measured slope [V/ms]:], values(
    ([Falling], line_field("i3_slope_falling")),
    ([Rising], line_field("i3_slope_rising")),
  ),
)
#v(4pt)
#prompt[I2: what happens to the output when the input no longer reaches either threshold? How does this compare with I1?]
#response("i2_small_input", height: 22pt)
#v(5pt)
#prompt[I1: are the measured switching points exactly zero? Explain the effect of halving the input amplitude using A1 and the comparator input voltages.]
#response("i1_explanation", height: 30pt)
#v(4pt)
#prompt[I2: record both output states at zero input and the input direction. Compare with S1 and explain why the previous state matters. Enter the original, refined and measured thresholds in the C1 comparison table on the final page.]
#response("i2_memory", height: 30pt)
#v(4pt)
#prompt[I3: record the differences used to calculate each signed slope above. Calculate the refined prediction from the measured input level, $R_c$ and $C$. Compare with B2 and the measured slope.]
#let slope_check(id, label) = (
  label, line_field(id + "_du"), line_field(id + "_dt"), line_field(id + "_refined"),
)
#table(
  columns: (1fr, 1fr, 1fr, 1.4fr), align: horizon,
  table.header([*I3 ramp*], [$Delta U$ [V]], [$Delta t$ [ms]], [*Refined slope [V/ms]*]),
  ..slope_check("i3_fall", [Falling]),
  ..slope_check("i3_rise", [Rising]),
)
#v(4pt)
#prompt[I3: compare the refined predictions with the measured slopes. Explain any substantial difference.]
#response("i3_comparison", height: 26pt)

#pagebreak()
#section("CASCADE, OSCILLATOR AND COMPARISON", note: "A2, A3, S1, S2, I2, I4, I5, C1, C2")
#field_row(
  [I4: final generator settings:], values(
    ([$f$ [Hz]], line_field("i4_generator_frequency")),
    ([Amplitude [Vpp]], line_field("i4_generator_amplitude")),
  ),
  [I4: measured triangle voltage [V]:], values(
    ([Minimum], line_field("i4_tri_min")),
    ([Maximum], line_field("i4_tri_max")),
  ),
  [I4: measured switching thresholds [V]:], values(
    ([Upper], line_field("i4_ut_up")),
    ([Lower], line_field("i4_ut_down")),
  ),
  [I5: measured output levels and frequency:], values(
    ([$U_H$ [V]], line_field("i5_high")),
    ([$U_L$ [V]], line_field("i5_low")),
    ([$f$ [Hz]], line_field("i5_frequency")),
  ),
  [I5: measured triangle voltage [V]:], values(
    ([Minimum], line_field("i5_tri_min")),
    ([Maximum], line_field("i5_tri_max")),
  ),
  [I5: calculated switching thresholds [V]:], values(
    ([Upper], line_field("i5_ut_up_refined")),
    ([Lower], line_field("i5_ut_down_refined")),
  ),
)
#v(4pt)
#prompt[Calculate the I5 thresholds using $U_H$ and $U_L$ measured with the oscillator loop connected.]
#v(3pt)
#subsection([C1 comparison table])
#prompt[Fill the relevant cells during A3, S2, I2 and I5. During C1, copy the remaining results from their earlier fields. Prediction uses your hardware components and $plus.minus 12 V$. Refined prediction uses measured output levels from I2 for the Schmitt trigger and I5 for the oscillator. Simulation uses the baseline S1 and S2 circuits. Account for different component values when comparing simulation and hardware.]
#let result(id, label) = (
  label, line_field(id + "_pred", height: 13pt), line_field(id + "_model", height: 13pt),
  line_field(id + "_sim", height: 13pt), line_field(id + "_meas", height: 13pt),
)
#table(
  columns: (1.8fr, 1fr, 1fr, 1fr, 1fr), align: horizon,
  table.header([*Quantity*], [*Prediction*], [*Refined prediction*], [*Simulation*], [*Measurement*]),
  ..result("c1_up", [Upper threshold [V]]),
  ..result("c1_down", [Lower threshold [V]]),
  ..result("c1_tri", [Triangle peak-to-peak [V]]),
  ..result("c1_fall", [Falling slope magnitude [V/ms]]),
  ..result("c1_rise", [Rising slope [V/ms]]),
  ..result("c1_period", [Period [ms]]),
)
#v(4pt)
#prompt[C1: does the refined prediction improve agreement? Give one numerical example, or state that agreement was already good. If a difference remains, suggest a cause and a measurement to test it.]
#response("c1_diagnostic", height: 32pt)
#v(4pt)
#prompt[C1 / C2: explain one full cycle and why pin 2 stays close to ground while pin 5 need not. Compare what reverses the ramp and sets the frequency in I4 and I5.]
#prompt[Include the energy source and explain why $R_c$ remains in the loop.]
#response("b3_cycle", height: 80pt)
#v(4pt)
#prompt[Troubleshooting / C2: record one observation, a suspected cause and a measurement that tests it. If the circuit worked, explain what fault your test would have detected.]
#response("c2_troubleshooting", height: 48pt)
#closing(
  conclusion: [How can the two circuits generate a repeating signal without a function generator? Support your answer with one measured value.],
  graph: false,
  reflect_height: 65pt,
)
