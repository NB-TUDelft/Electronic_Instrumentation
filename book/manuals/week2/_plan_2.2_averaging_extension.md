# Week 2 manual plan: 2.2 averaging extension

Draft extension plan for [2.2_Timed_acquisitions.ipynb](2.2_Timed_acquisitions.ipynb). The user decision is that averaging moves out of the reduced Week 3.1 signal-processing manual and into the timed-acquisition manual. This keeps Week 3 focused on aliasing, anti-aliasing, FFT interpretation, and deliberate undersampling.

The extension uses selected material from the legacy 9B and 9C manuals:

* [9B_Digital_Filtering_and_Averaging_STUDENT.ipynb](../../../old/EI_manuals/9B_Digital_Filtering_and_Averaging_STUDENT.ipynb)
* [9C_Signal_Denoising_by_Average_STUDENT.ipynb](../../../old/EI_manuals/9C_Signal_Denoising_by_Average_STUDENT.ipynb)

## 1. Why this belongs in Manual 2.2

Manual 2.2 already teaches timed measurements, sampling intervals, timestamps, and repeated acquisition loops. Averaging is a measurement strategy before it is a signal-processing trick. Students need to know when repeated samples can be averaged, when repeated traces need alignment, and why averaging does not fix systematic timing mistakes.

Week 3.1 will still compare averaging with analog and digital filters, but the mechanics should be learned here.

## 2. Extension scope

Keep the current Manual 2.2 structure, then add one compact averaging arc:

1. Predict how random noise changes when you average $N$ independent samples.
2. Simulate repeated noisy acquisitions.
3. Measure a fixed voltage repeatedly on the ALPACA and verify the standard-deviation trend.
4. Compare point averaging with trace averaging.
5. Move phase-alignment code to a deep dive.

To keep the practicum within one 3 h block, shorten the existing frequency sweep in Task I3 from five frequencies to three frequencies, or make the full sweep a deep dive.

## 3. Source triage

### 3.1 From 9B

| Old task | Tag | Goes to | Notes |
|---|---|---|---|
| Background: digital filtering and averaging definitions | CORE | 2.2 Background extension | Keep only averaging and the contrast with filtering. The digital-filter details stay in 3.1. |
| Anticipate: triggering needed for filtering or averaging | TRANSFERABLE | 2.2 A5 | Reframe as "when can you average repeated points or repeated traces?" |
| Simulate: noisy acquisitions and average | CORE | 2.2 S1 | Keep with simpler code and clear axes. |
| Implement: acquire noisy LED signal | OMIT | Future sensors or deep dive | Too much optical setup for 2.2. |
| Implement: average measured traces | TRANSFERABLE | 2.2 I3 or deep dive | Keep a simplified ALPACA version. |
| Compare: choose filtering vs averaging | TRANSFERABLE | 2.2 C4 and 3.1 C3 | Keep the averaging half here. |

### 3.2 From 9C

| Old task | Tag | Goes to | Notes |
|---|---|---|---|
| Background: untriggered trace averaging fails | CORE | 2.2 Background extension | Keep because it is the central warning. |
| Anticipate: phase-alignment strategy | TRANSFERABLE | 2.2 A5 | Keep short, no long code. |
| Simulate: zero crossing and rolling arrays | NICE | Deep dive DD1 | Useful but too detailed for the main route. |
| Implement: average untriggered synthetic data | CORE | 2.2 S1 | Keep as the visual proof. |
| Implement: align by maximum and average | NICE | Deep dive DD1 | Keep as a course deep dive. |
| Compare: artifacts from imperfect alignment | NICE | Deep dive DD1 | Keep for TA check-off. |

## 4. Proposed Manual 2.2 changes

### 4.1 Background addition

Add a short subsection after the existing sampling-rate explanation.

Working title: **Repeated measurements and averaging**

Content to add:

* If random noise has standard deviation $\sigma$, the average of $N$ independent samples has standard deviation approximately $\sigma / \sqrt{N}$.
* Averaging does not remove a wrong offset, a wrong calibration, or aliasing.
* There are two different operations:
  * Point averaging: repeat the same measurement condition and average the values.
  * Trace averaging: repeat the same waveform and average corresponding time points.
* Trace averaging only works when traces are aligned in time or phase. If the start phase drifts, the signal can average away.

### 4.2 New Anticipate task

Add after current Task A4.

* **A5: Predict what averaging can and cannot improve**. A fixed voltage is measured repeatedly. The raw standard deviation is $12\,\mathrm{mV}$. Predict the standard deviation after averaging $N = 4$, $16$, and $64$ samples. Then answer two short questions: does averaging remove a $20\,\mathrm{mV}$ calibration offset, and does averaging recover a sine wave if every trace starts at a random phase?

