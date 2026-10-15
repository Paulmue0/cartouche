// Composes rendered pages into one image for the README. Not part of the
// published package; run it through `just docs`. Page paths are given as
// `--input pages=...`, absolute from the project root.
// The background is transparent so the sheet works on light and dark.
#set page(width: auto, height: auto, margin: 4pt, fill: none)

#let files = sys.inputs.at("pages").split(",")
#let width = eval(sys.inputs.at("width", default: "5cm"))
#let per-row = int(sys.inputs.at("per-row", default: "99"))

#grid(
  columns: calc.min(files.len(), per-row),
  column-gutter: 10pt,
  row-gutter: 10pt,
  ..files.map(f => box(stroke: 0.5pt + luma(75%), image(f, width: width))),
)
