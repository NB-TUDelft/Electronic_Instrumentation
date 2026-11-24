#import "../tpl/logbook_common.typ": *

#show: logbook.with(
  title: "Log Book Entry 5.2",
  subtitle: "NB2420 Electronic Instrumentation " + sym.dot.c + " Manual 5.2 " + sym.dot.c + " Differential measurements",
)

#set block(spacing: 4pt)
#set table(inset: (x: 3pt, y: 2.5pt))
#show table: set text(size: 8.5pt)

#let lf(name) = line_field(name, height: 14pt)
#let unit(body) = block(breakable: false, width: 100%, body)

#let s1_row(id, label, ul, ur, pred) = (
  label, ul, ur, pred, lf(id + "_out"),
)
#let s2_row(id, label) = (
  label,
  lf(id + "_il"), lf(id + "_ir"),
  lf(id + "_ul"), lf(id + "_ur"), lf(id + "_out"),
  lf(id + "_level"),
)
#let s3_row(id, label) = (
  label,
  lf(id + "_1v_ul"), lf(id + "_1v_ur"), lf(id + "_1v_out"),
  lf(id + "_3v_ul"), lf(id + "_3v_ur"), lf(id + "_3v_out"),
)
#let electrical(id, label) = (
  label, lf(id + "_ul"), lf(id + "_ur"), lf(id + "_out"),
)
#let gain(id, label) = (
  label, lf(id + "_pred"), lf(id + "_sim"), lf(id + "_meas"),
)
#let balance(id, label) = (
  label, lf(id + "_before_ul"), lf(id + "_before_ur"),
  lf(id + "_after_ul"), lf(id + "_after_ur"),
)
#let level(id, label) = (
  label, lf(id + "_u"), lf(id + "_corrected"), lf(id + "_display"),
)

#unit[
  #section("SIMULATION", note: "Tasks A1, A2, A3, A5, S1, S2 and S3")
  #subsection([Subtractor simulation], note: [Tasks A2, A3 and S1; reference at ground; enter $A_d$, $A_c$, CMRR in C1])
  #table(
    columns: (1.7fr, 0.75fr, 0.75fr, 0.95fr, 1.35fr), align: horizon,
    table.header([*Case*], [*$U_L$ (V)*], [*$U_R$ (V)*], [*Pred. $U_"out"$ (V)*], [*Sim. $U_"out"$ (V)*]),
    ..s1_row("s1_diff_pos", [Difference, one way], [$-0.50$], [$+0.50$], [$+1.00$]),
    ..s1_row("s1_diff_neg", [Difference, other way], [$+0.50$], [$-0.50$], [$-1.00$]),
    ..s1_row("s1_cm_room", [Common, room light], [$-0.50$], [$-0.50$], [$0$]),
    ..s1_row("s1_cm_bright", [Common, bright room], [$-1.50$], [$-1.50$], [$0$]),
  )
  #field_row([Why the simulated CMRR beats 46 dB (what exists only on the bench?):], lf("s1_cmrr_note"))
]

#unit[
  #subsection([Photocurrent chain sweep], note: [Tasks A5 and S2; `ambient=1`])
  #table(
    columns: (0.85fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1.05fr), align: horizon,
    table.header(
      [*`V(pos)` (V)*], [*$I_L$ (#(sym.mu)A)*], [*$I_R$ (#(sym.mu)A)*],
      [*$U_L$ (V)*], [*$U_R$ (V)*], [*$U_"out"$ (V)*], [*Display level*],
    ),
    ..s2_row("s2_m1", [$-1$]),
    ..s2_row("s2_m05", [$-0.5$]),
    ..s2_row("s2_0", [$0$]),
    ..s2_row("s2_p05", [$+0.5$]),
    ..s2_row("s2_p1", [$+1$]),
  )
  #field_row([At `ambient=3`, which voltages change (near supply?):], lf("s2_ambient3"))
]