### 4.3 New Simulate section

Manual 2.2 currently jumps from Anticipate to Practicum. Add one short Simulate task to fit the BASIC format more closely.

* **S1: Average noisy repeated measurements**. Run provided Python code that generates:
  * repeated measurements of a fixed voltage with random noise;
  * repeated traces of the same sine with aligned phase;
  * repeated traces of the same sine with random phase.

Students plot raw values and averages. They identify which average improves and which average fails.

### 4.4 New Implement and Investigate task

Add after current Task I2, before the frequency sweep. Shorten the frequency sweep if needed.

* **I3: Average repeated ADC readings of a fixed input**. Keep the potentiometer fixed near mid-scale. Collect 500 timed ADC samples. Compute block averages for $N = 1$, $4$, $16$, and $64$. Plot the measured standard deviation of the block averages versus $N$. Compare with the $\sigma / \sqrt{N}$ prediction from A5.

Rename the current frequency-response sweep from I3 to I4 if the notebook is edited.

Optional implementation detail:

* If the ALPACA input is too quiet to show a clear trend, use a high-value source resistor or a deliberately long wire to introduce small pickup. Keep the voltage inside the safe ALPACA input range.

### 4.5 New Compare and Conclude task

Add after current C3.

* **C4: Averaging decision table**. Fill a table with four cases: fixed noisy voltage, drifting voltage, aligned repeated sine traces, and unaligned repeated sine traces. For each case, decide whether averaging helps and what must be true for the answer to be yes.

### 4.6 Deep dive

Add one `deep-dive dropdown`.

* **DD1: Align traces before averaging**. Use a provided synthetic dataset adapted from 9C. First average unaligned traces and observe that the sine nearly disappears. Then align each trace by its maximum, crop to a common length, and average again. Explain the improvement and the artifacts.

This deep dive can later be referenced from Week 3.1 DD3.

## 5. Revised time budget for Manual 2.2

| Section | Current intent | New intent |
|---|---:|---:|
| Background | 10 to 15 min | 15 to 20 min |
| Anticipate A1 to A4 | 35 to 45 min | 40 to 50 min with A5 |
| Simulate | none | 10 to 15 min with S1 |
| Implement I1 to I2 | 45 to 55 min | unchanged |
| Averaging I3 | none | 20 min |
| Frequency sweep | 35 to 45 min | 20 to 30 min, reduced to three frequencies |
| Compare and Conclude | 25 min | 30 min with C4 |

The extension is feasible only if the frequency sweep is trimmed or moved partly into a deep dive.

## 6. Artifacts to add when editing the notebook

### 6.1 Code helpers

* `block_average(values, block_size)`: returns block means and their timestamps.
* `simulate_averaging(seed=None)`: generates fixed-voltage and trace examples for S1.
* `plot_std_vs_block_size(values, block_sizes)`: makes the I3 comparison plot.

### 6.2 Figures

| File | Used in | Notes |
|---|---|---|
| `images/averaging_random_noise.svg` | Background | Raw samples and averaged samples around the same mean. |
| `images/trace_averaging_alignment.svg` | Background, DD1 | Aligned traces average to a sine; unaligned traces average toward zero. |

## 7. Risks and open points

* **ADC noise may be too small to see clearly**. Pilot the fixed-voltage measurement. If the raw standard deviation is tiny, use synthetic data in S1 as the main visual and keep I3 as a real-data confirmation.
* **Trace averaging can become a coding task**. Keep alignment in the deep dive. The main manual should teach the decision rule, not force students to debug array indexing.
* **Manual 2.2 currently has no Simulate section**. Adding S1 improves alignment with the BASIC format, but it does change the notebook structure.
* **Frequency sweep needs trimming**. Without trimming, the extension risks pushing the IC part over 3 h.

## 8. Cross-walk to Week 3.1

| Week 2.2 extension item | Week 3.1 dependency |
|---|---|
| A5, S1: averaging reduces random noise under repeated identical conditions | 3.1 C3 compares averaging with analog and digital filtering. |
| I3: block averaging from timed ADC samples | 3.1 uses the same timestamp discipline for FFT and undersampling. |
| DD1: phase alignment before trace averaging | 3.1 DD3 can reuse the dataset or refer students back to this deep dive. |
| C4: averaging decision table | 3.1 asks students to choose the right tool: average, digital filter, analog anti-alias filter, or undersample deliberately. |
