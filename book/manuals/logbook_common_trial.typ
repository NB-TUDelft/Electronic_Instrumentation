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
#let target_length = "A completed logbook should normally fit within 2 pages."

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

#let section(title, note: "") = { v(3pt); band(title, note: note); v(2pt) }

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
  v(2pt); rule; v(2pt)

  #grid(
  columns: (auto, 3fr, auto, 2fr, auto, 1.5fr),
  column-gutter: 6pt,
  align: horizon,

  [Name(s):], line_field("name", height: 15pt),
  [Partner:], line_field("partner", height: 15pt),
  [Date:], line_field("date", height: 15pt),
  )
  body
}

// ------------------------------------------------------- standard Preparation
#let preparation(
  theory: [What theories, laws, and/or formulas are most important for this experiment? ],
  goals: [What do you expect to learn?],
  prediction: [What do you expect to observe, and why?],
  prep_height: 100pt,
  materials: (),
  steps: 8,
) = {
  section("PREPARATION", note: "complete before the practicum")

  prompt[
    1. #theory \
    2. #goals \
    3. #prediction
  ]
  area("preparation", height: prep_height)
  
}

// ----------------------------------------------------------- standard closing
#let closing(
  analysis: [Which results matched or differed from your expectations, and why?],
  conclusion: [What is the most important thing you learned?],
  do_different: [What would you do differently next time?],
  reflect_height: 100pt,
  graph: true,
  graph_prompt: [Plot your measured data. Label both axes with a unit.],
  graph_height: 150pt,
) = {
  if graph {
    v(3pt)
    [*Graph* #h(6pt) #prompt[#graph_prompt]]
    v(2pt)
    sketchbox("graph", height: graph_height)
  }
  section("REFLECTION", note: "complete before submission")
  v(2pt)
  prompt[
    1. #analysis \
    2. #conclusion \
    3. #do_different
  ]
  area("reflection", height: reflect_height)
}
