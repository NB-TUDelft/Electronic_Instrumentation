// Shared scaffolding for the NB2420 log book entries.
//
// Each manual's entry imports this, then supplies only the material that is
// specific to that manual. Keeping the Preparation and closing blocks here
// means every entry asks the same questions in the same order, which is the
// point of a log book.

#import "/_typst_lib/capture_field.typ": capture_field, text_field, textarea_field, checkbox_field

// capture_field's text_field sizes its widget with measure(), which cannot
// resolve a relative width, so a "width: 100%" box yields a 20pt interactive
// area inside a full width outline. fill_cell routes through layout(), which
// sees the real container width. Never size a field with a percentage.
#let line_field(name, height: 16pt) = capture_field(
  field_name: name,
  field_type: "text",
  fill_cell: true,
  min_height: height,
)[
  #box(width: 100%, height: height, stroke: 0.5pt + gray, fill: rgb("#f7f9fb"), inset: 2pt)
]

#let area(name, height: 60pt) = textarea_field(name, height: height)
#let check(name) = checkbox_field(name)

#let prompt(body) = text(size: 8pt, fill: rgb("#555555"), style: "italic", body)
#let hint(body) = text(size: 8pt, fill: rgb("#555555"), body)
#let rule = line(length: 100%, stroke: 0.6pt + rgb("#333333"))

#let band(title, note: "") = block(
  width: 100%, fill: rgb("#e8eef4"), inset: (x: 6pt, y: 4pt), radius: 2pt,
  [#text(weight: "bold", size: 10.5pt, title) #h(1fr) #text(size: 8pt, note)],
)

// A blank area to draw in, with a line naming a photo handed in beside the
// entry. PDF forms have no image field, so a reference is the robust route.
#let sketchbox(name, height: 150pt) = {
  rect(width: 100%, height: height, stroke: 0.5pt + rgb("#888888"), radius: 2pt)
  v(3pt)
  grid(
    columns: (auto, 1fr), column-gutter: 6pt, align: horizon,
    hint[Photo or file reference:], line_field(name + "_ref", height: 14pt),
  )
}

#let section(title, note: "") = { v(6pt); band(title, note: note); v(4pt) }

#let field_row(..pairs) = grid(
  columns: (auto, 1fr), column-gutter: 6pt, row-gutter: 5pt, align: horizon,
  ..pairs,
)

// ---------------------------------------------------------------- page frame
#let logbook(title: "", subtitle: "", body) = {
  set page(paper: "a4", margin: (x: 14mm, y: 12mm), numbering: "1 / 1")
  set text(font: ("Libertinus Serif", "DejaVu Serif"), size: 9.5pt)
  set table(stroke: 0.4pt + rgb("#888888"), inset: 4pt)

  grid(
    columns: (1fr, auto), align: (left + horizon, right + horizon),
    [
      #text(size: 13pt, weight: "bold")[#title] \
      #text(size: 10pt)[#subtitle]
    ],
    hint[Hand in via BrightSpace],
  )
  v(2pt); rule; v(4pt)

  field_row(
    [Name(s):], line_field("name", height: 15pt),
    [Date:], line_field("date", height: 15pt),
    [Partner:], line_field("partner", height: 15pt),
    [Group:], line_field("group", height: 15pt),
  )
  body
}

// ------------------------------------------------------- standard Preparation
#let preparation(
  question: [What relationship are you testing in this manual?],
  theory: [State the relation you will test and what you expect to happen.],
  theory_height: 100pt,
  materials: (),
  steps: 8,
) = {
  section("PREPARATION", note: "complete before the practicum")

  [*Research question* \ ]
  prompt[One sentence. #question]
  area("research_question", height: 50pt)

  v(4pt)
  [*Theory* \ ]
  prompt[#theory]
  area("theory", height: theory_height)

  v(4pt)
  [*Quantities*]
  field_row(
    [Independent variable:], line_field("iv"),
    [Dependent variable:], line_field("dv"),
    [Controlled variable(s):], line_field("cv"),
  )

  v(6pt)
  grid(
    columns: (1fr, 1fr), column-gutter: 10pt,
    [
      *Materials* \
      #prompt[Tick what you actually used.]
      #v(3pt)
      #grid(
        columns: (auto, 1fr), column-gutter: 5pt, row-gutter: 7pt, align: horizon,
        ..materials.enumerate().map(((i, m)) => (check("mat" + str(i)), [#m])).flatten(),
        check("mat_other"), line_field("mat_other_txt", height: 14pt),
      )
    ],
    [
      *Procedure* \
      #prompt[The steps you will follow at the bench, in order.]
      #v(3pt)
      #grid(
        columns: (auto, 1fr), column-gutter: 5pt, row-gutter: 7pt, align: horizon,
        ..range(1, steps + 1).map(i => ([#str(i).], line_field("proc" + str(i), height: 15pt))).flatten(),
      )
    ],
  )
}

// ----------------------------------------------------------- standard closing
#let closing(
  analysis: [Where do prediction, simulation and measurement diverge, and what does the size of the divergence tell you?],
  conclusion: [Answer your research question.],
  graph: true,
  graph_prompt: [Plot your measured data. Label both axes with a unit.],
  graph_height: 150pt,
) = {
  if graph {
    v(6pt)
    [*Graph* #h(6pt) #prompt[#graph_prompt]]
    v(3pt)
    sketchbox("graph", height: graph_height)
  }

  v(6pt)
  [*Analysis and trend* \ ]
  prompt[#analysis]
  area("analysis", height: 74pt)

  v(4pt)
  [*Conclusion(s)* \ ]
  prompt[#conclusion]
  area("conclusion", height: 68pt)

  v(4pt)
  [*What I wanted to say as well* \ ]
  area("extra", height: 42pt)

  v(5pt); rule; v(3pt)
  field_row(
    [#text(size: 8pt)[TA check-off:]], line_field("ta_sign", height: 14pt),
    [#text(size: 8pt)[Date:]], line_field("ta_date", height: 14pt),
  )
}