#unit[
  #subsection([Mismatch and trimming], note: [Tasks A1 and S3; `V(pos)` = 0, `sR` = 1, $R_(f,R) = 100$ k#sym.Omega; voltages in V])
  #table(
    columns: (2.2fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr), align: horizon,
    table.header(
      table.cell(rowspan: 2)[*Case*],
      table.cell(colspan: 3, align: center + horizon)[*Room light 1 V (lower)*],
      table.cell(colspan: 3, align: center + horizon)[*Room light 3 V (higher)*],
      [*$U_L$*], [*$U_R$*], [*$U_"out"$*],
      [*$U_L$*], [*$U_R$*], [*$U_"out"$*],
    ),
    ..s3_row("s3_matched", [Matched ($R_(f,L) = 100$ k#sym.Omega)]),
    ..s3_row("s3_rf_mismatch", [Feedback only ($R_(f,L) = 105$ k#sym.Omega)]),
    ..s3_row("s3_sensor_mismatch", [Sensor only (`sL` = 1.05)]),
    ..s3_row("s3_trimmed", [Sensor trimmed (`sL` = 1.05)]),
  )
  #field_row([Calculated $P$ for $R_(f,L) = 91$ k#sym.Omega + $P$ (k#sym.Omega):], lf("s3_trim_p"))
]

#unit[
  #section("BALANCE AND COMMON-MODE REJECTION", note: "Tasks A1, A2, A3, S1, S3, I1, I2 and C1")
  #prompt[Record raw readings before calculating gains. Voltages are in V.]

  #subsection([Subtractor input test and gains], note: [Tasks A2, A3, S1, I2 and C1; reference at ground])
  #table(
    columns: (1.6fr, 1fr, 1fr, 1fr), align: horizon,
    table.header([*Nominal input pair*], [*$U_L$ measured*], [*$U_R$ measured*], [*$U_"out"$ measured*]),
    ..electrical("i2_plus", [0.5, 1.5]),
    ..electrical("i2_minus", [1.5, 0.5]),
    ..electrical("i2_low", [0.5, 0.5]),
    ..electrical("i2_high", [1.5, 1.5]),
  )
  #table(
    columns: (1.6fr, 1fr, 1fr, 1fr), align: horizon,
    table.header([*Subtractor quantity*], [*Predicted, matched*], [*Simulated, matched*], [*Measured*]),
    ..gain("c1_ad", [$A_d$]),
    ..gain("c1_ac", [$A_c$]),
    ..gain("c1_cmrr", [CMRR (dB), or bound]),
  )
  #field_row([Measurement resolution used for common-mode result:], lf("i2_resolution"))
]

#unit[
  #subsection([Equal illumination], note: [Tasks A1, S3, I1 and C1])
  #table(
    columns: (1.25fr, 1fr, 1fr, 1fr, 1fr), align: horizon,
    table.header([*Light level*], [*$U_L$ before*], [*$U_R$ before*], [*$U_L$ after*], [*$U_R$ after*]),
    ..balance("i1_low", [Lower]),
    ..balance("i1_high", [Higher]),
  )
  #grid(
    columns: (auto, 1fr, auto, 1fr), column-gutter: 6pt, align: horizon,
    [Left feedback before / after (k#sym.Omega):], lf("i1_rf_left"),
    [Right feedback (k#sym.Omega):], lf("i1_rf_right"),
  )
  #field_row([Imbalance follows sensor or channel after swap?], lf("i1_swap"))
]

#unit[
  #section("FIVE-LEVEL DETECTOR", note: "Tasks A5, S2, I3, I4 and C2")
  #subsection([Full detector], note: [Task I3])
  #table(
    columns: (1.25fr, 1fr, 1fr, 1fr), align: horizon,
    table.header([*Torch condition*], [*$U_L$ (V)*], [*$U_R$ (V)*], [*$U_"out"$ (V)*]),
    ..electrical("i3_left", [Left]),
    ..electrical("i3_centre", [Centre]),
    ..electrical("i3_right", [Right]),
  )
  #grid(
    columns: (auto, 1fr, auto, 1fr), column-gutter: 6pt, align: horizon,
    [Loaded $U_"ref"$ (V):], lf("i3_reference"),
    [Verified output min / max (V):], lf("i3_window"),
  )
  #grid(
    columns: (auto, 1fr), column-gutter: 5pt, align: horizon,
    check("i3_adc_check"), [ADC2 connected only after checking the output range and common ground.],
  )
]

#unit[
  #subsection([Calibration and five-level display], note: [Tasks A5, S2, I4 and C2])
  #grid(
    columns: (auto, 1fr, auto, 1fr), column-gutter: 6pt, align: horizon,
    [Baseline (software units):], lf("i4_baseline"),
    [Largest cal. departure (software units):], lf("i4_noise"),
  )
  #field_row([Deadband $D$ / strong threshold $H$ (software units):], lf("i4_thresholds"))
  #prompt[Use one baseline for the comparison. Record a limitation if a level cannot be reached within the verified ADC range.]
  #table(
    columns: (1.2fr, 1fr, 1.1fr, 1.5fr), align: horizon,
    table.header([*Torch condition*], [*$U_"out"$ (V)*], [*Corrected reading*], [*Displayed level and label*]),
    ..level("i4_far_left", [Far left]),
    ..level("i4_left", [Left]),
    ..level("i4_centre", [Centre]),
    ..level("i4_right", [Right]),
    ..level("i4_far_right", [Far right]),
  )
]

#unit[
  #subsection([Shared-light check after trimming], note: [Tasks I3, I4 and C2; no directional torch, same baseline])
  #table(
    columns: (1.2fr, 1fr, 1.1fr, 1.5fr), align: horizon,
    table.header([*Shared illumination*], [*$U_"out"$ (V)*], [*Corrected reading*], [*Displayed level*]),
    ..level("c2_ambient_low", [Lower]),
    ..level("c2_ambient_high", [Higher]),
  )
  #field_row([Setup sketch, trace or display file ref. (incl. deep dive):], lf("c2_evidence"))
]

#closing(
  graph: false,
)
